From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/9] help: reuse display_columns() for help -a
Date: Sun, 20 Mar 2011 23:04:49 +0700
Message-ID: <1300637089-21440-1-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 17:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1L7s-0001bY-MU
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 17:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab1CTQFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 12:05:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab1CTQE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 12:04:59 -0400
Received: by iwn34 with SMTP id 34so5649719iwn.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/OmWQTfJc7Dh6SI//6cn1swCZkUWrqpyVEmzmADChuQ=;
        b=fM+hQqEzjD733OFa3Ks82m6IWwG2uuqPWYcCmET9ypb13ntTckaemk+jEEaWjh5Lj1
         MbRLldLXLQZiOHI8ZsttuRV7tdjERpYXrjSnk2hggr85271p3hP8gGHZi1WnJRYAb+I6
         dkKHLymVcntFnwgjd2KLZzJRV9AyyB+gXYrJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TuKbzLkAfwbGIqGzb0oGk4WzszRYix6Kv/YzyTQYZY7+NJ5a2TW5yBTy0TTUjkenrW
         yiexAIK7h4bduIVKoBUTxNkSo8kksdKlxApKG9gHwJ9sAdCwUrz0etLwstWfw3tYJvUH
         f3wKthLiBh/i/tBHmFx5Kr7Dv0mrB86gOVcaE=
Received: by 10.231.28.138 with SMTP id m10mr3043725ibc.39.1300637098768;
        Sun, 20 Mar 2011 09:04:58 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id 13sm3058828ibo.25.2011.03.20.09.04.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 09:04:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 23:04:50 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169513>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This one is better. Because 'longest' is no longer used, all support
 code may be removed as well.

 help.c |   45 +++++++++++----------------------------------
 1 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/help.c b/help.c
index 768f64c..92150ea 100644
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
@@ -71,31 +72,16 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
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
+	display_columns(&list, COL_MODE_COLUMN | COL_ENABLED,
+			term_columns(), 1, "  ");
+	string_list_clear(&list, 0);
 }
=20
 static int is_executable(const char *name)
@@ -204,22 +190,13 @@ void load_command_list(const char *prefix,
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
@@ -228,7 +205,7 @@ void list_commands(const char *title, struct cmdnam=
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
1.7.4.74.g639db
