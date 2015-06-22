From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/19] delete_refs(): bail early if the packed-refs file cannot be rewritten
Date: Mon, 22 Jun 2015 16:02:57 +0200
Message-ID: <28505bdd95dc4da84bef1afc709a51d99718a5ad.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72K5-0005Z7-4B
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933544AbbFVODd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50631 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933182AbbFVOD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:27 -0400
X-AuditID: 12074414-f794f6d000007852-23-558815aa0b8b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 99.0D.30802.AA518855; Mon, 22 Jun 2015 10:03:23 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc4030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:21 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLtatCPUYKqWRdeVbiaLht4rzBa3
	V8xntvjR0sNssXlzO4sDq8ff9x+YPBZsKvV41ruH0ePiJWWPz5vkAlijuG2SEkvKgjPT8/Tt
	Ergz3m/5xlJwh7fi74qtrA2Mj7i6GDk5JARMJF7MfMIOYYtJXLi3nq2LkYtDSOAyo8Txx43M
	EM5JJolp0+czg1SxCehKLOppZgKxRQTUJCa2HWIBKWIW6GCUuLB8G9goYYF4icfv74HZLAKq
	Entbv7OC2LwCURJnf99ghFgnJ3H++E+woZwCFhLz9/0HqxcSMJeYOPMRywRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQkJKZAfjkZNyhxgFOBiVeHgdbNtDhVgT
	y4orcw8xSnIwKYnyHngNFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC23IWKMebklhZlVqUD5OS
	5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJMHrJ9IRKiRYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPio74YmB8gKR4gPaagLTzFhck5gJFIVpPMSpKifP6gyQEQBIZpXlwY2GJ
	4hWjONCXwrzFIFU8wCQD1/0KaDAT0OAvuW0gg0sSEVJSDYw+vufetXqwblm6yEXJ946vnbZk
	6hWbg3Nb37K7SNrVxAfvm37pY6PKn7Pfru7TVjjHMPHMU+lf1gq61ksmyT5TcLCKjQqzuCX2
	RnIW7+zNzxhfXzv5jE2NOS3hydSAaUeL7rPtjLKIZNB5fuiqR5tMueZp+Yvz55qa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272344>

If we fail to delete the doomed references from the packed-refs file,
then it is unsafe to delete their loose references, because doing so
might expose a value from the packed-refs file that is obsolete and
perhaps even points at an object that has been garbage collected.

So if repack_without_refs() fails, emit a more explicit error message
and bail.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 5386077..19afc4d 100644
--- a/refs.c
+++ b/refs.c
@@ -2823,9 +2823,26 @@ int delete_refs(struct string_list *refnames)
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
-	if (repack_without_refs(refnames, &err))
-		result |= error("%s", err.buf);
-	strbuf_release(&err);
+	if (!refnames->nr)
+		return 0;
+
+	result = repack_without_refs(refnames, &err);
+	if (result) {
+		/*
+		 * If we failed to rewrite the packed-refs file, then
+		 * it is unsafe to try to remove loose refs, because
+		 * doing so might expose an obsolete packed value for
+		 * a reference that might even point at an object that
+		 * has been garbage collected.
+		 */
+		if (refnames->nr == 1)
+			error(_("could not delete reference %s: %s"),
+			      refnames->items[0].string, err.buf);
+		else
+			error(_("could not delete references: %s"), err.buf);
+
+		goto out;
+	}
 
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
@@ -2834,6 +2851,8 @@ int delete_refs(struct string_list *refnames)
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
+out:
+	strbuf_release(&err);
 	return result;
 }
 
-- 
2.1.4
