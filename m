From: Matthias Andree <matthias.andree@gmx.de>
Subject: [PATCH] Fix export_marks() error handling.
Date: Fri, 24 Jul 2009 10:17:13 +0200
Message-ID: <1248423433-25407-1-git-send-email-matthias.andree@gmx.de>
References: <7v7hxyyfcg.fsf@alter.siamese.dyndns.org>
Cc: Matthias Andree <matthias.andree@gmx.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 24 10:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUFy6-0006AH-Bm
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 10:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbZGXIRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 04:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbZGXIRU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 04:17:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:54665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750796AbZGXIRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 04:17:19 -0400
Received: (qmail invoked by alias); 24 Jul 2009 08:17:18 -0000
Received: from g227137127.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.227.137.127]
  by mail.gmx.net (mp055) with SMTP; 24 Jul 2009 10:17:18 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX183qQg0xT83bchDo+WtFOnJO0Up81tCYTFTR3qPkA
	7FdIn3rd1locYf
Received: by merlin.emma.line.org (Postfix, from userid 1000)
	id 0434294C41; Fri, 24 Jul 2009 10:17:16 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3.413.g91e7
In-Reply-To: <7v7hxyyfcg.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123908>

- Don't leak one FILE * on error per export_marks() call. Found with
  cppcheck and reported by Martin Ettl.

- Abort the potentially long for(;idnums.size;) loop on write errors.

- Record error if fprintf() fails for reasons not required to set the
  stream error indicator, such as ENOMEM.

- Add a trailing full-stop to error message when fopen() fails.

Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
---
 builtin-fast-export.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 9a8a6fc..ca19825 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -428,21 +428,27 @@ static void export_marks(char *file)
 	uint32_t mark;
 	struct object_decoration *deco = idnums.hash;
 	FILE *f;
+	int e = 0;
 
 	f = fopen(file, "w");
 	if (!f)
-		error("Unable to open marks file %s for writing", file);
+		error("Unable to open marks file %s for writing.", file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
 			mark = ptr_to_mark(deco->decoration);
-			fprintf(f, ":%"PRIu32" %s\n", mark,
-				sha1_to_hex(deco->base->sha1));
+			if (fprintf(f, ":%"PRIu32" %s\n", mark,
+				sha1_to_hex(deco->base->sha1)) < 0) {
+			    e = 1;
+			    break;
+			}
 		}
 		deco++;
 	}
 
-	if (ferror(f) || fclose(f))
+	e |= ferror(f);
+	e |= fclose(f);
+	if (e)
 		error("Unable to write marks file %s.", file);
 }
 
-- 
1.6.3.3.413.g91e7
