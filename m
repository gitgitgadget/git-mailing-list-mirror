From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] Support working directory located at root
Date: Wed, 10 Feb 2010 00:02:29 +0700
Message-ID: <1265734950-15145-3-git-send-email-pclouds@gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetXE-0007RQ-BZ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab0BIRFb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 12:05:31 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53343 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0BIRF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:05:29 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so351911vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZweJ/wvUpQAm/5yb1oI3Q5s0a9+wPgaQRn51TbDRvIA=;
        b=Ur7mDhARN8rnIBFMIM+Qyc/P4qdTGFq3SnqyMgxEvv57rDU+c5wSznwt6VgNRE158g
         GbBNhJgJeVWODEoPN22yZAXzobq+haTEsiPwrZJwucpMT+6t3NUksWRQfTq+6/YEH/sS
         d6AM39J/l8oZ5oG77eNA25oKyQeJUQTY2fDIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ety+FwO9C6s/vGpK9Cyb9ye+M+pnBM7aAumDZwEyWqS2kRIDq/W9EhbxADe6fwDjk9
         6W6gH8twwEwos4Lsj5WhJBukUQOqy1ctTzHgRHULiahC9kJcqt97hLpnyOuFLZ0fWzxI
         fY+Xx0zMdlOWVEuLxZ096Z/oK0Obz6VfLYVNQ=
Received: by 10.220.125.83 with SMTP id x19mr755986vcr.107.1265735129399;
        Tue, 09 Feb 2010 09:05:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.235.86])
        by mx.google.com with ESMTPS id 41sm2285989vws.10.2010.02.09.09.05.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:05:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:02:47 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139418>

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
 I said I would have code change for DOS drive too. But I take it back.
 Supporting GIT_DIR=3DC:\.git might be easy, GIT_DIR=3DC:.git is not.

 setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index b38cbee..4d24a74 100644
--- a/setup.c
+++ b/setup.c
@@ -25,7 +25,7 @@ const char *prefix_path(const char *prefix, int len, =
const char *path)
 		len =3D strlen(work_tree);
 		total =3D strlen(sanitized) + 1;
 		if (strncmp(sanitized, work_tree, len) ||
-		    (sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')) {
+		    (len > 1 && sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')=
) {
 		error_out:
 			die("'%s' is outside repository", orig);
 		}
@@ -403,7 +403,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			if (offset !=3D len) {
-				cwd[offset] =3D '\0';
+				cwd[offset ? offset : 1] =3D '\0';
 				set_git_dir(cwd);
 			} else
 				set_git_dir(".");
@@ -427,7 +427,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	inside_git_dir =3D 0;
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
-	git_work_tree_cfg =3D xstrndup(cwd, offset);
+	git_work_tree_cfg =3D xstrndup(cwd, offset ? offset : 1);
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
 	if (offset =3D=3D len)
--=20
1.7.0.rc2.182.g3adef
