From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] builtins: reset startup_info->have_run_setup_gitdir when unsetting up repository
Date: Sat, 27 Mar 2010 16:13:04 +0700
Message-ID: <1269681184-1992-2-git-send-email-pclouds@gmail.com>
References: <1269681184-1992-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 16:13:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvXhc-0006HQ-F2
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 16:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab0C0PN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 11:13:28 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:43545 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab0C0PNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 11:13:17 -0400
Received: by mail-fx0-f223.google.com with SMTP id 23so2847933fxm.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KUlT0DmCrkL07ObK+jSv4NDxKeAkMh1S+NTi9f66jbc=;
        b=TY5QrWjGYy3eqI6BLD6gQCzhgjWTt3NIe9eh+GcBDEP2fiMZCE+1D653fqD0zshkI1
         aY9/OLKzURsrSFCD4vGKPLKIqUgZtYikpkd7mMXMdEf6G6bjMytihFV8hPKupfAPOH4J
         a33cqrHGXUxyk3rIodTUDc8xD2ohgWSCZ7xp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E0C+OEKDO9sQKaVKBeHORHHkWttR7ZXSBSBelCss3WeYZBHPBbpz+UcwRijwMQPkUg
         MHLfODsjtkFCV4wPAu8CtZJQWN0F523LT4CEauuER6c8EmdcByqNmNizHc1rzpJB1wjx
         1orveUqxFbMdGB9VwKHmPjMVxtRqyOj61n7tg=
Received: by 10.102.16.36 with SMTP id 36mr1274752mup.124.1269702796806;
        Sat, 27 Mar 2010 08:13:16 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id w5sm8856501mue.54.2010.03.27.08.13.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 08:13:16 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 27 Mar 2010 16:13:10 +0700
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1269681184-1992-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143336>

startup_info->have_run_setup_gitdir is used to guard unallowed access
to repository. When a repository has been set up and the real command
does not expect any setup, we should revert to the original "fresh"
state, including startup_info->have_run_setup_gitdir. Otherwise, the
next attempt to set up repository will fail.

While at it, also reset repository_format_version to zero. When
omitted, the format should be understood as the last supported
version, i.e. zero. This is probably only used by "git init" or "git
clone".

=46ault caught by Jonathan Nieder (and demonstrated with a beautiful te=
st case)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Junio, I can split this up and put it to the original patches where th=
e faults
 are introduced if you want.

 git.c           |   13 ++++++++-----
 setup.c         |    2 +-
 t/t0001-init.sh |   14 ++++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 7ebfea5..5c249fd 100644
--- a/git.c
+++ b/git.c
@@ -242,11 +242,14 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
 			int nongit_ok;
 			setup_git_directory_gently(&nongit_ok);
 		}
-		else if (startup_info->have_repository) {
-			if (p->option & (RUN_SETUP_GENTLY | RUN_SETUP))
-				; /* done already */
-			else
-				unset_git_directory(startup_info->prefix);
+		else if (startup_info->have_run_setup_gitdir) {
+			if (startup_info->have_repository) {
+				if (p->option & (RUN_SETUP_GENTLY | RUN_SETUP))
+					; /* done already */
+				else
+					unset_git_directory(startup_info->prefix);
+			}
+			startup_info->have_run_setup_gitdir =3D 0;
 		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
diff --git a/setup.c b/setup.c
index d9bb616..43b529e 100644
--- a/setup.c
+++ b/setup.c
@@ -358,7 +358,7 @@ void unset_git_directory(const char *prefix)
 	inside_git_dir =3D -1;
=20
 	/* Initialized in check_repository_format_version() */
-	repository_format_version =3D 0xFF;
+	repository_format_version =3D 0;
 	shared_repository =3D PERM_UMASK;
 	is_bare_repository_cfg =3D -1;
 	git_work_tree_cfg =3D NULL;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5386504..f93856b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -33,6 +33,20 @@ test_expect_success 'plain' '
 	check_config plain/.git false unset
 '
=20
+test_expect_success 'plain through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		HOME=3D$(pwd)/alias-config &&
+		export HOME &&
+		mkdir alias-config &&
+		echo "[alias] aliasedinit =3D init" >alias-config/.gitconfig &&
+		mkdir plain-aliased &&
+		cd plain-aliased &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased/.git false unset
+'
+
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
 		unset GIT_DIR
--=20
1.7.0.rc1.541.g2da82.dirty
