Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC9B1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 15:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3PRA (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 11:17:00 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:49205 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 11:17:00 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 2583480A51BF; Fri, 30 Aug 2019 17:16:59 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id B8853807B73B;
        Fri, 30 Aug 2019 17:16:13 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:54406 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i3idF-0004lz-RF; Fri, 30 Aug 2019 17:16:09 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Szeder=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v6 2/2] builtin/rebase.c: Remove pointless message
Date:   Fri, 30 Aug 2019 17:16:06 +0200
Message-Id: <20190830151607.4208-3-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190830151607.4208-1-ben@wijen.net>
References: <20190829164757.7301-1-ben@wijen.net>
 <20190830151607.4208-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i3idF-0004lz-RF
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing 'git rebase --autostash <upstream> <master>' with a dirty worktree
a 'HEAD is now at ...' message is emitted, which is pointless as it refers to
the old active branch which isn't actually moved.

This commit removes the 'HEAD is now at...' message.

Signed-off-by: Ben Wijen <ben@wijen.net>
---
 builtin/rebase.c            | 17 +----------------
 t/t3420-rebase-autostash.sh |  4 ----
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b3b17669e3..118205e481 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1968,13 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				state_dir_path("autostash", &options);
 			struct child_process stash = CHILD_PROCESS_INIT;
 			struct object_id oid;
-			struct object_id head_oid;
-			if (get_oid("HEAD", &head_oid)) {
-				ret = error(_("could not determine HEAD revision"));
-			}
-
-			struct commit *head =
-				lookup_commit_reference(the_repository, &head_oid);
 
 			argv_array_pushl(&stash.args,
 					 "stash", "create", "autostash", NULL);
@@ -1995,17 +1988,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				    options.state_dir);
 			write_file(autostash, "%s", oid_to_hex(&oid));
 			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(&head->object.oid, "reset --hard",
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
index 43685a5c8e..2421bc39f5 100755
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
-- 
2.22.0

