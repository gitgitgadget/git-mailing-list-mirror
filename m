From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/13] delete_ref(): handle special case more explicitly
Date: Mon,  8 Jun 2015 13:45:37 +0200
Message-ID: <1a8670c63b4e8b3b2f99d0e1acbb18162111f166.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVF-00054K-AF
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbFHLqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:02 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49628 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752319AbbFHLp6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:45:58 -0400
X-AuditID: 1207440d-f79026d000000bad-26-55758074941e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D8.5E.02989.47085755; Mon,  8 Jun 2015 07:45:56 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop0017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:55 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqFvSUBpqcL5F06LrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGadvbmctmMpZ8WvBRfYGxq3sXYycHBICJhKNB1azQNhiEhfurWfrYuTiEBK4zCjx49ds
	sCIhgRNMEle+5oDYbAK6Eot6mplAbBEBNYmJbYdYQBqYBToYJS4s3wbWICzgIfG6extYEYuA
	qkTvocPMIDavQJTE+f2f2CC2yUmcP/4TLM4pYCFx9/8FNohl5hIft7UzTmDkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10gvN7NELzWldBMjJKR4dzD+XydziFGAg1GJh/fAopJQIdbE
	suLK3EOMkhxMSqK8XWWloUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJksgHK8KYmVValF+TAp
	aQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQnej3VAjYJFqempFWmZOSUIaSYOTpDhXFIi
	xal5KalFiaUlGfGg2IgvBkYHSIoHaK9KPcje4oLEXKAoROspRkUpcd7HIHMFQBIZpXlwY2GJ
	4hWjONCXwrzZIO08wCQD1/0KaDAT0ODvX4tBBpckIqSkGhhbtzrtPB3kfss89+KBUjWGzB9e
	LGb5ZxTuhk73Klh7btUu9Q2Zt+bIJyfN2VLywPpi0juJbZxPIoVd9857/8pxv/XMKqvJx8/L
	v567TIxn0+QnfyX4U44FBsyZozz7STP3WbE7U7UuTmYUSlfcsaRnxkd2t1VP13tM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271013>

delete_ref() uses a different convention for its old_sha1 parameter
than, say, ref_transaction_delete(): NULL_SHA1 means not to check the
old value. Make this fact a little bit clearer in the code by handling
it in explicit, commented code rather than burying it in a conditional
expression.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b575bb8..f9d87b6 100644
--- a/refs.c
+++ b/refs.c
@@ -2795,10 +2795,13 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
+	/* Treat NULL_SHA1 as "don't care" */
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
