Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EBFC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D4620756
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJEHZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:25:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:49266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgJEHZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:25:04 -0400
Received: (qmail 30369 invoked by uid 109); 5 Oct 2020 07:25:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 07:25:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16588 invoked by uid 111); 5 Oct 2020 07:25:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 03:25:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 03:25:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] fsck: complain when .gitattributes or .gitignore is a
 symlink
Message-ID: <20201005072503.GG2291074@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005071751.GA2290770@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit made it impossible to have a symlinked
.gitattributes or .gitignore file via verify_path(). Let's add the same
check to fsck, which matches how we handle .gitmodules symlinks, via
b7b1fca175 (fsck: complain when .gitmodules is a symlink, 2018-05-04).

Note that we won't add these to the existing gitmodules block. Its logic
is a bit more complicated, as we also check the content of non-symlink
instances we find. But for these new files, there is no content check;
we're just looking at the name and mode of the tree entry (and we can
avoid even the complicated name checks in the common case that the mode
doesn't indicate a symlink).

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                    | 15 +++++++++++++++
 t/t7450-bad-meta-files.sh |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/fsck.c b/fsck.c
index 024810139b..fcd3f268b1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -67,6 +67,8 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(GITMODULES_URL, ERROR) \
 	FUNC(GITMODULES_PATH, ERROR) \
 	FUNC(GITMODULES_UPDATE, ERROR) \
+	FUNC(GITIGNORE_SYMLINK, ERROR) \
+	FUNC(GITATTRIBUTES_SYMLINK, ERROR) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
@@ -688,6 +690,19 @@ static int fsck_tree(const struct object_id *tree_oid,
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
+		}
+
 		if ((backslash = strchr(name, '\\'))) {
 			while (backslash) {
 				backslash++;
diff --git a/t/t7450-bad-meta-files.sh b/t/t7450-bad-meta-files.sh
index 6a038ed55b..c7201803ec 100755
--- a/t/t7450-bad-meta-files.sh
+++ b/t/t7450-bad-meta-files.sh
@@ -281,6 +281,11 @@ test_expect_success 'refuse to load symlinked .gitattributes into index' '
 	test_i18ngrep "invalid path.*gitattributes" err
 '
 
+test_expect_success 'fsck detects symlinked .gitattributes file' '
+	test_must_fail git -C symlink-attr fsck 2>err &&
+	test_i18ngrep "tree $tree: gitattributesSymlink" err
+'
+
 test_expect_success 'create repo with symlinked .gitignore file' '
 	git init symlink-ignore &&
 	target=$(echo target | git -C symlink-ignore hash-object -w --stdin) &&
@@ -295,5 +300,9 @@ test_expect_success 'refuse to load symlinked .gitignore into index' '
 	test_i18ngrep "invalid path.*gitignore" err
 '
 
+test_expect_success 'fsck detects symlinked .gitignore file' '
+	test_must_fail git -C symlink-ignore fsck 2>err &&
+	test_i18ngrep "tree $tree: gitignoreSymlink" err
+'
 
 test_done
-- 
2.28.0.1295.g4824feede7
