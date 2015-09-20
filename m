From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Add test_repo_expect_success for running tests in a new repository
Date: Sun, 20 Sep 2015 08:25:02 +0700
Message-ID: <1442712302-7912-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 03:24:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdTMz-0000EU-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 03:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbITBYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Sep 2015 21:24:41 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36139 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbbITBYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2015 21:24:40 -0400
Received: by padhk3 with SMTP id hk3so83297394pad.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2015 18:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=beIC4ItWUqfjfM3PSSQ7nnKUsWTawFL8IOqSoX7MoW0=;
        b=csmFXTk1AzernYez9+dWcdk0Puf7sm37QaNq9/Gh9NMhFGymV2VxhUoEAMGNoGWgYK
         boacrvoaHtx/wCZFcoGfQ/+LMZMQTHUyhjyA+MjC4OdPrLw8MffgF61Jxz1RrRTs7G02
         gjdOgzrQCrd5ScrpXRWkbQ+Y3QIxh7Jm38koRlY9on/c+46aciFMsvt4EvzBpxJy6jWF
         5UxgPhvW+IH/y8BEMgWzUE2gkWz0vhRM1rl1PR7/hZ2Y3408sqV6J3oK9uMfyDvzhR5r
         kh9TkeUs3bXsbrl3QD5ioh6vgOhoJUpd+B1YPLiRk0pgRqEu5SFjQHZ3cIKeEntk5llj
         RvDA==
X-Received: by 10.66.191.131 with SMTP id gy3mr15376234pac.113.1442712279655;
        Sat, 19 Sep 2015 18:24:39 -0700 (PDT)
Received: from lanh ([171.232.94.243])
        by smtp.gmail.com with ESMTPSA id bs3sm16540356pbd.89.2015.09.19.18.24.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Sep 2015 18:24:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 20 Sep 2015 08:25:07 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278240>

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
 Lately I start to add more and more tests in this style. So this
 looks like a good change to me.

 t/README                | 15 +++++++++++++++
 t/test-lib-functions.sh | 20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/t/README b/t/README
index 35438bc..ee761af 100644
--- a/t/README
+++ b/t/README
@@ -738,6 +738,21 @@ library for your script to use.
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
index e8d3c0f..45d7423 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -394,6 +394,26 @@ test_expect_success () {
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
