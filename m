From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/25] fetch: make own copies of refnames
Date: Sat, 25 May 2013 11:08:01 +0200
Message-ID: <1369472904-12875-3-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAVH-0006EK-1N
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab3EYJJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:05 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:52887 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752314Ab3EYJIz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:08:55 -0400
X-AuditID: 1207440d-b7fd06d000000905-6a-51a07fa77426
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.12.02309.7AF70A15; Sat, 25 May 2013 05:08:55 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guc000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:08:53 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqLu8fkGgwY193BZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzvi45yhbwQTOigWXexkbGE+ydzFycEgImEi0L8rpYuQEMsUkLtxb
	z9bFyMUhJHCZUWJLw0x2COcCk0TTy7VsIFVsAroSi3qamUBsEQFHiRMPrrOCFDEL9DJKPHz0
	HSwhLGAjcfDTK2aQDSwCqhLHVtaBhHkFXCRmH//HCLFNQeLyrDVgJZwCrhJvT3CChIWASp5/
	Osc6gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQIOPdwfh/ncwh
	RgEORiUe3h0l8wOFWBPLiitzDzFKcjApifLy1y4IFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	y5AClONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfB61AE1ChalpqdW
	pGXmlCCkmTg4QQQXyAYeoA2BIIW8xQWJucWZ6RBFpxgVpcR5J4IkBEASGaV5cANg6eAVozjQ
	P8K8KSBVPMBUAtf9CmgwE9Dgm7nzQQaXJCKkpBoYNS1M2c8Gz33QwJzPrrcjdnPiylMzmw3T
	pKJO312SHL+S2V1l590eg7PX9B01I3cWzF997ZYYw549Nabl/kwTF23kM/zGtifj7R1pqb9z
	rqr9279JUMorWldj9wPnZQbi387tXyvdvO75ubq2G2JByzonr7uSoJbWsJrhHPe9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225515>

Do not retain references to refnames passed to the each_ref_fn
callback add_existing(), because their lifetime is not guaranteed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..f949115 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -590,7 +590,7 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
@@ -693,7 +693,7 @@ static int truncate_fetch_head(void)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
-- 
1.8.2.3
