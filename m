From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 26/26] commit_ref_transaction(): Work with transaction->updates in place
Date: Mon, 10 Mar 2014 13:46:43 +0100
Message-ID: <1394455603-2968-27-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcY-00082d-Et
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbaCJMrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54286 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752930AbaCJMrl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:41 -0400
X-AuditID: 1207440c-f79656d000003eba-44-531db46c9284
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C2.6E.16058.C64BD135; Mon, 10 Mar 2014 08:47:40 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwo025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:38 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqJuzRTbY4PpheYud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8an3lvsBZ1cFSt+rmVsYGzm6GLk5JAQMJH49P47
	K4QtJnHh3nq2LkYuDiGBy4wS7XN6WSGcE0wSJ+/OAqtiE9CVWNTTzARiiwioSUxsO8QCUsQs
	cIVR4vPXX+wgCWGBCInG3VfAbBYBVYmb/etYQGxeAReJv60LodbJSUz5vQCshhMoPv3KAzBb
	SMBZ4uWeZtYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluilppRuYoQEH88O
	xm/rZA4xCnAwKvHwHngrEyzEmlhWXJl7iFGSg0lJlHfiWtlgIb6k/JTKjMTijPii0pzU4kOM
	EhzMSiK8mYuBcrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd5/m4Ea
	BYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHREV8MjA+QFA/QXv0tIHuLCxJzgaIQ
	racYFaXEeeeAzBUASWSU5sGNhaWUV4ziQF8K85qCtPMA0xFc9yugwUxAg5uPS4EMLklESEk1
	MPqkFc6UCz7AlGQovjK7p2hqkJVoHdsE3tO2UVMfBzYuzuV8a8AlxswgdtyhX+5z9SHGp7u+
	l7U7vmEq/ilQsHpafioL97V9gaJL2DrmWefbbn3dMGNmNbtNwYTZVf9bikONdjP8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243745>

Now that we free the transaction when we are done, there is no need to
make a copy of transaction->updates before working with it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index d83fc7b..ea33adc 100644
--- a/refs.c
+++ b/refs.c
@@ -3402,19 +3402,17 @@ int commit_ref_transaction(struct ref_transaction *transaction,
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
@@ -3469,7 +3467,6 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(updates);
 	free(delnames);
 	free_ref_transaction(transaction);
 	return ret;
-- 
1.9.0
