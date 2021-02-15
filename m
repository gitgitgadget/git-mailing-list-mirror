Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A6FC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3762164DE8
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBOXTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 18:19:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:33320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhBOXTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 18:19:16 -0500
Received: (qmail 9422 invoked by uid 109); 15 Feb 2021 23:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Feb 2021 23:18:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17306 invoked by uid 111); 15 Feb 2021 23:18:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Feb 2021 18:18:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Feb 2021 18:18:29 -0500
From:   Jeff King <peff@peff.net>
To:     Blake Burkhart <bburky@bburky.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 1/2] fsck: make symlinked .gitignore and .gitattributes a
 warning
Message-ID: <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCsBA002yv8XpppM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently added fsck checks to complain about symlinked .gitignore and
.gitattributes files, which are no longer allowed to be checked out.
This is partially to inform fsck users of the problem, but also to
protect older clients from receiving them (by blocking push and fetch
via transfer.fsckObjects).

While there are some minor security implications to having these files
be symlinks, this is out-weighed by the inconvenience of blocking
historical commits in some projects that might include them.

Let's loosen the fsck check to a warning. It will continue to be
reported by both git-fsck and transfer.fsckObjects, but will not impact
the exit code or the acceptance of objects. Note that internally in
fsck.c this is called "INFO", but the word "warning" will appear in
user-visible output.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                       |  4 ++--
 t/t7450-bad-dotgitx-files.sh | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fsck.c b/fsck.c
index d0a201348d..c75c7d7dc7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -67,8 +67,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(GITMODULES_URL, ERROR) \
 	FUNC(GITMODULES_PATH, ERROR) \
 	FUNC(GITMODULES_UPDATE, ERROR) \
-	FUNC(GITIGNORE_SYMLINK, ERROR) \
-	FUNC(GITATTRIBUTES_SYMLINK, ERROR) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
@@ -81,6 +79,8 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
+	FUNC(GITIGNORE_SYMLINK, INFO) \
+	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	/* ignored (elevated when requested) */ \
diff --git a/t/t7450-bad-dotgitx-files.sh b/t/t7450-bad-dotgitx-files.sh
index 326b34e167..4b1edb150e 100755
--- a/t/t7450-bad-dotgitx-files.sh
+++ b/t/t7450-bad-dotgitx-files.sh
@@ -140,6 +140,16 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
 '
 
 check_forbidden_symlink () {
+	fsck_must_fail=test_must_fail
+	fsck_prefix=error
+	case "$1" in
+	--fsck-warning)
+		fsck_must_fail=
+		fsck_prefix=warning
+		shift
+		;;
+	esac
+
 	name=$1
 	type=$2
 	path=$3
@@ -172,8 +182,8 @@ check_forbidden_symlink () {
 
 			# Check not only that we fail, but that it is due to the
 			# symlink detector
-			test_must_fail git fsck 2>output &&
-			test_i18ngrep "tree $tree: ${name}Symlink" output
+			$fsck_must_fail git fsck 2>output &&
+			test_i18ngrep "$fsck_prefix.*tree $tree: ${name}Symlink" output
 		)
 	'
 
@@ -193,13 +203,13 @@ check_forbidden_symlink gitmodules vanilla .gitmodules
 check_forbidden_symlink gitmodules ntfs ".gitmodules ."
 check_forbidden_symlink gitmodules hfs ".${u200c}gitmodules"
 
-check_forbidden_symlink gitattributes vanilla .gitattributes
-check_forbidden_symlink gitattributes ntfs ".gitattributes ."
-check_forbidden_symlink gitattributes hfs ".${u200c}gitattributes"
+check_forbidden_symlink --fsck-warning gitattributes vanilla .gitattributes
+check_forbidden_symlink --fsck-warning gitattributes ntfs ".gitattributes ."
+check_forbidden_symlink --fsck-warning gitattributes hfs ".${u200c}gitattributes"
 
-check_forbidden_symlink gitignore vanilla .gitignore
-check_forbidden_symlink gitignore ntfs ".gitignore ."
-check_forbidden_symlink gitignore hfs ".${u200c}gitignore"
+check_forbidden_symlink --fsck-warning gitignore vanilla .gitignore
+check_forbidden_symlink --fsck-warning gitignore ntfs ".gitignore ."
+check_forbidden_symlink --fsck-warning gitignore hfs ".${u200c}gitignore"
 
 test_expect_success 'fsck detects non-blob .gitmodules' '
 	git init non-blob &&
-- 
2.30.1.986.gd86016a168

