Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5444C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 22:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjEEWOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjEEWOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 18:14:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1FB1FC0
        for <git@vger.kernel.org>; Fri,  5 May 2023 15:13:58 -0700 (PDT)
Received: (qmail 4827 invoked by uid 109); 5 May 2023 22:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 22:13:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4690 invoked by uid 111); 5 May 2023 22:13:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 18:13:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 18:13:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230505221357.GD3321533@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLSDS89y8P2+g/2@nand.local>
 <20230505212631.GB3321533@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505212631.GB3321533@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 05:26:31PM -0400, Jeff King wrote:

> But since the cruft-pack implementation diverges quite a bit from the
> regular "-A" handling, I guess it makes the code more complex rather
> than less. The asymmetry feels like a wart to me, but I guess in the
> long run we'd hope that the "turn unreachable loose" strategy is
> deprecated anyway.

One thing that could make this a lot simpler is if the code was added to
"are we recent" code paths in the first place.

Something like this:

diff --git a/reachable.c b/reachable.c
index 55bb114353..86bb5e021e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -16,6 +16,9 @@
 #include "object-store.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
+#include "oidset.h"
+#include "run-command.h"
+#include "config.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -67,8 +70,71 @@ struct recent_data {
 	timestamp_t timestamp;
 	report_recent_object_fn *cb;
 	int ignore_in_core_kept_packs;
+	struct oidset fake_recent_oids;
+	int fake_recent_oids_loaded;
 };
 
+static int run_one_recent_cmd(struct oidset *set, const char *args)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *out;
+	int ret = 0;
+
+	cmd.use_shell = 1;
+	cmd.out = -1;
+
+	strvec_push(&cmd.args, args);
+
+	if (start_command(&cmd))
+		return -1;
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline(&buf, out) != EOF) {
+		struct object_id oid;
+		const char *rest;
+
+		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest)
+			die(_("invalid extra cruft tip: '%s'"), buf.buf);
+
+		oidset_insert(set, &oid);
+	}
+
+	if (finish_command(&cmd))
+		die(_("cruft tip hook returned error"));
+
+	fclose(out);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
+			 struct recent_data *data)
+{
+	if (mtime > data->timestamp)
+		return 1;
+
+	if (!data->fake_recent_oids_loaded) {
+		const struct string_list *programs;
+
+		if (!git_config_get_string_multi("pack.extracrufttips", &programs)) {
+			size_t i;
+			for (i = 0; i < programs->nr; i++) {
+				if (run_one_recent_cmd(&data->fake_recent_oids,
+						       programs->items[i].string) < 0)
+					die(_("unable to enumerate additional cruft tips"));
+			}
+		}
+		data->fake_recent_oids_loaded = 1;
+	}
+
+	if (oidset_contains(&data->fake_recent_oids, oid))
+		return 1;
+
+	return 0;
+}
+
 static void add_recent_object(const struct object_id *oid,
 			      struct packed_git *pack,
 			      off_t offset,
@@ -78,7 +144,7 @@ static void add_recent_object(const struct object_id *oid,
 	struct object *obj;
 	enum object_type type;
 
-	if (mtime <= data->timestamp)
+	if (!obj_is_recent(oid, mtime, data))
 		return;
 
 	/*
@@ -193,6 +259,10 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	data.cb = cb;
 	data.ignore_in_core_kept_packs = ignore_in_core_kept_packs;
 
+	/* XXX must free before exiting function */
+	oidset_init(&data.fake_recent_oids, 0);
+	data.fake_recent_oids_loaded = 0;
+
 	r = for_each_loose_object(add_recent_loose, &data,
 				  FOR_EACH_OBJECT_LOCAL_ONLY);
 	if (r)

That would affect both "repack -A" and "repack --cruft". It would also
affect "git prune", but that seems like a good thing to me.

It would not affect a straight "repack -ad", since there we do not ask
about recency at all. I'm not sure if that use case is important or not.
If it is, we could easily trigger the "is it recent" code in that case
only if a hook is configured (we'd just set the cutoff to "0" so that
everything looks "too old").

Note that this inverts the loop logic from what you have. In your patch,
you ask the hook to enumerate all faux-recent objects, and then you
treat them separately from objects we found on disk. Here we enumerate
the objects on disk as usual, and just adjust our idea of "recent" based
on the hook. I think this is a bit simpler because objects we don't even
bother to ask it about objects we've already handled, are already marked
as recent, or are not present in the repository.

-Peff
