From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/4] t0024, t5000: clear variable UNZIP, use GIT_UNZIP instead
Date: Sun, 06 Jan 2013 18:47:57 +0100
Message-ID: <50E9B8CD.2010209@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 18:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TruKb-0001br-Pw
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 18:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086Ab3AFRsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 12:48:02 -0500
Received: from india601.server4you.de ([85.25.151.105]:37103 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3AFRsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 12:48:00 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id E0A03193;
	Sun,  6 Jan 2013 18:47:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E9B82D.50005@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212827>

InfoZIP's unzip takes default parameters from the environment variable
UNZIP.  Unset it in the test library and use GIT_UNZIP for specifying
alternate versions of the unzip command instead.

t0024 wasn't even using variable for the actual extraction.  t5000
was, but when setting it to InfoZIP's unzip it would try to extract
from itself (because it treats the contents of $UNZIP as parameters),
which failed of course.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t0024-crlf-archive.sh |  6 +++---
 t/t5000-tar-tree.sh     | 10 +++++-----
 t/test-lib.sh           |  2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index ec6c1b3..080fe5c 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -3,7 +3,7 @@
 test_description='respect crlf in git archive'
 
 . ./test-lib.sh
-UNZIP=${UNZIP:-unzip}
+GIT_UNZIP=${GIT_UNZIP:-unzip}
 
 test_expect_success setup '
 
@@ -26,7 +26,7 @@ test_expect_success 'tar archive' '
 
 '
 
-"$UNZIP" -v >/dev/null 2>&1
+"$GIT_UNZIP" -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	say "Skipping ZIP test, because unzip was not found"
 else
@@ -37,7 +37,7 @@ test_expect_success UNZIP 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
 
-	( mkdir unzipped && cd unzipped && unzip ../test.zip ) &&
+	( mkdir unzipped && cd unzipped && "$GIT_UNZIP" ../test.zip ) &&
 
 	test_cmp sample unzipped/sample
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index ecf00ed..1f7593d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,7 +25,7 @@ commit id embedding:
 '
 
 . ./test-lib.sh
-UNZIP=${UNZIP:-unzip}
+GIT_UNZIP=${GIT_UNZIP:-unzip}
 GZIP=${GZIP:-gzip}
 GUNZIP=${GUNZIP:-gzip -d}
 
@@ -37,9 +37,9 @@ check_zip() {
 	dir=$1
 	dir_with_prefix=$dir/$2
 
-	test_expect_success UNZIP " extract ZIP archive" "
-		(mkdir $dir && cd $dir && $UNZIP ../$zipfile)
-	"
+	test_expect_success UNZIP " extract ZIP archive" '
+		(mkdir $dir && cd $dir && "$GIT_UNZIP" ../$zipfile)
+	'
 
 	test_expect_success UNZIP " validate filenames" "
 		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
@@ -201,7 +201,7 @@ test_expect_success \
       test_cmp a/substfile2 g/prefix/a/substfile2
 '
 
-$UNZIP -v >/dev/null 2>&1
+"$GIT_UNZIP" -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	say "Skipping ZIP tests, because unzip was not found"
 else
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8a12cbb..d8ec408 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -85,6 +85,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 		.*_TEST
 		PROVE
 		VALGRIND
+		UNZIP
 		PERF_AGGREGATING_LATER
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
@@ -128,6 +129,7 @@ fi
 unset CDPATH
 
 unset GREP_OPTIONS
+unset UNZIP
 
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 1|2|true)
-- 
1.7.12
