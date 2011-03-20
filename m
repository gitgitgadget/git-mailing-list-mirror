From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/9] help: reuse display_columns() for help -a
Date: Sun, 20 Mar 2011 19:57:51 +0700
Message-ID: <1300625873-18435-8-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:59:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IE7-0003CH-M3
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab1CTM7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:59:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57792 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1CTM7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:59:18 -0400
Received: by mail-iy0-f174.google.com with SMTP id 26so5552163iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=9D/ltebyxDGjulUKjpO2xCG6RiDHH6x31AdwNkgfLqE=;
        b=SKnMpAwzvJvgsLNpFgeqEFmJOAu8dgabXtCQIQ7IktJUpncuGex4l6BkyLEyOvNtFN
         aWzXbxpnBHumyqvNecqWEaHFvkcEVmPUu5mdgvU+6/A5lAr8LHlsta5FPmEi9Pgfp30T
         N6g1+PW0m5SCycVxJN4/Fj6afRA5L31Ls6UHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vNUNPmkrYqDRLjJi+70cjOy5AvfzByoi3fCdGhgrsY5mf+OvcPZq6CCeIqRCDdnNPd
         3TtvgYnDjngizGmQjwj7qWyNGwSTzRRWr+ZMcBDkdCqLPHU6zCOgFWj+KvPctov8oXNU
         4zpNjEFeUCoxaKIBKELucpOgoWL5Sezwi75GI=
Received: by 10.231.142.23 with SMTP id o23mr3104592ibu.57.1300625958234;
        Sun, 20 Mar 2011 05:59:18 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id 19sm3677791ibx.1.2011.03.20.05.59.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:59:17 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:59:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169509>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 help.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/help.c b/help.c
index 768f64c..dcc8b81 100644
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
@@ -73,29 +74,14 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
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
--=20
1.7.4.74.g639db
