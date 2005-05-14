From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Test framework documentation.
Date: Sat, 14 May 2005 00:25:06 -0700
Message-ID: <7vwtq246ct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 09:26:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWr24-0003SW-Fh
	for gcvg-git@gmane.org; Sat, 14 May 2005 09:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVENHZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 03:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVENHZk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 03:25:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30922 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262697AbVENHZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 03:25:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514072508.PIHX23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 May 2005 03:25:08 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds instruction for running tests, and writing new tests.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

t/README |  174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
1 files changed, 174 insertions(+)
t/README (. --> 100644)

--- a/t/README
+++ b/t/README
@@ -0,0 +1,174 @@
+Core GIT Tests
+==============
+
+This directory holds many test scripts for core GIT tools.  The
+first part of this short document describes how to run the tests
+and read their output.
+
+When fixing the tools or adding enhancements, you are strongly
+encouraged to add tests in this directory to cover what you are
+trying to fix or enhance.  The later part of this short document
+describes how your test scripts should be organized.
+
+
+Running Tests
+-------------
+
+The easiest way to run tests is to say "make".  This runs all
+the tests.
+
+    *** t0000-basic.sh ***
+    * ok #1: .git/objects should be empty after git-init-db in an empty repo.
+    * ok #2: .git/objects should have 256 subdirectories.
+    * ok #3: git-update-cache without --add should fail adding.
+    ...
+    * ok #23: no diff after checkout and git-update-cache --refresh.
+    * passed all 23 test(s)
+    *** t0100-environment-names.sh ***
+    * ok #1: using old names should issue warnings.
+    * ok #2: using old names but having new names should not issue warnings.
+    ...
+
+Or you can run each test individually from command line, like
+this:
+
+    $ sh ./t0500-ls-files.sh
+    * ok #1: git-update-cache --add to add various paths.
+    * ok #2: git-ls-files -k to show killed files.
+    * ok #3: validate git-ls-files -k output.
+    * passed all 3 test(s)
+
+You can pass --verbose (or -v), --debug (or -d), and --immediate
+(or -i) command line argument to the test.
+
+--verbose::
+	This makes the test more verbose.  Specifically, the
+	command being run and their output if any are also
+	output.
+
+--debug::
+	This may help the person who is developing a new test.
+	It causes the command defined with test_debug to run.
+
+--immediate::
+	This causes the test to immediately exit upon the first
+	failed test.
+
+
+Writing Tests
+-------------
+
+The test script is written as a shell script.  It should start
+with the standard "#!/bin/sh" with copyright notices, and an
+assignment to variable 'test_description', like this:
+
+	#!/bin/sh
+	#
+	# Copyright (c) 2005 Junio C Hamano
+	#
+
+	test_description='xxx test (new option --frotz)
+
+	This test registers the following structure in the cache
+	and tries to run git-ls-files with new option --frotz.'
+
+Source 'test-lib.sh'
+--------------------
+
+After assigning test_description, the test script should source
+test-lib.sh like this:
+
+	. ./test-lib.sh
+
+This test harness library does the following things:
+
+ - If the script is invoked with command line argument --help
+   (or -h), it shows the test_description and exits.
+
+ - Creates an empty test directory with an empty .git/objects
+   database and chdir(2) into it.  This directory is 't/trash'
+   if you must know, but I do not think you care.
+
+ - Defines standard test helper functions for your scripts to
+   use.  These functions are designed to make all scripts behave
+   consistently when command line arguments --verbose (or -v),
+   --debug (or -d), and --immediate (or -i) is given.
+
+
+End with test_done
+------------------
+
+Your script will be a sequence of tests, using helper functions
+from the test harness library.  At the end of the script, call
+'test_done'.
+
+
+Test harness library
+--------------------
+
+There are a handful helper functions defined in the test harness
+library for your script to use.
+
+ - test_expect_success <message> <script>
+
+   This takes two strings as parameter, and evaluates the
+   <script>.  If it yields success, test is considered
+   successful.  <message> should state what it is testing.
+
+   Example:
+
+	test_expect_success \
+	    'git-write-tree should be able to write an empty tree.' \
+	    'tree=$(git-write-tree)'
+
+ - test_expect_failure <message> <script>
+
+   This is the opposite of test_expect_success.  If <script>
+   yields success, test is considered a failure.
+
+   Example:
+
+	test_expect_failure \
+	    'git-update-cache without --add should fail adding.' \
+	    'git-update-cache should-be-empty'
+
+ - test_debug <script>
+
+   This takes a single argument, <script>, and evaluates it only
+   when the test script is started with --debug command line
+   argument.  This is primarily meant for use during the
+   development of a new test script.
+
+ - test_done
+
+   Your test script must have test_done at the end.  Its purpose
+   is to summarize successes and failures in the test script and
+   exit with an appropriate error code.
+
+
+Tips for Writing Tests
+----------------------
+
+As with any programming projects, existing programs are the best
+source of the information.  However, do _not_ emulate
+t0000-basic.sh when writing your tests.  The test is special in
+that it tries to validate the very core of GIT.  For example, it
+knows that there will be 256 subdirectories under .git/objects/,
+and it knows that the object ID of an empty tree is a certain
+40-byte string.  This is deliberately done so in t0000-basic.sh
+because the things the very basic core test tries to achieve is
+to serve as a basis for people who are changing the GIT internal
+drastically.  For these people, after making certain changes,
+not seeing failures from the basic test _is_ a failure.  And
+such drastic changes to the core GIT that even changes these
+otherwise supposedly stable object IDs should be accompanied by
+an update to t0000-basic.sh.
+
+However, other tests that simply rely on basic parts of the core
+GIT working properly should not have that level of intimate
+knowledge of the core GIT internals.  If all the test scripts
+hardcoded the object IDs like t0000-basic.sh does, that defeats
+the purpose of t0000-basic.sh, which is to isolate that level of
+validation in one place.  Your test also ends up needing
+updating when such a change to the internal happens, so do _not_
+do it and leave the low level of validation to t0000-basic.sh.
------------------------------------------------

