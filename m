From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/20] Add test_repo_expect_success for running tests in a new repository
Date: Tue, 29 Dec 2015 19:10:37 +0700
Message-ID: <1451391043-28093-15-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8Y-00073O-I8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbbL2MMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:18 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33547 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbL2MMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:17 -0500
Received: by mail-pf0-f182.google.com with SMTP id q63so90974007pfb.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lvp/pdVLuO/wEqM/4pw+9s+Fa40AaXtVNlZRdcvHrZA=;
        b=FNiF2roQkvyNCKsVAhzC25trauY5fsanQhJBYG01zCrKUDExQxR391tP6jheyfRxnt
         26G1CRwpCNojVUdPAxY2HP550llURosUKh8y6u2wo5DDQUXRK22dIm1W1oEnO9IFeUuJ
         Ij3C4cMN/48zfYC8m+Vp1BhxczO/QvtlGsFQJV6qmIjx98QM7Lh+AgeaDdZy9Pesi5+U
         KFQYDWl+NpsCjmyjd5ZwDh/UZQtN3ajj5QJP1nA8otwxw9PnXGfYOzJPTSsylopGT+qr
         MnzZbvAX83COrzL3KUkAMzFW/NC0VlGTpgOA/CJ41pdXq0+jKSXsazcoMgP2m9pPC4pD
         Vvnw==
X-Received: by 10.98.13.16 with SMTP id v16mr84909716pfi.129.1451391136646;
        Tue, 29 Dec 2015 04:12:16 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id fe6sm87910618pab.40.2015.12.29.04.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:12 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283124>

This could be convenient when tests are independent from the rest in th=
e
same file. Normally we would do this

test_expect_success '...' '
	git init foo &&
	(
		cd foo &&
		<script>
	)
'

Now we can write a shorter version

test_repo_expect_success '...' '
	<script>
'

The other function, test_subdir_expect_success, expands the script to
"( cd <repo> && <script> )", which can be useful for grouping a series =
of
tests that operate on the same repository in a subdir, e.g.

test_expect_success 'create repo abc' 'test_create_repo abc'
test_subdir_expect_success abc '...' <script>
test_subdir_expect_success abc '...' <another-script>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/README                | 15 +++++++++++++++
 t/test-lib-functions.sh | 20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/t/README b/t/README
index 1dc908e..6fc0d92 100644
--- a/t/README
+++ b/t/README
@@ -743,6 +743,21 @@ library for your script to use.
    the symbolic link in the file system and a part that does; then onl=
y
    the latter part need be protected by a SYMLINKS prerequisite (see b=
elow).
=20
+ - test_subdir_expect_success <subdir> [<prereq>] <message> <script>
+   test_subdir_expect_success <subdir> <prereq> <message> <script> <pr=
ologue>
+
+   Expands to
+
+        test_expect_success [<prereq>] <message> "( cd <subdir> && <sc=
ript> )"
+   or
+
+        test_expect_success <prereq> <message> "<prologue> && ( cd <su=
bdir> && <script> )"
+
+ - test_repo_expect_success [<prereq>] <message> <script>
+
+   Create a new repository and perform <script> inside this repository
+   in a subshell.
+
 Prerequisites
 -------------
=20
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c64e5a5..3182b9a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -416,6 +416,26 @@ test_expect_success () {
 	test_finish_
 }
=20
+test_subdir_expect_success () {
+	local subdir=3D"$1"
+	shift
+	case "$#" in
+		2) test_expect_success "$1" "( cd $subdir && $2 )";;
+		3) test_expect_success "$1" "$2" "( cd $subdir && $3 )";;
+		4) test_expect_success "$1" "$2" "$4 && ( cd $subdir && $3 )";;
+		*) error "bug in the test script: not 3-5 parameters to test-subdir-=
expect-success";;
+	esac
+}
+
+test_repo_expect_success () {
+	local repo=3Drepo-$(($test_count+1))
+	case "$#" in
+		2) test_subdir_expect_success "$repo" '' "$1" "$2" "test_create_repo=
 $repo";;
+		3) test_subdir_expect_success "$repo" "$1" "$2" "$3" "test_create_re=
po $repo";;
+		*) error "bug in the test script: not 2 or 3 parameters to test-repo=
-expect-success";;
+	esac
+}
+
 # test_external runs external test scripts that provide continuous
 # test output about their progress, and succeeds/fails on
 # zero/non-zero exit code.  It outputs the test output on stdout even
--=20
2.3.0.rc1.137.g477eb31
