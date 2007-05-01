From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Bisect: add special treatment for bangs passed to
 "bisect run".
Date: Tue, 1 May 2007 11:31:12 +0200
Message-ID: <20070501113112.c4b32b55.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 11:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HioZs-000750-P2
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031622AbXEAJXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 05:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031625AbXEAJXQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:23:16 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46667 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031622AbXEAJXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 05:23:15 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 25639B963C;
	Tue,  1 May 2007 11:23:14 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45932>

Something like:

 $ git bisect run ! grep string my_file

does not work right now, probably because '!' is a shell keyword.

(This simple script shows the problem:

 $ echo "#"\!"/bin/sh" > ./simple_test.sh
 $ echo "echo \"running:\" \"\$@\"" >> ./simple_test.sh
 $ echo "\"\$@\"" >> ./simple_test.sh
 $ chmod +x ./simple_test.sh
 $ ./simple_test.sh ! grep foo bar.txt
 running: ! grep foo bar.txt
 ./simple_test.sh: line 3: !: command not found
)

This patch tries to work around this problem by counting how
many bangs are passed at the beginning of the "bisect run"
argument list and adding them back when evaluating "$@".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |   25 +++++++++++++++++++++++--
 t/t6030-bisect-porcelain.sh |    9 +++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1cd4561..f4ce199 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -307,10 +307,31 @@ bisect_replay () {
 bisect_run () {
     bisect_next_check fail
 
+    # Count '!' because they need special code.
+    bang_count=0
+    while [ "$1" == '!' ]
+    do
+      bang_count=$(expr $bang_count + 1)
+      shift
+    done
+    test $bang_count -gt 0 && bang_modulo=$(expr $bang_count % 2)
+
+    # Bisect loop.
     while true
     do
-      echo "running $@"
-      "$@"
+      # Run the command/script passed as argument.
+      if [ $bang_count -eq 0 ]; then
+	  echo "running $@"
+	  "$@"
+      else
+	  if [ $bang_modulo -eq 0 ]; then
+	      echo "running ! ( ! $@ )"
+	      ! ( ! "$@" )
+	  else
+	      echo "running ! $@"
+	      ! "$@"
+	  fi
+      fi
       res=$?
 
       # Check for really bad run error.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 30f6ade..56fd645 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -99,6 +99,15 @@ test_expect_success \
      grep "$HASH4 is first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
+# We again want to automatically find the commit that
+# introduced "Ciao" into hello.
+test_expect_success \
+    '"git bisect run" with bang in argument' \
+    'git bisect start $HASH4 $HASH1 &&
+     git bisect run ! grep Ciao hello > my_bisect_log.txt &&
+     grep "$HASH4 is first bad commit" my_bisect_log.txt &&
+     git bisect reset'
+
 #
 #
 test_done
-- 
1.5.2.rc0.71.g4342-dirty
