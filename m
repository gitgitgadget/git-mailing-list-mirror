From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/12] delete_ref(): handle special case more explicitly
Date: Sat, 13 Jun 2015 16:42:06 +0200
Message-ID: <0c66a6bd6e49b9c28fa3617ee50de746ef4ea9a3.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3mdy-0007iJ-8H
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbbFMOmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:31 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51525 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176AbbFMOmY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:24 -0400
X-AuditID: 1207440f-f79236d000000c5e-00-557c414e13cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B5.CF.03166.E414C755; Sat, 13 Jun 2015 10:42:22 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpR026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:21 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOvnWBNq0HHP2KLrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGQeP1Rf0cVVsbZ/D3sDYw9HFyMkhIWAi8f7sHCYIW0ziwr31bF2MXBxCApcZJX68384I
	4ZxgkpjVe5oVpIpNQFdiUU8zWIeIgJrExLZDLCBFzAIdjBIXlm9jB0kIC3hLnJnbygZiswio
	SlyZdIwFxOYViJI4suo2I8Q6OYnzx38ydzFycHAKWEi8bMoECQsJmEu8XdHOOoGRdwEjwypG
	ucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkIDi38HYtV7mEKMAB6MSD29GbHWo
	EGtiWXFl7iFGSQ4mJVHeyD1AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8gto1oUK8KYmVValF
	+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQnea/ZAjYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgyIgvBsYGSIoHaO9DkHbe4oLEXKAoROspRkUpcd5bIAkBkERGaR7c
	WFiaeMUoDvSlMK+HA1AVDzDFwHW/AhrMBDS4vacKZHBJIkJKqoEx9fESXo30T/kbbnnkbK3X
	3/tLlZHjRJYs+15Xpw7D2Je/7F+eO8ki6FVyzpKled61aA0ldov6om8l7N2p3DGpbNcdPxg9
	+PtswaH3Bqf1G8S9Nc95ix6sOcp2ca5PeXQCg5FGv2eUZF8V17/QRKkCljmRaWbl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271547>

delete_ref() uses a different convention for its old_sha1 parameter
than, say, ref_transaction_delete(): NULL_SHA1 means not to check the
old value. Make this fact a little bit clearer in the code by handling
it in explicit, commented code rather than burying it in a conditional
expression.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b575bb8..f0b6cec 100644
--- a/refs.c
+++ b/refs.c
@@ -2795,10 +2795,17 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
+	/*
+	 * Treat NULL_SHA1 and NULL alike, to mean "we don't care what
+	 * the old value of the reference was (or even if it didn't
+	 * exist)":
+	 */
+	if (old_sha1 && is_null_sha1(old_sha1))
+		old_sha1 = NULL;
+
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname,
-				   (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
+	    ref_transaction_delete(transaction, refname, old_sha1,
 				   flags, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
-- 
2.1.4
