From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] worktree setup: calculate prefix even if no worktree is found
Date: Mon,  8 Mar 2010 23:50:31 +0700
Message-ID: <1268067033-25199-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 17:54:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NogDS-00065v-69
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 17:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab0CHQx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 11:53:58 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45653 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab0CHQx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 11:53:56 -0500
Received: by ewy8 with SMTP id 8so220474ewy.28
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=RVSc7a5gOCCnogmiau53Yt49wDQaiLRKFZSGvZe/mak=;
        b=rcvY2wUFsPCr8mWBvbhPOOG43vHDoi60/syEsjCj8uDNI/jMbJdOgjXvNs9CAHbmNT
         E4vMtsCepHFm5vyaQewnPYXqDkiXI5VThAkabQO4P8BS8SwhRMRlMIyr9Y6A5mvJzUKR
         arn+wg//6uG7xknqPDdonfwsApqn5YLcxumUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=CONhbiJHA7RzbPBE9UNFqm1A6Mz8Mnw4Cl1l+l+oNwrA1MCNtezhMEXVpAVkQ5EXyq
         CKioy4UEQjVvEkss4qv70sZDxu9a+5DNZOJ/S1lw7x+mCGYejyR/uH7dxrwjp73GkGDI
         OR3tuBrA7czoU9IsNg/smd9KWjIH45Jp3t79A=
Received: by 10.213.109.140 with SMTP id j12mr3264217ebp.84.1268067235331;
        Mon, 08 Mar 2010 08:53:55 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 15sm2383332ewy.8.2010.03.08.08.53.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 08:53:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  8 Mar 2010 23:50:34 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141771>

Commit a672ea6 (rehabilitate 'git index-pack' inside the object
store - 2008-10-20) worked around a fault in
setup_git_directory_gently(). When walking up from inside a git
repository, we will return NULL as prefix.  We should have returned a
correct prefix anyway because cwd has been moved.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I missed index-pack in my RUN_SETUP_GENTLY series. So three more patch=
es
 on top.

 setup.c              |   19 ++++++++-----------
 t/t1500-rev-parse.sh |    2 +-
 t/t1501-worktree.sh  |    5 +++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/setup.c b/setup.c
index bb3648c..8796c6f 100644
--- a/setup.c
+++ b/setup.c
@@ -392,13 +392,16 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 	offset =3D len =3D strlen(cwd);
 	for (;;) {
 		gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile_dir) {
-			if (set_git_dir(gitfile_dir))
+		if (gitfile_dir || is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
+			if (gitfile_dir && set_git_dir(gitfile_dir))
 				die("Repository setup failed");
+			inside_git_dir =3D 0;
+			if (!work_tree_env)
+				inside_work_tree =3D 1;
+			root_len =3D offset_1st_component(cwd);
+			git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : ro=
ot_len);
 			break;
 		}
-		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
-			break;
 		if (is_git_directory(".")) {
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
@@ -409,8 +412,7 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 				set_git_dir(cwd);
 			} else
 				set_git_dir(".");
-			check_repository_format_gently(nongit_ok);
-			return NULL;
+			break;
 		}
 		while (--offset > ceil_offset && cwd[offset] !=3D '/');
 		if (offset <=3D ceil_offset) {
@@ -426,11 +428,6 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 			die_errno("Cannot change to '%s/..'", cwd);
 	}
=20
-	inside_git_dir =3D 0;
-	if (!work_tree_env)
-		inside_work_tree =3D 1;
-	root_len =3D offset_1st_component(cwd);
-	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
 	if (offset =3D=3D len)
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..4ee92c7 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -42,7 +42,7 @@ test_rev_parse toplevel false false true '' .git
 cd .git || exit 1
 test_rev_parse .git/ false true false '' .
 cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
+test_rev_parse .git/objects/ false true false 'objects/' "$ROOT/.git"
 cd ../.. || exit 1
=20
 mkdir -p sub/dir || exit 1
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 9df3012..c72b578 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -28,6 +28,11 @@ test_rev_parse() {
 	[ $# -eq 0 ] && return
 }
=20
+cd .git/objects || exit 1
+say "subdirectory inside .git"
+test_rev_parse 'inside'       false true false objects/
+cd ../.. || exit 1
+
 EMPTY_TREE=3D$(git write-tree)
 mkdir -p work/sub/dir || exit 1
 mv .git repo.git || exit 1
--=20
1.7.0.1.384.g6abcaa
