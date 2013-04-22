From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 31/33] pack_one_ref(): do some cheap tests before a more expensive one
Date: Mon, 22 Apr 2013 21:52:39 +0200
Message-ID: <1366660361-21831-32-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMwG-0007fY-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab3DVUBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:42 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63503 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755111Ab3DVUBi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:38 -0400
X-AuditID: 12074412-b7f216d0000008d4-7d-517595633327
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B3.8F.02260.36595715; Mon, 22 Apr 2013 15:54:11 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOi008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:10 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqJs8tTTQ4H+nokXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfMaetjL/jFUXHz4nq2Bsb5
	7F2MnBwSAiYS2x6tY4OwxSQu3FsPZgsJXGaUaJvrDGFfYJL4cs0PxGYT0JVY1NPMBGKLCKhJ
	TGw7xAJiMws4SGz+3MgIYgsLREpsaHoFZrMIqEqcvniSFcTmFXCV2Ln7E9QuBYnj27eB1XAC
	xU93nGCB2OUiseLgVJYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRu
	YoQEitAOxvUn5Q4xCnAwKvHwCriXBgqxJpYVV+YeYpTkYFIS5eWYAhTiS8pPqcxILM6ILyrN
	SS0+xCjBwawkwiuaD5TjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLg
	/TYZqFGwKDU9tSItM6cEIc3EwQkiuEA28ABtkAfZzltckJhbnJkOUXSKUVFKnNdtElBCACSR
	UZoHNwAW068YxYH+EeblA2nnAaYDuO5XQIOZgAZnJpSADC5JREhJNTB6Gt66a3ZX4cSeQ2vM
	c2vXFtV1GdUu/7/voPKKk/URuwJ4lkifNvjakRRu/eI4p0Xq6ifeiuzfP4Sd3hZ3WPvr22bB
	mzruSf2nzi1N7Xn4Z8qtmLWbJz4X0dKqcjikmvj6u/9tzp9rj99/OUfMar3OCXFNPkOnBa2/
	bz5rtElxbt+zaTZX+szTSizFGYmGWsxFxYkAt1CDpcQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222082>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index df670cb..b1cda1b 100644
--- a/refs.c
+++ b/refs.c
@@ -2007,18 +2007,17 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
 	enum peel_status peel_status;
-	int is_tag_ref;
-
-	/* Do not pack symbolic or broken refs: */
-	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
-		return 0;
-	is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
+	int is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref &&
 	    !(entry->flag & REF_ISPACKED))
 		return 0;
 
+	/* Do not pack symbolic or broken refs: */
+	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
+		return 0;
+
 	peel_status = peel_entry(entry, 1);
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
-- 
1.8.2.1
