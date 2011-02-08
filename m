From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] help: reuse struct column_layout
Date: Tue,  8 Feb 2011 22:22:19 +0700
Message-ID: <1297178541-31124-6-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQg-0006vI-GW
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab1BHPYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:30 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1BHPY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:29 -0500
Received: by mail-pz0-f46.google.com with SMTP id 35so1140930pzk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=zFQRe4Q3O11FdrJ4rBKzV/JputBD1JlZWZpBpJzG7yM=;
        b=rRChAFddeg4YrkbfqRkG1SJTLgUeCEOrfNaYmCr5E/Bzv6SS47tJoMnk9dG+WP5QIX
         swdsuIEoc0sr54VFSomPgYdbAW8sGteav7mRYN/j+iT0dK8RUAq5y+qJIMDt/8NlgS3o
         rm/ICHN5h0uak5EGsp93a9VKoW3spabrS1kks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aszCUmWbdXpfdl9x4uMRBLkacnnazkRjqpSbTeztd0XBhh8VTWeB0FDrPf7t/oroTH
         15nEcnUKPcQ4H00qlVt44yUA8yLdZ6IJBeOfg5OwCZQXAJXbBI4hX6dJpAIoRA6wNkt4
         wdvVbbuSKxXnea9BRohvf0dhM/KIVTVFWc++s=
Received: by 10.142.171.3 with SMTP id t3mr17202959wfe.281.1297178669223;
        Tue, 08 Feb 2011 07:24:29 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id e14sm7712836wfg.8.2011.02.08.07.24.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:24:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:23:01 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166356>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 help.c |   33 +++++++++++----------------------
 1 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/help.c b/help.c
index 1344208..dc06f63 100644
--- a/help.c
+++ b/help.c
@@ -4,6 +4,7 @@
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
+#include "column.h"
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -72,29 +73,17 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
names *excludes)
=20
 static void pretty_print_string_list(struct cmdnames *cmds, int longes=
t)
 {
-	int cols =3D 1, rows;
-	int space =3D longest + 1; /* min 1 SP between words */
-	int max_cols =3D term_columns() - 1; /* don't print *on* the edge */
-	int i, j;
-
-	if (space < max_cols)
-		cols =3D max_cols / space;
-	rows =3D DIV_ROUND_UP(cmds->cnt, cols);
+	struct column_layout c;
+	int i;
=20
-	for (i =3D 0; i < rows; i++) {
-		printf("  ");
+	memset(&c, 0, sizeof(c));
+	c.mode =3D COL_COLUMN_FIRST;
+	c.width =3D term_columns();
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
+		string_list_append(&c.items, cmds->names[i]->name);
+	display_columns(&c, 2, "  ");
+	string_list_clear(&c.items, 0);
 }
=20
 static int is_executable(const char *name)
--=20
1.7.2.2
