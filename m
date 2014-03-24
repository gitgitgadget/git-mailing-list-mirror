From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 27/27] ref_transaction_commit(): Work with transaction->updates in place
Date: Mon, 24 Mar 2014 18:57:00 +0100
Message-ID: <1395683820-17304-28-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99D-0002Oo-AY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbaCXR6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:58:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:58427 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753863AbaCXR6F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:58:05 -0400
X-AuditID: 12074414-f79d96d000002d2b-8d-5330722c1d6a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 80.9E.11563.C2270335; Mon, 24 Mar 2014 13:58:04 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xx028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:58:02 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqKtTZBBs0DZN0GLnOgmLrivdTBYN
	vVeYLebd3cVkcXvFfGaLHy09zBYfOxcwO7B7/H3/gclj56y77B6XXn5n8/j4bDm7x7PePYwe
	Fy8pe3zeJBfAHsVtk5RYUhacmZ6nb5fAnfHkQANLQSdXxcld99gbGJs5uhg5OSQETCT2T3rE
	DmGLSVy4t56ti5GLQ0jgMqPEghU3WEASQgInmCQ+/g4AsdkEdCUW9TQzgdgiAmoSE9sOsYA0
	MAtcYZS48nE7WIOwQLTEkedvwaayCKhK7G5eDtbAK+AqMe/JCqhtchJTfi8AszmB4lvbDzND
	LHOR2PGxl2kCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCGhJ7KD
	8chJuUOMAhyMSjy8EcYGwUKsiWXFlbmHGCU5mJREedlygUJ8SfkplRmJxRnxRaU5qcWHGCU4
	mJVEeC3DgXK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8UwuBGgWL
	UtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP0N5akHbe4oLEXKAoROsp
	RkUpcd5rBUAJAZBERmke3FhYQnnFKA70pTDvfJB2HmAygut+BTSYCWhweJMeyOCSRISUVANj
	3T+1qn8LLmup3eGSjF2ml/trrkxiBcfbLOlNMYq8zayza351WOYfK1jLrbGVeeLUW+KzL2Zc
	CIqo1A07vDJdIPply/+Vq950Mkb13Lz7srpHRSS8M+CZwpXFux2/VP1JPjjV9fjP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244851>

Now that we free the transaction when we are done, there is no need to
make a copy of transaction->updates before working with it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 07f900a..aaf75f6 100644
--- a/refs.c
+++ b/refs.c
@@ -3410,19 +3410,17 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3477,7 +3475,6 @@ cleanup:
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
-	free(updates);
 	free(delnames);
 	ref_transaction_free(transaction);
 	return ret;
-- 
1.9.0
