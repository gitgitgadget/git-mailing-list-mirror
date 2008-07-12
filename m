From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t0004: fix timing bug
Date: Sat, 12 Jul 2008 04:14:52 -0700
Message-ID: <7vej5zwdzn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 13:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHd56-0007nC-Kg
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 13:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbYGLLPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 07:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbYGLLPA
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 07:15:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbYGLLO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 07:14:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C0FBC28FFF;
	Sat, 12 Jul 2008 07:14:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0957A28FFE; Sat, 12 Jul 2008 07:14:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C300DCD2-5003-11DD-8BDA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88233>

The test created an initial commit, made .git/objects unwritable and then
exercised various codepaths to create loose commit, tree and blob objects
to make sure the commands notice failures from these attempts.

However, the initial commit was not preceded with test_tick, which made
its object name depend on the timestamp.  The names of all the later tree
and blob objects the test tried to create were static.  If the initial
commit's object name happened to begin with the same two hexdigits as the
tree or blob objects the test later attempted to create, the fan-out
directory in which these tree or blob would be created is already created
when the initial commit was made, and the object creation succeeds, and
commands being tested should not notice any failure --- in short, the test
was bogus.

This makes the fan-out directories also unwritable, and adds test_tick
before the commit object creation to make the test repeatable.

The contents of the file to create a blob from "a" to "60" is to force the
name of the blob object to begin with "1b", which shares the fan-out
directory with the initial commit that is created with the test.  This was
useful when diagnosing the breakage of this test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I initially hoped that I spotted a bug in the Linux filesystem code
   that lets a quick operation sneak past chmod that is done immediately
   after it or something racy so that I can tease Linus with it, but no
   such luck ;-)  Doubly embarrasing is that the test-bug is mine. 

 t/t0004-unwritable.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 9255c63..63e1217 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -8,6 +8,7 @@ test_expect_success setup '
 
 	>file &&
 	git add file &&
+	test_tick &&
 	git commit -m initial &&
 	echo >file &&
 	git add file
@@ -17,11 +18,11 @@ test_expect_success setup '
 test_expect_success 'write-tree should notice unwritable repository' '
 
 	(
-		chmod a-w .git/objects
+		chmod a-w .git/objects .git/objects/?? &&
 		test_must_fail git write-tree
 	)
 	status=$?
-	chmod 775 .git/objects
+	chmod 775 .git/objects .git/objects/??
 	(exit $status)
 
 '
@@ -29,11 +30,11 @@ test_expect_success 'write-tree should notice unwritable repository' '
 test_expect_success 'commit should notice unwritable repository' '
 
 	(
-		chmod a-w .git/objects
+		chmod a-w .git/objects .git/objects/?? &&
 		test_must_fail git commit -m second
 	)
 	status=$?
-	chmod 775 .git/objects
+	chmod 775 .git/objects .git/objects/??
 	(exit $status)
 
 '
@@ -41,12 +42,12 @@ test_expect_success 'commit should notice unwritable repository' '
 test_expect_success 'update-index should notice unwritable repository' '
 
 	(
-		echo a >file &&
-		chmod a-w .git/objects
+		echo 6O >file &&
+		chmod a-w .git/objects .git/objects/?? &&
 		test_must_fail git update-index file
 	)
 	status=$?
-	chmod 775 .git/objects
+	chmod 775 .git/objects .git/objects/??
 	(exit $status)
 
 '
@@ -55,11 +56,11 @@ test_expect_success 'add should notice unwritable repository' '
 
 	(
 		echo b >file &&
-		chmod a-w .git/objects
+		chmod a-w .git/objects .git/objects/?? &&
 		test_must_fail git add file
 	)
 	status=$?
-	chmod 775 .git/objects
+	chmod 775 .git/objects .git/objects/??
 	(exit $status)
 
 '
