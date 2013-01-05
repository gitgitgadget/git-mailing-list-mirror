From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t7061: comments and one failure
Date: Sat, 05 Jan 2013 12:07:24 +0100
Message-ID: <50E8096C.7000501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: apelisse@gmail.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 12:07:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrRbO-0006uJ-PK
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 12:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab3AELH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 06:07:28 -0500
Received: from mout.web.de ([212.227.17.11]:53284 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755470Ab3AELH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 06:07:26 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MA5v3-1TgkD71l1t-00BSWe; Sat, 05 Jan 2013 12:07:24
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Provags-ID: V02:K0:ivzEUP+wdLDMfhgwTqY4X2wQ0Wm8kGqhBAzubaNidQi
 fL+vb3HNF+bZBl90hNPwWVcdu+21vz6AEfIzJheedPmwgfj+OA
 glh6lyhwOg7nZ2AyfPQCpMDTP5Cai07g0lFXk+06g2rdjgGBdE
 TO/un1hsfv63jehCBYw+sKuhhodaUO93VyMbnCyP7wqNQ77Wu+
 Lblhs1gQkvUyfS00RbGqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212685>

Hej,
TC 9 is failing (Mac OS X 10.6),
==========================
expecting success: 
        >tracked/uncommitted &&
        git status --porcelain --ignored >actual &&
        test_cmp expected actual

--- expected    2013-01-05 11:01:00.000000000 +0000
+++ actual      2013-01-05 11:01:00.000000000 +0000
@@ -1,4 +1,3 @@
 ?? .gitignore
 ?? actual
 ?? expected
-!! tracked/
not ok 9 - status ignored tracked directory and uncommitted file with --ignore
#       
#               >tracked/uncommitted &&
#               git status --porcelain --ignored >actual &&
#               test_cmp expected actual
#       
=======================
I haven't been able to dig further into this,
(I can volonteer to do some more debugging).
Looking into the code, there are 2 questions:

1) echo "ignored" >.gitignore &&
  We don't need the quoting of a simple string which does not have space in it.
2)  : >untracked/ignored &&
Do we need the colon here?

Would it make sence to do the following:


diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0da1214..761a2e7 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -12,10 +12,10 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success 'status untracked directory with --ignored' '
-	echo "ignored" >.gitignore &&
+	echo ignored >.gitignore &&
 	mkdir untracked &&
-	: >untracked/ignored &&
-	: >untracked/uncommitted &&
+	>untracked/ignored &&
+	>untracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
 '
@@ -43,7 +43,7 @@ EOF
 test_expect_success 'status ignored directory with --ignore' '
 	rm -rf untracked &&
 	mkdir ignored &&
-	: >ignored/uncommitted &&
+	>ignored/uncommitted &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
 '
@@ -71,8 +71,8 @@ test_expect_success 'status untracked directory with ignored files with --ignore
 	rm -rf ignored &&
 	mkdir untracked-ignored &&
 	mkdir untracked-ignored/test &&
-	: >untracked-ignored/ignored &&
-	: >untracked-ignored/test/ignored &&
+	>untracked-ignored/ignored &&
+	>untracked-ignored/test/ignored &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
 '
@@ -99,10 +99,10 @@ EOF
 test_expect_success 'status ignored tracked directory with --ignore' '
 	rm -rf untracked-ignored &&
 	mkdir tracked &&
-	: >tracked/committed &&
+	>tracked/committed &&
 	git add tracked/committed &&
 	git commit -m. &&
-	echo "tracked" >.gitignore &&
+	echo tracked >.gitignore &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
 '
@@ -126,7 +126,7 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
-	: >tracked/uncommitted &&
+	>tracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
 '


/Torsten
