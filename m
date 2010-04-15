From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/9] Setup cleanup, chapter one
Date: Wed, 14 Apr 2010 19:05:09 -0500
Message-ID: <20100415000448.GA14151@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <7vwrw9oiva.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:05:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Ca8-0005JE-0E
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0DOAFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 20:05:13 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:54523 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0DOAFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 20:05:11 -0400
Received: by yxe37 with SMTP id 37so398517yxe.21
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 17:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DCxjZk1xKKtyQcFwq0FE8HgIziDJFlwqpIlHCm8uAik=;
        b=xRK5d2NuKqywl5Qb9hR+g76St3MT6+wajxISqw7E18pfCcyagDIQzBTAB69y3jFWeH
         q2YaFzQhw7LXDfFosZdvrvqyXhl8cjhxIXpscNgTgPW9RARNys9Vo1lUlJHCy+8AzOqw
         HMz8nwG9F9jajRiTMhYidbAUghuNvF1dBNEGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nlShRXXqoPq+BFsmV/58YCGVc7nDAbtQv01Yl7tkxEjsBDtLYU8K0iEIJSqj5Mh0D1
         ihY1Jf81iu//W1PWqzHSzIxrtKJJKgJW8dqJiENYveNyIlOdz4cM78Rtvtvn0c7x5+Cx
         Dh6FbWVJSTvY8xuQhLvwziWGmCHi7QJkvudr4=
Received: by 10.231.173.129 with SMTP id p1mr3601520ibz.85.1271289909258;
        Wed, 14 Apr 2010 17:05:09 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id co35sm478097ibb.2.2010.04.14.17.05.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 17:05:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrw9oiva.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144926>

Junio C Hamano wrote:

> By the way, the other day I had an interesting experience after runni=
ng:
>=20
> 	git -p help -m cat-file
>=20
> If you try this yourself, you probably need "reset" or "stty sane" to
> recover.
>=20
> Does this series address it?

No, it doesn=E2=80=99t.

The bug seems to be timing-related.  The two copies of =E2=80=98less=E2=
=80=99 fight over
initialization of the terminal and nobody wins.

What is the right thing to do in this case?  Can we assume =E2=80=98man=
=E2=80=99 comes
with a pager and suppress our own?  Should we ask =E2=80=98man=E2=80=99=
 to suppress its
pager, losing the formatting and status line in the process, but settin=
g
MANPAGER=3Dcat?  Probably the right thing to do would be to suppress ou=
r
pager and set MANPAGER according to git_pager() so =E2=80=98man=E2=80=99=
 can use it.

Maybe something roughly like this (on top of the series)?  This does
not help backends that do not know how to use MANPAGER.

diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..d9a0307 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -316,6 +316,40 @@ static const char *cmd_to_page(const char *git_cmd=
)
 		return prepend("git", git_cmd);
 }
=20
+static void commit_pager_choice(void) {
+	switch (startup_info->use_pager) {
+	case 0:
+		setenv("GIT_PAGER", "cat", 1);
+		break;
+	case 1:
+		setup_pager();
+		break;
+	default:
+		break;
+	}
+}
+
+static void setup_man_pager(void) {
+	const char *pager;
+
+	switch (startup_info->use_pager) {
+	case 0:
+		setenv("MANPAGER", "cat", 1);
+		break;
+	case 1:
+		pager =3D git_pager(isatty(1));
+		if (!pager) {
+			setenv("MANPAGER", "cat", 1);
+		} else {
+			setenv("LESS", "FRSX", 0);
+			setenv("MANPAGER", pager, 1);
+		}
+		break;
+	default:
+		break;
+	}
+}
+
 static void setup_man_path(void)
 {
 	struct strbuf new_path =3D STRBUF_INIT;
@@ -358,6 +392,7 @@ static void show_man_page(const char *git_cmd)
 	const char *fallback =3D getenv("GIT_MAN_VIEWER");
=20
 	setup_man_path();
+	setup_man_pager();
 	for (viewer =3D man_viewer_list; viewer; viewer =3D viewer->next)
 	{
 		exec_viewer(viewer->name, page); /* will return when unable */
@@ -423,20 +458,17 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format =3D help_format;
=20
-	if (show_all) {
+	if (show_all || !argv[0]) {
+		commit_pager_choice();
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", &main_cmds, &other_cmds);
+		if (show_all)
+			list_commands("git commands", &main_cmds, &other_cmds);
+		else
+			list_common_cmds_help();
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
=20
-	if (!argv[0]) {
-		printf("usage: %s\n\n", git_usage_string);
-		list_common_cmds_help();
-		printf("\n%s\n", git_more_info_string);
-		return 0;
-	}
-
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
=20
diff --git a/cache.h b/cache.h
index 030ba01..8ba5727 100644
--- a/cache.h
+++ b/cache.h
@@ -1061,6 +1061,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	int use_pager;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/git.c b/git.c
index 0a0d9eb..a81726e 100644
--- a/git.c
+++ b/git.c
@@ -14,7 +14,6 @@ const char git_more_info_string[] =3D
 	"See 'git help COMMAND' for more information on a specific command.";
=20
 static struct startup_info git_startup_info;
-static int use_pager =3D -1;
 struct pager_config {
 	const char *cmd;
 	int val;
@@ -39,7 +38,7 @@ int check_pager_config(const char *cmd)
 }
=20
 static void commit_pager_choice(void) {
-	switch (use_pager) {
+	switch (startup_info->use_pager) {
 	case 0:
 		setenv("GIT_PAGER", "cat", 1);
 		break;
@@ -86,9 +85,9 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
 			puts(system_path(GIT_HTML_PATH));
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-			use_pager =3D 1;
+			startup_info->use_pager =3D 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
-			use_pager =3D 0;
+			startup_info->use_pager =3D 0;
 			if (envchanged)
 				*envchanged =3D 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
@@ -221,13 +220,15 @@ static int handle_alias(int *argcp, const char **=
*argv)
 const char git_version_string[] =3D GIT_VERSION;
=20
 #define RUN_SETUP		(1<<0)
-#define USE_PAGER		(1<<1)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE		(1<<2)
-#define RUN_SETUP_GENTLY	(1<<3)
+#define NEED_WORK_TREE		(1<<1)
+#define RUN_SETUP_GENTLY	(1<<2)
+#define USE_PAGER		(1<<3)
+/* do not commit_pager_choice() -- the builtin will take care of it */
+#define NO_PAGER_SETUP		(1<<4)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -244,6 +245,8 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 	prefix =3D NULL;
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
+		int use_pager =3D startup_info->use_pager;
+
 		if (p->option & RUN_SETUP)
 			prefix =3D setup_git_directory();
 		if (p->option & RUN_SETUP_GENTLY) {
@@ -255,8 +258,10 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 			use_pager =3D check_pager_config(p->cmd);
 		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
 			use_pager =3D 1;
+		startup_info->use_pager =3D use_pager;
 	}
-	commit_pager_choice();
+	if (!(p->option & NO_PAGER_SETUP))
+		commit_pager_choice();
=20
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
@@ -328,7 +333,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, USE_PAGER },
 		{ "hash-object", cmd_hash_object },
-		{ "help", cmd_help },
+		{ "help", cmd_help, NO_PAGER_SETUP },
 		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
@@ -484,6 +489,7 @@ int main(int argc, const char **argv)
 	const char *cmd;
=20
 	memset(&git_startup_info, 0, sizeof(git_startup_info));
+	git_startup_info.use_pager =3D -1;
 	startup_info =3D &git_startup_info;
=20
 	cmd =3D git_extract_argv0_path(argv[0]);
