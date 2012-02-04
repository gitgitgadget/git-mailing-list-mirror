From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 08/12] help: reuse print_columns() for help -a
Date: Sat,  4 Feb 2012 22:59:12 +0700
Message-ID: <1328371156-4009-9-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthyA-0006s8-OJ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab2BDP4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:56:01 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40600 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab2BDP4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:56:00 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so3706596pbd.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hogzf7JDu1YJEMThKMB1lEhyL/HxbsHddrw+iS4ZxYE=;
        b=ndb8Y5tjJJtqQ40R3sqn2IZ1pzZQTGg6YI+cItjIaSLHO5lep5v86Xi4vvmyb67YSJ
         9aR6kx522wzjRa7ThyVjoSdYrZcevSZzvh50QmeQ/TAkE4Dve1L6vZ6wNwujz+dxK9fw
         hLPGP6iE1P23N7Au7fGBANjtJeVyUk6NvTyjw=
Received: by 10.68.211.198 with SMTP id ne6mr29076390pbc.83.1328370960001;
        Sat, 04 Feb 2012 07:56:00 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id r9sm22407883pbi.6.2012.02.04.07.55.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:55:58 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 23:00:26 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189881>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 help.c |   47 +++++++++++++----------------------------------
 1 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/help.c b/help.c
index 672561b..d6d2e19 100644
--- a/help.c
+++ b/help.c
@@ -4,6 +4,7 @@
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
+#include "string-list.h"
 #include "column.h"
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
@@ -71,31 +72,18 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
 	cmds->cnt =3D cj;
 }
=20
-static void pretty_print_string_list(struct cmdnames *cmds, int longes=
t)
+static void pretty_print_string_list(struct cmdnames *cmds)
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
+	print_columns(&list, COL_MODE_COLUMN | COL_ENABLED, &copts);
+	string_list_clear(&list, 0);
 }
=20
 static int is_executable(const char *name)
@@ -207,22 +195,13 @@ void load_command_list(const char *prefix,
 void list_commands(const char *title, struct cmdnames *main_cmds,
 		   struct cmdnames *other_cmds)
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
+		pretty_print_string_list(main_cmds);
 		putchar('\n');
 	}
=20
@@ -231,7 +210,7 @@ void list_commands(const char *title, struct cmdnam=
es *main_cmds,
 		printf("---------------------------------------");
 		mput_char('-', strlen(title));
 		putchar('\n');
-		pretty_print_string_list(other_cmds, longest);
+		pretty_print_string_list(other_cmds);
 		putchar('\n');
 	}
 }
--=20
1.7.8.36.g69ee2
