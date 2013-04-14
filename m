From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] branch: colour upstream branches
Date: Sat, 13 Apr 2013 20:46:25 -0500
Message-ID: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 03:47:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URC2e-0003zo-IZ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 03:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab3DNBre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 21:47:34 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:64874 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DNBrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 21:47:33 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so1735980qca.32
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 18:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Q/DKV4hr0FPL9RIvuXFIL7J0kJx6p5SSUirC4TVAJVo=;
        b=uYKgrq1RpAD2Rru6VHxa0PPtbL36n5a4HTMv/W/X1TyluhMZt6Zvg2NPNkgY9HD9ai
         Ey5sQaP/CbwRIiFBBQ/BkgE4Hxh8XYBncAagXD/BnpgECZG7U/MTuGPrpEvdwLEId6nq
         qkZ6ISyZ3DKIrnlJnBbYDHpoylByJ89xsVtUPynyq6SEPirlh/EpyewXOrZNVfcfSWkW
         dD3x9xhlVfb8XV72TdXQELsc4C3Fx0MThHbTA9VDuk7uziLqGJRGvoA3OVoXaU7slQev
         n2sHLk9Vipx4LpFbeqcvXnI50ER4/gSn61KNd5TsBi9WPgUlB08r30yIi8R4DrRDklJZ
         MjQA==
X-Received: by 10.224.17.72 with SMTP id r8mr17438453qaa.48.1365904052480;
        Sat, 13 Apr 2013 18:47:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id bt19sm23772369qab.0.2013.04.13.18.47.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 18:47:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.641.gd16d37a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221076>

It's hard to see them among so much output otherwise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 00d17d2..a1cdc29 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -417,32 +417,45 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
+	char fancy[80];
 
 	if (!stat_tracking_info(branch, &ours, &theirs)) {
 		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref)
-			strbuf_addf(stat, "[%s] ",
-			    shorten_unambiguous_ref(branch->merge[0]->dst, 0));
+		    show_upstream_ref) {
+			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+			if (want_color(branch_use_color))
+				strbuf_addf(stat, "[%s%s%s] ",
+						GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
+			else
+				strbuf_addf(stat, "[%s] ", ref);
+		}
 		return;
 	}
 
-	if (show_upstream_ref)
+	if (show_upstream_ref) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+		if (want_color(branch_use_color))
+			snprintf(fancy, sizeof(fancy), "%s%s%s",
+					GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
+		else
+			strncpy(fancy, ref, sizeof(fancy));
+	}
+
 	if (!ours) {
 		if (ref)
-			strbuf_addf(stat, _("[%s: behind %d]"), ref, theirs);
+			strbuf_addf(stat, _("[%s: behind %d]"), fancy, theirs);
 		else
 			strbuf_addf(stat, _("[behind %d]"), theirs);
 
 	} else if (!theirs) {
 		if (ref)
-			strbuf_addf(stat, _("[%s: ahead %d]"), ref, ours);
+			strbuf_addf(stat, _("[%s: ahead %d]"), fancy, ours);
 		else
 			strbuf_addf(stat, _("[ahead %d]"), ours);
 	} else {
 		if (ref)
 			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
-				    ref, ours, theirs);
+				    fancy, ours, theirs);
 		else
 			strbuf_addf(stat, _("[ahead %d, behind %d]"),
 				    ours, theirs);
-- 
1.8.2.1.641.gd16d37a
