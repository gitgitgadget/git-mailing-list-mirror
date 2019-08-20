Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAC571F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfHTUMt (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:12:49 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:54522 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTUMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:12:48 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 5124580A51AE; Tue, 20 Aug 2019 22:12:47 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id D30B380A51A1;
        Tue, 20 Aug 2019 22:12:43 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:33342 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i0AUi-0005DL-KU; Tue, 20 Aug 2019 22:12:40 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v2 1/1] rebase.c: make sure current branch isn't moved when autostashing
Date:   Tue, 20 Aug 2019 22:12:37 +0200
Message-Id: <20190820201237.10205-2-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820201237.10205-1-ben@wijen.net>
References: <20190818095349.3218-3-ben@wijen.net>
 <20190820201237.10205-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i0AUi-0005DL-KU
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
upstream branch to master.

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
 builtin/rebase.c            | 18 ++++++------------
 t/t3420-rebase-autostash.sh | 13 +++++++++----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 670096c065..a928f44941 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1968,9 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				state_dir_path("autostash", &options);
 			struct child_process stash = CHILD_PROCESS_INIT;
 			struct object_id oid;
-			struct commit *head =
-				lookup_commit_reference(the_repository,
-							&options.orig_head);
 
 			argv_array_pushl(&stash.args,
 					 "stash", "create", "autostash", NULL);
@@ -1991,17 +1988,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				    options.state_dir);
 			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(&head->object.oid, "reset --hard",
+
+			/*
+			 * We might not be on orig_head yet:
+			 * Make sure to reset w/o switching branches...
+			 */
+			if (reset_head(NULL, "reset --hard",
 				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
 				die(_("could not reset --hard"));
-			printf(_("HEAD is now at %s"),
-			       find_unique_abbrev(&head->object.oid,
-						  DEFAULT_ABBREV));
-			strbuf_reset(&buf);
-			pp_commit_easy(CMIT_FMT_ONELINE, head, &buf);
-			if (buf.len > 0)
-				printf(" %s", buf.buf);
-			putchar('\n');
 
 			if (discard_index(the_repository->index) < 0 ||
 				repo_read_index(the_repository) < 0)
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index b8f4d03467..c26b4b0885 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -37,7 +37,6 @@ test_expect_success setup '
 create_expected_success_am () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	HEAD is now at $(git rev-parse --short feature-branch) third commit
 	First, rewinding head to replay your work on top of it...
 	Applying: second commit
 	Applying: third commit
@@ -48,7 +47,6 @@ create_expected_success_am () {
 create_expected_success_interactive () {
 	q_to_cr >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	HEAD is now at $(git rev-parse --short feature-branch) third commit
 	Applied autostash.
 	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
@@ -57,7 +55,6 @@ create_expected_success_interactive () {
 create_expected_failure_am () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	HEAD is now at $(git rev-parse --short feature-branch) third commit
 	First, rewinding head to replay your work on top of it...
 	Applying: second commit
 	Applying: third commit
@@ -70,7 +67,6 @@ create_expected_failure_am () {
 create_expected_failure_interactive () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	HEAD is now at $(git rev-parse --short feature-branch) third commit
 	Applying autostash resulted in conflicts.
 	Your changes are safe in the stash.
 	You can run "git stash pop" or "git stash drop" at any time.
@@ -306,4 +302,13 @@ test_expect_success 'branch is left alone when possible' '
 	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
 '
 
+test_expect_success 'never change upstream branch' '
+	test_when_finished "git reset --hard && git branch -D upstream" &&
+	git checkout -b upstream unrelated-onto-branch &&
+	echo changed >file0 &&
+	git add file0 &&
+	git rebase --autostash upstream feature-branch &&
+	test_cmp_rev upstream unrelated-onto-branch
+'
+
 test_done
-- 
2.22.0

