From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/4] t5002: check if unzip supports symlinks
Date: Sun, 06 Jan 2013 18:59:39 +0100
Message-ID: <50E9BB8B.9020101@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 19:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TruW0-0006Bi-Sq
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 19:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab3AFR7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 12:59:43 -0500
Received: from india601.server4you.de ([85.25.151.105]:37109 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab3AFR7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 12:59:42 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id 0478E81;
	Sun,  6 Jan 2013 18:59:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E9B82D.50005@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212830>

Only add a symlink to the repository if both the filesystem and
unzip support symlinks.  To check the latter, add a ZIP file
containing a symlink, created like this with InfoZIP zip 3.0:

	$ echo sample text >textfile
	$ ln -s textfile symlink
	$ zip -y infozip-symlinks.zip textfile symlink

If we can extract it successfully, we add a symlink to the test
repository for git archive --format=zip, or otherwise skip that
step.  Users can see the skipped test and perhaps run it again
with a different unzip version.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5002-archive-zip.sh       |  26 +++++++++++++++++++-------
 t/t5002/infozip-symlinks.zip | Bin 0 -> 328 bytes
 2 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 t/t5002/infozip-symlinks.zip

diff --git a/t/t5002-archive-zip.sh b/t/t5002-archive-zip.sh
index ac9c6d4..d35aa24 100755
--- a/t/t5002-archive-zip.sh
+++ b/t/t5002-archive-zip.sh
@@ -12,6 +12,15 @@ test_lazy_prereq UNZIP '
 	test $? -ne 127
 '
 
+test_lazy_prereq UNZIP_SYMLINKS '
+	(
+		mkdir unzip-symlinks &&
+		cd unzip-symlinks &&
+		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5002/infozip-symlinks.zip &&
+		test -h symlink
+	)
+'
+
 check_zip() {
 	zipfile=$1.zip
 	listfile=$1.lst
@@ -40,15 +49,18 @@ test_expect_success \
      cp /bin/sh a/bin &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
-     if test_have_prereq SYMLINKS; then
-	ln -s a a/l1
-     else
-	printf %s a > a/l1
-     fi &&
      (p=long_path_to_a_file && cd a &&
       for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
-      echo text >file_with_long_path) &&
-     (cd a && find .) | sort >a.lst'
+      echo text >file_with_long_path)
+'
+
+test_expect_success SYMLINKS,UNZIP_SYMLINKS 'add symlink' '
+	ln -s a a/symlink_to_a
+'
+
+test_expect_success 'prepare file list' '
+	(cd a && find .) | sort >a.lst
+'
 
 test_expect_success \
     'add ignored file' \
diff --git a/t/t5002/infozip-symlinks.zip b/t/t5002/infozip-symlinks.zip
new file mode 100644
index 0000000000000000000000000000000000000000..065728c631cf1f7ab20a045a83abc3e08455eeba
GIT binary patch
literal 328
zcmWIWW@h1H0D(ty)tzkeJdg4K*&xipAj43ST2YdgnUfkC!pXp_F7Y}5gi9;985mh!
zFf%Z)qyW_wC*~I9q$+@vas|Lmdj&M@9kbsh4zNiK4D3MDiYs$-GV`**hM5Bm0%0`6
zU={{=Gcw6B<8qh;&`<^jMj&3&2x7r>g@&*~oQY;CvT2wOgO~;~=j}p2APILS&@e1c
U4De=U11V+#!r4H2I*7vn0CeC%rvLx|

literal 0
HcmV?d00001

-- 
1.7.12
