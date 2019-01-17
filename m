Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE751F453
	for <e@80x24.org>; Thu, 17 Jan 2019 16:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfAQQ1O (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 11:27:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:39912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725882AbfAQQ1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 11:27:13 -0500
Received: (qmail 29309 invoked by uid 109); 17 Jan 2019 16:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Jan 2019 16:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1704 invoked by uid 111); 17 Jan 2019 16:27:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 17 Jan 2019 11:27:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2019 11:27:11 -0500
Date:   Thu, 17 Jan 2019 11:27:11 -0500
From:   Jeff King <peff@peff.net>
To:     Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Aleksey Pivovarov <aleksey.pivovarov@jetbrains.com>
Subject: Re: git add =?utf-8?B?4oCUaWdub3JlLWVycm9y?= =?utf-8?Q?s?= causes
 --renormalize
Message-ID: <20190117162711.GA7935@sigill.intra.peff.net>
References: <401130AF-056B-40BF-8001-8492223B8A6B@jetbrains.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <401130AF-056B-40BF-8001-8492223B8A6B@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 06:22:05PM +0300, Dmitriy Smirnov wrote:

> Calling `git add —ignore-errors` appears to be equal to calling `git add —renormalize`:
> 
> Main.java is saved with CRLF in repo
> git config core.autocrlf = input
> 
> $ src  git:(master) echo line >> Main.java  
> $ src  git:(master) git add --ignore-errors Main.java  
> $ src  git:(master) git commit -m "Ignore errors"                          
> [master cf24b3b] Ignore errors
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> 
> The reason appears to be wrong bit mask usage
> 
> #define ADD_CACHE_IGNORE_ERRORS    4
> and
> #define HASH_RENORMALIZE  4
> 
> Looks like a regression since 2.16.0 - 9472935d81eaf9faed771878c9df0216ae0d9045

Thanks for a very clear report! The patch below should fix it.

-- >8 --
Subject: [PATCH] add: use separate ADD_CACHE_RENORMALIZE flag

Commit 9472935d81 (add: introduce "--renormalize", 2017-11-16) taught
git-add to pass HASH_RENORMALIZE to add_to_index(), which then passes
the flag along to index_path(). However, the flags taken by
add_to_index() and the ones taken by index_path() are distinct
namespaces. We cannot take HASH_* flags in add_to_index(), because they
overlap with the ADD_CACHE_* flags we already take (in this case,
HASH_RENORMALIZE conflicts with ADD_CACHE_IGNORE_ERRORS).

We can solve this by adding a new ADD_CACHE_RENORMALIZE flag, and using
it to set HASH_RENORMALIZE within add_to_index(). In order to make it
clear that these two flags come from distinct sets, let's also change
the name "newflags" in the function to "hash_flags".

Reported-by: Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c               | 2 +-
 cache.h                     | 1 +
 read-cache.c                | 8 ++++----
 t/t0025-crlf-renormalize.sh | 9 +++++++++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 12247b48fd..f481ae548e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -137,7 +137,7 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 			continue; /* do not touch non blobs */
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
-		retval |= add_file_to_cache(ce->name, flags | HASH_RENORMALIZE);
+		retval |= add_file_to_cache(ce->name, flags | ADD_CACHE_RENORMALIZE);
 	}
 
 	return retval;
diff --git a/cache.h b/cache.h
index 49713cc5a5..11b19505fc 100644
--- a/cache.h
+++ b/cache.h
@@ -745,6 +745,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
+#define ADD_CACHE_RENORMALIZE 64        /* Pass along HASH_RENORMALIZE */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 
diff --git a/read-cache.c b/read-cache.c
index bfff271a3d..9783c493a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -703,10 +703,10 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int intent_only = flags & ADD_CACHE_INTENT;
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
-	int newflags = HASH_WRITE_OBJECT;
+	int hash_flags = HASH_WRITE_OBJECT;
 
-	if (flags & HASH_RENORMALIZE)
-		newflags |= HASH_RENORMALIZE;
+	if (flags & ADD_CACHE_RENORMALIZE)
+		hash_flags |= HASH_RENORMALIZE;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error(_("%s: can only add regular files, symbolic links or git-directories"), path);
@@ -762,7 +762,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		}
 	}
 	if (!intent_only) {
-		if (index_path(istate, &ce->oid, path, st, newflags)) {
+		if (index_path(istate, &ce->oid, path, st, hash_flags)) {
 			discard_cache_entry(ce);
 			return error(_("unable to index file '%s'"), path);
 		}
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index 9d9e02a211..e13363ade5 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -27,4 +27,13 @@ test_expect_success 'renormalize CRLF in repo' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ignore-errors not mistaken for renormalize' '
+	git reset --hard &&
+	echo "*.txt text=auto" >.gitattributes &&
+	git ls-files --eol >expect &&
+	git add --ignore-errors "*.txt" &&
+	git ls-files --eol >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.20.1.689.g635a1dda8a

