Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B3C1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH2QsU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 12:48:20 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:37803 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfH2QsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 12:48:20 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id A31C480A51C2; Thu, 29 Aug 2019 18:48:18 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 2D67780A51BD;
        Thu, 29 Aug 2019 18:48:02 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:58842 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i3Naa-0007BY-AL; Thu, 29 Aug 2019 18:48:00 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Szeder=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v5 1/2] builtin/rebase.c: make sure the active branch isn't moved when autostashing
Date:   Thu, 29 Aug 2019 18:47:56 +0200
Message-Id: <20190829164757.7301-2-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164757.7301-1-ben@wijen.net>
References: <20190826164513.9102-1-ben@wijen.net>
 <20190829164757.7301-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i3Naa-0007BY-AL
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider the following scenario:
    git checkout not-the-master
    work work work
    git rebase --autostash upstream master

Here 'rebase --autostash <upstream> <branch>' incorrectly moves the
active branch (not-the-master) to master (before the rebase).

The expected behavior: (58794775:/git-rebase.sh:526)
    AUTOSTASH=$(git stash create autostash)
    git reset --hard
    git checkout master
    git rebase upstream
    git stash apply $AUTOSTASH

The actual behavior: (6defce2b:/builtin/rebase.c:1062)
    AUTOSTASH=$(git stash create autostash)
    git reset --hard master
    git checkout master
    git rebase upstream
    git stash apply $AUTOSTASH

This commit reinstates the 'legacy script' behavior as introduced with
58794775: rebase: implement --[no-]autostash and rebase.autostash

Signed-off-by: Ben Wijen <ben@wijen.net>
---
 builtin/rebase.c            | 8 ++++++--
 t/t3420-rebase-autostash.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 670096c065..b3b17669e3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1968,9 +1968,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				state_dir_path("autostash", &options);
 			struct child_process stash = CHILD_PROCESS_INIT;
 			struct object_id oid;
+			struct object_id head_oid;
+			if (get_oid("HEAD", &head_oid)) {
+				ret = error(_("could not determine HEAD revision"));
+			}
+
 			struct commit *head =
-				lookup_commit_reference(the_repository,
-							&options.orig_head);
+				lookup_commit_reference(the_repository, &head_oid);
 
 			argv_array_pushl(&stash.args,
 					 "stash", "create", "autostash", NULL);
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index b8f4d03467..43685a5c8e 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -306,4 +306,12 @@ test_expect_success 'branch is left alone when possible' '
 	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
 '
 
+test_expect_success 'never change active branch' '
+	git checkout -b not-the-feature-branch unrelated-onto-branch &&
+	test_when_finished "git reset --hard && git checkout master" &&
+	echo changed >file0 &&
+	git rebase --autostash not-the-feature-branch feature-branch &&
+	test_cmp_rev not-the-feature-branch unrelated-onto-branch
+'
+
 test_done
-- 
2.22.0

