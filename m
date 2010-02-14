From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/5] Support working directory located at root
Date: Sun, 14 Feb 2010 22:44:44 +0700
Message-ID: <1266162285-10955-4-git-send-email-pclouds@gmail.com>
References: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 16:55:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nggoq-0004yA-47
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 16:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab0BNPzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 10:55:31 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:41102 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab0BNPza (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 10:55:30 -0500
Received: by pxi29 with SMTP id 29so539920pxi.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UKGyurErB4AwUVfy8Bx24xr80sd4NgznRQ0FJQwyE0Y=;
        b=XfrhUFVInQyfGn7Dv3HmrA6srcL9F2LqNvTgs1RSr8Unj9+x4ZDv3WtLMU0Ts3/S+J
         Tmw48o7eVV7Jni6gdZezqkFrwRrvMP/fcjdZYpCDcVdLnC6l1mWKa5311AIJxLaehFMI
         EYtekOCQvGVhNPRJHbvSBed5liWX5MSaTgZA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nTpOcKaaiLQDDHrRnHgGAoXUrKM+k9EUUREy/Dz3HKoHCxZ3qwiHTCUvhCsmeeMuWt
         8LMM/DcuOyoLpYD4wZlWJO30i/IF620UvUBKOLGAFeWeFgz0wIN3p86FAgFvS0L8Cqdj
         zz3WzD8eZK0ILr9uvZ2oC5eOyNDAXlDZYOEks=
Received: by 10.143.27.42 with SMTP id e42mr2675433wfj.234.1266162462524;
        Sun, 14 Feb 2010 07:47:42 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 22sm3633773pzk.13.2010.02.14.07.47.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 07:47:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Feb 2010 22:45:02 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139914>

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
index b38cbee..08df00e 100644
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
+		root_len =3D offset_1st_component(work_tree);
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
+				root_len =3D offset_1st_component(cwd);
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
+	root_len =3D offset_1st_component(cwd);
+	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
 	if (offset =3D=3D len)
--=20
1.7.0.195.g637a2
