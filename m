From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 10/9] t5000: rationalize unzip tests
Date: Thu, 03 May 2012 10:52:16 +0200
Message-ID: <4FA24740.4020502@lsrfire.ath.cx>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 10:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPrlw-0002s0-Je
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 10:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2ECIwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 04:52:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:58273 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab2ECIwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 04:52:17 -0400
Received: from [192.168.2.105] (p4FFDA20E.dip.t-dialin.net [79.253.162.14])
	by india601.server4you.de (Postfix) with ESMTPSA id C93332F804F;
	Thu,  3 May 2012 10:52:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196892>

Factor out a function for checking the contents of ZIP archives.  It
extracts their contents and compares them to the original files.  This
removes some duplicate code.  Tests that just create archives can lose
their UNZIP prerequisite.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh |   81 +++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 94f2eba..a5314f6 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -31,6 +31,26 @@ GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
 
+check_zip() {
+	zipfile=$1.zip
+	listfile=$1.lst
+	dir=$1
+	dir_with_prefix=$dir/$2
+
+	test_expect_success UNZIP " extract ZIP archive" "
+		(mkdir $dir && cd $dir && $UNZIP ../$zipfile)
+	"
+
+	test_expect_success UNZIP " validate filenames" "
+		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
+		test_cmp a.lst $listfile
+	"
+
+	test_expect_success UNZIP " validate file contents" "
+		diff -r a ${dir_with_prefix}a
+	"
+}
+
 test_expect_success \
     'populate workdir' \
     'mkdir a b c &&
@@ -181,10 +201,19 @@ test_expect_success \
       test_cmp a/substfile2 g/prefix/a/substfile2
 '
 
+$UNZIP -v >/dev/null 2>&1
+if [ $? -eq 127 ]; then
+	say "Skipping ZIP tests, because unzip was not found"
+else
+	test_set_prereq UNZIP
+fi
+
 test_expect_success \
     'git archive --format=zip' \
     'git archive --format=zip HEAD >d.zip'
 
+check_zip d
+
 test_expect_success \
     'git archive --format=zip in a bare repo' \
     '(cd bare.git && git archive --format=zip HEAD) >d1.zip'
@@ -207,56 +236,26 @@ test_expect_success 'git archive with --output, override inferred format' '
 	test_cmp b.tar d4.zip
 '
 
-$UNZIP -v >/dev/null 2>&1
-if [ $? -eq 127 ]; then
-	say "Skipping ZIP tests, because unzip was not found"
-else
-	test_set_prereq UNZIP
-fi
-
-test_expect_success UNZIP \
-    'extract ZIP archive' \
-    '(mkdir d && cd d && $UNZIP ../d.zip)'
-
-test_expect_success UNZIP \
-    'validate filenames' \
-    '(cd d/a && find .) | sort >d.lst &&
-     test_cmp a.lst d.lst'
-
-test_expect_success UNZIP \
-    'validate file contents' \
-    'diff -r a d/a'
-
 test_expect_success \
     'git archive --format=zip with prefix' \
     'git archive --format=zip --prefix=prefix/ HEAD >e.zip'
 
-test_expect_success UNZIP \
-    'extract ZIP archive with prefix' \
-    '(mkdir e && cd e && $UNZIP ../e.zip)'
+check_zip e prefix/
 
-test_expect_success UNZIP \
-    'validate filenames with prefix' \
-    '(cd e/prefix/a && find .) | sort >e.lst &&
-     test_cmp a.lst e.lst'
-
-test_expect_success UNZIP \
-    'validate file contents with prefix' \
-    'diff -r a e/prefix/a'
-
-test_expect_success UNZIP 'git archive -0 --format=zip on large files' '
-    test_config core.bigfilethreshold 1 &&
-    git archive -0 --format=zip HEAD >large.zip &&
-    (mkdir large && cd large && $UNZIP ../large.zip)
+test_expect_success 'git archive -0 --format=zip on large files' '
+	test_config core.bigfilethreshold 1 &&
+	git archive -0 --format=zip HEAD >large.zip
 '
 
-test_expect_success UNZIP 'git archive --format=zip on large files' '
-    test_config core.bigfilethreshold 1 &&
-    git archive --format=zip HEAD >large-compressed.zip &&
-    (mkdir large-compressed && cd large-compressed && $UNZIP ../large-compressed.zip) &&
-    test_cmp large-compressed/a/bin/sh large/a/bin/sh
+check_zip large
+
+test_expect_success 'git archive --format=zip on large files' '
+	test_config core.bigfilethreshold 1 &&
+	git archive --format=zip HEAD >large-compressed.zip
 '
 
+check_zip large-compressed
+
 test_expect_success \
     'git archive --list outside of a git repo' \
     'GIT_DIR=some/non-existing/directory git archive --list'
