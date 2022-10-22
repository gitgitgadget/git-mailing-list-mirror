Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BCC38A2D
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJVAVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJVAVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:21:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AEF2A56A0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:21:49 -0700 (PDT)
Received: (qmail 15212 invoked by uid 109); 22 Oct 2022 00:21:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:21:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18975 invoked by uid 111); 22 Oct 2022 00:21:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:21:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:21:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] repack: populate extension bits incrementally
Message-ID: <Y1M3nMNTOGAH0L82@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After generating the main pack and then any additional cruft packs, we
iterate over the "names" list (which contains hashes of packs generated
by pack-objects), and call populate_pack_exts() for each.

There's one small problem with this. In repack_promisor_objects(), we
may add entries to "names" and call populate_pack_exts() for them.
Calling it again is mostly just wasteful, as we'll stat() the filename
with each possible extension, get the same result, and just overwrite
our bits.

So we could drop the call there, and leave the final loop to populate
all of the bits. But instead, this patch does the reverse: drops the
final loop, and teaches the other two sites to populate the bits as they
add entries.

This makes the code easier to reason about, as you never have to worry
about when the util field is valid; it is always valid for each entry.

It also serves my ulterior purpose: recording the generated filenames as
soon as possible will make it easier for a future patch to use them for
cleaning up from a failed operation.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8e71230bf7..b5bd9e5fed 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -714,10 +714,14 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
+		struct string_list_item *item;
+
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only "
 			      "from pack-objects."));
-		string_list_append(names, line.buf);
+
+		item = string_list_append(names, line.buf);
+		item->util = populate_pack_exts(line.buf);
 	}
 	fclose(out);
 
@@ -956,9 +960,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
+		struct string_list_item *item;
+
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
-		string_list_append(&names, line.buf);
+		item = string_list_append(&names, line.buf);
+		item->util = populate_pack_exts(item->string);
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
@@ -997,10 +1004,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	string_list_sort(&names);
 
-	for_each_string_list_item(item, &names) {
-		item->util = populate_pack_exts(item->string);
-	}
-
 	close_object_store(the_repository->objects);
 
 	/*
-- 
2.38.1.496.ga614b0e9bd

