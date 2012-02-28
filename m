From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 06/10] help: reuse print_columns() for help -a
Date: Tue, 28 Feb 2012 18:58:47 +0700
Message-ID: <1330430331-19945-7-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2LiV-0005WC-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965481Ab2B1L7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 06:59:35 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53635 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965476Ab2B1L7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:59:34 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so2265513dae.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 03:59:34 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.228.103 as permitted sender) client-ip=10.68.228.103;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.228.103 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.228.103])
        by 10.68.228.103 with SMTP id sh7mr901421pbc.106.1330430374451 (num_hops = 1);
        Tue, 28 Feb 2012 03:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+bgz29/O4Rph0hIv9agVKIpQxNVE9YJbFR3IcAmNy5E=;
        b=lR5tLKsJ3MkZtoCnwzGxzrC9NJYHX1VabAKRDKnmk/5jrbLcvi40V0Liym+6vULCRu
         tVvOogqi+ryrcCorXHBq0HtPP71Kf8OUkz68hBKfQng1EirefPfn3sIDIJkkWWJSSY70
         lTiy+Xbpl5D9/Z7eYxWvm3RBG6pDPkFcQ07xQ=
Received: by 10.68.228.103 with SMTP id sh7mr787508pbc.106.1330430374402;
        Tue, 28 Feb 2012 03:59:34 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id u6sm11407351pbu.12.2012.02.28.03.59.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 03:59:29 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 18:59:37 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191720>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c |    7 ++++++-
 help.c         |   54 ++++++++++++++++++------------------------------=
------
 help.h         |    2 +-
 3 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..c64f152 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "column.h"
 #include "help.h"
=20
 static struct man_viewer_list {
@@ -30,6 +31,7 @@ enum help_format {
 };
=20
 static int show_all =3D 0;
+static unsigned int colopts;
 static enum help_format help_format =3D HELP_FORMAT_NONE;
 static struct option builtin_help_options[] =3D {
 	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
@@ -251,6 +253,8 @@ static int add_man_viewer_info(const char *var, con=
st char *value)
=20
 static int git_help_config(const char *var, const char *value, void *c=
b)
 {
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, "help", &colopts);
 	if (!strcmp(var, "help.format")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -424,8 +428,9 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 	parsed_help_format =3D help_format;
=20
 	if (show_all) {
+		git_config(git_help_config, NULL);
 		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", &main_cmds, &other_cmds);
+		list_commands("git commands", colopts, &main_cmds, &other_cmds);
 		printf("%s\n", git_more_info_string);
 		return 0;
 	}
diff --git a/help.c b/help.c
index 14eefc9..3155c68 100644
--- a/help.c
+++ b/help.c
@@ -4,6 +4,8 @@
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
+#include "string-list.h"
+#include "column.h"
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -70,31 +72,20 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
 	cmds->cnt =3D cj;
 }
=20
-static void pretty_print_string_list(struct cmdnames *cmds, int longes=
t)
+static void pretty_print_string_list(struct cmdnames *cmds, unsigned i=
nt colopts)
 {
-	int cols =3D 1, rows;
-	int space =3D longest + 1; /* min 1 SP between words */
-	int max_cols =3D term_columns() - 1; /* don't print *on* the edge */
-	int i, j;
-
-	if (space < max_cols)
-		cols =3D max_cols / space;
-	rows =3D DIV_ROUND_UP(cmds->cnt, cols);
-
-	for (i =3D 0; i < rows; i++) {
-		printf("  ");
+	struct string_list list =3D STRING_LIST_INIT_NODUP;
+	struct column_options copts;
+	int i;
=20
-		for (j =3D 0; j < cols; j++) {
-			int n =3D j * rows + i;
-			int size =3D space;
-			if (n >=3D cmds->cnt)
-				break;
-			if (j =3D=3D cols-1 || n + rows >=3D cmds->cnt)
-				size =3D 1;
-			printf("%-*s", size, cmds->names[n]->name);
-		}
-		putchar('\n');
-	}
+	for (i =3D 0; i < cmds->cnt; i++)
+		string_list_append(&list, cmds->names[i]->name);
+	memset(&copts, 0, sizeof(copts));
+	copts.indent =3D "  ";
+	copts.padding =3D 2;
+	/* always enable column display here */
+	print_columns(&list, colopts | COL_ENABLED, &copts);
+	string_list_clear(&list, 0);
 }
=20
 static int is_executable(const char *name)
@@ -203,25 +194,16 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
=20
-void list_commands(const char *title, struct cmdnames *main_cmds,
-		   struct cmdnames *other_cmds)
+void list_commands(const char *title, unsigned int colopts,
+		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
 {
-	int i, longest =3D 0;
-
-	for (i =3D 0; i < main_cmds->cnt; i++)
-		if (longest < main_cmds->names[i]->len)
-			longest =3D main_cmds->names[i]->len;
-	for (i =3D 0; i < other_cmds->cnt; i++)
-		if (longest < other_cmds->names[i]->len)
-			longest =3D other_cmds->names[i]->len;
-
 	if (main_cmds->cnt) {
 		const char *exec_path =3D git_exec_path();
 		printf("available %s in '%s'\n", title, exec_path);
 		printf("----------------");
 		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
-		pretty_print_string_list(main_cmds, longest);
+		pretty_print_string_list(main_cmds, colopts);
 		putchar('\n');
 	}
=20
@@ -230,7 +212,7 @@ void list_commands(const char *title, struct cmdnam=
es *main_cmds,
 		printf("---------------------------------------");
 		mput_char('-', strlen(title));
 		putchar('\n');
-		pretty_print_string_list(other_cmds, longest);
+		pretty_print_string_list(other_cmds, colopts);
 		putchar('\n');
 	}
 }
diff --git a/help.h b/help.h
index b6b12d5..854d2d4 100644
--- a/help.h
+++ b/help.h
@@ -25,7 +25,7 @@ extern void add_cmdname(struct cmdnames *cmds, const =
char *name, int len);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *exclu=
des);
 extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-extern void list_commands(const char *title,
+extern void list_commands(const char *title, unsigned int colopts,
 			  struct cmdnames *main_cmds,
 			  struct cmdnames *other_cmds);
=20
--=20
1.7.8.36.g69ee2
