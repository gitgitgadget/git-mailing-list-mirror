Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608BC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 07:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbiHTHg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbiHTHg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 03:36:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C398585
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 00:36:26 -0700 (PDT)
Received: (qmail 21392 invoked by uid 109); 20 Aug 2022 07:36:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 07:36:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9457 invoked by uid 111); 20 Aug 2022 07:36:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 03:36:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 03:36:25 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/6] xdiff: drop unused mmfile parameters from
 xdl_do_patience_diff()
Message-ID: <YwCO+WE2Z+sJofEb@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9OpXIQ9dYMQJ4B@coredump.intra.peff.net>
 <CAPoeCOa6BDsunamy7_GtaSy-gL_0r3kAwDJ7ffA_uiFUzhen9w@mail.gmail.com>
 <YwCGJLJU2+ui+hvn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwCGJLJU2+ui+hvn@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 02:58:44AM -0400, Jeff King wrote:

> > Looking at the xpatience.c I think we can remove the mmfile_t
> > parameters there as well, they are only end up being used because
> > patience_diff() gets called recursively. I'm about to go off list for
> > a week, but I can look at putting a patch together for that when I get
> > back unless you want to.
> 
> I wondered that, too, but they also get passed in to fill_hashmap(),
> which records the pointers in its "struct hashmap". It looks like those
> fields are never accessed, though, and could even be removed from the
> struct entirely!
> 
> So I think there is some room for cleanup.

And here's a patch, so we don't forget about it. It could be applied
independently of this series, but there's a small textual dependency
since we're touching a line close to the related histogram cleanup.

Thanks for mentioning this. I had given only a cursory glance before,
and just assumed it would be hard to trace. It turned out to be fun. :)

Junio: this could go on top of the jk/unused-fixes topic.

-- >8 --
Subject: xdiff: drop unused mmfile parameters from xdl_do_patience_diff()

The entry point to the patience-diff algorithm takes two mmfile_t
structs with the original file contents, but it doesn't actually do
anything useful with them. This is similar to the case recently cleaned
up in the histogram code via f1d019071e (xdiff: drop unused mmfile
parameters from xdl_do_histogram_diff(), 2022-08-19), but there's a bit
more subtlety going on.

We pass them into the recursive patience_diff(), which in turn passes
them into fill_hashmap(), which stuffs the pointers into a struct. But
the only thing which reads the struct fields is our recursion into
patience_diff()!

So it's unlikely that something like -Wunused-parameter could find this
case: it would have to detect the circular dependency caused by the
recursion (not to mention tracing across struct field assignments).

But once found, it's easy to have the compiler confirm what's going on:

  1. Drop the "file1" and "file2" fields from the hashmap struct
     definition. Remove the assignments in fill_hashmap(), and
     temporarily substitute NULL in the recursive call to
     patience_diff(). Compiling shows that no other code touched those
     fields.

  2. Now fill_hashmap() will trigger -Wunused-parameter. Drop "file1"
     and "file2" from its definition and callsite.

  3. Now patience_diff() will trigger -Wunused-parameter. Drop them
     there, too. One of the callsites is the recursion with our
     NULL values, so those temporary values go away.

  4. Now xdl_do_patience_diff() will trigger -Wunused-parameter. Drop
     them there. And we're done.

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Jeff King <peff@peff.net>
---
Explaining the 4 steps is probably overkill, but I found it a little
interesting how one can bend the compiler to their will here. At least I
didn't make it a series of 4 patches. ;)

 xdiff/xdiffi.c    |  2 +-
 xdiff/xdiffi.h    |  3 +--
 xdiff/xpatience.c | 23 +++++++----------------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 8c64519eac..32652ded2d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -321,7 +321,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 
 	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
-		res = xdl_do_patience_diff(mf1, mf2, xpp, xe);
+		res = xdl_do_patience_diff(xpp, xe);
 		goto out;
 	}
 
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 9d988e0263..126c9d8ff4 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -56,8 +56,7 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr);
 void xdl_free_script(xdchange_t *xscr);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
-int xdl_do_patience_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
-		xdfenv_t *env);
+int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env);
 int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env);
 
 #endif /* #if !defined(XDIFFI_H) */
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index fe39c2978c..a2d8955537 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -69,7 +69,6 @@ struct hashmap {
 	} *entries, *first, *last;
 	/* were common records found? */
 	unsigned long has_matches;
-	mmfile_t *file1, *file2;
 	xdfenv_t *env;
 	xpparam_t const *xpp;
 };
@@ -139,13 +138,10 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
  *
  * It is assumed that env has been prepared using xdl_prepare().
  */
-static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
-		xpparam_t const *xpp, xdfenv_t *env,
+static int fill_hashmap(xpparam_t const *xpp, xdfenv_t *env,
 		struct hashmap *result,
 		int line1, int count1, int line2, int count2)
 {
-	result->file1 = file1;
-	result->file2 = file2;
 	result->xpp = xpp;
 	result->env = env;
 
@@ -254,8 +250,7 @@ static int match(struct hashmap *map, int line1, int line2)
 	return record1->ha == record2->ha;
 }
 
-static int patience_diff(mmfile_t *file1, mmfile_t *file2,
-		xpparam_t const *xpp, xdfenv_t *env,
+static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 		int line1, int count1, int line2, int count2);
 
 static int walk_common_sequence(struct hashmap *map, struct entry *first,
@@ -286,8 +281,7 @@ static int walk_common_sequence(struct hashmap *map, struct entry *first,
 
 		/* Recurse */
 		if (next1 > line1 || next2 > line2) {
-			if (patience_diff(map->file1, map->file2,
-					map->xpp, map->env,
+			if (patience_diff(map->xpp, map->env,
 					line1, next1 - line1,
 					line2, next2 - line2))
 				return -1;
@@ -326,8 +320,7 @@ static int fall_back_to_classic_diff(struct hashmap *map,
  *
  * This function assumes that env was prepared with xdl_prepare_env().
  */
-static int patience_diff(mmfile_t *file1, mmfile_t *file2,
-		xpparam_t const *xpp, xdfenv_t *env,
+static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 		int line1, int count1, int line2, int count2)
 {
 	struct hashmap map;
@@ -346,7 +339,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 	}
 
 	memset(&map, 0, sizeof(map));
-	if (fill_hashmap(file1, file2, xpp, env, &map,
+	if (fill_hashmap(xpp, env, &map,
 			line1, count1, line2, count2))
 		return -1;
 
@@ -374,9 +367,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *file2,
 	return result;
 }
 
-int xdl_do_patience_diff(mmfile_t *file1, mmfile_t *file2,
-		xpparam_t const *xpp, xdfenv_t *env)
+int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
-	return patience_diff(file1, file2, xpp, env,
-			1, env->xdf1.nrec, 1, env->xdf2.nrec);
+	return patience_diff(xpp, env, 1, env->xdf1.nrec, 1, env->xdf2.nrec);
 }
-- 
2.37.2.931.g60e3983abc

