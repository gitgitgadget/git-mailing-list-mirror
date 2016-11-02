Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EA620193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbcKBNHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:07:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:37457 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbcKBNHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:07:12 -0400
Received: (qmail 22700 invoked by uid 109); 2 Nov 2016 13:07:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:07:12 +0000
Received: (qmail 2707 invoked by uid 111); 2 Nov 2016 13:07:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 09:07:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 09:07:10 -0400
Date:   Wed, 2 Nov 2016 09:07:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] exclude: convert "check_index" into a flags field
Message-ID: <20161102130709.5dm5hmrgknadf5zm@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass the "check_index" flag through the variants of
add_excludes(). Let's turn this into a full flags bit-field,
so that we can add more flags to it without affecting the
function signature.

Note that only one caller actually needs to use the new flag
name, as the rest all were passing "0" already.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 13 +++++++++----
 dir.h |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a9a..4fa1ca109 100644
--- a/dir.c
+++ b/dir.c
@@ -691,6 +691,9 @@ static void invalidate_directory(struct untracked_cache *uc,
 		dir->dirs[i]->recurse = 0;
 }
 
+/* Flags for add_excludes() */
+#define EXCLUDE_CHECK_INDEX (1<<0)
+
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * the index if "check_index" is non-zero), parse it and store the
@@ -701,9 +704,10 @@ static void invalidate_directory(struct untracked_cache *uc,
  * ss_valid is non-zero, "ss" must contain good value as input.
  */
 static int add_excludes(const char *fname, const char *base, int baselen,
-			struct exclude_list *el, int check_index,
+			struct exclude_list *el, unsigned flags,
 			struct sha1_stat *sha1_stat)
 {
+	int check_index = !!(flags & EXCLUDE_CHECK_INDEX);
 	struct stat st;
 	int fd, i, lineno = 1;
 	size_t size = 0;
@@ -787,9 +791,9 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 
 int add_excludes_from_file_to_list(const char *fname, const char *base,
 				   int baselen, struct exclude_list *el,
-				   int check_index)
+				   unsigned flags)
 {
-	return add_excludes(fname, base, baselen, el, check_index, NULL);
+	return add_excludes(fname, base, baselen, el, flags, NULL);
 }
 
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
@@ -1125,7 +1129,8 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
-			add_excludes(el->src, el->src, stk->baselen, el, 1,
+			add_excludes(el->src, el->src, stk->baselen, el,
+				     EXCLUDE_CHECK_INDEX,
 				     untracked ? &sha1_stat : NULL);
 		}
 		/*
diff --git a/dir.h b/dir.h
index 97c83bb38..ba7eb924c 100644
--- a/dir.h
+++ b/dir.h
@@ -239,7 +239,7 @@ extern int is_excluded(struct dir_struct *dir, const char *name, int *dtype);
 extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
 					     int group_type, const char *src);
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-					  struct exclude_list *el, int check_index);
+					  struct exclude_list *el, unsigned flags);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
-- 
2.11.0.rc0.258.gf434c15

