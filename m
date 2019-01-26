Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9620D1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 10:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfAZKQ2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 05:16:28 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:44964
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbfAZKQ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Jan 2019 05:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1548497786;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=C3DHMqv6Wz5KSccApyWdELwIMeY63jULHZEb8xh9FY0=;
        b=dI3Hro9nujXuYi/4wy4u/UomDq4kov471hzp02Jdb9sZiev+8mnc2az73BWAZkgk
        rhRzI9XyUi1L+vezW14TquEpra+ead/LEkTpwdychyRNr042MQ8Hy43bGoVNP0tvMnk
        ckQU8VWhfzJbNLupaa0UzvCpgB6DYOepISmoe6oo=
From:   Ben Woosley <Ben.Woosley@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016889a9145a-83604d85-036b-409b-a3d2-2eb1ef2c5b95-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020168891b1a3e-140bd175-a8cb-4379-a114-de68b1cac5d6-000000@eu-west-1.amazonses.com>
References: <01020168891b1a3e-140bd175-a8cb-4379-a114-de68b1cac5d6-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] rebase: move state_dir to tmp prior to deletion
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Jan 2019 10:16:26 +0000
X-SES-Outgoing: 2019.01.26-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Woosley <ben.woosley@gmail.com>

To avoid partial deletion / zombie rebases.

Example behavior under partial deletion, after
Ctrl-Cing out of a standard rebase:

    $ git rebase target
    First, rewinding head to replay your work on top of it...
    Applying: [...]
    ^C
    $ git status
    rebase in progress; onto (null)
    You are currently rebasing.
      (all conflicts fixed: run "git rebase --continue")

    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)
    [...]
    $ git rebase --continue
    error: could not read '.git/rebase-apply/head-name': No such file or directory
    $ git rebase --abort
    error: could not read '.git/rebase-apply/head-name': No such file or directory

Others report this issue here:
https://stackoverflow.com/questions/3685001/git-how-to-fix-corrupted-interactive-rebase
---
 git-legacy-rebase.sh           | 17 ++++++++++++++---
 git-rebase--preserve-merges.sh |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index b4c7dbfa575d3..832a211c925c3 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -128,11 +128,22 @@ read_basic_state () {
 	}
 }
 
+remove_rebase_state () {
+  removal_dir=$(mktemp -d -t "git-rebase-state-XXXXXX")
+  if test -d "$removal_dir"
+  then
+    mv "$state_dir" "$removal_dir"
+  else
+    removal_dir="$state_dir"
+  fi
+  rm -rf "$removal_dir"
+}
+
 finish_rebase () {
 	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 	apply_autostash &&
 	{ git gc --auto || true; } &&
-	rm -rf "$state_dir"
+	remove_rebase_state
 }
 
 run_interactive () {
@@ -194,7 +205,7 @@ run_specific_rebase () {
 	elif test $ret -eq 2 # special exit status for rebase -p
 	then
 		apply_autostash &&
-		rm -rf "$state_dir" &&
+		remove_rebase_state &&
 		die "Nothing to do"
 	fi
 	exit $ret
@@ -439,7 +450,7 @@ abort)
 	exit
 	;;
 quit)
-	exec rm -rf "$state_dir"
+	remove_rebase_state
 	;;
 edit-todo)
 	run_specific_rebase
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index afbb65765d461..146b52df14928 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -226,7 +226,7 @@ Once you are satisfied with your changes, run
 
 die_abort () {
 	apply_autostash
-	rm -rf "$state_dir"
+	remove_rebase_state
 	die "$1"
 }
 

--
https://github.com/git/git/pull/569
