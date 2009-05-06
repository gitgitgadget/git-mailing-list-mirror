From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tests in Cygwin
Date: Wed, 06 May 2009 13:42:27 -0700
Message-ID: <7vvdoet13g.fsf@alter.siamese.dyndns.org>
References: <83prfbhasp.fsf@kalahari.s2.org>
	<4A01E64C.7050703@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:43:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1nxX-0007xX-Gh
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761550AbZEFUmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761528AbZEFUmf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:42:35 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53391 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759842AbZEFUme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:42:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506204234.IRHF20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 May 2009 16:42:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id oLiU1b00C4aMwMQ03LiVKC; Wed, 06 May 2009 16:42:34 -0400
X-Authority-Analysis: v=1.0 c=1 a=X5qfkU2QAAAA:8 a=zDJmUZwlLNuI9MvgU5QA:9
 a=q20MyIUILVcY_ZnA2KsA:7 a=b9WDudQj-0dUi09r3q_r0FuAjUkA:4 a=APNzIMUK1msA:10
X-CM-Score: 0.00
In-Reply-To: <4A01E64C.7050703@SierraAtlantic.com> (Don Slutz's message of "Wed\, 06 May 2009 15\:34\:36 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118385>

Don Slutz <Don.Slutz@SierraAtlantic.com> writes:

> A lot of these failures are do to running as root (member of
> Administrators)....

Perhaps we can do this to reduce the noise level.

---
 t/README                    |   26 +++++++++++++++++++++++---
 t/t1004-read-tree-m-u-wf.sh |    2 +-
 t/t7300-clean.sh            |    2 +-
 t/test-lib.sh               |   22 +++++++++++++++-------
 4 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/t/README b/t/README
index d8f6c7d..a532c32 100644
--- a/t/README
+++ b/t/README
@@ -194,19 +194,28 @@ Test harness library
 There are a handful helper functions defined in the test harness
 library for your script to use.
 
- - test_expect_success <message> <script>
+ - test_expect_success [<prereq>] <message> <script>
 
-   This takes two strings as parameter, and evaluates the
+   This takes two or three strings as parameters, and evaluates the
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.
 
+   An optional parameter <prereq> is a space separated list of prerequisite
+   tokens.  The test will be skipped if the test environment lacks any of
+   the prerequiste feature listed (see below for commonly used
+   prerequisites).
+
    Example:
 
 	test_expect_success \
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=$(git-write-tree)'
 
- - test_expect_failure <message> <script>
+	test_expect_success SANITY '/ should not be writable' '
+		! test -w /
+	'
+
+ - test_expect_failure [<prereq>] <message> <script>
 
    This is NOT the opposite of test_expect_success, but is used
    to mark a test that demonstrates a known breakage.  Unlike
@@ -247,6 +256,17 @@ library for your script to use.
    Merges the given rev using the given message.  Like test_commit,
    creates a tag and calls test_tick before committing.
 
+Prerequisites
+-------------
+
+ POSIXPERM	The filesystem supports POSIX style permission bits
+ BSLASHPSPEC	???
+ EXECKEEPSPID	The process retains the same pid across exec(2)
+
+ SANITY		Test is not run by root user, and an attempt to an
+                unwritable file is expected to fail correctly.
+
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index f19b4a2..eb60f80 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '
 
 '
 
-test_expect_success SYMLINKS 'funny symlink in work tree, un-unlink-able' '
+test_expect_success 'SYMLINKS SANITY' 'funny symlink in work tree, un-unlink-able' '
 
 	rm -fr a b &&
 	git reset --hard &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 929d5d4..7a5f680 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -369,7 +369,7 @@ test_expect_success 'core.excludesfile' '
 
 '
 
-test_expect_success 'removal failure' '
+test_expect_success SANITY 'removal failure' '
 
 	mkdir foo &&
 	touch foo/bar &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index dad1437..1922e0b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -264,12 +264,16 @@ test_set_prereq () {
 satisfied=" "
 
 test_have_prereq () {
-	case $satisfied in
-	*" $1 "*)
-		: yes, have it ;;
-	*)
-		! : nope ;;
-	esac
+	for prerequisite
+	do
+		case $satisfied in
+		*" $prerequisite "*)
+			: yes, have it ;;
+		*)
+			return 1 ;;
+		esac
+	done
+	:
 }
 
 # You are not expected to call test_ok_ and test_failure_ directly, use
@@ -670,6 +674,10 @@ do
 	esac
 done
 
+# When tests are run as root (which is silly), permission
+# tests will report things are writable when they should not be.
+test -w / || test_set_prereq SANITY
+
 # Fix some commands on Windows
 case $(uname -s) in
 *MINGW*)
@@ -692,7 +700,7 @@ case $(uname -s) in
 	# exec does not inherit the PID
 	;;
 *)
-	test_set_prereq POSIXPERM
+	test_have_prereq SANITY && test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
 	;;
