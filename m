Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576DC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0802B613DA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhD0VTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:43 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41518 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239226AbhD0VT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:28 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id CA5DB80591;
        Tue, 27 Apr 2021 17:18:44 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v3 29/30] subtree: push: allow specifying a local rev other than HEAD
Date:   Tue, 27 Apr 2021 15:17:47 -0600
Message-Id: <20210427211748.2607474-30-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427211748.2607474-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

'git subtree split' lets you specify a rev other than HEAD.  'git push'
lets you specify a mapping between a local thing and a remot ref.  So
smash those together, and have 'git subtree push' let you specify which
local thing to run split on and push the result of that split to the
remote ref.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh     | 24 +++++++++++++++++-------
 contrib/subtree/git-subtree.txt    | 14 ++++++++------
 contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++++++++
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 431214a1d3..9e4d9a0619 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -27,7 +27,7 @@ git subtree add   --prefix=<prefix> <repository> <ref>
 git subtree merge --prefix=<prefix> <commit>
 git subtree split --prefix=<prefix> [<commit>]
 git subtree pull  --prefix=<prefix> <repository> <ref>
-git subtree push  --prefix=<prefix> <repository> <ref>
+git subtree push  --prefix=<prefix> <repository> <refspec>
 --
 h,help        show the help
 q             quiet
@@ -952,20 +952,30 @@ cmd_pull () {
 	cmd_merge FETCH_HEAD
 }
 
-# Usage: cmd_push REPOSITORY REMOTEREF
+# Usage: cmd_push REPOSITORY [+][LOCALREV:]REMOTEREF
 cmd_push () {
 	if test $# -ne 2
 	then
-		die "You must provide <repository> <ref>"
+		die "You must provide <repository> <refspec>"
 	fi
-	ensure_valid_ref_format "$2"
 	if test -e "$dir"
 	then
 		repository=$1
-		refspec=$2
+		refspec=${2#+}
+		remoteref=${refspec#*:}
+		if test "$remoteref" = "$refspec"
+		then
+			localrevname_presplit=HEAD
+		else
+			localrevname_presplit=${refspec%%:*}
+		fi
+		ensure_valid_ref_format "$remoteref"
+		localrev_presplit=$(git rev-parse -q --verify "$localrevname_presplit^{commit}") ||
+			die "'$localrevname_presplit' does not refer to a commit"
+
 		echo "git push using: " "$repository" "$refspec"
-		localrev=$(cmd_split) || die
-		git push "$repository" "$localrev":"refs/heads/$refspec"
+		localrev=$(cmd_split "$localrev_presplit") || die
+		git push "$repository" "$localrev":"refs/heads/$remoteref"
 	else
 		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index fbb52f127b..9cddfa2654 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 
 [verse]
 'git subtree' [<options>] -P <prefix> pull <repository> <remote-ref>
-'git subtree' [<options>] -P <prefix> push <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> push <repository> <refspec>
 
 DESCRIPTION
 -----------
@@ -115,11 +115,13 @@ pull <repository> <remote-ref>::
 	it fetches the given ref from the specified remote
 	repository.
 
-push <repository> <remote-ref>::
-	Does a 'split' using the <prefix> subtree of HEAD and then
-	does a 'git push' to push the result to the <repository> and
-	<remote-ref>.  This can be used to push your subtree to
-	different branches of the remote repository.
+push <repository> [+][<local-commit>:]<remote-ref>::
+	Does a 'split' using the <prefix> subtree of <local-commit>
+	and then does a 'git push' to push the result to the
+	<repository> and <remote-ref>.  This can be used to push your
+	subtree to different branches of the remote repository.  Just
+	as with 'split', if no <local-commit> is given, then HEAD is
+	used.  The optional leading '+' is ignored.
 
 OPTIONS FOR ALL COMMANDS
 ------------------------
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 5a6541437b..d7ad6ffff0 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -820,6 +820,28 @@ test_expect_success 'push "sub dir"/ with --branch for an incompatible branch' '
 	)
 '
 
+test_expect_success 'push "sub dir"/ with a local rev' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		bad_tree=$(git rev-parse --verify HEAD:"sub dir") &&
+		good_tree=$(git rev-parse --verify HEAD^:"sub dir") &&
+		git subtree push --prefix="sub dir" --annotate="*" ./"sub proj" HEAD^:from-mainline &&
+		split_tree=$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline:) &&
+		test "$split_tree" = "$good_tree"
+	)
+'
+
 #
 # Validity checking
 #
-- 
2.31.1

