Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A38620193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbcKBNJO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:09:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:37463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbcKBNJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:09:13 -0400
Received: (qmail 22833 invoked by uid 109); 2 Nov 2016 13:09:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:09:13 +0000
Received: (qmail 2742 invoked by uid 111); 2 Nov 2016 13:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 09:09:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 09:09:11 -0400
Date:   Wed, 2 Nov 2016 09:09:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] exclude: do not respect symlinks for in-tree .gitignore
Message-ID: <20161102130911.gj2h6cya3mzx6cwt@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like .gitattributes, we would like to make sure that
.gitignore files are handled consistently whether read from
the index or from the filesystem. We can do so by using
O_NOFOLLOW when opening the files.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c              |  9 +++++++--
 t/t0008-ignores.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 4fa1ca109..cf3fde005 100644
--- a/dir.c
+++ b/dir.c
@@ -693,6 +693,7 @@ static void invalidate_directory(struct untracked_cache *uc,
 
 /* Flags for add_excludes() */
 #define EXCLUDE_CHECK_INDEX (1<<0)
+#define EXCLUDE_NOFOLLOW (1<<1)
 
 /*
  * Given a file with name "fname", read it (either from disk, or from
@@ -713,7 +714,11 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 	size_t size = 0;
 	char *buf, *entry;
 
-	fd = open(fname, O_RDONLY);
+	if (flags & EXCLUDE_NOFOLLOW)
+		fd = open_nofollow(fname, O_RDONLY);
+	else
+		fd = open(fname, O_RDONLY);
+
 	if (fd < 0 || fstat(fd, &st) < 0) {
 		if (errno != ENOENT)
 			warn_on_inaccessible(fname);
@@ -1130,7 +1135,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
 			add_excludes(el->src, el->src, stk->baselen, el,
-				     EXCLUDE_CHECK_INDEX,
+				     EXCLUDE_CHECK_INDEX | EXCLUDE_NOFOLLOW,
 				     untracked ? &sha1_stat : NULL);
 		}
 		/*
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index d27f438bf..7348b8e6a 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -841,4 +841,33 @@ test_expect_success 'info/exclude trumps core.excludesfile' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'set up ignore file for symlink tests' '
+	echo "*" >ignore
+'
+
+test_expect_success SYMLINKS 'symlinks respected in core.excludesFile' '
+	test_when_finished "rm symlink" &&
+	ln -s ignore symlink &&
+	test_config core.excludesFile "$(pwd)/symlink" &&
+	echo file >expect &&
+	git check-ignore file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'symlinks respected in info/exclude' '
+	test_when_finished "rm .git/info/exclude" &&
+	ln -sf ../../ignore .git/info/exclude &&
+	echo file >expect &&
+	git check-ignore file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'symlinks not respected in-tree' '
+	test_when_finished "rm .gitignore" &&
+	ln -sf ignore .gitignore &&
+	>expect &&
+	test_must_fail git check-ignore file >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.rc0.258.gf434c15
