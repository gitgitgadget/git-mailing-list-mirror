From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri,  7 Oct 2011 11:29:07 -0400
Message-ID: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 17:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCCMR-000872-0Q
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 17:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab1JGP3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 11:29:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64890 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab1JGP3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 11:29:13 -0400
Received: by ggnv2 with SMTP id v2so2847398ggn.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FM4s/6DbdcUKl4/KERnYwFf53tx8BA7ALrKYehFSJ+4=;
        b=AVB87Pn5Hv/V2gp6HBsmq5UG/YaivRsxhdwkPqvncPwWZ8ci5ZdQQpDP1wvm/BZcqc
         K9qTI+MZt1+QyD6EQYkpWwr7KuuQt+Xe8a0D7B6JKOjGpTQWz64wLLinFYr8fvDmaGcF
         i5SypZe7r0yDJ3oBDakPlGWtr4GE4kd2TQ2nA=
Received: by 10.236.156.33 with SMTP id l21mr10648820yhk.24.1318001352560;
        Fri, 07 Oct 2011 08:29:12 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id u66sm13313829yhu.13.2011.10.07.08.29.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 08:29:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.147.g00fdf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183080>

Implement "git merge [-e|--edit]" as "git merge --no-commit && git commit"
as a convenience for the user.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/merge-options.txt |    6 ++++++
 builtin/merge.c                 |   14 ++++++++++++++
 t/t7600-merge.sh                |   15 +++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index b613d4ed08..6bd0b041c3 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -7,6 +7,12 @@ With --no-commit perform the merge but pretend the merge
 failed and do not autocommit, to give the user a chance to
 inspect and further tweak the merge result before committing.
 
+--edit::
+-e::
++
+	Invoke editor before committing successful merge to further
+	edit the default merge message.
+
 --ff::
 --no-ff::
 	Do not generate a merge commit if the merge resolved as
diff --git a/builtin/merge.c b/builtin/merge.c
index ee56974371..815e151487 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -46,6 +46,7 @@ static const char * const builtin_merge_usage[] = {
 
 static int show_diffstat = 1, shortlog_len, squash;
 static int option_commit = 1, allow_fast_forward = 1;
+static int option_edit = 0;
 static int fast_forward_only;
 static int allow_trivial = 1, have_message;
 static struct strbuf merge_msg;
@@ -190,6 +191,8 @@ static struct option builtin_merge_options[] = {
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
 		"perform a commit if the merge succeeds (default)"),
+	OPT_BOOLEAN('e', "edit", &option_edit,
+		"edit message before committing"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast-forward (default)"),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
@@ -1092,6 +1095,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		option_commit = 0;
 	}
 
+	/* if not committing, edit is nonsensical */
+	if (!option_commit)
+		option_edit = 0;
+	/* if editing, invoke 'git commit -e' after successful merge */
+	if (option_edit)
+		option_commit = 0;
+
 	if (!allow_fast_forward && fast_forward_only)
 		die(_("You cannot combine --no-ff with --ff-only."));
 
@@ -1447,6 +1457,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (merge_was_ok) {
+		if (option_edit) {
+			const char *args[] = {"commit", "-e", NULL};
+			return run_command_v_opt(args, RUN_GIT_CMD);
+		}
 		fprintf(stderr, _("Automatic merge went well; "
 			"stopped before committing as requested\n"));
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 87aac835a1..8c6b811718 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -643,4 +643,19 @@ test_expect_success 'amending no-ff merge commit' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+cat >editor <<\EOF
+#!/bin/sh
+# strip comments and blank lines from end of message
+sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
+EOF
+chmod 755 editor
+
+test_expect_success 'merge --no-ff --edit' '
+	git reset --hard c0 &&
+	EDITOR=./editor git merge --no-ff --edit c1 &&
+	verify_parents $c0 $c1 &&
+	git cat-file commit HEAD | sed "1,/^$/d" > actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
1.7.7.147.g00fdf
