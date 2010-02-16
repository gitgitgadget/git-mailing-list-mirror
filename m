From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 03/26] Save setup_git_dir* info globally for later use
Date: Tue, 16 Feb 2010 23:04:54 +0700
Message-ID: <1266336317-607-4-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:09:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPyW-0006Wm-KS
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919Ab0BPQIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:23 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684Ab0BPQIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:21 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uixV0Mym/FH9BcypWijEzQKYfr+CGtivE0IDBX8WL4g=;
        b=Gl6etZsXOVCOdTQ8aASidlD45nA+Uf6N3W1oauY/sQrZLGOi1X+9cbgAv7nmnoItKU
         3HYo3tt+81fc0V8u5q/oJuvoVe66A0TdLrjvP/QmI3Us1b43hCeeR8foC6t3i2xPfVCX
         PmquPg1E+blv0BHn5x2b8+Zu8DNlmKOBBE+1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IghI8lp3I9enWW/BE5k6+R8tO/cEbooLRJGAYIDYBWpArgWsCKE9wMCFSjKisYr+4r
         moXBEfgelBMP1pMvdc1ykg4bWuwerMvrKIEtDePq1aCldinmDK4bYVy3GOPYbdWoX7lz
         kMSbrKfvpwkKilLSdW3lXf1nrBNTzB1AOCm2Y=
Received: by 10.150.168.37 with SMTP id q37mr9228227ybe.265.1266336500873;
        Tue, 16 Feb 2010 08:08:20 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 4sm2931976ywi.9.2010.02.16.08.08.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:37 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140104>

=46or one thing, this could help catching setup_git_dir being run twice=
,
which is usually wrong.

This also helps moving up setup_git_dir* from inside builtin commands
to handle_internal_command(). Without this, run_builtin()
needs to find another way to pass "nongit_ok" to builtin commands.

The main program has to intialize startup_info pointer properly. For
builtin commands, git.c will take care of that. If startup_info is
NULL, the prior behavior should apply.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Could have save the command name in startup_info too, so error
 messages are clearer..

 cache.h       |    8 ++++++++
 environment.c |    1 +
 git.c         |   31 +++++++++++++++++++++++--------
 setup.c       |   14 +++++++++++++-
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..fcbed37 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,4 +1040,12 @@ void overlay_tree_on_cache(const char *tree_name=
, const char *prefix);
 char *alias_lookup(const char *alias);
 int split_cmdline(char *cmdline, const char ***argv);
=20
+/* git.c */
+struct startup_info {
+	const char *prefix;
+	int have_set_gitdir;
+	int have_repository;
+};
+extern struct startup_info *startup_info;
+
 #endif /* CACHE_H */
diff --git a/environment.c b/environment.c
index 739ec27..1ab8815 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+struct startup_info *startup_info;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/git.c b/git.c
index b3e23f1..ea29cca 100644
--- a/git.c
+++ b/git.c
@@ -13,6 +13,8 @@ const char git_usage_string[] =3D
 const char git_more_info_string[] =3D
 	"See 'git help COMMAND' for more information on a specific command.";
=20
+static struct startup_info opts;
+struct startup_info *startup_info;
 static int use_pager =3D -1;
 struct pager_config {
 	const char *cmd;
@@ -206,9 +208,6 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	if (subdir && chdir(subdir))
-		die_errno("Cannot change to '%s'", subdir);
-
 	errno =3D saved_errno;
=20
 	return ret;
@@ -234,13 +233,26 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
 {
 	int status, help;
 	struct stat st;
-	const char *prefix;
=20
-	prefix =3D NULL;
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
-		if (p->option & RUN_SETUP)
-			prefix =3D setup_git_directory();
+		/* handle_alias() may have set up gitdir for alias lookup */
+		if (startup_info->have_set_gitdir) {
+			if (p->option & RUN_SETUP) {
+				if (!startup_info->have_repository)
+					die("No repository found");
+			}
+			else {
+				/* This is WRONG, but we can't get rid of it now */
+				startup_info->have_set_gitdir =3D 0;
+				if (startup_info->prefix && chdir(startup_info->prefix))
+					die("Cannot change to '%s'", startup_info->prefix);
+			}
+		}
+		else {
+			if (p->option & RUN_SETUP)
+				setup_git_directory();
+		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
@@ -254,7 +266,7 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
=20
 	trace_argv_printf(argv, "trace: built-in: git");
=20
-	status =3D p->fn(argc, argv, prefix);
+	status =3D p->fn(argc, argv, startup_info->prefix);
 	if (status)
 		return status;
=20
@@ -473,6 +485,9 @@ int main(int argc, const char **argv)
 {
 	const char *cmd;
=20
+	startup_info =3D &opts;
+	memset(startup_info, 0, sizeof(*startup_info));
+
 	cmd =3D git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd =3D "git-help";
diff --git a/setup.c b/setup.c
index 183bcf6..0c05d36 100644
--- a/setup.c
+++ b/setup.c
@@ -236,7 +236,13 @@ void setup_work_tree(void)
 		git_dir =3D make_absolute_path(git_dir);
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
+
+	/* we know gitdir is already set, we only adjust it to relative path =
*/
+	if (startup_info)
+		startup_info->have_set_gitdir =3D 0;
 	set_git_dir(make_relative_path(git_dir, work_tree));
+	if (startup_info)
+		startup_info->have_set_gitdir =3D 1;
 	initialized =3D 1;
 }
=20
@@ -447,8 +453,14 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	const char *prefix;
=20
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
-	if (!nongit_ok || (!*nongit_ok && check_repository_format_gently(nong=
it_ok)))
+	if (startup_info)
+		startup_info->have_set_gitdir =3D 1;
+	if ((!nongit_ok || !*nongit_ok) && check_repository_format_gently(non=
git_ok))
 		prefix =3D NULL;
+	if (startup_info) {
+		startup_info->prefix =3D prefix;
+		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+	}
 	return prefix;
 }
=20
--=20
1.7.0.195.g637a2
