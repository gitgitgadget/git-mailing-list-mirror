From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/19] delete_ref(): handle special case more explicitly
Date: Mon, 22 Jun 2015 16:02:54 +0200
Message-ID: <0c66a6bd6e49b9c28fa3617ee50de746ef4ea9a3.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KL-0005gX-5e
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658AbbFVODq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:46 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52838 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933450AbbFVOD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:28 -0400
X-AuditID: 12074412-f79a76d000007c8b-5f-558815a7336b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.21.31883.7A518855; Mon, 22 Jun 2015 10:03:19 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc1030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:18 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLtctCPU4OZRKYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZxw8Vl/Qx1WxtX0OewNjD0cXIweHhICJxK2X1V2MnECmmMSFe+vZuhi5OIQELjNK7Pm/
	nQXCOckksab7LiNIFZuArsSinmYmEFtEQE1iYtshsCJmgQ5GiQvLt7GDJIQFvCUWzzjDAmKz
	CKhK/Hs0mw3E5hWIkvi16R8zxDo5ifPHf4LZnAIWEvP3/QfrFRIwl5g48xHLBEbeBYwMqxjl
	EnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCAkpoB+P6k3KHGAU4GJV4eB1s20OF
	WBPLiitzDzFKcjApifIeeA0U4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbchYox5uSWFmVWpQP
	k5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwesn0hEqJFiUmp5akZaZU4KQZuLgBBnO
	JSVSnJqXklqUWFqSEQ+KjPhiYGyApHiA9uaAtPMWFyTmAkUhWk8xKkqJ804GSQiAJDJK8+DG
	wtLEK0ZxoC+FeTeCVPEAUwxc9yugwUxAg7/ktoEMLklESEk1MFbnyGf6SCfptm/fNF9GQyp3
	8pP/LTYn39nUZn5Wtmz0O7mUeWHva6bj1vNv5/4yO2fDs+7Cky6RZbk3fgkoLz2dXsghfVJt
	+rGIvSlbKqd1n5x+Z0LwjUM5qy4em2MeabLVf304+8FLj775/BXb2WPzLli37WDT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272348>

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
