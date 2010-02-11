From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] Support working directory located at root
Date: Thu, 11 Feb 2010 21:43:22 +0700
Message-ID: <1265899403-15904-5-git-send-email-pclouds@gmail.com>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:54:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaRD-00049O-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab0BKOye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:54:34 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:34396 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab0BKOyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:54:33 -0500
Received: by gxk24 with SMTP id 24so1165572gxk.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZnqS0RRIJzxgOOFMW17P/v7r0zd2pNNNf48YQ/o8u+k=;
        b=J0QlyJEd0kdUebrGFcMUYvAMmY9PWOHJqAnRSsZIF3Ey4kKhS8onaQe6V/r1Js7OK+
         JlAeXb9o54iXLpO3Ls3mBurBixbTTPUW9PDAZELMa6OB4jE3OVB+xTtIX5/G6t06GaPd
         d2ZCQ68CZ7zDGravKOWDGakjJFSvCaCfLDJnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F84HgJylQrE2itH28ucLhhqXGc/JDrw3uBismSxqFFauqD2EzVtLj0gBO03OjkNrb9
         DWEoWKdgzgO/aBSuyjiA4hFVupvLt/Y4pYJQrBS30xfEhtjEVRaWItwit/X1EMF0JLmM
         oqpvb4OZDzWUrGq6YlzWjacg5mmK/3TyYUno0=
Received: by 10.150.131.15 with SMTP id e15mr267250ybd.324.1265899593760;
        Thu, 11 Feb 2010 06:46:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 6sm944549ywd.52.2010.02.11.06.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 06:46:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Feb 2010 21:43:52 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139599>

Git should work regardless where the working directory is located,
even at root. This patch fixes two places where it assumes working
directory always have parent directory.

In setup_git_directory_gently(), when Git goes up to root and finds
=2Egit there, it happily sets worktree to "" instead of "/".

In prefix_path(), loosen the outside repo check a little bit. Usually
when a path XXX is inside worktree /foo, it must be either "/foo", or
"/foo/...". When worktree is simply "/", we can safely ignore the
check: we have a slash at the beginning already.

Not related to worktree, but also set gitdir correctly if a bare repo
is placed (insanely?) at root.

Thanks Jo=C3=A3o Carlos Mendes Lu=C3=ADs for pointing out this problem.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index b38cbee..cdad176 100644
--- a/setup.c
+++ b/setup.c
@@ -18,14 +18,15 @@ const char *prefix_path(const char *prefix, int len=
, const char *path)
 	if (normalize_path_copy(sanitized, sanitized))
 		goto error_out;
 	if (is_absolute_path(orig)) {
-		size_t len, total;
+		size_t root_len, len, total;
 		const char *work_tree =3D get_git_work_tree();
 		if (!work_tree)
 			goto error_out;
 		len =3D strlen(work_tree);
+		root_len =3D is_root_path(work_tree);
 		total =3D strlen(sanitized) + 1;
 		if (strncmp(sanitized, work_tree, len) ||
-		    (sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')) {
+		    (len > root_len && sanitized[len] !=3D '\0' && sanitized[len] !=3D=
 '/')) {
 		error_out:
 			die("'%s' is outside repository", orig);
 		}
@@ -321,7 +322,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
-	int len, offset, ceil_offset;
+	int len, offset, ceil_offset, root_len;
=20
 	/*
 	 * Let's assume that we are in a git repository.
@@ -403,7 +404,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			if (offset !=3D len) {
-				cwd[offset] =3D '\0';
+				root_len =3D is_root_path(cwd);
+				cwd[offset > root_len ? offset : root_len] =3D '\0';
 				set_git_dir(cwd);
 			} else
 				set_git_dir(".");
@@ -427,7 +429,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	inside_git_dir =3D 0;
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
-	git_work_tree_cfg =3D xstrndup(cwd, offset);
+	root_len =3D is_root_path(cwd);
+	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
 	if (offset =3D=3D len)
--=20
1.7.0.rc2.182.g3adef
