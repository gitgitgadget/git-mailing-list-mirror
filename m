From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] stash: Add stash.showFlag config variable
Date: Thu, 27 Aug 2015 22:52:08 +0900
Message-ID: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 15:55:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUxe8-0007zj-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 15:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbH0NzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 09:55:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36857 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbbH0NzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 09:55:09 -0400
Received: by pacgr6 with SMTP id gr6so8883784pac.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=cJ9nTuCqC/xyjtdYz7mH+tmFP38xQO7lkdkMnXeWtBA=;
        b=Z+K5BvbCBI1r/Vc7IhvdUiWGB+hOFSjcWzGI4RxYqBVKFSzoNQLsYk0+uT6UGS6a0f
         R04xMFJ9vSvpnMB4kXfUIhkq3GPl3ljj0MqZVBSeFtPzAtOJ9kXyt57gESKY0tbScpnk
         I0pv0C4gyuGOTa+dXioFYtsgP+lOOc8Z0yTSg4oJZ34Loybx25ms/cwmguCVETRiVnYe
         f4C5hrA2GRNiophpM90rHxHiT7NjcKEgiLi5m5rt8ascokFt5TW/BY9uNopzvxkgK7/K
         Sljw+GziRVkcSEw3QmGFAIC0pdKESjA856GfWTnIepCo0z9sx6vbVxDDIPbvDmYBfi5t
         NYnQ==
X-Received: by 10.68.225.228 with SMTP id rn4mr6788003pbc.25.1440683708524;
        Thu, 27 Aug 2015 06:55:08 -0700 (PDT)
Received: from localhost.localdomain ([220.120.166.123])
        by smtp.gmail.com with ESMTPSA id h4sm2565127pdd.91.2015.08.27.06.55.07
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 06:55:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276674>

Some users might want to see diff (patch) output always rather than
diffstat when [s]he runs 'git stash show'.  Although this can be done
with adding -p option, it'd be better to provide a config option to
control this behavior IMHO.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/config.txt    | 5 +++++
 Documentation/git-stash.txt | 1 +
 git-stash.sh                | 8 +++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f5d15ff..bbadae6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2567,6 +2567,11 @@ status.submoduleSummary::
 	submodule summary' command, which shows a similar output but does
 	not honor these settings.
 
+stash.showFlag::
+	The default option to pass to `git stash show` when no option is
+	given. The default is '--stat'.  See description of 'show' command
+	in linkgit:git-stash[1].
+
 submodule.<name>.path::
 submodule.<name>.url::
 	The path within this project and URL for a submodule. These
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 375213f..e00f67e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -95,6 +95,7 @@ show [<stash>]::
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to 'git diff' (e.g., `git stash show
 	-p stash@{1}` to view the second most recent stash in patch form).
+	You can use stash.showflag config variable to change this behavior.
 
 pop [--index] [-q|--quiet] [<stash>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index 1d5ba7a..8432435 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -33,6 +33,12 @@ else
        reset_color=
 fi
 
+if git config --get stash.showflag > /dev/null 2> /dev/null; then
+	show_flag=$(git config --get stash.showflag)
+else
+	show_flag=--stat
+fi
+
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
 	git diff-files --quiet --ignore-submodules &&
@@ -305,7 +311,7 @@ show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	git diff ${FLAGS:-${show_flag}} $b_commit $w_commit
 }
 
 show_help () {
-- 
2.5.0
