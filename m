From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH v2] bash-prompt.sh: Show where rebase is at when interrupted by a merge conflict
Date: Thu, 25 Apr 2013 19:28:54 +1000
Message-ID: <1366882134-12026-1-git-send-email-zoltan.klinger@gmail.com>
Cc: felipe.contreras@gmail.com, szeder@ira.uka.de,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 11:26:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVIRX-0001yn-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 11:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab3DYJ0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 05:26:12 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63929 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab3DYJ0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 05:26:10 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so1751465pad.34
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=0QAe9qbBfpje/uC4Q7bSUS3jySnR6mc58HAcJH55RIc=;
        b=zIOD2mYD1rw85RkA1Ni57qzs9vkDK/3S2NhQIx+1zZ7jeOYMK7w3H+CDCrsxNklKAj
         MlxBd0hznn4KDnViY0HpxpMZkraobKXFIDymFCDjYg14GjPVIKCsYAkNXBo8rsgLDBmg
         jg9EdHOw/ExLKPiKn/lTEH0UrsrgjDFu9p0dqF4o5RiE7zSdaEXDAXhTVkk1Tb3bD3EF
         Q8aAsyu0y6kw/MWikFsZCic2RCf9thCJ2sGJOKtjkDVnKwAJVxuIhoznBXsLNtDd4PjF
         FKaVeXWBF9dkbJsUSj4GoeAFYl0EsZqgUyLfccuL5pW3QkeeCYu8bvbrFxGwXXvOlfEB
         LQVA==
X-Received: by 10.66.25.80 with SMTP id a16mr23948311pag.97.1366881969972;
        Thu, 25 Apr 2013 02:26:09 -0700 (PDT)
Received: from localhost.localdomain (ppp121-44-192-99.lns20.syd7.internode.on.net. [121.44.192.99])
        by mx.google.com with ESMTPSA id dg5sm6626104pbc.29.2013.04.25.02.26.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 02:26:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222359>

When a rebase is interrupted by a merge conflict it could be useful to
know how far a rebase has progressed and how many commits in total this
rebase will apply. Teach the __git_ps1() command to display the number
of commits so far applied and the total number of commits to be applied.

Below is a sample output of the improved __git_ps1() command:
  ((3ec0a6a...)|REBASE 2/5)

In the example above the rebase has stopped at the second commit due to
a merge conflict and there are a total number of five commits to be
applied by this rebase.

This information can be already obtained from the following files which are
being generated during the rebase:
    GIT_DIR/.git/rebase-merge/msgnum (git-rebase--merge.sh)
    GIT_DIR/.git/rebase-merge/end    (git-rebase--merge.sh)
    GIT_DIR/.git/rebase-apply/next   (git-am.sh)
    GIT_DIR/.git/rebase-apply/last   (git-am.sh)

1) Modify git-rebase--interactive.sh to also create
      GIT_DIR/.git/rebase-merge/msgnum
      GIT_DIR/.git/rebase-merge/end
   files for the number of commits so far applied and the total number of
   commits to be applied.
2) Modify git-prompt.sh to read and display info from the above files
3) Update test t9903-bash-prompt.sh to reflect changes introduced by
   this patch.

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---

Changes since previous patch:

    * Fix typo in commit message
    * Make prompt easier to read by replacing '|' character with space
    * Modify test cases to have more than one commit to apply by the rebase

 contrib/completion/git-prompt.sh |   21 ++++++++++++++++-----
 git-rebase--interactive.sh       |    5 +++++
 t/t9903-bash-prompt.sh           |   14 ++++++++++----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 054c52e..eaf5c36 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -263,14 +263,21 @@ __git_ps1 ()
 	else
 		local r=""
 		local b=""
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r="|REBASE-i"
-			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -d "$g/rebase-merge" ]; then
-			r="|REBASE-m"
+		local step=""
+		local total=""
+		if [ -d "$g/rebase-merge" ]; then
 			b="$(cat "$g/rebase-merge/head-name")"
+			step=$(cat "$g/rebase-merge/msgnum")
+			total=$(cat "$g/rebase-merge/end")
+			if [ -f "$g/rebase-merge/interactive" ]; then
+				r="|REBASE-i"
+			else
+				r="|REBASE-m"
+			fi
 		else
 			if [ -d "$g/rebase-apply" ]; then
+				step=$(cat "$g/rebase-apply/next")
+				total=$(cat "$g/rebase-apply/last")
 				if [ -f "$g/rebase-apply/rebasing" ]; then
 					r="|REBASE"
 				elif [ -f "$g/rebase-apply/applying" ]; then
@@ -308,6 +315,10 @@ __git_ps1 ()
 			}
 		fi
 
+		if [ -n "$step" ] && [ -n "$total" ]; then
+			r="$r $step/$total"
+		fi
+
 		local w=""
 		local i=""
 		local s=""
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 048a140..f76ff8f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -57,6 +57,9 @@ rewritten="$state_dir"/rewritten
 
 dropped="$state_dir"/dropped
 
+end="$state_dir"/end
+msgnum="$state_dir"/msgnum
+
 # A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE that will be used for the commit that is currently
 # being rebased.
@@ -109,7 +112,9 @@ mark_action_done () {
 	sed -e 1d < "$todo" >> "$todo".new
 	mv -f "$todo".new "$todo"
 	new_count=$(git stripspace --strip-comments <"$done" | wc -l)
+	echo $new_count > $msgnum
 	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
+	echo $total > $end
 	if test "$last_count" != "$new_count"
 	then
 		last_count=$new_count
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index e147a8d..083b319 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -28,6 +28,10 @@ test_expect_success 'setup for prompt tests' '
 	git checkout -b b2 master &&
 	echo 0 > file &&
 	git commit -m "second b2" file &&
+	echo 00 > file &&
+	git commit -m "another b2" file &&
+	echo 000 > file &&
+	git commit -m "yet another b2" file &&
 	git checkout master
 '
 
@@ -243,10 +247,12 @@ test_expect_success 'prompt - inside bare repository' '
 '
 
 test_expect_success 'prompt - interactive rebase' '
-	printf " (b1|REBASE-i)" > expected
+	printf " (b1|REBASE-i 2/3)" > expected
 	echo "#!$SHELL_PATH" >fake_editor.sh &&
 	cat >>fake_editor.sh <<\EOF &&
-echo "edit $(git log -1 --format="%h")" > "$1"
+echo "exec echo" > "$1"
+echo "edit $(git log -1 --format="%h")" >> "$1"
+echo "exec echo" >> "$1"
 EOF
 	test_when_finished "rm -f fake_editor.sh" &&
 	chmod a+x fake_editor.sh &&
@@ -260,7 +266,7 @@ EOF
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-m)" > expected &&
+	printf " (b2|REBASE-m 1/3)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
@@ -270,7 +276,7 @@ test_expect_success 'prompt - rebase merge' '
 '
 
 test_expect_success 'prompt - rebase' '
-	printf " ((t2)|REBASE)" > expected &&
+	printf " ((t2)|REBASE 1/3)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase b1 b2 &&
-- 
1.7.9.5
