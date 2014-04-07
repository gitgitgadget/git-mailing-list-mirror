From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 27/27] ref_transaction_commit(): work with transaction->updates in place
Date: Mon,  7 Apr 2014 15:48:18 +0200
Message-ID: <1396878498-19887-28-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vd-0003AS-Pw
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbaDGNtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:32 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44184 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755322AbaDGNtR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:49:17 -0400
X-AuditID: 12074413-f79076d000002d17-dc-5342acdc6054
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 63.88.11543.CDCA2435; Mon,  7 Apr 2014 09:49:16 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaY026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:49:14 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqHtnjVOwwZTFihY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxlz26xFXRyVfw4/5y1gbGZo4uRg0NCwETi9ZvI
	LkZOIFNM4sK99WxdjFwcQgKXGSV+d/1nhHCOMUlMf9HCAlLFJqArsainmQnEFhFQk5jYdogF
	pIhZ4AqjxJWP28GKhAWiJb6/O8gIsoFFQFXi4AJ2kDCvgKvEvxv32SC2yUmcPDaZFcTmBIrP
	OHSLEcQWEnCRuL/mGMsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3
	MUICT3gH466TcocYBTgYlXh4Vx5yDBZiTSwrrsw9xCjJwaQkyvt8mVOwEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRFertVAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eS
	BO96kEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7R3Ltje4oLE
	XKAoROspRkUpcd4SkIQASCKjNA9uLCydvGIUB/pSmPc5SBUPMBXBdb8CGswENNjQFWxwSSJC
	SqqBUbfo7WT+E3OOrQ5jMVv75JdMiyff6644zpjdTzjdw36a3XoZZGolzi7W3uoo/+1yUHTd
	46qY07Iryualvl8QWTtpx+FmJvcI9soo/VMLE9UdJp2wnH3j6Ia/iy2MV20pvL5/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245852>

Now that we free the transaction when we are done, there is no need to
make a copy of transaction->updates before working with it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c058f30..728a761 100644
--- a/refs.c
+++ b/refs.c
@@ -3413,19 +3413,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
-	struct ref_update **updates;
 	const char **delnames;
 	int n = transaction->nr;
+	struct ref_update **updates = transaction->updates;
 
 	if (!n)
 		return 0;
 
 	/* Allocate work space */
-	updates = xmalloc(sizeof(*updates) * n);
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
-	memcpy(updates, transaction->updates, sizeof(*updates) * n);
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
 	ret = ref_update_reject_duplicates(updates, n, onerr);
 	if (ret)
@@ -3480,7 +3478,6 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(updates);
 	free(delnames);
 	ref_transaction_free(transaction);
 	return ret;
-- 
1.9.1
