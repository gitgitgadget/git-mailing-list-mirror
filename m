Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D3DC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AF12075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgH1Sum (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:50:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:43966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgH1Sul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:50:41 -0400
Received: (qmail 28389 invoked by uid 109); 28 Aug 2020 18:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 18:50:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11165 invoked by uid 111); 28 Aug 2020 18:50:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 14:50:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 14:50:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] midx: traverse the local MIDX first
Message-ID: <20200828185039.GA2171353@coredump.intra.peff.net>
References: <20200828180621.GA9036@nand.nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828180621.GA9036@nand.nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 02:06:21PM -0400, Taylor Blau wrote:

> The occurs when dropping a pack known to the local MIDX with alternates
> configured that have their own MIDX. Since the alternate's MIDX is
> returned via 'get_multi_pack_index()', 'midx_contains_pack()' returns
> true (which is correct, since it traverses through the '->next' pointer
> to find the MIDX in the chain that does contain the requested object).
> But, we call 'clear_midx_file()' on 'the_repository', which drops the
> MIDX at the path of the first MIDX in the chain, which (in the case of
> t7700.6 is the one in the alternate).

OK, that makes sense for what we're seeing.

> This patch bandaids that situation by trying to place the local MIDX
> first in the chain when calling 'prepare_multi_pack_index_one()'.
> Specifically, it always inserts all MIDXs loads subsequent to the local
> one as the head of the tail of the MIDX chain. This makes it so that we
> don't have a quadratic insertion while still keeping the local MIDX at
> the front of the list. Likewise, it avoids an 'O(m*n)' lookup in
> 'remove_redundant_pack()' where 'm' is the number of redundant packs and
> 'n' is the number of alternates.
> 
> Protect 'remove_redundant_pack()' against a case where alternates with
> MIDXs exist, but no local MIDX exists by first checking that 'm->local'
> before asking whether or not it contains the requested pack.

It seems like the root of the problem is that get_multi_pack_index() is
being used for two different things:

  - most callers want to iterate over all of the possible midx files,
    because they're trying to look up an object.

  - this caller wants the single midx for the local repository (I
    wondered if there might be more of these that we just never noticed
    because the test suite doesn't use alternates, but having just
    audited them all, the answer is no).

So I'd be tempted to say that the latter callers should be using a
separate function that gives them what they want. That lets them avoid
being too intimate with the details of how we order things.

The patch below illustrates that.  It also changes the existing function
name to avoid confusion and to help audit the existing callers, but
that's optional and maybe not worth it.

It does do the linear lookup, so it has the O(m*n) you mentioned. But
the number of alternates is generally small, and I'd be shocked if this
was the first m*n loop over the number of alternates. However, we could
still do the ordering thing and just keep the details inside the new
function.

---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7016b28485..a9be7480df 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1246,7 +1246,7 @@ static int want_object_in_pack(const struct object_id *oid,
 			return want;
 	}
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
+	for (m = get_all_multi_pack_index(the_repository); m; m = m->next) {
 		struct pack_entry e;
 		if (fill_midx_entry(the_repository, oid, &e, m)) {
 			struct packed_git *p = e.p;
diff --git a/builtin/repack.c b/builtin/repack.c
index f10f52779c..60cb196956 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -133,7 +133,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_multi_pack_index(the_repository);
+	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
 	strbuf_addf(&buf, "%s.pack", base_name);
 	if (m && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
diff --git a/packfile.c b/packfile.c
index 6ab5233613..ece317642a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -915,7 +915,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 
 		prepare_packed_git(r);
 		count = 0;
-		for (m = get_multi_pack_index(r); m; m = m->next)
+		for (m = get_all_multi_pack_index(r); m; m = m->next)
 			count += m->num_objects;
 		for (p = r->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
@@ -1021,12 +1021,24 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packed_git;
 }
 
-struct multi_pack_index *get_multi_pack_index(struct repository *r)
+struct multi_pack_index *get_all_multi_pack_index(struct repository *r)
 {
 	prepare_packed_git(r);
 	return r->objects->multi_pack_index;
 }
 
+struct multi_pack_index *get_local_multi_pack_index(struct repository *r)
+{
+	struct multi_pack_index *m;
+
+	for (m = get_all_multi_pack_index(r); m; m = m->next) {
+		if (m->local)
+			break;
+	}
+
+	return m;
+}
+
 struct packed_git *get_all_packs(struct repository *r)
 {
 	struct multi_pack_index *m;
diff --git a/packfile.h b/packfile.h
index 240aa73b95..2516eb4667 100644
--- a/packfile.h
+++ b/packfile.h
@@ -56,7 +56,8 @@ void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct repository *r);
+struct multi_pack_index *get_all_multi_pack_index(struct repository *r);
+struct multi_pack_index *get_local_multi_pack_index(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*
diff --git a/sha1-name.c b/sha1-name.c
index 0b8cb5247a..be6b675953 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -184,7 +184,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
+	for (m = get_all_multi_pack_index(ds->repo); m && !ds->ambiguous;
 	     m = m->next)
 		unique_in_midx(m, ds);
 	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
@@ -660,7 +660,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
+	for (m = get_all_multi_pack_index(mad->repo); m; m = m->next)
 		find_abbrev_len_for_midx(m, mad);
 	for (p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
