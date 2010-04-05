From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/43] worktree setup: calculate prefix even if no worktree is found
Date: Mon,  5 Apr 2010 20:41:04 +0200
Message-ID: <1270492888-26589-20-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH2-0000ps-QG
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab0DESmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:44 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab0DESmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:36 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zUKobxKK7stFuhgIwMsffpfz7beXA+8wS6D5s3hGhDc=;
        b=ZVKx74DMlm4j6jy5JV5NFEQSCqX2pq26Zllr6ENOpNGJ3AC2oKfjlWw7IpEEnm6mXT
         wq+nkLwVTOvESlxLrzZYH9xvlawLHrT8pVmNT0rpkqE9YFvHs5MtCkQ74hewfrMXhfqs
         b0/j+/Q/tFX1q/iReZwKPq7T34EpU5yhiz6FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IWh08Ovw7Kc0bnmqufoxClaslaUJrSRBmZHIh+FiLz3Qtd44kHpV+Xq8gzkLMELY9b
         Ja0KRIrgcw15rw7kAgb1jOvp/aMSsSs9mF+GybpdnjnNLu6+0rlCWmZl4wnMYndH6uf0
         cjm6QAbeNjc22ZF8qty9YpvOIxNSs98Oo577Q=
Received: by 10.223.62.83 with SMTP id w19mr6157872fah.22.1270492955578;
        Mon, 05 Apr 2010 11:42:35 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 21sm13811823fkx.40.2010.04.05.11.42.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:34 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:32 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144034>

Commit a672ea6 (rehabilitate 'git index-pack' inside the object
store - 2008-10-20) worked around a fault in
setup_git_directory_gently(). When walking up from inside a git
repository, we will return NULL as prefix.  We should have returned a
correct prefix anyway because cwd has been moved.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
1.7.0.rc1.541.g2da82.dirty
