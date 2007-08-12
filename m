From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Sun, 12 Aug 2007 22:34:35 +0200
Message-ID: <118695087531-git-send-email-prohaska@zib.de>
References: <11869508753328-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: gitster@pobox.com, dmitry.kakurin@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 12 22:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKK99-00037K-6v
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbXHLUep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757808AbXHLUen
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:34:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:52553 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757300AbXHLUel (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 16:34:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CKYabq004079;
	Sun, 12 Aug 2007 22:34:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CKYZsu018009;
	Sun, 12 Aug 2007 22:34:35 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11869508753328-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55722>

We need to check out .gitattributes files first to have
them in place when we check out the remaining files. This
is needed to get the right attributes during checkout,
for example having the right crlf conversion on the first
checkout if crlf is controlled by a .gitattribute file.

This works only together with the commit

'attr: fix attribute handling if .gitattributes is involved'

which ensures that .gitattributes files do not trigger the
attribute machinery too early.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-checkout-index.c |   47 ++++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 75377b9..5e87a39 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -125,27 +125,38 @@ static int checkout_file(const char *name, int prefix_length)
 
 static void checkout_all(const char *prefix, int prefix_length)
 {
-	int i, errs = 0;
+	int i, pass, errs = 0;
 	struct cache_entry* last_ce = NULL;
 
-	for (i = 0; i < active_nr ; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce) != checkout_stage
-		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
-			continue;
-		if (prefix && *prefix &&
-		    (ce_namelen(ce) <= prefix_length ||
-		     memcmp(prefix, ce->name, prefix_length)))
-			continue;
-		if (last_ce && to_tempfile) {
-			if (ce_namelen(last_ce) != ce_namelen(ce)
-			    || memcmp(last_ce->name, ce->name, ce_namelen(ce)))
-				write_tempfile_record(last_ce->name, prefix_length);
+	/* pass 0: check out only .gitattribute files
+	   pass 1: check out every file
+
+	   This is needed to have all .gitattributes in place before
+	   checking out files, and thus do the right conversion.
+	 */
+	for (pass = 0; pass < 2; pass++) {
+		for (i = 0; i < active_nr ; i++) {
+			struct cache_entry *ce = active_cache[i];
+			if (pass == 0 && strstr (ce->name, GITATTRIBUTES_FILE) == 0) {
+			    continue;
+			}
+			if (ce_stage(ce) != checkout_stage
+			    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
+				continue;
+			if (prefix && *prefix &&
+			    (ce_namelen(ce) <= prefix_length ||
+			     memcmp(prefix, ce->name, prefix_length)))
+				continue;
+			if (last_ce && to_tempfile) {
+				if (ce_namelen(last_ce) != ce_namelen(ce)
+				    || memcmp(last_ce->name, ce->name, ce_namelen(ce)))
+					write_tempfile_record(last_ce->name, prefix_length);
+			}
+			if (checkout_entry(ce, &state,
+			    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+				errs++;
+			last_ce = ce;
 		}
-		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
-			errs++;
-		last_ce = ce;
 	}
 	if (last_ce && to_tempfile)
 		write_tempfile_record(last_ce->name, prefix_length);
-- 
1.5.3.rc4.96.g6ceb
