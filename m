From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t/t7008: workaround broken handling of \000 by printf on IRIX
Date: Thu,  9 Sep 2010 14:15:57 -0500
Message-ID: <aIkKF4vjSeghwDQ63eyGAtU7mB-u0vNW0EzVfr5b9bck9XbQlHqCr65xFtnqEeEN20sMaBebsFc@cipher.nrlssc.navy.mil>
References: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 09 21:18:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmdS-0002cl-07
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab0IITSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:18:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34290 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0IITSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:18:04 -0400
Received: by mail.nrlssc.navy.mil id o89JG5S3003154; Thu, 9 Sep 2010 14:16:05 -0500
In-Reply-To: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Sep 2010 19:16:05.0698 (UTC) FILETIME=[734ACA20:01CB5053]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155887>

From: Brandon Casey <drafnel@gmail.com>

On IRIX 6.5, the printf utility in /usr/bin does not appear to handle the
\ddd notation according to POSIX.  This printf appears to halt processing
of the string argument and ignore any additional characters in the string.
Work around this flaw by replacing the \000's with 'Q' and using the
q_to_nul helper function provided by test-lib.sh

This problem with printf is not apparent when using the Bash shell since
Bash implements a POSIX compatible printf function internally.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7008-grep-binary.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index c0f9f3f..e058d18 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -5,7 +5,7 @@ test_description='git grep in binary files'
 . ./test-lib.sh
 
 test_expect_success 'setup' "
-	printf 'binary\000file\n' >a &&
+	echo 'binaryQfile' | q_to_nul >a &&
 	git add a &&
 	git commit -m.
 "
@@ -70,32 +70,32 @@ test_expect_failure 'git grep .fi a' '
 '
 
 test_expect_success 'git grep -F y<NUL>f a' "
-	printf 'y\000f' >f &&
+	printf 'yQf' | q_to_nul >f &&
 	git grep -f f -F a
 "
 
 test_expect_success 'git grep -F y<NUL>x a' "
-	printf 'y\000x' >f &&
+	printf 'yQx' | q_to_nul >f &&
 	test_must_fail git grep -f f -F a
 "
 
 test_expect_success 'git grep -Fi Y<NUL>f a' "
-	printf 'Y\000f' >f &&
+	printf 'YQf' | q_to_nul >f &&
 	git grep -f f -Fi a
 "
 
 test_expect_failure 'git grep -Fi Y<NUL>x a' "
-	printf 'Y\000x' >f &&
+	printf 'YQx' | q_to_nul >f &&
 	test_must_fail git grep -f f -Fi a
 "
 
 test_expect_success 'git grep y<NUL>f a' "
-	printf 'y\000f' >f &&
+	printf 'yQf' | q_to_nul >f &&
 	git grep -f f a
 "
 
 test_expect_failure 'git grep y<NUL>x a' "
-	printf 'y\000x' >f &&
+	printf 'yQx' | q_to_nul >f &&
 	test_must_fail git grep -f f a
 "
 
-- 
1.7.2.1
