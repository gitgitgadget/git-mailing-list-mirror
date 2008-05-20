From: David Reiss <dreiss@facebook.com>
Subject: [PATCH 2/4] Fold test-absolute-path into test-path-utils
Date: Mon, 19 May 2008 23:49:00 -0700
Message-ID: <4832745C.7030709@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 08:51:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyLgc-0000HC-Cd
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 08:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbYETGuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYETGuN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 02:50:13 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:14129 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbYETGuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 02:50:12 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4K6oBxC019876
	for <git@vger.kernel.org>; Mon, 19 May 2008 23:50:11 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 May 2008 23:47:07 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-OriginalArrivalTime: 20 May 2008 06:47:08.0100 (UTC) FILETIME=[52940040:01C8BA45]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-20_01:2008-05-20,2008-05-20,2008-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805190302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82466>

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Completely unnecessary.  I just thought it might be nice to combine these
to cut down on the number of test driver functions.

 .gitignore           |    1 -
 Makefile             |    2 +-
 t/t0000-basic.sh     |    8 ++++----
 test-absolute-path.c |   11 -----------
 test-path-utils.c    |    8 ++++++++
 5 files changed, 13 insertions(+), 17 deletions(-)
 delete mode 100644 test-absolute-path.c

diff --git a/.gitignore b/.gitignore
index c54c473..31ea9f1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -142,7 +142,6 @@ git-write-tree
 git-core-*/?*
 gitk-wish
 gitweb/gitweb.cgi
-test-absolute-path
 test-chmtime
 test-date
 test-delta
diff --git a/Makefile b/Makefile
index d76c16b..cda7ab1 100644
--- a/Makefile
+++ b/Makefile
@@ -1182,7 +1182,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-path-utils$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-utils$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 27b54cb..9745f25 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -301,14 +301,14 @@ test_expect_success 'absolute path works as expected' '
 	mkdir third &&
 	dir="$(cd .git; pwd -P)" &&
 	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-absolute-path $dir2)" &&
+	test "$dir" = "$(test-path-utils make_absolute_path $dir2)" &&
 	file="$dir"/index &&
-	test "$file" = "$(test-absolute-path $dir2/index)" &&
+	test "$file" = "$(test-path-utils make_absolute_path $dir2/index)" &&
 	basename=blub &&
-	test "$dir/$basename" = $(cd .git && test-absolute-path $basename) &&
+	test "$dir/$basename" = $(cd .git && test-path-utils make_absolute_path $basename) &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first; pwd -P)"/file &&
-	test "$sym" = "$(test-absolute-path $dir2/syml)"
+	test "$sym" = "$(test-path-utils make_absolute_path $dir2/syml)"
 '
 
 test_expect_success 'very long name in the index handled sanely' '
diff --git a/test-absolute-path.c b/test-absolute-path.c
deleted file mode 100644
index c959ea2..0000000
--- a/test-absolute-path.c
+++ /dev/null
@@ -1,11 +0,0 @@
-#include "cache.h"
-
-int main(int argc, char **argv)
-{
-	while (argc > 1) {
-		puts(make_absolute_path(argv[1]));
-		argc--;
-		argv++;
-	}
-	return 0;
-}
diff --git a/test-path-utils.c b/test-path-utils.c
index 1bd4321..842b580 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -9,5 +9,13 @@ int main(int argc, char **argv)
 		puts(buf);
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "make_absolute_path")) {
+		while (argc > 2) {
+			puts(make_absolute_path(argv[2]));
+			argc--;
+			argv++;
+		}
+	}
+
 	return 0;
 }
-- 
1.5.4
