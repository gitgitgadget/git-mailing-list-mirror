From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/16] help: reuse display_columns() for help -a
Date: Wed,  9 Feb 2011 19:24:36 +0700
Message-ID: <1297254284-3729-9-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn98o-0007XS-4N
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1BIM1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:18 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52594 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:18 -0500
Received: by pzk35 with SMTP id 35so18502pzk.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4V88UxPDSDjIbOA3a/rINHD3E4CObUB5GgV67+BlHcU=;
        b=PfHl6XvYlo3syO0IO1DQbIqdWmvfxNMhUHesNA/s/WE+Bgb7kYVJce/DP560ml4V18
         NCOsThiR4l7KsfktcH1SYqj2LyYkaKgjkRCC7ygXhKycStlJ/JIfuSwW7OSnoH9V4UL/
         YYCYSAexkXYzPxAbuuhJvrryOATFNDnKhafnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AmFv5zDY3moFz89FsX8cF6bjVR7cVoIfNmZ2SqpGhIeeXqCHJNKp0BlmmNArbfeBuU
         hWji3M6R84CkG8O/5dpm8wUeepVVwXiVD32aOvBloyi5gSXRxYeyznxqPy+rsQPBMKAk
         DpgeuFEwxUMacdPJRKztv0KitiY1DhI45lt7o=
Received: by 10.142.52.9 with SMTP id z9mr11718661wfz.335.1297254437671;
        Wed, 09 Feb 2011 04:27:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id f5sm333018wfo.16.2011.02.09.04.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:47 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166412>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 help.c |   29 +++++++----------------------
 1 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/help.c b/help.c
index 768f64c..81942f9 100644
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
@@ -73,29 +74,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
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
+	display_columns(&list, COL_MODE_COLUMN, term_columns(), 1, "  ");
+	string_list_clear(&list, 0);
 }
=20
 static int is_executable(const char *name)
--=20
1.7.2.2
