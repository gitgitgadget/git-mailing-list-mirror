Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6962FC43381
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEF864DF5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBPOpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:45:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:34208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBPOpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:45:16 -0500
Received: (qmail 13425 invoked by uid 109); 16 Feb 2021 14:44:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:44:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24753 invoked by uid 111); 16 Feb 2021 14:44:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:44:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:44:34 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 5/6] exclude: do not respect symlinks for in-tree .gitignore
Message-ID: <YCvaUukNiliIXHgq@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with .gitattributes, we would like to make sure that .gitignore files
are handled consistently whether read from the index or from the
filesystem. Likewise, we would like to avoid reading out-of-tree files
pointed to by the symlinks, which could have security implications in
certain setups.

We can cover both by using open_nofollow() when opening the in-tree
files. We'll continue to follow links for core.excludesFile, as well as
$GIT_DIR/info/exclude.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c              | 12 ++++++++++--
 t/t0008-ignores.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index f7fb1db718..3692a28186 100644
--- a/dir.c
+++ b/dir.c
@@ -1035,6 +1035,9 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
 				    struct pattern_list *pl);
 
+/* Flags for add_patterns() */
+#define PATTERN_NOFOLLOW (1<<0)
+
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * an index if 'istate' is non-null), parse it and store the
@@ -1054,7 +1057,11 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 	size_t size = 0;
 	char *buf;
 
-	fd = open(fname, O_RDONLY);
+	if (flags & PATTERN_NOFOLLOW)
+		fd = open_nofollow(fname, O_RDONLY);
+	else
+		fd = open(fname, O_RDONLY);
+
 	if (fd < 0 || fstat(fd, &st) < 0) {
 		if (fd < 0)
 			warn_on_fopen_errors(fname);
@@ -1558,7 +1565,8 @@ static void prep_exclude(struct dir_struct *dir,
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			pl->src = strbuf_detach(&sb, NULL);
-			add_patterns(pl->src, pl->src, stk->baselen, pl, istate, 0,
+			add_patterns(pl->src, pl->src, stk->baselen, pl, istate,
+				     PATTERN_NOFOLLOW,
 				     untracked ? &oid_stat : NULL);
 		}
 		/*
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 370a389e5c..854cfda11f 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -865,4 +865,38 @@ test_expect_success 'info/exclude trumps core.excludesfile' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'set up ignore file for symlink tests' '
+	echo "*" >ignore &&
+	rm -f .gitignore .git/info/exclude
+'
+
+test_expect_success SYMLINKS 'symlinks respected in core.excludesFile' '
+	test_when_finished "rm symlink" &&
+	ln -s ignore symlink &&
+	test_config core.excludesFile "$(pwd)/symlink" &&
+	echo file >expect &&
+	git check-ignore file >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+'
+
+test_expect_success SYMLINKS 'symlinks respected in info/exclude' '
+	test_when_finished "rm .git/info/exclude" &&
+	ln -s ../../ignore .git/info/exclude &&
+	echo file >expect &&
+	git check-ignore file >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+'
+
+test_expect_success SYMLINKS 'symlinks not respected in-tree' '
+	test_when_finished "rm .gitignore" &&
+	ln -s ignore .gitignore &&
+	mkdir subdir &&
+	ln -s ignore subdir/.gitignore &&
+	test_must_fail git check-ignore subdir/file >actual 2>err &&
+	test_must_be_empty actual &&
+	test_i18ngrep "unable to access.*gitignore" err
+'
+
 test_done
-- 
2.30.1.986.gd86016a168

