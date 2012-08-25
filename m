From: mhagger@alum.mit.edu
Subject: [PATCH v2 11/17] filter_refs(): do not leave gaps in return_refs
Date: Sat, 25 Aug 2012 08:44:21 +0200
Message-ID: <1345877067-11841-12-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5AGc-0004TT-Ny
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab2HYGyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:54:41 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:56612 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753526Ab2HYGyj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:54:39 -0400
X-AuditID: 1207440d-b7f236d000000943-b9-5038748284ca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.13.02371.28478305; Sat, 25 Aug 2012 02:45:22 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSm011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:21 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqNtUYhFgsKNbx6LrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGd/bH7AWdPFX7Dp5hrGBcR93FyMHh4SAicTV86ldjJxAppjEhXvr2boYuTiEBC4zSqz7
	2sgMkhASOMskcWKNK4jNJiAl8bKxhx3EFhFQk5jYdogFpIFZoItRYvm6X2wgCWEBT4mFixYz
	gtgsAqoSX1b2MIHYvAKuErcXnWSF2KYo8eP7GrAFnEDxCb8uskMsc5FoOnaFZQIj7wJGhlWM
	cok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIQHFu4Px/zqZQ4wCHIxKPLw3zpgH
	CLEmlhVX5h5ilORgUhLlFSu0CBDiS8pPqcxILM6ILyrNSS0+xCjBwawkwvudASjHm5JYWZVa
	lA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg3VMM1ChYlJqeWpGWmVOCkGbi4AQR
	XCAbeIA2zAcp5C0uSMwtzkyHKDrFqCglznsKJCEAksgozYMbAIv9V4ziQP8I884sAqriAaYN
	uO5XQIOZgAaXu5qDDC5JREhJNTC6Rf0ScE4wUl0VfG1SE0f1nVSl7+p3Wktv5shMjVt7RXDZ
	93t/HUV6OP0P1G572y3RmneywI5duv7dwqjrKYcv2deeed17bMvX1Z2HPzRsX/XGvbbChmeD
	+8OPVVmt1ROabjPEFHtemdapy5pqJrn4K/+mY+XBm0/xKz48oXLrgJxDb7UIxzMl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204266>

From: Michael Haggerty <mhagger@alum.mit.edu>

It used to be that this function processed refnames in some arbitrary
order but wanted to return them in the order that they were requested,
not the order that they were processed.  Now, the refnames are
processed in sorted order, so there is no reason to go to the extra
effort.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index ca1ddd9..a995357 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -527,14 +527,13 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	int head_pos;
+	int head_pos = 0, matched = 0;
 
 	if (*nr_heads && !args.fetch_all)
 		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
 	else
 		return_refs = NULL;
 
-	head_pos = 0;
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
@@ -554,7 +553,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					return_refs[head_pos] = ref;
+					return_refs[matched++] = ref;
 					heads[head_pos++][0] = '\0';
 					break;
 				}
@@ -569,13 +568,11 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 
 	if (!args.fetch_all) {
 		int i;
-		for (i = 0; i < *nr_heads; i++) {
+		for (i = 0; i < matched; i++) {
 			ref = return_refs[i];
-			if (ref) {
-				*newtail = ref;
-				ref->next = NULL;
-				newtail = &ref->next;
-			}
+			*newtail = ref;
+			ref->next = NULL;
+			newtail = &ref->next;
 		}
 		free(return_refs);
 	}
-- 
1.7.11.3
