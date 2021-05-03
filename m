Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A90C43460
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED03610C8
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhECUoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:44:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:43584 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhECUoU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:44:20 -0400
Received: (qmail 7636 invoked by uid 109); 3 May 2021 20:43:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:43:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7531 invoked by uid 111); 3 May 2021 20:43:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:43:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:43:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 8/9] fsck: warn about symlinked dotfiles we'll open with
 O_NOFOLLOW
Message-ID: <YJBgbfxayKvMAXaC@coredump.intra.peff.net>
References: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJBgMP9eXq31INyN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commits merged in via 204333b015 (Merge branch
'jk/open-dotgitx-with-nofollow', 2021-03-22), we stopped following
symbolic links for .gitattributes, .gitignore, and .mailmap files.

Let's teach fsck to warn that these symlinks are not going to do
anything. Note that this is just a warning, and won't block the objects
via transfer.fsckObjects, since there are reported to be cases of this
in the wild (and even once fixed, they will continue to exist in the
commit history of those projects, but are not particularly dangerous).

Note that we won't add these to the existing gitmodules block in the
fsck code. The logic for gitmodules is a bit more complicated, as we
also check the content of non-symlink instances we find. But for these
new files, there is no content check; we're just looking at the name and
mode of the tree entry (and we can avoid even the complicated name
checks in the common case that the mode doesn't indicate a symlink).

We can reuse the test helper function we defined for .gitmodules, though
(it needs some slight adjustments for the fsck error code, and because
we don't block these symlinks via verify_path()).

Note that I didn't explicitly test the transfer.fsckObjects case here
(nor does the existing .gitmodules test that it blocks a push). The
translation of fsck severities to outcomes is covered in general in
t5504.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                      | 18 ++++++++++++++++++
 fsck.h                      |  3 +++
 t/t7450-bad-git-dotfiles.sh | 29 +++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index db94817898..3ec500d707 100644
--- a/fsck.c
+++ b/fsck.c
@@ -614,6 +614,24 @@ static int fsck_tree(const struct object_id *tree_oid,
 						 ".gitmodules is a symbolic link");
 		}
 
+		if (S_ISLNK(mode)) {
+			if (is_hfs_dotgitignore(name) ||
+			    is_ntfs_dotgitignore(name))
+				retval += report(options, tree_oid, OBJ_TREE,
+						 FSCK_MSG_GITIGNORE_SYMLINK,
+						 ".gitignore is a symlink");
+			if (is_hfs_dotgitattributes(name) ||
+			    is_ntfs_dotgitattributes(name))
+				retval += report(options, tree_oid, OBJ_TREE,
+						 FSCK_MSG_GITATTRIBUTES_SYMLINK,
+						 ".gitattributes is a symlink");
+			if (is_hfs_dotmailmap(name) ||
+			    is_ntfs_dotmailmap(name))
+				retval += report(options, tree_oid, OBJ_TREE,
+						 FSCK_MSG_MAILMAP_SYMLINK,
+						 ".mailmap is a symlink");
+		}
+
 		if ((backslash = strchr(name, '\\'))) {
 			while (backslash) {
 				backslash++;
diff --git a/fsck.h b/fsck.h
index 7202c3c87e..d07f7a2459 100644
--- a/fsck.h
+++ b/fsck.h
@@ -67,6 +67,9 @@ enum fsck_msg_type {
 	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
+	FUNC(GITIGNORE_SYMLINK, INFO) \
+	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
+	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	/* ignored (elevated when requested) */ \
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index b494d72976..e2773bb06d 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -140,6 +140,18 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
 '
 
 check_dotx_symlink () {
+	fsck_must_fail=test_must_fail
+	fsck_prefix=error
+	refuse_index=t
+	case "$1" in
+	--warning)
+		fsck_must_fail=
+		fsck_prefix=warning
+		refuse_index=
+		shift
+		;;
+	esac
+
 	name=$1
 	type=$2
 	path=$3
@@ -172,11 +184,12 @@ check_dotx_symlink () {
 
 			# Check not only that we fail, but that it is due to the
 			# symlink detector
-			test_must_fail git fsck 2>output &&
-			grep "tree $tree: ${name}Symlink" output
+			$fsck_must_fail git fsck 2>output &&
+			grep "$fsck_prefix.*tree $tree: ${name}Symlink" output
 		)
 	'
 
+	test -n "$refuse_index" &&
 	test_expect_success "refuse to load symlinked $name into index ($type)" '
 		test_must_fail \
 			git -C $dir \
@@ -193,6 +206,18 @@ check_dotx_symlink gitmodules vanilla .gitmodules
 check_dotx_symlink gitmodules ntfs ".gitmodules ."
 check_dotx_symlink gitmodules hfs ".${u200c}gitmodules"
 
+check_dotx_symlink --warning gitattributes vanilla .gitattributes
+check_dotx_symlink --warning gitattributes ntfs ".gitattributes ."
+check_dotx_symlink --warning gitattributes hfs ".${u200c}gitattributes"
+
+check_dotx_symlink --warning gitignore vanilla .gitignore
+check_dotx_symlink --warning gitignore ntfs ".gitignore ."
+check_dotx_symlink --warning gitignore hfs ".${u200c}gitignore"
+
+check_dotx_symlink --warning mailmap vanilla .mailmap
+check_dotx_symlink --warning mailmap ntfs ".mailmap ."
+check_dotx_symlink --warning mailmap hfs ".${u200c}mailmap"
+
 test_expect_success 'fsck detects non-blob .gitmodules' '
 	git init non-blob &&
 	(
-- 
2.31.1.926.gd12152deb6

