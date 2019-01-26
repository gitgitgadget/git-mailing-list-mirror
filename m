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
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CFF1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 07:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfAZHlX (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 02:41:23 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:38936
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbfAZHlX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Jan 2019 02:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1548488481;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=zjoR/mFA1uuRHXSBgtBnCsnbxbofyOcYhdwpoCM0DGQ=;
        b=piARbUZGPFlWLB5ejomocsUbdgHe7Kh/m6pfv0leduZAtQ6ZxPd1kOWYKmTdzyxI
        3jlvioMOosFEXRMUBITLW0ApEp789ly8eQXljMsoorqNJOa3dDIcKyT8fYVzJqXPdcG
        k/cEfl6+DmYHj/K6NtyfrRu8EfNTYJQJnDQSg++Y=
From:   Ben Woosley <Ben.Woosley@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020168891b1a3e-140bd175-a8cb-4379-a114-de68b1cac5d6-000000@eu-west-1.amazonses.com>
Subject: [PATCH] rebase: move state_dir to tmp prior to deletion
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Jan 2019 07:41:21 +0000
X-SES-Outgoing: 2019.01.26-54.240.7.11
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
index b4c7dbfa575d3..878c0e42054d7 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -128,11 +128,22 @@ read_basic_state () {
 	}
 }
 
+remove_rebase_state () {
+  state_tmpdir=$(mktemp -d -t "git-rebase-state-XXXXXX")
+  if test -d state_tmpdir
+  then
+    exec mv "$state_dir" "$state_tmpdir"
+    exec rm -rf "$state_tmpdir"
+  else
+    exec rm -rf "$state_dir"
+  fi
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
