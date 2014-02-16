From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] diff: do not reuse_worktree_file for submodules
Date: Sun, 16 Feb 2014 17:52:34 +0100
Message-ID: <d08b7e5a36ee13226d1ad56a731016762ae89938.1392569505.git.tr@thomasrast.ch>
References: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Gr=C3=A9gory=20Pakosz?= <gregory.pakosz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4xW-0000os-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbaBPQwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Feb 2014 11:52:47 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:50491 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbaBPQwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:52:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5FA914D64E6;
	Sun, 16 Feb 2014 17:52:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id H1KSD14OQHjG; Sun, 16 Feb 2014 17:52:35 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 57F7A4D64BD;
	Sun, 16 Feb 2014 17:52:35 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
In-Reply-To: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242236>

The GIT_EXTERNAL_DIFF calling code attempts to reuse existing worktree
files for the worktree side of diffs, for performance reasons.
However, that code also tries to do the same with submodules.  This
results in calls to $GIT_EXTERNAL_DIFF where the old-file is a file of
the form "Submodule commit $sha1", but the new-file is a directory in
the worktree.

=46ix it by never reusing a worktree "file" in the submodule case.

Reported-by: Gr=C3=A9gory Pakosz <gregory.pakosz@gmail.com>
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 diff.c                   |  5 +++--
 t/t4020-diff-external.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 7c59bfe..e9a8874 100644
--- a/diff.c
+++ b/diff.c
@@ -2845,8 +2845,9 @@ static struct diff_tempfile *prepare_temp_file(co=
nst char *name,
 		remove_tempfile_installed =3D 1;
 	}
=20
-	if (!one->sha1_valid ||
-	    reuse_worktree_file(name, one->sha1, 1)) {
+	if (!S_ISGITLINK(one->mode) &&
+	    (!one->sha1_valid ||
+	     reuse_worktree_file(name, one->sha1, 1))) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno =3D=3D ENOENT)
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index bcae35a..0446201 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -226,12 +226,13 @@ keep_only_cr () {
 }
=20
 test_expect_success 'external diff with autocrlf =3D true' '
-	git config core.autocrlf true &&
+	test_config core.autocrlf true &&
 	GIT_EXTERNAL_DIFF=3D./fake-diff.sh git diff &&
 	test $(wc -l < crlfed.txt) =3D $(cat crlfed.txt | keep_only_cr | wc -=
c)
 '
=20
 test_expect_success 'diff --cached' '
+	test_config core.autocrlf true &&
 	git add file &&
 	git update-index --assume-unchanged file &&
 	echo second >file &&
@@ -239,4 +240,31 @@ test_expect_success 'diff --cached' '
 	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
 '
=20
+test_expect_success 'clean up crlf leftovers' '
+	git update-index --no-assume-unchanged file &&
+	rm -f file* &&
+	git reset --hard
+'
+
+test_expect_success 'submodule diff' '
+	git init sub &&
+	( cd sub && test_commit sub1 ) &&
+	git add sub &&
+	test_tick &&
+	git commit -m "add submodule" &&
+	( cd sub && test_commit sub2 ) &&
+	write_script gather_pre_post.sh <<-\EOF &&
+	echo "$1 $4" # path, mode
+	cat "$2" # old file
+	cat "$5" # new file
+	EOF
+	GIT_EXTERNAL_DIFF=3D./gather_pre_post.sh git diff >actual &&
+	cat >expected <<-EOF &&
+	sub 160000
+	Subproject commit $(git rev-parse HEAD:sub)
+	Subproject commit $(cd sub && git rev-parse HEAD)
+	EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
1.9.0.313.g3d0a325
