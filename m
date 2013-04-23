From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH] git-prompt.sh: Show where rebase is at when interrupted by a merge conflict
Date: Tue, 23 Apr 2013 22:35:07 +1000
Message-ID: <1366720507-16504-1-git-send-email-zoltan.klinger@gmail.com>
Cc: felipe.contreras@gmail.com,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:35:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUcRv-0000Bx-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab3DWMfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:35:51 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:59397 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107Ab3DWMfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 08:35:50 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so318601daj.22
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=kftzrrr/yHTiY3mBLZwd5g2plPlGSp31tu64vi8AbwQ=;
        b=h6YRB88Sj6TanpLvcau+B82yLSvMuxsfFUN5xqEAhcJT8GnC7s4gJiaidBX7VhSvO/
         BqlEdgnMGr2TSJjibAZHJsLdZL1YqpO+6/TpD6Rcj+ldAz9NjC4HBBlOVUfz5FcEyZV9
         Spw+DtqZv2QLQTprR1YbovS2xPEhJm47UgQscjTGogmMd2VaDE/Gsy3VDWuhrvGzVqAM
         OFVjvAVBCaqCztN0gDm6ytecFN69sse/XHgUQHfCHBNI2pjOtC7XgITf0UnCFzMPjupq
         1C7Hd3z5vEvAqMKrn0HTkl/cYWf9erRQ5LetXf8orlQQT0mW74w24uosvtG8bksi3jEY
         k7yA==
X-Received: by 10.68.20.138 with SMTP id n10mr40451362pbe.140.1366720549679;
        Tue, 23 Apr 2013 05:35:49 -0700 (PDT)
Received: from localhost.localdomain (ppp121-44-192-99.lns20.syd7.internode.on.net. [121.44.192.99])
        by mx.google.com with ESMTPS id mm9sm29367175pbc.43.2013.04.23.05.35.47
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 05:35:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222155>

When a rebase is interrupted by a merge conflict it could be useful to
know how far a rebase has progressed and how many commits in total this
rebase will apply. Teach the __git_ps1() command to display the number
of commits so far applied and the total number of commits to be applied.

Below is a sample output of the improved __git_ps1() command:
  ((3ec0a6a...)|REBASE|2/5)

In the example above the rebase has stopped at the second commit due to
a merge conflict and there are a total number of five commits to be
applied by this rebase.

This information can be alredy obtained from the following files which are
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
 contrib/completion/git-prompt.sh |   21 ++++++++++++++++-----
 git-rebase--interactive.sh       |    5 +++++
 t/t9903-bash-prompt.sh           |    6 +++---
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 756a951..49f7742 100644
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
+			r="$r|$step/$total"
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
index e147a8d..2f8f9ab 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -243,7 +243,7 @@ test_expect_success 'prompt - inside bare repository' '
 '
 
 test_expect_success 'prompt - interactive rebase' '
-	printf " (b1|REBASE-i)" > expected
+	printf " (b1|REBASE-i|1/1)" > expected
 	echo "#!$SHELL_PATH" >fake_editor.sh &&
 	cat >>fake_editor.sh <<\EOF &&
 echo "edit $(git log -1 --format="%h")" > "$1"
@@ -260,7 +260,7 @@ EOF
 '
 
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-m)" > expected &&
+	printf " (b2|REBASE-m|1/1)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
@@ -270,7 +270,7 @@ test_expect_success 'prompt - rebase merge' '
 '
 
 test_expect_success 'prompt - rebase' '
-	printf " ((t2)|REBASE)" > expected &&
+	printf " ((t2)|REBASE|1/1)" > expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase b1 b2 &&
-- 
1.7.9.5
