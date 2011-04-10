From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 1/3] --dirstat: Describe non-obvious differences relative to
 --stat or regular diff
Date: Mon, 11 Apr 2011 00:48:50 +0200
Message-ID: <1302475732-741-2-git-send-email-johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q93S3-0006hZ-Ua
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 00:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab1DJWtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 18:49:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49087 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750Ab1DJWtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 18:49:46 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG004J4KQX5670@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:45 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DC7531EEF72B_DA23408B	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:44 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 822561EEF17D_DA23408F	for <git@vger.kernel.org>; Sun,
 10 Apr 2011 22:49:44 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJG00KXIKQDX600@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 00:49:44 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1302475732-741-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171294>

Also add a testcase documenting the current behavior.

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/diff-options.txt                     |    4 +++
 t/t4013-diff-various.sh                            |   27 +++++++++++++++----
 t/t4013/diff.diff_--dirstat_initial_rearrange      |    2 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    2 +-
 t/t4013/diff.log_--decorate=full_--all             |    6 ++++
 t/t4013/diff.log_--decorate_--all                  |    6 ++++
 6 files changed, 40 insertions(+), 7 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat_initial_rearrange

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..23772d6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -72,6 +72,10 @@ endif::git-format-patch[]
 	a cut-off percent (3% by default) are not shown. The cut-off percent
 	can be set with `--dirstat=<limit>`. Changes in a child directory are not
 	counted for the parent directory, unless `--cumulative` is used.
++
+Note that the `--dirstat` option computes the changes while ignoring
+pure code movements within a file.  In other words, rearranging lines
+in a file is not counted as a change.
 
 --dirstat-by-file[=<limit>]::
 	Same as `--dirstat`, but counts changed files instead of lines.
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5daa0f2..3b1b392 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -80,18 +80,31 @@ test_expect_success setup '
 
 	git config log.showroot false &&
 	git commit --amend &&
+
+	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
+	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+	git checkout -b rearrange initial &&
+	for i in B A; do echo $i; done >dir/sub &&
+	git add dir/sub &&
+	git commit -m "Rearranged lines in dir/sub" &&
+	git checkout master &&
+
 	git show-branch
 '
 
 : <<\EOF
 ! [initial] Initial
  * [master] Merge branch 'side'
-  ! [side] Side
----
- -  [master] Merge branch 'side'
- *+ [side] Side
- *  [master^] Second
-+*+ [initial] Initial
+  ! [rearrange] Rearranged lines in dir/sub
+   ! [side] Side
+----
+  +  [rearrange] Rearranged lines in dir/sub
+ -   [master] Merge branch 'side'
+ * + [side] Side
+ *   [master^] Third
+ *   [master~2] Second
++*++ [initial] Initial
 EOF
 
 V=`git version | sed -e 's/^git version //' -e 's/\./\\./g'`
@@ -287,6 +300,8 @@ diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
 diff master master^ side
 diff --dirstat master~1 master~2
+# --dirstat doesn't notice changes that simply rearrange existing lines
+diff --dirstat initial rearrange
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff_--dirstat_initial_rearrange b/t/t4013/diff.diff_--dirstat_initial_rearrange
new file mode 100644
index 0000000..fb2e17d
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_initial_rearrange
@@ -0,0 +1,2 @@
+$ git diff --dirstat initial rearrange
+$
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
index 1f0f9ad..3b4e113 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -1,7 +1,7 @@
 $ git format-patch --stdout --cover-letter -n initial..master^
 From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
 From: C O Mitter <committer@example.com>
-Date: Mon, 26 Jun 2006 00:05:00 +0000
+Date: Mon, 26 Jun 2006 00:06:00 +0000
 Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
 
 *** BLURB HERE ***
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index d155e0b..44d4525 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -1,4 +1,10 @@
 $ git log --decorate=full --all
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, refs/heads/master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index fd7c3e6..27d3eab 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -1,4 +1,10 @@
 $ git log --decorate --all
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
 commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
-- 
1.7.5.rc1.3.g4d7b
