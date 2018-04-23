Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815B21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932643AbeDWXlD (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60688 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932766AbeDWXkt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A50E60D6A;
        Mon, 23 Apr 2018 23:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526847;
        bh=xhXrybH+ytYnyFAWMpphb3h7Jv51Co/G7dPtPcS2a/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GY81IPRo3806cNyAOfAADf1lAIS1/P4qo48pDnoZafcrF9lexCS+Bx+u5p/8kVi6Z
         4o+UBilavQTriM8F/ONF5osgi9bya3Gxoikj/oVMBybMzRCb48FnpKNDOJJ2yVTJjr
         Xu0b5UAc9wvZJ9pXfYjOvGK/rNy3famGN77Px1zYflL6iKixR7dX9V6i5VLMlkGWm8
         ruT5i04bbjo5IBhiJWBG01Lc6G71deZXp/fJtiJlkKlka7HtpoYzyrTUfU4xQRTqoC
         DD7WLB8UK/+iit3oKkLXVaRVyE2Le+EH/JIByJld03QyfPqIZReoPKlLjJndKAWjuM
         u7DM7SzkM4MWOh+Kmplw8X7ZP/pyqX/2Gt/y/P+G/dtZ4Ia0PmOoAZurIzm/FBIqHq
         yWXtnN2sFnKctfaKdPoxyoOiICmHDREmjfcCOZg6DhDq2mUPd6XCoo6cdTweti1RGe
         gbVc3h9be5DE6uoObKpkkQP1fg+7bP1jPvmacoYYZhPoysQ+F8/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 39/41] Update shell scripts to compute empty tree object ID
Date:   Mon, 23 Apr 2018 23:39:49 +0000
Message-Id: <20180423233951.276447-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several of our shell scripts hard-code the object ID of the empty tree.
To avoid any problems when changing hashes, compute this value on
startup of the script.  For performance, store the value in a variable
and reuse it throughout the life of the script.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-filter-branch.sh               | 4 +++-
 git-rebase--interactive.sh         | 4 +++-
 templates/hooks--pre-commit.sample | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 64f21547c1..ccceaf19a7 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -11,6 +11,8 @@
 # The following functions will also be available in the commit filter:
 
 functions=$(cat << \EOF
+EMPTY_TREE=$(git hash-object -t tree /dev/null)
+
 warn () {
 	echo "$*" >&2
 }
@@ -46,7 +48,7 @@ git_commit_non_empty_tree()
 {
 	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
 		map "$3"
-	elif test $# = 1 && test "$1" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904; then
+	elif test $# = 1 && test "$1" = $EMPTY_TREE; then
 		:
 	else
 		git commit-tree "$@"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 50323fc273..cc873d630d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,6 +81,8 @@ rewritten_pending="$state_dir"/rewritten-pending
 # and leaves CR at the end instead.
 cr=$(printf "\015")
 
+empty_tree=$(git hash-object -t tree /dev/null)
+
 strategy_args=${strategy:+--strategy=$strategy}
 test -n "$strategy_opts" &&
 eval '
@@ -238,7 +240,7 @@ is_empty_commit() {
 		die "$(eval_gettext "\$sha1: not a commit that can be picked")"
 	}
 	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
-		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+		ptree=$empty_tree
 	test "$tree" = "$ptree"
 }
 
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 68d62d5446..6a75641638 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -12,7 +12,7 @@ then
 	against=HEAD
 else
 	# Initial commit: diff against an empty tree object
-	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	against=$(git hash-object -t tree /dev/null)
 fi
 
 # If you want to allow non-ASCII filenames set this variable to true.
