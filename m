From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/12] help: use columnizer
Date: Sun,  7 Mar 2010 19:09:37 +0700
Message-ID: <1267963785-473-5-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:13:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMZ-0006M7-TG
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab0CGMNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33676 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923Ab0CGMNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:19 -0500
Received: by pwj8 with SMTP id 8so3254848pwj.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XBZ1NIJPzCWCnE0+sKUyZNfH9gY2H9ADI7XbEErTUWM=;
        b=muWNWTvHYxO5v8zMLwdJht7flrCKDDtQ1T5um37WjTnpYG5wsbhG70w6MyvVv145bk
         C4NVVBbaVH+n8DNZ2RbP3GshtVUcN7j/Rydp0Zj7d4E5Qi3+DErArOvq50NYVrOYPDIW
         ARAgvajpIMi4Zd0LLe7+862yKCZQiXZlwymfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iYzuHG05n9VF1v+SbsASXPC1DGE7vqmrYY2SUeZKbtCz1CtgsyD/aRg5jP9UBHV9ke
         V5IQzaqEcFiLLEsjKEnF4d1hmTVYMahh/kUZZyEC7B4OzApVhsXTI8J0DHQ4JMd5Dn++
         czKfj/wONEJNbRHGj3TxEVgw+od6KOdn+prvI=
Received: by 10.141.108.5 with SMTP id k5mr2245002rvm.205.1267963999562;
        Sun, 07 Mar 2010 04:13:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3576876pzk.10.2010.03.07.04.13.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:04 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141676>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 help.c |   33 +++++++++++----------------------
 1 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/help.c b/help.c
index 888bf8c..e039c14 100644
--- a/help.c
+++ b/help.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "levenshtein.h"
 #include "help.h"
+#include "column.h"
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
@@ -71,29 +72,17 @@ void exclude_cmds(struct cmdnames *cmds, struct cmd=
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
+	struct columnizer cp;
+	int i;
=20
-	for (i =3D 0; i < rows; i++) {
-		printf("  ");
+	memset(&cp, 0, sizeof(cp));
+	cp.flags |=3D COLUMNIZER_HOMOGENEOUS | COLUMNIZER_COLUMN_FIRST;
+	cp.space =3D 1;
+	cp.left_space =3D 2;
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
+		feed_columnizer(&cp, cmds->names[i]->name);
+	feed_columnizer(&cp, NULL);
 }
=20
 static int is_executable(const char *name)
--=20
1.7.0.1.370.gd3c5
