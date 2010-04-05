From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/43] worktree setup: call set_git_dir explicitly
Date: Mon,  5 Apr 2010 20:41:10 +0200
Message-ID: <1270492888-26589-26-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH6-0000ps-N7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab0DESnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:05 -0400
Received: from mail-iw0-f199.google.com ([209.85.223.199]:64776 "EHLO
	mail-iw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab0DESnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:00 -0400
Received: by iwn37 with SMTP id 37so136903iwn.15
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZbhDC+QMGELluNOuhbNPrxwHo8KpFrE2gEOFCJQ18LI=;
        b=YGclDUKX9U34E8DPLriGFvGEg3UvfBD2jcjBQlS/gs/PbLhbigrjJWHCX59NUdvnIA
         CyMn2m0f0Ot+w26AVVGrzekuwx8P3NXTijblJjj2ORHRMIdyLIWIEUJHMgFkt8iaFVsi
         PbM85Wh6jbSwXKt1j/AJxQQJh1Rq8+Nz/eYBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ALCWhTWjpzXgH9oFVaqeZAx+8SphLF/cgWRD3AuCADvm3d7OS/xkvf4jdde5e2X7wG
         /ZOppovdyrz+Q9G5VSPWywVqx+t4MujPuG2tFm+wGlx3ib+Y9NVYKPATPhFFHBOXG1Wm
         hHIwlMTZKKkVlXPh+mLpq/pHrutw6F6G19GuE=
Received: by 10.231.159.134 with SMTP id j6mr2848721ibx.29.1270492978795;
        Mon, 05 Apr 2010 11:42:58 -0700 (PDT)
Received: from dektop ([72.14.241.33])
        by mx.google.com with ESMTPS id cm22sm9875970ibb.11.2010.04.05.11.42.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:57 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:52 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144029>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.0.rc1.541.g2da82.dirty
