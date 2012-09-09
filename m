From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/14] filter_refs(): build refs list as we go
Date: Sun,  9 Sep 2012 08:19:44 +0200
Message-ID: <1347171589-13327-10-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatg-0002rp-6K
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab2IIGVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:22 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61151 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752489Ab2IIGUo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:44 -0400
X-AuditID: 12074412-b7f216d0000008e3-da-504c353cc60e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 51.9B.02275.C353C405; Sun,  9 Sep 2012 02:20:44 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlm029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:43 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqGtj6hNgsLZNwaLrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGatfP2IvmClc8batk6WB8T1fFyMnh4SAicT9mQtZIGwxiQv31rN1MXJxCAlcZpR492Ml
	E4Rzhkmic+ViRpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMAl2MEsvX/WIDSQgLOEos//iCGcRm
	EVCVePr0I1icV8BVYsv5DWwQ6xQlfnxfA1bDCRR/NXM32AIhAReJTTuvsU5g5F3AyLCKUS4x
	pzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIySohHYwrj8pd4hRgINRiYeX5Y53gBBr
	YllxZe4hRkkOJiVRXg0TnwAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxX2YFyvCmJlVWpRfkw
	KWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvMYgQwWLUtNTK9Iyc0oQ0kwcnCCCC2QD
	D9CGYJBC3uKCxNzizHSIolOMilLivGUgCQGQREZpHtwAWPy/YhQH+keY1xmkigeYOuC6XwEN
	ZgIaLPLMA2RwSSJCSqqBcdY/l6/F6/dYdS2Mn3RQ5+3unWqrTLJPTZZ9k/tGaOrUJWwLo68q
	LPO7xKuvKWu97XXH6u2iFz+Jrp0vsfSiSMAWi50n2tM+cv+xKxY52nxzsuLWsOCc1/J2Dmtq
	39nOcXj2wOz/1i2ZvQ3WyuJXts/hDXdg352S+n7jq8wVAb/ycxSdI3yez1BiKc5I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205055>

Instead of temporarily storing matched refs to temporary array
"return_refs", simply append them to newlist as we go.  This changes
the order of references in newlist to strictly sorted if "--all" and
"--depth" and named references are all specified, but that usage is
broken anyway (see the last two tests in t5500).

This changes the last test in t5500 from segfaulting into just
emitting a spurious error (this will be fixed in a moment).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 12ba009..4e94aa4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -537,24 +537,11 @@ static int non_matching_ref(struct string_list_item *item, void *unused)
 
 static void filter_refs(struct ref **refs, struct string_list *sought)
 {
-	struct ref **return_refs;
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	struct ref *fastarray[32];
 	int sought_pos;
 
-	if (sought->nr && !args.fetch_all) {
-		if (ARRAY_SIZE(fastarray) < sought->nr)
-			return_refs = xcalloc(sought->nr, sizeof(struct ref *));
-		else {
-			return_refs = fastarray;
-			memset(return_refs, 0, sizeof(struct ref *) * sought->nr);
-		}
-	}
-	else
-		return_refs = NULL;
-
 	sought_pos = 0;
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
@@ -575,8 +562,10 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					return_refs[sought_pos] = ref;
 					sought->items[sought_pos++].util = "matched";
+					*newtail = ref;
+					ref->next = NULL;
+					newtail = &ref->next;
 					break;
 				}
 				else /* might have it; keep looking */
@@ -588,20 +577,8 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 		free(ref);
 	}
 
-	if (!args.fetch_all) {
-		int i;
-		for (i = 0; i < sought->nr; i++) {
-			ref = return_refs[i];
-			if (ref) {
-				*newtail = ref;
-				ref->next = NULL;
-				newtail = &ref->next;
-			}
-		}
-		if (return_refs != fastarray)
-			free(return_refs);
+	if (!args.fetch_all)
 		filter_string_list(sought, 0, non_matching_ref, NULL);
-	}
 	*refs = newlist;
 }
 
-- 
1.7.11.3
