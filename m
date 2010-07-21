From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t7002: test git grep --no-index from a bare repository
Date: Wed, 21 Jul 2010 19:23:38 +0700
Message-ID: <1279715018-24225-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 00:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObhXY-0002Kx-0l
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 00:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab0GUWNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 18:13:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53755 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab0GUWNO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 18:13:14 -0400
Received: by pzk26 with SMTP id 26so2268504pzk.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/0tLGRmclPeGzy3bShCgxBaNBOotIHC2O324fRWMJw8=;
        b=g29iL9xOsr7IuexCX95HnVAPj2W4EHBtiIEv9vw5MIVh19qGuplulqzDt6/aILgjwE
         Jm6mooKvnL/ABMqk4rchletTx0fZpIgpcclYkZqJEmULQcqfdJyzMpBm39HAamWcNJyC
         OCfvTyZIl6MbaB3XuREUNEotJ6ITd4PNhnaic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=AbL7BXRHMCMimuiyeWTD61brZ/mjhVyrxG89GazycGxsPJJF+wC5ZH5QWWwo/ZreAr
         RN74ZAIK8tJWrIdcHF6ZcWKvM0KkkH0ZqZazxPBK9cDrguWHxL8h5FiXzfyT4kFBUG86
         xQbnZOW52+HWjkks/FTwSLmH5mhRYIKWHps9A=
Received: by 10.114.26.15 with SMTP id 15mr1361332waz.185.1279750394089;
        Wed, 21 Jul 2010 15:13:14 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d39sm85924111wam.16.2010.07.21.15.13.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 15:13:13 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 21 Jul 2010 19:23:39 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151427>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

If git grep --no-index is to be a general-purpose replacement for
standard grep, then it should work even for examining the content of a
=2Egit directory.  The current implementation has some problems:

 * .git/info/exclude is honored though it shouldn=E2=80=99t be
 * when run from within a .git directory, grep --no-index searches
   the entire .git directory instead of just directories below
   the current working directory.
 * when run from within a .git directory, prefix will always
   be NULL, so run_pager() will not be able to move back to
   the original cwd.

The last few tests (which demonstrate that grep --no-index looks for
=2Egit/info/exclude even when no repository is involved) are by Duy.
Any bugs in the other tests are my fault.

Also clarify in document what files will be searched in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 There is an interesting thing about this command. Back in tp/setup
 series, there is a patch that changes the current behavior,
 "calculate prefix even if no worktree is found". grep is interesting
 because it depends on the current behavior, i.e. prefix being NULL
 in bare repo, while it still needs true prefix to do chdir()
 stuff in run_pager().

 So I have a feeling that my patch is the right way to go. But
 I really need to watch all other commands and make sure they don't
 depend on this behavior like grep.

 Documentation/git-grep.txt |    5 +-
 builtin/grep.c             |    2 +

These are my additional changes.

 t/t7810-grep.sh            |  116 ++++++++++++++++++++++++++++++++++++=
++++++++

This one remains the same from tp/setup.

 3 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 5474dd7..bb420d9 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,8 +28,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Look for specified patterns in the tracked files in the work tree, blo=
bs
-registered in the index file, or blobs in given tree objects.
-
+registered in the index file, or blobs in given tree objects. By defau=
lt
+it will only search tracked files within the current directory (or ful=
l
+tree if in bare repository).
=20
 OPTIONS
 -------
diff --git a/builtin/grep.c b/builtin/grep.c
index 597f76b..e8abdc7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1109,6 +1109,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
=20
 	if (use_threads)
 		hit |=3D wait_all();
+
+	/* FIXME prefix is NULL in bare repo, no matter where cwd is */
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8a63227..7329433 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -494,6 +494,98 @@ test_expect_success 'inside git repository but wit=
h --no-index' '
 	)
 '
=20
+test_expect_success 'set up bare repository' '
+
+	rm -fr bare &&
+	mkdir -p bare/basis/sub &&
+	echo hello >bare/basis/file1 &&
+	echo world >bare/basis/sub/file2 &&
+	echo ".*o*" >bare/basis/.gitignore &&
+	(
+		cd bare/basis &&
+		git init &&
+		git ls-files --other | git update-index --add --stdin &&
+		tree=3D$(git write-tree) &&
+		commit=3D$(printf "basis\n" | git commit-tree "$tree") &&
+		git update-ref -m init refs/heads/master "$commit" &&
+		git update-index --refresh &&
+		git diff-index --exit-code HEAD
+	) &&
+	git clone --no-checkout --bare bare/basis bare/d.git &&
+	mkdir -p bare/d.git/sub &&
+	echo olleh >bare/d.git/fich1 &&
+	echo dlrow >bare/d.git/sub/file2 &&
+	echo "file2" >bare/d.git/.gitignore &&
+	echo "o*" >>bare/d.git/.gitignore
+	{
+		echo "HEAD:.gitignore:.*o*" &&
+		echo HEAD:file1:hello &&
+		echo HEAD:sub/file2:world
+	} >bare/expect.full &&
+	: >bare/expect.empty &&
+	echo file2:dlrow >bare/expect.sub
+'
+
+test_expect_success 'in bare repo, grep without --no-index or --cached=
 fails' '
+	(
+		cd bare/d.git &&
+		test_must_fail git grep o >../actual.plain 2>../actual.msg &&
+		grep "work tree" ../actual.msg &&
+		test_cmp ../expect.empty ../actual.plain &&
+		cd sub &&
+		test_must_fail git grep o >../../actual.sub 2>../../actual.msg &&
+		test_cmp ../../expect.empty ../../actual.sub &&
+		grep "work tree" ../../actual.msg
+	)
+'
+
+test_expect_success 'in bare repo, --cached and HEAD ignore working di=
r' '
+
+	(
+		cd bare/d.git &&
+		test_must_fail git grep --cached o >../actual.cached 2>../actual.msg=
 &&
+		test_cmp ../expect.empty ../actual.cached &&
+		! grep fatal ../actual.msg &&
+		git grep -e o HEAD >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git grep o >../../actual.sub 2>../../actual.msg &&
+		test_cmp ../../expect.empty ../../actual.sub &&
+		git grep -e o HEAD >../../actual.full-sub &&
+		test_cmp ../../expect.full ../../actual.full-sub
+	)
+'
+
+test_expect_success '--no-index from a bare repository' '
+	rm -f bare/d.git/info/exclude &&
+	(
+		cd bare/d.git &&
+		git grep --no-index o >../actual.noindex &&
+		grep "^fich1:olleh\$" ../actual.noindex &&
+		grep "^.gitignore:o[*]\$" ../actual.noindex &&
+		! grep file2 ../actual.noindex
+	)
+'
+
+test_expect_failure '--no-index from a subdirectory of a bare reposito=
ry' '
+	(
+		cd bare/d.git/sub &&
+		git grep --no-index o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	)
+'
+
+test_expect_failure '--no-index neglects info/exclude in bare repo' '
+	echo "fich1" >bare/d.git/info/exclude &&
+	(
+		cd bare/d.git &&
+		git grep --no-index o >../actual.noindex &&
+		grep "^fich1:olleh\$" ../actual.noindex &&
+		grep "^.gitignore:o[*]\$" ../actual.noindex &&
+		! grep file2 ../actual.noindex
+	)
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
@@ -527,4 +619,28 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'Setup fake .git' '
+	cd t &&
+	GIT_CEILING_DIRECTORIES=3D"`pwd`" &&
+	export GIT_CEILING_DIRECTORIES &&
+	cd a &&
+	mkdir -p .git/info &&
+	cd ../..
+
+'
+
+test_expect_failure 'Ignore fake .git/info/exclude' '
+	(
+		cd t/a &&
+		echo v > .git/info/exclude &&
+		git grep --no-index vvv . &&
+		rm .git/info/exclude
+	)
+'
+
+test_expect_success 'Unsetup fake .git' '
+	rm -rf t/a &&
+	unset GIT_CEILING_DIRECTORIES
+'
+
 test_done
--=20
1.7.1.rc1.69.g24c2f7
