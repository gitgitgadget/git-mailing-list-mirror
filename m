From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] worktree setup: return to original cwd if prefix is set NULL
Date: Fri, 23 Jul 2010 19:04:10 +0700
Message-ID: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 14:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcGyn-0005yI-3r
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 14:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab0GWMDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 08:03:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46470 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0GWMDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 08:03:43 -0400
Received: by pzk26 with SMTP id 26so43740pzk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=YpcT3PrvLIB7Rd/tnXqKMMMs1DHmT7+OXy56xlgd3to=;
        b=It1KZjnvaifbRseb9A1NLlXtCUpCBVwCTTM30BbMdIRCrxi0STMQuLpcHWvVeyiPY2
         gXQNDgPYyo4h5tWNim4hNQOAcWcZVKQ+JsvDyfvghkEU7Jd+8QRjCalsfdkp3BeDTAZg
         4MEZab6WYMs+EU2ePfXjV53MQEpKIakTMOy7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=J9XA8bss7uWHMFqwBAn/T/g5f3WQJUkIG+0cffAYV4MbDVQ4hOjK5dlcLXCWK5J/XH
         n9tXaeYSajs8q0J0iTeiZOR94SqkWylUQyKnmK1umTG1EyjM5fiI+xIQZHjZ4lulHTBQ
         BAfcedu2OCnkQS+X/7e5a3v6Xq+aIMVNvw5sY=
Received: by 10.114.92.10 with SMTP id p10mr5351926wab.214.1279886623229;
        Fri, 23 Jul 2010 05:03:43 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id g4sm286382wae.14.2010.07.23.05.03.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 05:03:42 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 23 Jul 2010 19:04:12 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151527>

Commit a672ea6 (rehabilitate 'git index-pack' inside the object
store - 2008-10-20) worked around a fault in
setup_git_directory_gently(). When walking up from inside a git
repository, we will return NULL as prefix.

Prefix and cwd should be consistent. That is if cwd is moved, prefix
reflects that. If prefix is NULL, cwd is unmoved. In this case, to
retain current behavior, we move cwd back, with an eye on gitdir
because gitdir may be relative to cwd.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c             |    7 +++++++
 t/t1501-worktree.sh |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 87c21f0..33eb253 100644
--- a/setup.c
+++ b/setup.c
@@ -413,6 +413,13 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			if (offset !=3D len) {
+				/*
+				 * The returned prefix in this code path is NULL
+				 * chdir() back to match NULL prefix, i.e. unmoved cwd
+				 */
+				if (chdir(cwd))
+					die_errno("Cannot come back to cwd");
+
 				root_len =3D offset_1st_component(cwd);
 				cwd[offset > root_len ? offset : root_len] =3D '\0';
 				set_git_dir(cwd);
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index bd8b607..edd81ce 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -33,6 +33,27 @@ mkdir -p work/sub/dir || exit 1
 mkdir -p work2 || exit 1
 mv .git repo.git || exit 1
=20
+cat >repo.git/objects/patch <<\EOF
+diff one one
+--- one
++++ one
+@@ -1 +1,2 @@
+ 1
++2
+EOF
+
+test_expect_success 'cwd is unchanged when prefix is NULL (from within=
 a repo)' '
+	(
+		cd repo.git/objects &&
+		echo 1 > one &&
+		cp one expected &&
+		echo 2 >> expected &&
+		git apply patch &&
+		test_cmp expected one &&
+		rm one expected patch
+	)
+'
+
 say "core.worktree =3D relative path"
 GIT_DIR=3Drepo.git
 GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
--=20
1.7.1.rc1.69.g24c2f7
