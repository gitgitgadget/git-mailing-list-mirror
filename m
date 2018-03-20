Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A373C1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 11:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeCTLLW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 07:11:22 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:59339 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeCTLLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 07:11:15 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yFAYeoeajwheayFAgepoFu; Tue, 20 Mar 2018 11:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521544274;
        bh=e6M7Z1vpTXEVeC3xfVxUCXhrXpNggqPSGPHMEayPmsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=URyrMiEJsrf17GwCH9muy/TQVOuskitKJ7PivH6Kq67bmbxqPmhosJB/uetUoXDwL
         IDXaR2LLusOb45a3V/zl5eijbP44zuna0mhz9id6WMZLoa40QKe6ntxyb1lOoqWiA2
         F8PixV79QI0kk1VM1DG61Vs1ktf+nbZtx3jNuePw=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=ko07KDYuzhHupL07CEkA:9
 a=RpkZxLk4WVXi8tnc:21 a=hdjgHSEy9KawI-nA:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/3] rebase --keep-empty: always use interactive rebase
Date:   Tue, 20 Mar 2018 11:10:57 +0000
Message-Id: <20180320111057.23862-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320111057.23862-1-phillip.wood@talktalk.net>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
 <20180320111057.23862-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHwBzXrLqkkthml9O2Lnxl5k0riKopV55Yi/aPiyAJt+LuB1GjHGzevuMXW1Q6MOzmrA4e/DwxFPZOep0mHXfiNAaTB8hA2vh+0hTH/kMnhshem+Hw9J
 eJ6/iTNGRjnz0Oqk962EAZA9CRK+lVGobNiKoFsJSnqgXGXQEWariWwTbMEgHB+3gLh3PBPrrFkYh+tfxyG8e+y3CFcaTj5KN2S4y6yLLBsDWNfNBaLIlWFm
 1IKjqSIa/CWZodiVhNI09gAYJZBBZg0MIfzGW+t7g2IBTXZJHdIDsvGxc5lz4Lkn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

rebase --merge accepts --keep-empty but just ignores it, by using an
implicit interactive rebase the user still gets the rename detection
of a merge based rebase but with with --keep-empty support.

If rebase --keep-empty without --interactive or --merge stops for the
user to resolve merge conflicts then 'git rebase --continue' will
fail. This is because it uses a different code path that does not
create $git_dir/rebase-apply. As rebase --keep-empty was implemented
using cherry-pick it has never supported the am options and now that
interactive rebases support --signoff there is no loss of
functionality by using an implicit interactive rebase.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase--am.sh                 | 79 ++++++++++++++++-----------------------
 git-rebase.sh                     |  5 +++
 t/t3421-rebase-topology-linear.sh |  4 +-
 3 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index be3f068922..ae596d3731 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -41,60 +41,47 @@ else
 fi
 
 ret=0
-if test -n "$keep_empty"
-then
-	# we have to do this the hard way.  git format-patch completely squashes
-	# empty commits and even if it didn't the format doesn't really lend
-	# itself well to recording empty patches.  fortunately, cherry-pick
-	# makes this easy
-	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
-		$allow_rerere_autoupdate --right-only "$revisions" \
-		$allow_empty_message \
-		${restrict_revision+^$restrict_revision}
-	ret=$?
-else
-	rm -f "$GIT_DIR/rebased-patches"
+rm -f "$GIT_DIR/rebased-patches"
 
-	git format-patch -k --stdout --full-index --cherry-pick --right-only \
-		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-		--pretty=mboxrd \
-		$git_format_patch_opt \
-		"$revisions" ${restrict_revision+^$restrict_revision} \
-		>"$GIT_DIR/rebased-patches"
-	ret=$?
+git format-patch -k --stdout --full-index --cherry-pick --right-only \
+	--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+	--pretty=mboxrd \
+	$git_format_patch_opt \
+	"$revisions" ${restrict_revision+^$restrict_revision} \
+	>"$GIT_DIR/rebased-patches"
+ret=$?
 
-	if test 0 != $ret
-	then
-		rm -f "$GIT_DIR/rebased-patches"
-		case "$head_name" in
-		refs/heads/*)
-			git checkout -q "$head_name"
-			;;
-		*)
-			git checkout -q "$orig_head"
-			;;
-		esac
+if test 0 != $ret
+then
+	rm -f "$GIT_DIR/rebased-patches"
+	case "$head_name" in
+	refs/heads/*)
+		git checkout -q "$head_name"
+		;;
+	*)
+		git checkout -q "$orig_head"
+		;;
+	esac
 
-		cat >&2 <<-EOF
+	cat >&2 <<-EOF
 
-		git encountered an error while preparing the patches to replay
-		these revisions:
+	git encountered an error while preparing the patches to replay
+	these revisions:
 
-		    $revisions
+	    $revisions
 
-		As a result, git cannot rebase them.
-		EOF
-		return $ret
-	fi
+	As a result, git cannot rebase them.
+	EOF
+	return $ret
+fi
 
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
-		--patch-format=mboxrd \
-		$allow_rerere_autoupdate \
-		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
-	ret=$?
+git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
+	--patch-format=mboxrd \
+	$allow_rerere_autoupdate \
+	${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
+ret=$?
 
-	rm -f "$GIT_DIR/rebased-patches"
-fi
+rm -f "$GIT_DIR/rebased-patches"
 
 if test 0 != $ret
 then
diff --git a/git-rebase.sh b/git-rebase.sh
index 7d3bb9d443..ad1a3bd3ef 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -459,6 +459,11 @@ then
 	test -z "$interactive_rebase" && interactive_rebase=implied
 fi
 
+if test -n "$keep_empty"
+then
+	test -z "$interactive_rebase" && interactive_rebase=implied
+fi
+
 if test -n "$interactive_rebase"
 then
 	type=interactive
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 68fe2003ef..13e5c1a2f1 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -199,7 +199,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase failure -p
 
@@ -214,7 +214,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
-test_run_rebase failure -m
+test_run_rebase success -m
 test_run_rebase failure -i
 test_run_rebase failure -p
 
-- 
2.16.2

