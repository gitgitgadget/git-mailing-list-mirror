From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/9] setup: split off a function to checks working dir for 
	.git file
Date: Sat, 24 Jul 2010 21:56:50 +1000
Message-ID: <AANLkTim7C-byLb9txD11OrB6aC3uO=kBjQx2Q8HGLxL+@mail.gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com> 
	<20100724111505.GC7150@burratino> <20100724112015.GD16054@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcdM7-0000Bk-J9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab0GXL5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 07:57:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33214 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0GXL5K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 07:57:10 -0400
Received: by pzk26 with SMTP id 26so453963pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EcWFwz7rcQc+YHtNGYtxOiIxvs933a5Uq3BTmODH3b8=;
        b=Gk1Hy6ouOmcKvmkMMAfKwR3xx8PYrA65yb6CjY6nEg4KpwaJzWW0E/1576NhTrbI8I
         KPDWMUQxCxETwxvOBE1XuY5nzt5eIeIOdEY+yNRMWCO+mko+D5fZrA4UMsK/pzq3UCuD
         2DO9SNrPm3hHiqv6GSM7TDVTilWeXq6DL6cz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HbSuPJEFadXKOR3jfJZ6iAUBIUnVDcH2I8fLWK7sXth7HLNqZMHvXJFGo2iFf4i6VC
         dMpdUvB78W1/0C2uKjWhtXiRC2pY+4GTQ78xUlunSp89lkp25Wf6+o9R3jbRqATa0yhK
         JAvdvso6yL2ySWKGpzUi/8uesB2TYC+U48ie8=
Received: by 10.142.214.17 with SMTP id m17mr5793640wfg.72.1279972630221; Sat, 
	24 Jul 2010 04:57:10 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Sat, 24 Jul 2010 04:56:50 -0700 (PDT)
In-Reply-To: <20100724112015.GD16054@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151622>

2010/7/24 Jonathan Nieder <jrnieder@gmail.com>:
> The repository discovery procedure looks something like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (same filesystem) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check .git in =
working dir
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check .
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chdir(..)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> Add a function for the first step to make the actual code look a bit
> closer to that pseudocode.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0setup.c | =C2=A0 20 +++++++++++++-------
> =C2=A01 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 16bee6d..3d25d0f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -348,6 +348,18 @@ static const char *setup_explicit_git_dir(const =
char *gitdirenv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;
> =C2=A0}
>
> +static int cwd_contains_git_dir(const char **gitfile_dirp)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *gitfile_dir =3D read_gitfile_gentl=
y(DEFAULT_GIT_DIR_ENVIRONMENT);
> + =C2=A0 =C2=A0 =C2=A0 *gitfile_dirp =3D gitfile_dir;
> + =C2=A0 =C2=A0 =C2=A0 if (gitfile_dir) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (set_git_dir(gi=
tfile_dir))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("Repository setup failed");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return is_git_directory(DEFAULT_GIT_DIR_ENVIRO=
NMENT);
> +}
> +
> =C2=A0/*
> =C2=A0* We cannot decide in this function whether we are in the work =
tree or
> =C2=A0* not, since the config can only be read _after_ this function =
was called.
> @@ -407,13 +419,7 @@ const char *setup_git_directory_gently(int *nong=
it_ok)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current_device=
 =3D buf.st_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gitfile_dir =3D re=
ad_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gitfile_dir) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (set_git_dir(gitfile_dir))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Repository setup failed");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_git_directo=
ry(DEFAULT_GIT_DIR_ENVIRONMENT))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cwd_contains_g=
it_dir(&gitfile_dir))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;

Notice the two "break;" here, which is the only way to reach out the
code below the loop. Perhaps you should move that code into
cwd_contains_git_dir() too and change its name appropriately.
setup_git_directory_gently() would become "discovery only" as real
setup would be done by three new functions.

Something like this on top (won't even compile):

diff --git a/setup.c b/setup.c
index 8901149..45b9860 100644
--- a/setup.c
+++ b/setup.c
@@ -346,16 +346,36 @@ static const char *setup_explicit_git_dir(const
char *gitdirenv,
 	return retval;
 }

-static int cwd_contains_git_dir(const char **gitfile_dirp)
+static int cwd_contains_git_dir(const char **gitfile_dirp, char *cwd)
 {
 	const char *gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIR=
ONMENT);
 	*gitfile_dirp =3D gitfile_dir;
 	if (gitfile_dir) {
 		if (set_git_dir(gitfile_dir))
 			die("Repository setup failed");
-		return 1;
+		goto found;
 	}
-	return is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+		goto found;
+
+	return NULL;
+
+found:
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
 }

 /*
@@ -369,6 +389,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
+	const char *prefix;
 	int len, offset, ceil_offset, root_len;
 	dev_t current_device =3D 0;
 	int one_filesystem =3D 1;
@@ -417,8 +438,9 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		current_device =3D buf.st_dev;
 	}
 	for (;;) {
-		if (cwd_contains_git_dir(&gitfile_dir))
-			break;
+		if ((prefix =3D cwd_contains_git_dir(&gitfile_dir, cwd)))
+			return prefix;
+
 		if (is_git_directory(".")) {
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
@@ -464,22 +486,6 @@ const char *setup_git_directory_gently(int *nongit=
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

 int git_config_perm(const char *var, const char *value)

--=20
Duy
