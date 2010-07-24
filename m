From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/9] setup: split off a function to checks working dir
 for .git file
Date: Sat, 24 Jul 2010 07:11:58 -0500
Message-ID: <20100724121157.GB16602@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
 <20100724112015.GD16054@burratino>
 <AANLkTim7C-byLb9txD11OrB6aC3uO=kBjQx2Q8HGLxL+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 14:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcdbI-0005Z5-9f
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 14:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab0GXMND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 08:13:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65458 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0GXMNA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 08:13:00 -0400
Received: by iwn7 with SMTP id 7so1124645iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zNC8K/L0voW+N7jtutYvnsgz5Hjle9vmvZp/0uREb9k=;
        b=APphfAF//fakszSFpy9M+HlROdn/2nSrbDm8/P2Sks6sH2vOUOZvDxlyns7R+3DyPE
         yxUSnVXpCjKzvuvsoftEE43TSM6NV3B6GUPU8R4VH3MxrOPyozjdMcRBtQJkDFLiPMQE
         jPLczQqg50wV/A59Ypn2zEUbxO5A0Mz1eRaE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=B6YN2sDPvajliIr/RzChdMDsbeclNfXWonaXxXvIOuauC0qUvfbIIO89e0WLD7ovGr
         aPzuVfZXtnumJx7wLc5q5uuKhxboMXR4K/dfX25Ysmhp+6z3JDG/1R5l3BYKobVKi/24
         dvx7KzNPqRSyDxq691RoSu/xqGQyHvuqeqnxY=
Received: by 10.231.178.103 with SMTP id bl39mr4813278ibb.138.1279973579593;
        Sat, 24 Jul 2010 05:12:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm1295377ibk.9.2010.07.24.05.12.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 05:12:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim7C-byLb9txD11OrB6aC3uO=kBjQx2Q8HGLxL+@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151624>

Nguyen Thai Ngoc Duy wrote:

> Notice the two "break;" here, which is the only way to reach out the
> code below the loop. Perhaps you should move that code into
> cwd_contains_git_dir() too and change its name appropriately.
> setup_git_directory_gently() would become "discovery only" as real
> setup would be done by three new functions.

Neat.

-- %< --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Subject: setup: split off a function to handle ordinary .git directorie=
s

=46inish the clean-up of setup_git_directory_gently() by splitting the
last case of validation+setup (global variables, prefix, check_format,
set_git_dir) into its own function.  Now setup_git_git_directory_gently
itself takes care of discovery only and the functions that pick up
from there are nearby in the source file so they can be easily
compared.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git i/setup.c w/setup.c
index 5734a1f..d19aa7d 100644
--- i/setup.c
+++ w/setup.c
@@ -360,6 +360,28 @@ static int cwd_contains_git_dir(const char **gitfi=
le_dirp)
 	return is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT);
 }
=20
+static const char *setup_discovered_git_dir(const char *work_tree_env,
+		int offset, int len, char *cwd, int *nongit_ok)
+{
+	int root_len;
+
+	inside_git_dir =3D 0;
+	if (!work_tree_env)
+		inside_work_tree =3D 1;
+	root_len =3D offset_1st_component(cwd);
+	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
+	if (check_repository_format_gently(nongit_ok))
+		return NULL;
+	if (offset =3D=3D len)
+		return NULL;
+
+	/* Make "offset" point to past the '/', and add a '/' at the end */
+	offset++;
+	cwd[len++] =3D '/';
+	cwd[len] =3D 0;
+	return cwd + offset;
+}
+
 static const char *setup_bare_git_dir(const char *work_tree_env,
 		int offset, int len, char *cwd, int *nongit_ok)
 {
@@ -411,7 +433,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
-	int len, offset, ceil_offset, root_len;
+	int len, offset, ceil_offset;
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
=20
@@ -456,7 +478,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		current_device =3D get_device_or_die(".", NULL);
 	for (;;) {
 		if (cwd_contains_git_dir(&gitfile_dir))
-			break;
+			return setup_discovered_git_dir(work_tree_env, offset,
+							len, cwd, nongit_ok);
 		if (is_git_directory("."))
 			return setup_bare_git_dir(work_tree_env, offset,
 							len, cwd, nongit_ok);
@@ -482,22 +505,6 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			die_errno("Cannot change to '%s/..'", cwd);
 		}
 	}
-
-	inside_git_dir =3D 0;
-	if (!work_tree_env)
-		inside_work_tree =3D 1;
-	root_len =3D offset_1st_component(cwd);
-	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
-	if (check_repository_format_gently(nongit_ok))
-		return NULL;
-	if (offset =3D=3D len)
-		return NULL;
-
-	/* Make "offset" point to past the '/', and add a '/' at the end */
-	offset++;
-	cwd[len++] =3D '/';
-	cwd[len] =3D 0;
-	return cwd + offset;
 }
=20
 int git_config_perm(const char *var, const char *value)
--=20
