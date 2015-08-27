From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2] stash: Add stash.showFlag config variable
Date: Fri, 28 Aug 2015 00:49:13 +0900
Message-ID: <1440690553-28582-1-git-send-email-namhyung@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 17:52:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUzTP-0001mt-KX
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 17:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbbH0PwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 11:52:15 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32927 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbbH0PwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 11:52:14 -0400
Received: by pacti10 with SMTP id ti10so30335320pac.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=yTptsnxZAAzuLb8kUZfHUeAmPVoJ68mPTWWAqHp4WRI=;
        b=bItZ+Nw7wPmbltjOdxMrYag/Tl/KjStMObFTiwOWPYgDL/D/FplRHMg6L+46njiBr4
         dvpAZNM5c0GQakPIzQPnRpvecrbXugaDYidQ8ObDSnWFSwi31iJzJ1utcB3mY/kZd6yk
         62dFmUsCejbgazvVHiVJitRd8hmzbeeNPk0WpCSgqiWkHYT8+7GKcKsG083YLBCOCFsJ
         W/mJPYmAUaYXUPFq9r1B/6TaKQZvt9y5+rgsZMXqwACiqcoTupj/c1+8K1FM4adUEu2b
         TezS+kreAwqUmmLfpreGtYBiGbKbeTjHDS+s/cHtDxFBcloN09RfsohlFlu5daB3iuhu
         TfnA==
X-Received: by 10.68.195.231 with SMTP id ih7mr8243213pbc.26.1440690734430;
        Thu, 27 Aug 2015 08:52:14 -0700 (PDT)
Received: from localhost.localdomain ([220.120.166.123])
        by smtp.gmail.com with ESMTPSA id ey3sm360558pbd.28.2015.08.27.08.52.12
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 08:52:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276679>

Some users might want to see diff (patch) output always rather than
diffstat when [s]he runs 'git stash show'.  Although this can be done
with adding -p option, it'd be better to provide a config option to
control this behavior IMHO.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/config.txt    | 5 +++++
 Documentation/git-stash.txt | 1 +
 git-stash.sh                | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

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
index 1d5ba7a..f48a97d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -305,7 +305,12 @@ show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	if test -z "$FLAGS"
+	then
+		show_flag=$(git config --get stash.showFlag || echo "--stat")
+	fi
+
+	git diff ${FLAGS:-${show_flag}} $b_commit $w_commit
 }
 
 show_help () {
-- 
2.5.0
