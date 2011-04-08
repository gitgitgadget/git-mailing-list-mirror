From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/3] --dirstat: Document shortcomings compared to --stat or regular diff
Date: Fri, 8 Apr 2011 16:48:11 +0200
Message-ID: <201104081648.11842.johan@herland.net>
References: <201104071549.37187.johan@herland.net> <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com> <201104081646.35750.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 16:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Czb-0005gd-Pw
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 16:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564Ab1DHOsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 10:48:55 -0400
Received: from smtp.opera.com ([213.236.208.81]:44207 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385Ab1DHOsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 10:48:54 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p38EmB8V007878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Apr 2011 14:48:12 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <201104081646.35750.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171125>

Also add a testcase documenting the current behavior.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/diff-options.txt                     |    5 +++
 t/t4013-diff-various.sh                            |   27 +++++++++++++++----
 t/t4013/diff.diff_--dirstat_initial_rearrange      |    2 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    2 +-
 t/t4013/diff.log_--decorate=full_--all             |    6 ++++
 t/t4013/diff.log_--decorate_--all                  |    6 ++++
 6 files changed, 41 insertions(+), 7 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat_initial_rearrange

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..25e48c4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -72,6 +72,11 @@ endif::git-format-patch[]
 	a cut-off percent (3% by default) are not shown. The cut-off percent
 	can be set with `--dirstat=<limit>`. Changes in a child directory are not
 	counted for the parent directory, unless `--cumulative` is used.
++
+Note that `--dirstat` does not use the regular diff machinery to calculate
+the changes (rather it is based on the rename detection machinery). Therefore,
+`--dirstat` may skip some changes that `--stat` does not skip. For example,
+rearranging the lines in a file will not be detected by `--dirstat`.
 
 --dirstat-by-file[=<limit>]::
 	Same as `--dirstat`, but counts changed files instead of lines.
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5daa0f2..8cc94ef 100755
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
+# --dirstat does NOT pick up changes that simply rearrange existing lines
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
1.7.5.rc1
