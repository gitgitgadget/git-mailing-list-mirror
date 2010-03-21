From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/19] worktree setup: call set_git_dir explicitly
Date: Sun, 21 Mar 2010 17:30:31 +0700
Message-ID: <1269167446-7799-5-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIUv-0003HC-Jz
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab0CUKey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:34:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54002 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab0CUKex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:34:53 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so509917gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=avJ0N3bG/8Cs6SIfdjY3x856KX/tFF+gz7wj0Izykpo=;
        b=vk52Bxyub43eAYC9HH7s3HmlmRmLUaIxF+i+BzL054IDPtAD0aqwEkhgTCJlXZlax6
         ViiOQx3V5YD6MIhBJELMJWx+pvWbSCLfppAune0KnjIRREFy1cdouxRESKXTvSLnMkDg
         W5ORoSXUzFMFjaOHQBZQgo9LVt9n/MrCE4Iuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dGSw1cPAL6uSf0Lxh34z32fxthjIAfwoRdVY/6WG0W7O+3YRgFvzMn4uTXm2pkOfUf
         mpyWUnKKBiBSAAn0L5+Nt1V8wAQcdPAQyRWCEI7+W4AWRZsy3SW4VP+Jz4JrJD6Kyw1a
         px6tzeBirFLjVvAalcveeO1MhkXkGaK3PS9+A=
Received: by 10.150.241.25 with SMTP id o25mr9986020ybh.54.1269167692793;
        Sun, 21 Mar 2010 03:34:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 21sm2424872iwn.3.2010.03.21.03.34.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:34:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:11 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142802>

Currently setup_git_env() can automatically set git directory to
".git", relative to current working directory, no matter where it
is. Any access to repository may call setup_git_env() automatically if
there is no repository found yet. This leads to obscure faults where
we don't expect a repository setup to happen.

The ultimate goal (**) is:

 - Git repository will be searched and set up by either one of these
   functions (and no other functions):

   + setup_git_directory_gently()
   + setup_git_directory()
   + enter_repo()
   + init_db()

 - Repository setup can't be called more than once. If it is really
   needed, then un-setup the previous repo before moving on with
   another one.

 - Any attempts to access repository when it's not found/set up should
   be caught.

This patch is the first step to accomplish this goal. It ensures that
after the "setup function" (mentioned above) is called, if a
repository is found, then setup_git_env() must be called already.

The two other cases (no setup function called,
setup_git_directory_gently() called but no repo found) will be covered
by the next patches, to ensure setup_git_env() will not be triggered.

(**) This only applies to builtin commands, for now.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index e067292..43a8609 100644
--- a/setup.c
+++ b/setup.c
@@ -350,14 +350,17 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
 				/* config may override worktree */
 				if (check_repository_format_gently(nongit_ok))
 					return NULL;
+				set_git_dir(gitdirenv);
 				return retval;
 			}
 			if (check_repository_format_gently(nongit_ok))
 				return NULL;
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
-			if (!retval || !*retval)
+			if (!retval || !*retval) {
+				set_git_dir(gitdirenv);
 				return NULL;
+			}
 			set_git_dir(make_absolute_path(gitdirenv));
 			if (chdir(work_tree_env) < 0)
 				die_errno ("Could not chdir to '%s'", work_tree_env);
@@ -392,8 +395,10 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 	offset =3D len =3D strlen(cwd);
 	for (;;) {
 		gitfile_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile_dir || is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT)) {
-			if (gitfile_dir && set_git_dir(gitfile_dir))
+		if (!gitfile_dir && is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+			gitfile_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+		if (gitfile_dir) {
+			if (set_git_dir(gitfile_dir))
 				die("Repository setup failed");
 			inside_git_dir =3D 0;
 			if (!work_tree_env)
--=20
1.7.0.2.425.gb99f1
