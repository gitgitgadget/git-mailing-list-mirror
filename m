Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDF01F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeHBQTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:05 -0400
Received: from ao2.it ([92.243.12.208]:54925 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387454AbeHBQTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:05 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv9-0006iF-9A; Thu, 02 Aug 2018 15:45:39 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwR-0002hc-Kd; Thu, 02 Aug 2018 15:46:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 12/12] submodule: remove the .gitmodules file when it is empty
Date:   Thu,  2 Aug 2018 15:46:34 +0200
Message-Id: <20180802134634.10300-13-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular this makes it possible to really clean things up when
removing the last submodule with "git rm".

The rationale is that if git creates .gitmodules when adding the first
submodule it should also remove it when removing the last submodule.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule.c                | 10 ++++++++--
 t/t3600-rm.sh              | 32 ++++++++++++++++----------------
 t/t7400-submodule-basic.sh | 11 +++++++++++
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2af09068d7..8cfa82231d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -145,8 +145,14 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(struct index_state *istate)
 {
-	if (add_file_to_index(istate, GITMODULES_FILE, 0))
-		die(_("staging updated .gitmodules failed"));
+	if (is_empty_file(GITMODULES_FILE)) {
+		if (remove_path(GITMODULES_FILE) < 0)
+			die(_("removing .empty gitmodules failed"));
+		remove_file_from_index(&the_index, GITMODULES_FILE);
+	} else {
+		if (add_file_to_index(istate, GITMODULES_FILE, 0))
+			die(_("staging updated .gitmodules failed"));
+	}
 }
 
 /* TODO: remove this function, use repo_submodule_init instead. */
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b8fbdefcdc..bac2054f51 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -296,7 +296,7 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git rm submod &&
 	test ! -e submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual &&
+	test_cmp expect.both_deleted actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
@@ -307,7 +307,7 @@ test_expect_success 'rm removes removed submodule from index and .gitmodules' '
 	rm -rf submod &&
 	git rm submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual &&
+	test_cmp expect.both_deleted actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
@@ -318,7 +318,7 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git rm submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual &&
+	test_cmp expect.both_deleted actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
@@ -329,7 +329,7 @@ test_expect_success 'rm removes a submodule with a trailing /' '
 	git rm submod/ &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm fails when given a file with a trailing /' '
@@ -352,7 +352,7 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual &&
+	test_cmp expect.both_deleted actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
@@ -433,7 +433,7 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a populated submodule with untracked files fails unless forced' '
@@ -448,7 +448,7 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'setup submodule conflict' '
@@ -485,7 +485,7 @@ test_expect_success 'rm removes work tree of unmodified conflicted submodule' '
 	git rm submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a conflicted populated submodule with different HEAD fails unless forced' '
@@ -502,7 +502,7 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual &&
+	test_cmp expect.both_deleted actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
@@ -521,7 +521,7 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual &&
+	test_cmp expect.both_deleted actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
@@ -540,7 +540,7 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a conflicted populated submodule with a .git directory fails even when forced' '
@@ -574,7 +574,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 	git rm submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a populated submodule with a .git directory migrates git dir' '
@@ -618,7 +618,7 @@ test_expect_success 'rm recursively removes work tree of unmodified submodules'
 	git rm submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a populated nested submodule with different nested HEAD fails unless forced' '
@@ -633,7 +633,7 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a populated nested submodule with nested modifications fails unless forced' '
@@ -648,7 +648,7 @@ test_expect_success 'rm of a populated nested submodule with nested modification
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success 'rm of a populated nested submodule with nested untracked files fails unless forced' '
@@ -663,7 +663,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect actual
+	test_cmp expect.both_deleted actual
 '
 
 test_expect_success "rm absorbs submodule's nested .git directory" '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 48fd14fae6..2bb42a4c8f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -99,6 +99,17 @@ inspect() {
 	)
 }
 
+test_expect_success 'removal of last submodule also removes empty .gitmodules' '
+	(
+		cd addtest &&
+		test ! -d .git/modules &&
+		git submodule add -q "$submodurl" first_submod &&
+		test -e .gitmodules &&
+		git rm -f first_submod &&
+		test ! -e .gitmodules
+	)
+'
+
 test_expect_success 'submodule add' '
 	echo "refs/heads/master" >expect &&
 	>empty &&
-- 
2.18.0

