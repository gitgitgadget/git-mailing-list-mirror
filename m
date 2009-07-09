From: Matthias Andree <matthias.andree@gmx.de>
Subject: [PATCH] Fix export_marks() error handling.
Date: Thu,  9 Jul 2009 15:28:01 +0200
Message-ID: <1247146081-4692-1-git-send-email-matthias.andree@gmx.de>
References: <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302>
Cc: Matthias Andree <matthias.andree@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 15:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOtwg-0002Wd-Ka
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 15:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036AbZGINps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 09:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759070AbZGINpr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 09:45:47 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:64960 "EHLO
	mail.uni-paderborn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758578AbZGINpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 09:45:46 -0400
X-Greylist: delayed 1047 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2009 09:45:46 EDT
Received: from balu.cs.uni-paderborn.de ([131.234.21.37])
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63 spheron)
	id 1MOtfc-0000aU-Hk; Thu, 09 Jul 2009 15:28:17 +0200
Received: from mandree by balu.cs.uni-paderborn.de with local (Exim 4.69)
	(envelope-from <mandree@balu.cs.uni-paderborn.de>)
	id KMIO32-0004BS-QH; Thu, 09 Jul 2009 15:28:15 +0200
X-Mailer: git-send-email 1.6.3.3.385.g60647
In-Reply-To: <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302>
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594, Antispam-Data: 2009.7.9.132121
X-IMT-Authenticated-Sender: uid=mandree,ou=People,o=upb,c=de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122974>

- Don't leak one FILE * on error per export_marks() call. Found with
  cppcheck and reported by Martin Ettl.

- Abort the potentially long for(;idnums.size;) loop on write errors.

- Add a trailing full-stop to error message when fopen() fails.

Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
---
 builtin-fast-export.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 9a8a6fc..6c0956d 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -428,21 +428,30 @@ static void export_marks(char *file)
 	uint32_t mark;
 	struct object_decoration *deco = idnums.hash;
 	FILE *f;
+	int e;
 
 	f = fopen(file, "w");
 	if (!f)
-		error("Unable to open marks file %s for writing", file);
+		error("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
 			mark = ptr_to_mark(deco->decoration);
-			fprintf(f, ":%"PRIu32" %s\n", mark,
+			e = fprintf(f, ":%"PRIu32" %s\n", mark,
 				sha1_to_hex(deco->base->sha1));
+			if (e < 0) break;
 		}
 		deco++;
 	}
 
-	if (ferror(f) || fclose(f))
+	/* do not optimize the next two lines - they must both be executed in
+	 * this order. || might short-circuit the fclose(), and combining them
+	 * into one statement might reverse the order of execution.
+	 * Also, fflush() may not be sufficient - on some file systems, the
+	 * error is still delayed until the final [f]close().  */
+	e  = ferror(f);
+	e |= fclose(f);
+	if (e)
 		error("Unable to write marks file %s.", file);
 }
 
-- 
1.6.3.3.385.g60647
