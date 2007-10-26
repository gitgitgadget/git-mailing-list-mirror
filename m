From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect run: "skip" current commit if script exit code is
 125.
Date: Fri, 26 Oct 2007 05:39:37 +0200
Message-ID: <20071026053937.2831a89b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 05:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlFwL-0000O7-Qa
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 05:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbXJZDcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 23:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754716AbXJZDck
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 23:32:40 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58863 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbXJZDcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 23:32:39 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6B9991AB2B7;
	Fri, 26 Oct 2007 05:32:37 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0443E1AB2B3;
	Fri, 26 Oct 2007 05:32:36 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62390>

This is incompatible with previous versions because an exit code
of 125 used to mark current commit as "bad". But hopefully this exit
code is not much used by test scripts or other programs. (126 and 127
are used by bash.)

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    8 ++++++--
 git-bisect.sh                |   11 ++++++++++-
 t/t6030-bisect-porcelain.sh  |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 785f381..14b7a95 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -183,13 +183,17 @@ $ git bisect run my_script
 
 Note that the "run" script (`my_script` in the above example) should
 exit with code 0 in case the current source code is good and with a
-code between 1 and 127 (included) in case the current source code is
-bad.
+code between 1 and 127 (included), except 125 that is special, in case
+the current source code is bad.
 
 Any other exit code will abort the automatic bisect process. (A
 program that does "exit(-1)" leaves $? = 255, see exit(3) manual page,
 the value is chopped with "& 0377".)
 
+The special exit code 125 should be used when the current source code
+cannot be tested. If the "run" script exits with this code, the current
+revision will be "skip"ped, see `git bisect skip` above.
+
 You may often find that during bisect you want to have near-constant
 tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
 "revision that does not have this commit needs this patch applied to
diff --git a/git-bisect.sh b/git-bisect.sh
index f8d0099..180c6c2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -392,7 +392,10 @@ bisect_run () {
       fi
 
       # Find current state depending on run success or failure.
-      if [ $res -gt 0 ]; then
+      # A special exit code of 125 means cannot test.
+      if [ $res -eq 125 ]; then
+	  state='skip'
+      elif [ $res -gt 0 ]; then
 	  state='bad'
       else
 	  state='good'
@@ -404,6 +407,12 @@ bisect_run () {
 
       cat "$GIT_DIR/BISECT_RUN"
 
+      if grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+		> /dev/null; then
+	  echo >&2 "bisect run cannot continue any more"
+	  exit $res
+      fi
+
       if [ $res -ne 0 ]; then
 	  echo >&2 "bisect run failed:"
 	  echo >&2 "'bisect_state $state' exited with error code $res"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 16d0c4a..53956c0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -177,6 +177,46 @@ test_expect_success 'bisect skip and bisect replay' '
 	git bisect reset
 '
 
+HASH6=
+test_expect_success 'bisect run & skip: cannot tell between 2' '
+	add_line_into_file "6: Yet a line." hello &&
+	HASH6=$(git rev-parse --verify HEAD) &&
+	echo "#"\!"/bin/sh" > test_script.sh &&
+	echo "tail -1 hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
+	echo "grep line hello > /dev/null" >> test_script.sh &&
+	echo "test \$? -ne 0" >> test_script.sh &&
+	chmod +x test_script.sh &&
+	git bisect start $HASH6 $HASH1 &&
+	if git bisect run ./test_script.sh > my_bisect_log.txt
+	then
+		echo Oops, should have failed.
+		false
+	else
+		test $? -eq 2 &&
+		grep "first bad commit could be any of" my_bisect_log.txt &&
+		! grep $HASH3 my_bisect_log.txt &&
+		! grep $HASH6 my_bisect_log.txt &&
+		grep $HASH4 my_bisect_log.txt &&
+		grep $HASH5 my_bisect_log.txt
+	fi
+'
+
+HASH7=
+test_expect_success 'bisect run & skip: find first bad' '
+	git bisect reset &&
+	add_line_into_file "7: Should be the last line." hello &&
+	HASH7=$(git rev-parse --verify HEAD) &&
+	echo "#"\!"/bin/sh" > test_script.sh &&
+	echo "tail -1 hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
+	echo "tail -1 hello | grep day > /dev/null && exit 125" >> test_script.sh &&
+	echo "grep Yet hello > /dev/null" >> test_script.sh &&
+	echo "test \$? -ne 0" >> test_script.sh &&
+	chmod +x test_script.sh &&
+	git bisect start $HASH7 $HASH1 &&
+	git bisect run ./test_script.sh > my_bisect_log.txt &&
+	grep "$HASH6 is first bad commit" my_bisect_log.txt
+'
+
 #
 #
 test_done
-- 
1.5.3.4.1494.g253d
