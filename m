From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] rebase: introduce "rebase.preserve" configuration option
Date: Tue,  5 Aug 2014 22:48:34 +0200
Message-ID: <1407271714-1624-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 22:48:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XElf1-0005hq-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbaHEUsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 16:48:40 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:45854 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbaHEUsj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 16:48:39 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1652758wes.20
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Hc8TElpBSggAL3kcpQBDGcHxIvFXiGzPQ/lu9QuXnRk=;
        b=E6H94lv0PIdyjK/PGMPB2LFqns/nOUyxr4P+Y3yTGtk8kgpt3vcvtHKhOdvKqXbyHo
         ehmS8Y8jZR93OCk4BsjND+GdePbm0BYB26fgz8qtTAXrXlK8KnptDW2DGlQPeBS9ucEK
         vTgbSgEISk2qKc+K2p7pJlUTfMe8oErzL8SAaopKiTqxML47ZTKFyhlWdhZJotV8V/n/
         C678zjqg4CMKyH4DO/fIDMd5+zoBF96CKWtpgx05GGXATnyEBr8MpY8evcCK6FAqc/d3
         X+BaLlzdl2QQirqcg53WO3Cn1eXZXP8rAh9a4zKSponYndVaYDdFH0xwgDItQK9KPGuR
         No5w==
X-Received: by 10.194.9.228 with SMTP id d4mr9075192wjb.99.1407271717871;
        Tue, 05 Aug 2014 13:48:37 -0700 (PDT)
Received: from localhost (dslb-088-073-244-207.088.073.pools.vodafone-ip.de. [88.73.244.207])
        by mx.google.com with ESMTPSA id ex2sm11043937wic.24.2014.08.05.13.48.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 05 Aug 2014 13:48:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc1.205.gf9880d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254827>

There are several ways to configure Git to preserve merges.
There is "pull.rebase=preserve" for all branches and
"branch.<name>.rebase=preserve" for individual branches.
However, there is no configuration option to preserve merges
for all branches when running git-rebase.

This patch introduces a new configuration variable
"rebase.preserve". If set to true, "--preserve-merges" option
will be enabled in git-rebase by default.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 Documentation/config.txt          |  3 +++
 git-rebase.sh                     |  1 +
 t/t3409-rebase-preserve-merges.sh | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c08286e..4166be0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2031,6 +2031,9 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
 
+rebase.preserve::
+	If set to true enable '--preserve-merges' option by default.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/git-rebase.sh b/git-rebase.sh
index 47ca3b9..e0b3e05 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -83,6 +83,7 @@ state_dir=
 # One of {'', continue, skip, abort}, as parsed from command line
 action=
 preserve_merges=
+test "$(git config --bool rebase.preserve)" = "true" && preserve_merges=t && interactive_rebase=implied
 autosquash=
 keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8c251c5..3a02240 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -76,6 +76,16 @@ test_expect_success 'setup for merge-preserving rebase' \
 		git merge --no-ff topic2
 	) &&
 
+	git clone ./. clone5 &&
+	(
+		cd clone5 &&
+		git checkout -b topic2 origin/topic &&
+		echo Sixth > A &&
+		git commit -a -m "Modify A3" &&
+		git checkout -b topic origin/topic &&
+		git merge --no-ff topic2
+	) &&
+
 	git checkout topic &&
 	echo Fourth >> B &&
 	git commit -a -m "Modify B2"
@@ -119,4 +129,14 @@ test_expect_success 'rebase -p ignores merge.log config' '
 	)
 '
 
+test_expect_success 'config rebase.preserve preserves no-ff merges' '
+	(
+	cd clone5 &&
+	git fetch &&
+	git -c rebase.preserve=true rebase origin/topic &&
+	test 3 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge branch" | wc -l)
+	)
+'
+
 test_done
-- 
2.1.0.rc1.205.gf9880d1
