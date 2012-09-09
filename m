From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/14] filter_refs(): simplify logic
Date: Sun,  9 Sep 2012 08:19:45 +0200
Message-ID: <1347171589-13327-11-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatr-00032a-Fc
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab2IIGVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:23 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:53102 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752499Ab2IIGUr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:47 -0400
X-AuditID: 1207440c-b7f616d00000270b-be-504c353ed19c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 56.89.09995.E353C405; Sun,  9 Sep 2012 02:20:46 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIln029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:45 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqGtn6hNg8GWdpkXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M070RBfcE6j4PXs1awPjLp4uRk4OCQETiaM7PjND2GISF+6tZ+ti5OIQErjMKHH43R8o
	5wyTxPONK9lAqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQt0MUosX/cLrEhYwFzi4bOjYEUsAqoS
	Fw7PZQSxeQVcJY4v38kKsU5R4sf3NWCrOYHir2buBqsREnCR2LTzGusERt4FjAyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUJCimcH47d1MocYBTgYlXh4me94BwixJpYV
	V+YeYpTkYFIS5W3W8wkQ4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7lR0ox5uSWFmVWpQPk5Lm
	YFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4P1gDNQoWJSanlqRlplTgpBm4uAEEVwgG3iA
	NlwHKeQtLkjMLc5Mhyg6xagoJc77ECQhAJLIKM2DGwCL/leM4kD/CPOeAaniASYOuO5XQIOZ
	gAaLPPMAGVySiJCSamBkPHzQvOj1ur7+rfa3Ne/87zovv1Ru1qOCCanKBq/TH+jpK707fdpz
	8eI1i26LiihNOqT/nmvNVqaSNsE7j9wUHm8O1y/oqozYavM7SVq/YoaqcuLiZzmLZ2Rs5Viy
	fukekZtOVVlJz8IDXlxKLnjHwWvBkMR5VeBex8vOojkK2nc+KF1f2rpIiaU4I9FQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205060>

Simplify flow within loop: first decide whether to keep the reference,
then keep/free it.  This makes it clearer that each ref has exactly
two possible destinies, and removes duplication of the code for
appending the reference to the linked list.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4e94aa4..056ccb8 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -544,37 +544,36 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 
 	sought_pos = 0;
 	for (ref = *refs; ref; ref = next) {
+		int keep = 0;
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
 		    check_refname_format(ref->name + 5, 0))
 			; /* trash */
 		else if (args.fetch_all &&
-			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
-			*newtail = ref;
-			ref->next = NULL;
-			newtail = &ref->next;
-			continue;
-		}
+			 (!args.depth || prefixcmp(ref->name, "refs/tags/")))
+			keep = 1;
 		else {
-			int cmp = -1;
 			while (sought_pos < sought->nr) {
-				cmp = strcmp(ref->name, sought->items[sought_pos].string);
-				if (cmp < 0) /* definitely do not have it */
-					break;
-				else if (cmp == 0) { /* definitely have it */
+				int cmp = strcmp(ref->name, sought->items[sought_pos].string);
+				if (cmp < 0)
+					break; /* definitely do not have it */
+				else if (cmp == 0) {
+					keep = 1; /* definitely have it */
 					sought->items[sought_pos++].util = "matched";
-					*newtail = ref;
-					ref->next = NULL;
-					newtail = &ref->next;
 					break;
 				}
-				else /* might have it; keep looking */
-					sought_pos++;
+				else
+					sought_pos++; /* might have it; keep looking */
 			}
-			if (!cmp)
-				continue; /* we will link it later */
 		}
-		free(ref);
+
+		if (keep) {
+			*newtail = ref;
+			ref->next = NULL;
+			newtail = &ref->next;
+		} else {
+			free(ref);
+		}
 	}
 
 	if (!args.fetch_all)
-- 
1.7.11.3
