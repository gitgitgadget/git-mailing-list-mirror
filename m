From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 5/7] bisect: change read_bisect_terms parameters
Date: Wed, 10 Jun 2015 21:01:56 +0200
Message-ID: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 21:02:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lGK-0003UZ-AV
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbbFJTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:02:04 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:41440 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752742AbbFJTCA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 15:02:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D807F2866;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOmvL+xs8Vnk; Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C71772852;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id B9AB120E6;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7X3ckkU6zzlQ; Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 79AAC20D6;
	Wed, 10 Jun 2015 21:01:58 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271343>

From: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>

The function reads BISECT_TERMS and stores it at the adress given in
parameters (instead of global variables name_bad and name_good).

This allows to use the function outside bisect.c.

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
---
 bisect.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index eaa85b6..7afd335 100644
--- a/bisect.c
+++ b/bisect.c
@@ -908,12 +908,11 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 }
 
 /*
- * The terms used for this bisect session are stored in
- * BISECT_TERMS: it can be bad/good or new/old.
- * We read them and store them to adapt the messages
- * accordingly. Default is bad/good.
+ * The terms used for this bisect session are stored in BISECT_TERMS.
+ * We read them and store them to adapt the messages accordingly.
+ * Default is bad/good.
  */
-void read_bisect_terms(void)
+void read_bisect_terms(const char **read_bad, const char **read_good)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path("BISECT_TERMS");
@@ -924,9 +923,9 @@ void read_bisect_terms(void)
 			strerror(errno));
 	} else {
 		strbuf_getline(&str, fp, '\n');
-		name_bad = strbuf_detach(&str, NULL);
+		*read_bad = strbuf_detach(&str, NULL);
 		strbuf_getline(&str, fp, '\n');
-		name_good = strbuf_detach(&str, NULL);
+		*read_good = strbuf_detach(&str, NULL);
 	}
 	strbuf_release(&str);
 	fclose(fp);
@@ -948,7 +947,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
-	read_bisect_terms();
+	read_bisect_terms(&name_bad, &name_good);
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
-- 
1.7.1
