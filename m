From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/14] handle_revision_opt(): use convert_ui() when handling "--abbrev="
Date: Tue, 17 Mar 2015 17:00:09 +0100
Message-ID: <1426608016-2978-8-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvB-00015M-0S
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbbCQQAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:37 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45531 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754324AbbCQQAb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:31 -0400
X-AuditID: 1207440e-f79bc6d000000c43-ab-55084f9f2260
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.AD.03139.F9F48055; Tue, 17 Mar 2015 12:00:31 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSi023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:30 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqDvfnyPU4NdlTouuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZ3VP2sRS8
	Yas49p+zgfE0axcjJ4eEgInE3UOr2SBsMYkL99YD2VwcQgKXGSWOHp3KCOGcZJI4vuQFWAeb
	gK7Eop5mJhBbREBNYmLbIRYQm1kgRaLzzx12EFtYIEJi+o05YDUsAqoS27bNAqvhFXCWmDZh
	LtQ2OYnzx38yg9icAi4SL/68ZgSxhYBq1k6bzDaBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTE
	vLzUIl1jvdzMEr3UlNJNjJDg4dvB2L5e5hCjAAejEg9vQx57qBBrYllxZe4hRkkOJiVR3jwP
	jlAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrx33IFyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJ
	JanZqakFqUUwWRkODiUJ3uV+QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoMiI
	LwbGBkiKB2jvJ5B23uKCxFygKETrKUZdjjtT/i9iEmLJy89LlRLnnQ9SJABSlFGaB7cClipe
	MYoDfSzMOwekigeYZuAmvQJawgS0pKWdDWRJSSJCSqqB0bXjyFOVmZPVDzUFz/H6ufidY9Y7
	2ccmYmnTuSfLGxhvmBtRIL6oynqppVMS7/p205jomobDa2M+nUx+8HbjK941tVc/+CXExavc
	kZPy27Lt4LcDlcdWSjoUcpuuO1O71+2hY37cBr+0///fum5jKTSYHftnjdhp148a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265638>

This adds error checking, where previously there was none. It also
disallows '+' and '-', leading whitespace, and trailing junk.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 4908e66..a6f7c2e 100644
--- a/revision.c
+++ b/revision.c
@@ -1963,7 +1963,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &arg)) {
-		revs->abbrev = strtoul(arg, NULL, 10);
+		if (convert_ui(arg, 10, &revs->abbrev))
+			die("--abbrev requires a non-negative integer argument");
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
 		else if (revs->abbrev > 40)
-- 
2.1.4
