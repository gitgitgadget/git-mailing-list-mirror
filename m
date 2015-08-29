From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v3] stash: Add two config variables for stash show
Date: Sun, 30 Aug 2015 00:25:57 +0900
Message-ID: <1440861957-26413-1-git-send-email-namhyung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 17:29:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVi40-0004JY-Ku
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 17:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbbH2P27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 11:28:59 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33840 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbbH2P27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 11:28:59 -0400
Received: by pabzx8 with SMTP id zx8so92348283pab.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=oHRaorMSdwiHIx2lp0ETtQ1Fsn+7co7N2oD8tS12mFE=;
        b=WahLkG22zAEc6knTKqlZgAGSwajzm87UXlIp4VwU0JmGHHGi2J6oLN3SOj0Ts9AXEU
         V1h9zwhf9V9eJmA2/cqabPgfkVq3w3q0NwKlyvn5cSved2BUHuqZyT/l62tzeWVYLGdz
         2UmA9h+PIZHy4FO2AHpVyjethM6SurTBCv7G5fxlygYsRFHSUum1gPyfrbw6fzrin0CF
         Rr5ebl9w7yKb4tELPtxbXGetLG5rdk4p4wBW44m43Z3WJytXuv8GyIr1el9UBQQ/82a2
         3MvEGKLta8TCUZYJrC2aiX0dtwjxRsWp9AIrkVvl9wbIyPd/wWJBKIEEn1YabMJZygt5
         f8qg==
X-Received: by 10.66.234.202 with SMTP id ug10mr24316630pac.50.1440862138519;
        Sat, 29 Aug 2015 08:28:58 -0700 (PDT)
Received: from localhost.localdomain ([220.120.166.123])
        by smtp.gmail.com with ESMTPSA id rg10sm8980391pbc.33.2015.08.29.08.28.57
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 08:28:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276791>

Some users might want to see diff (patch) output always rather than
diffstat when [s]he runs 'git stash show'.  Although this can be done
with adding -p option, it'd be better to provide a config option to
control this behavior IMHO.

This patch adds two variables which control to show diffstat and patch
output respectively.  The stash.showStat is for diffstat and default is
true.  The stat.showPatch is for the patch output and default is false.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/config.txt    | 10 ++++++++++
 Documentation/git-stash.txt |  2 ++
 git-stash.sh                | 20 +++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5d15ff..b4c8ee1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2567,6 +2567,16 @@ status.submoduleSummary::
 	submodule summary' command, which shows a similar output but does
 	not honor these settings.
 
+stash.showPatch::
+	If this is set to true, the `git stash show` command without an
+	option will show the stash in patch form.  Defaults to false.
+	See description of 'show' command in linkgit:git-stash[1].
+
+stash.showStat::
+	If this is set to true, the `git stash show` command without an
+	option will show diffstat of the stash.  Defaults to true.
+	See description of 'show' command in linkgit:git-stash[1].
+
 submodule.<name>.path::
 submodule.<name>.url::
 	The path within this project and URL for a submodule. These
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 375213f..92df596 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -95,6 +95,8 @@ show [<stash>]::
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to 'git diff' (e.g., `git stash show
 	-p stash@{1}` to view the second most recent stash in patch form).
+	You can use stash.showStat and/or stash.showPatch config variables
+	to change the default behavior.
 
 pop [--index] [-q|--quiet] [<stash>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index 1d5ba7a..c7c65e2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -305,7 +305,25 @@ show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	if test -z "$FLAGS"
+	then
+		if test "$(git config --bool stash.showStat || echo true)" = "true"
+		then
+			FLAGS=--stat
+		fi
+
+		if test "$(git config --bool stash.showPatch || echo false)" = "true"
+		then
+			FLAGS=${FLAGS}${FLAGS:+ }-p
+		fi
+
+		if test -z "$FLAGS"
+		then
+			return 0
+		fi
+	fi
+
+	git diff ${FLAGS} $b_commit $w_commit
 }
 
 show_help () {
-- 
2.5.0
