From: mhagger@alum.mit.edu
Subject: [PATCH 13/17] cmd_fetch_pack: return early if finish_connect() returns an error
Date: Thu, 23 Aug 2012 10:10:38 +0200
Message-ID: <1345709442-16046-14-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:18:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Scv-0000Ua-UW
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933712Ab2HWISq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:46 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43995 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933708Ab2HWISk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:40 -0400
X-AuditID: 12074411-b7fa36d0000008cc-40-5035e5b94ef8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 41.D6.02252.9B5E5305; Thu, 23 Aug 2012 04:11:37 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVD030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:36 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLvzqWmAQeNZIYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xpGTT9kK
	rrBVnH/5iLWBcRVrFyMnh4SAicTDXT+hbDGJC/fWs3UxcnEICVxmlDh69QEThHOWSWLFh4fM
	IFVsAlISLxt72EFsEQE1iYlth1hAbGaBFImO592MILawQITEpr0XwKayCKhKXPg0C6yeV8BV
	Yuvrn8wQ2xQlfnxfA2ZzAsUXfN8E1isk4CLxsfEm8wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdE31cjNL9FJTSjcxQgJIcAfjjJNyhxgFOBiVeHhfmJsGCLEmlhVX5h5ilORgUhLl
	/fcIKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN3weUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0gg
	PbEkNTs1tSC1CCYrw8GhJMErCYwUIcGi1PTUirTMnBKENBMHJ4jgAtnAA7RBEaSQt7ggMbc4
	Mx2i6BSjopQ4rwlIQgAkkVGaBzcAFuuvGMWB/hHm5Qap4gGmCbjuV0CDmYAGq101BhlckoiQ
	kmpgTG785M1nllv5yOTiC6Fqttn3T8i5Lg2Mmqh82/4595Y3r7lvJt3fv8L3Sdwpo5/P0lmn
	TOJfw3OZu+1wf8jSK9kH/l040nt0hdXa+W/tutQDT9rJHG9qY25n4NNNPyOw7d5t5nKxKZrT
	XYudfmtJJBgdd2Rb9zVc/P7bjot7H17puPoiJ9BqtRJLcUaioRZzUXEiAHeonPrQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204123>

From: Michael Haggerty <mhagger@alum.mit.edu>

This simplifies the logic without changing the behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cc9af80..4794839 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1025,10 +1025,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	close(fd[0]);
 	close(fd[1]);
 	if (finish_connect(conn))
-		ref = NULL;
-	ret = !ref;
+		return 1;
 
-	if (!ret && nr_heads) {
+	ret = !ref;
+	if (ref && nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
-- 
1.7.11.3
