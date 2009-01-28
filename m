From: Yuval Kogman <nothingmuch@woobling.org>
Subject: [PATCH] Add --ff-only flag to git-merge
Date: Wed, 28 Jan 2009 14:53:58 +0200
Message-ID: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
Cc: Yuval Kogman <nothingmuch@woobling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 13:55:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS9x8-0000xs-SD
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 13:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZA1MyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 07:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbZA1MyH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 07:54:07 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39502 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZA1MyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 07:54:04 -0500
Received: by ewy14 with SMTP id 14so2813637ewy.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 04:54:02 -0800 (PST)
Received: by 10.86.59.18 with SMTP id h18mr825213fga.57.1233147242682;
        Wed, 28 Jan 2009 04:54:02 -0800 (PST)
Received: from syeeda.local (bzq-84-109-225-67.red.bezeqint.net [84.109.225.67])
        by mx.google.com with ESMTPS id e11sm271648fga.29.2009.01.28.04.54.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 04:54:02 -0800 (PST)
Received: by syeeda.local (Postfix, from userid 501)
	id 0828430BB57D; Wed, 28 Jan 2009 14:53:58 +0200 (IST)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107532>

This patch adds an --ff-only flag to git-merge. When specified git-merge
will exit with an error whenver a merge will not be a simple fast
forward, similar to the default behavior of git push.
---
 builtin-merge.c  |    6 ++++++
 t/t7600-merge.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e4555b0..d37423b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -44,6 +44,7 @@ static const char * const builtin_merge_usage[] = {
 static int show_diffstat = 1, option_log, squash;
 static int option_commit = 1, allow_fast_forward = 1;
 static int allow_trivial = 1, have_message;
+static int only_fast_forward;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
@@ -167,6 +168,8 @@ static struct option builtin_merge_options[] = {
 		"perform a commit if the merge succeeds (default)"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast forward (default)"),
+	OPT_BOOLEAN(0, "ff-only", &only_fast_forward,
+		"allow only fast forward"),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
@@ -1012,6 +1015,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		finish(o->sha1, msg.buf);
 		drop_save();
 		return 0;
+	} else if ( only_fast_forward ) {
+		printf("Merge is non fast forward, aborting.\n");
+		return 1;
 	} else if (!remoteheads->next && common->next)
 		;
 		/*
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5b210b..6c2febc 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -234,6 +234,8 @@ test_expect_success 'reject non-strategy with a git-merge-foo name' '
 	test_must_fail git merge -s index c1
 '
 
+test_debug 'gitk --all'
+
 test_expect_success 'merge c0 with c1' '
 	git reset --hard c0 &&
 	git merge c1 &&
@@ -243,6 +245,15 @@ test_expect_success 'merge c0 with c1' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c0 with c1 (fast forward only)' '
+	git reset --hard c0 &&
+	git merge --ff-only c1 &&
+	verify_merge file result.1 &&
+	verify_head "$c1"
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -253,6 +264,14 @@ test_expect_success 'merge c1 with c2' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git merge --ff-only c2
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2 and c3' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -263,6 +282,14 @@ test_expect_success 'merge c1 with c2 and c3' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 and c3 (fast forward only' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git merge --ff-only c2 c3
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c0 with c1 (no-commit)' '
 	git reset --hard c0 &&
 	git merge --no-commit c1 &&
@@ -470,6 +497,15 @@ test_expect_success 'merge c1 with c0, c2, c0, and c1' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge fast forward only' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge --ff-only c0 c2 c0 c1
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
        git config branch.master.mergeoptions "" &&
@@ -481,6 +517,15 @@ test_expect_success 'merge c1 with c0, c2, c0, and c1' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge fast forward only' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge --ff-only c1 c2
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c1 and c2' '
        git reset --hard c1 &&
        git config branch.master.mergeoptions "" &&
-- 
1.6.1
