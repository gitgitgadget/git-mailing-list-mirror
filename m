From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] t1402: work around shell quoting issue on NetBSD
Date: Tue, 08 Jan 2013 21:23:01 +0100
Message-ID: <50EC8025.8000707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsfhv-0001m4-AY
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 21:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab3AHUXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 15:23:16 -0500
Received: from india601.server4you.de ([85.25.151.105]:37211 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab3AHUXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 15:23:15 -0500
Received: from [192.168.2.105] (p4FFDA953.dip.t-dialin.net [79.253.169.83])
	by india601.server4you.de (Postfix) with ESMTPSA id 1901E81;
	Tue,  8 Jan 2013 21:23:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213003>

The test fails for me on NetBSD 6.0.1 and reports:

	ok 1 - ref name '' is invalid
	ok 2 - ref name '/' is invalid
	ok 3 - ref name '/' is invalid with options --allow-onelevel
	ok 4 - ref name '/' is invalid with options --normalize
	error: bug in the test script: not 2 or 3 parameters to test-expect-success

The alleged bug is in this line:

	invalid_ref NOT_MINGW '/' '--allow-onelevel --normalize'

invalid_ref() constructs a test case description using its last argument,
but the shell seems to split it up into two pieces if it contains a
space.  Minimal test case:

	# on NetBSD with /bin/sh
	$ a() { echo $#-$1-$2; }
	$ t="x"; a "${t:+$t}"
	1-x-
	$ t="x y"; a "${t:+$t}"
	2-x-y
	$ t="x y"; a "${t:+x y}"
	1-x y-

	# and with bash
	$ t="x y"; a "${t:+$t}"
	1-x y-
	$ t="x y"; a "${t:+x y}"
	1-x y-

This may be a bug in the shell, but here's a simple workaround: Construct
the description string first and store it in a variable, and then use
that to call test_expect_success().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t1402-check-ref-format.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1ae4d87..1a5a5f3 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -11,7 +11,8 @@ valid_ref() {
 		prereq=$1
 		shift
 	esac
-	test_expect_success $prereq "ref name '$1' is valid${2:+ with options $2}" "
+	desc="ref name '$1' is valid${2:+ with options $2}"
+	test_expect_success $prereq "$desc" "
 		git check-ref-format $2 '$1'
 	"
 }
@@ -22,7 +23,8 @@ invalid_ref() {
 		prereq=$1
 		shift
 	esac
-	test_expect_success $prereq "ref name '$1' is invalid${2:+ with options $2}" "
+	desc="ref name '$1' is invalid${2:+ with options $2}"
+	test_expect_success $prereq "$desc" "
 		test_must_fail git check-ref-format $2 '$1'
 	"
 }
-- 
1.7.12
