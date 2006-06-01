From: Tim O'Callaghan <timo@dspsrv.com>
Subject: More information on git for Cygwin x86-64
Date: Fri, 2 Jun 2006 01:44:10 +0200
Message-ID: <20060601234410.GA3408@Zangband>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
X-From: git-owner@vger.kernel.org Fri Jun 02 01:44:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlwqP-0005FG-OI
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 01:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWFAXoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 19:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWFAXoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 19:44:16 -0400
Received: from ns.dspsrv.com ([193.120.211.34]:33988 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S1751006AbWFAXoF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 19:44:05 -0400
Received: from [213.46.16.78] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1Flwpg-0003fM-00
	for git@vger.kernel.org; Fri, 02 Jun 2006 00:44:04 +0100
To: git@vger.kernel.org
Mail-Followup-To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r655 (CYGWIN_NT-5.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21128>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After some investigation, it looks like the problem is to do with the
index.lock file. I think it may have something to do with with the
rename function in index.c.

As far as i can tell index.lock should not exist after any git
call. An atexit() call is registered remove it when it is created, so
this should ensure it gets removed. Unfortunately that is not what
happens in this case.

A quick check with an unlink() before the rename in index.c, worked
for the first failure in t0000-basic, but not the next one.

The only relevant reference I could find in the list archives is:
http://www.gelato.unsw.edu.au/archives/git/0510/10188.html

The attached patch has two fixes. The first is a check to see if
cygwin is installed, and if so, to ensure that the script uses cygwin
Unix style find, rather than the win2k find.

The second adds a test_warning_ function to the test library. Not sure
how useful th may be to everyone else, but it works for me. This
checks to see if the index.lock still exists, and adds a simple
'warning' category to the tests.

Tim.

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.txt"

diff --git a/t/README b/t/README
index ac5a3ac..d278702 100644
--- a/t/README
+++ b/t/README
@@ -52,7 +52,7 @@ (or -i) command line argument to the tes
 
 --immediate::
 	This causes the test to immediately exit upon the first
-	failed test.
+	failed test or warning.
 
 
 Naming Tests
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 05f6e79..e24cab0 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -80,6 +80,7 @@ fi
 
 test_failure=0
 test_count=0
+warning_count=0
 
 trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
 
@@ -101,6 +102,17 @@ test_failure_ () {
 	test "$immediate" = "" || { trap - exit; exit 1; }
 }
 
+test_warning_ () {
+    if [ -e ".git/index.lock" ]
+    then 
+        say "Warn $warning_count: file .git/index.lock exists"
+        warning_count=$(expr "$warning_count" + 1)
+    fi
+    if [ "$immediate" != "" -a $warning_count -gt 0 ]
+    then 
+        trap - exit; exit 1;
+    fi
+}
 
 test_debug () {
 	test "$debug" = "" || eval "$1"
@@ -123,6 +135,7 @@ test_expect_failure () {
 	else
 		test_failure_ "$@"
 	fi
+        test_warning_
 }
 
 test_expect_success () {
@@ -136,6 +149,7 @@ test_expect_success () {
 	else
 		test_failure_ "$@"
 	fi
+        test_warning_
 }
 
 test_expect_code () {
@@ -149,6 +163,7 @@ test_expect_code () {
 	else
 		test_failure_ "$@"
 	fi
+        test_warning_
 }
 
 # Most tests can use the created repository, but some amy need to create more.
@@ -178,13 +193,12 @@ test_done () {
 		# The Makefile provided will clean this test area so
 		# we will leave things as they are.
 
-		say "passed all $test_count test(s)"
+		say "passed all $test_count test(s) with $warning_count warning(s)"
 		exit 0 ;;
 
 	*)
-		say "failed $test_failure among $test_count test(s)"
+		say "failed $test_failure among $test_count test(s) with $warning_count warning(s)"
 		exit 1 ;;
-
 	esac
 }
 
@@ -210,6 +224,13 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
+# make sure the cygwin find is used instead of the win2k find.
+if [ $(uname -o 2>/dev/null || echo not) = "Cygwin" ]
+then
+    alias find="/bin/find" 
+fi
+
+
 # Test repository
 test=trash
 rm -fr "$test"

--AqsLC8rIMeq19msA--
