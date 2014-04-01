From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/22] try_merge_strategy(): remove redundant lock_file allocation
Date: Tue,  1 Apr 2014 17:58:10 +0200
Message-ID: <1396367910-7299-3-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV17C-0007cq-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbaDAP6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:58:42 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56966 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbaDAP6j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:39 -0400
X-AuditID: 1207440d-f79d86d0000043db-9e-533ae22e497d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.07.17371.E22EA335; Tue,  1 Apr 2014 11:58:38 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWb6027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:37 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqKv3yCrY4N4zC4uuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3x5ukH5oLT7BXPPrSzNDBOYeti5OSQEDCR2LbsFjOELSZx4d56sLiQwGVGiQ+ryroY
	uYDsY0wSG28vBEuwCehKLOppZgKxRQTUJCa2HWIBsZkFUiRe/d0FZgsLBEks2PGDFcRmEVCV
	+LBpCiOIzSvgLLHxwG8miGVyElN+L2AHsTkFXCQuPdjDCrHYWeL0m8XMExh5FzAyrGKUS8wp
	zdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICSneHYz/18kcYhTgYFTi4T143ipYiDWx
	rLgy9xCjJAeTkijvj7tAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8s24C5XhTEiurUovyYVLS
	HCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzXHgA1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxIMiI74YGBsgKR6gvStB2nmLCxJzgaIQracYFaXEeUMeAiUEQBIZpXlwY2GJ
	4hWjONCXwrybQNp5gEkGrvsV0GAmoMHc68AGlyQipKQaGKdtzLn4WGWCvnbfFd+TN1xlv1+e
	atCszHfg/pb/t80PnJRgiuJZfJ6zp6ftoRtHa1K7l0rADaf1L/b84j69bl1QZW6p4trzxWc/
	Zmv7OFQa609fljH5RS4Dw2sdqSLOO5tXvaj5s3bD1a3OvcfDj6zOnNe8bAsDwxnb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245612>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block used to shadow the
"lock" variable at function scope, so the only change needed is to
remove the inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e15d0e1..f714961 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -671,7 +671,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int index_fd;
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
-- 
1.9.0
