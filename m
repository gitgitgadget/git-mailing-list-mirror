Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6D220899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbdHKROq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:14:46 -0400
Received: from 4.mo176.mail-out.ovh.net ([46.105.39.204]:32899 "EHLO
        4.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbdHKROq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:14:46 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 2942F6D434;
        Fri, 11 Aug 2017 19:14:44 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Aug 2017 19:14:43 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH] stash: clean untracked files before reset
To:     <git@vger.kernel.org>
CC:     <sam@whiteoctober.co.uk>
References: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
Message-ID: <b87007d1-eb5a-f092-9e03-5c6549044b42@morey-chaisemartin.com>
Date:   Fri, 11 Aug 2017 19:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS2.indiv2.local (172.16.1.2) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 16574372529847133982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkeelgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If calling git stash -u on a repo that contains a file that is not
ignored any more due to a current modification of the gitignore file,
this file is stashed but not remove from the working tree.
This is due to git-stash first doing a reset --hard which clears the
.gitignore file modification and the call git clean, leaving the file
untouched.
This causes git stash pop to fail due to the file existing.

This patch simply switches the order between cleaning and resetting
and adds a test for this usecase.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Reported-by: Sam Partington <sam@whiteoctober.co.uk>
---
 git-stash.sh                       | 11 ++++++-----
 t/t3905-stash-include-untracked.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9b6c2da7b..39083b4d9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -300,6 +300,12 @@ push_stash () {
 
 	if test -z "$patch_mode"
 	then
+		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
+		if test -n "$untracked"
+		then
+			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
+		fi
+
 		if test $# != 0
 		then
 			git reset -q -- "$@"
@@ -309,11 +315,6 @@ push_stash () {
 		else
 			git reset --hard -q
 		fi
-		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
-		if test -n "$untracked"
-		then
-			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
-		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
 		then
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 193adc7b6..c1f84d3d5 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -211,4 +211,22 @@ test_expect_success 'stash push with $IFS character' '
 	test_path_is_file bar
 '
 
+cat > .gitignore <<EOF
+ignored
+ignored.d/*
+EOF
+
+test_expect_success 'stash previously ignored file' '
+which git &&
+	git reset HEAD &&
+	git add .gitignore &&
+	git commit -m "Add .gitignore" && 
+	>ignored.d/foo &&
+	echo "!ignored.d/foo" >> .gitignore &&
+	git stash save --include-untracked &&
+	test_path_is_missing ignored.d/foo &&
+	git stash pop &&
+	test_path_is_file ignored.d/foo
+'
+
 test_done
-- 
2.14.0.1.gd9597ce13

