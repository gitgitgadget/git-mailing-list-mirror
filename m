From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/4] help.c::exclude_cmds: plug a leak
Date: Sun,  6 May 2012 14:55:28 +0800
Message-ID: <1336287330-7215-3-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQvOL-0004ih-Ta
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 08:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab2EFG4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 02:56:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33800 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab2EFGzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 02:55:47 -0400
Received: by pbbrp8 with SMTP id rp8so5453735pbb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M741C8pF895FWRlyh5/mA8gPXMQCRrUA0zz1blDjw6o=;
        b=KNcS6HfcuKYSBoQ/u+1PmSfm3KtyPlcylhRQSHZG7fNrRW3o/8u6cxwOp4E/MSZ43s
         ggR2oyovODoaNsIIOAY1j7YEEISTwSzWPKAPqSqS7iAFVoPxKd/O+qsN0LnHZnokOQQa
         S38ys5j/08+C6Guy9KCGSZy6gbKSfGr0NO2MD9rHsoYtHgaFD1t78KAC9U5H2lBharvo
         yB6oQ3prqjtnfke7lRO3SMKHKP0CmOL41VypyPEcL1u1wMi/W5jnaQnS7S1TTx1TdtiQ
         81HdYdgCp/vaOSHwoSZUkUudGIi4KP81xQ0u3vERJbzBb7tscFLOo4FvhDROKbGZH4m4
         Uq1A==
Received: by 10.68.197.8 with SMTP id iq8mr3374315pbc.65.1336287347166;
        Sat, 05 May 2012 23:55:47 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm32.beta238.maxonline.com.sg. [116.86.238.32])
        by mx.google.com with ESMTPS id wn3sm14086094pbc.74.2012.05.05.23.55.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 23:55:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.611.g8a79d96
In-Reply-To: <1336287330-7215-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197153>

Create a fresh cmdnames to hold the entries we want to keep, such that
we free the excluded entries in cmds only.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

---

A solution that does not require a fresh cmdnames escapes me.
---
 help.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index b64056d..705f152 100644
--- a/help.c
+++ b/help.c
@@ -65,21 +65,29 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	int ci, cj, ei;
 	int cmp;
 
+	struct cmdnames excluded;
+	memset(&excluded, 0, sizeof(excluded));
+	ALLOC_GROW(excluded.names, cmds->cnt, excluded.alloc);
+
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
-		if (cmp < 0)
-			cmds->names[cj++] = cmds->names[ci++];
-		else if (cmp == 0)
+		if (cmp < 0) {
+			excluded.names[cj] = cmds->names[ci];
+			cmds->names[ci] = NULL;
+			ci++, cj++;
+		} else if (cmp == 0)
 			ci++, ei++;
 		else if (cmp > 0)
 			ei++;
 	}
 
-	while (ci < cmds->cnt)
-		cmds->names[cj++] = cmds->names[ci++];
-
+	clean_cmdnames(cmds);
+	cmds->alloc = excluded.alloc;
 	cmds->cnt = cj;
+	cmds->names = excluded.names;
+	while (cj--)
+		cmds->names[cj] = excluded.names[cj];
 }
 
 static void pretty_print_string_list(struct cmdnames *cmds,
-- 
1.7.10.1.611.g8a79d96
