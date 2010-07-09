From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] test-lib: simplify GIT_SKIP_TESTS loop
Date: Fri,  9 Jul 2010 12:01:28 +0200
Message-ID: <0f97dc0377b97675f45b568254dabefb5b1e0146.1278669505.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 12:02:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXAPy-0001Tr-20
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 12:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab0GIKCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 06:02:45 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45516 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849Ab0GIKCo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 06:02:44 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DDCB416B5D8;
	Fri,  9 Jul 2010 06:02:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 09 Jul 2010 06:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=95RMqvNVzUUiGFDDzLvmixG5Ndk=; b=ijD/oUkQP14A5zm8Gfgaed1UhDOCgEIP3+lnma/GUpHiiMNhGxxkAZVEKrQgnQ5KjRzTd+jqRql7+b66i5aIuOzlxthwUx6itgG/X5tQ5WRsT/sbRmM3cV1NOBH2H8gYApGRWp2Ftyj51acfRJTYSYxbOuoqs3w5gyHX/lMnFLA=
X-Sasl-enc: D8WuugRyj8ksaXPEKPKD64ilKB2b+ca0ivngs1l3OcD+ 1278669742
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 450BF4D4144;
	Fri,  9 Jul 2010 06:02:22 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150649>

04ece59 (GIT_SKIP_TESTS: allow users to omit tests that are known to break, 2006-12-28)
introduced GIT_SKIP_TESTS, and since then we have had two nested loops
iterating over GIT_SKIP_TESTS with the same loop variable.

Reduce this to one loop.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I am probably making a complete shell fool out of myself by overlooking
something completely trivial.

But just in case I am not, this reduces the loop from O(N^2) to O(N), although
I do admit that N is typically not that large...
(Note that the inner $skp does not overwrite the outer one, at least not with bash.)

 t/test-lib.sh |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..8e3de53 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -827,23 +827,20 @@ cd -P "$test" || exit 1
 
 this_test=${0##*/}
 this_test=${this_test%%-*}
+to_skip=
 for skp in $GIT_SKIP_TESTS
 do
-	to_skip=
-	for skp in $GIT_SKIP_TESTS
-	do
-		case "$this_test" in
-		$skp)
-			to_skip=t
-		esac
-	done
-	case "$to_skip" in
-	t)
-		say_color skip >&3 "skipping test $this_test altogether"
-		say_color skip "skip all tests in $this_test"
-		test_done
+	case "$this_test" in
+	$skp)
+		to_skip=t
 	esac
 done
+case "$to_skip" in
+t)
+	say_color skip >&3 "skipping test $this_test altogether"
+	say_color skip "skip all tests in $this_test"
+	test_done
+esac
 
 # Provide an implementation of the 'yes' utility
 yes () {
-- 
1.7.2.rc1.212.g850a
