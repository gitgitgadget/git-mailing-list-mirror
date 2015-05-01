From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/18] ref_transaction_commit(): provide better error messages
Date: Fri,  1 May 2015 14:25:56 +0200
Message-ID: <1430483158-14349-17-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1q-0001As-9S
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbEAM0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57978 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753760AbbEAM0a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:30 -0400
X-AuditID: 1207440c-f79376d00000680a-18-554370f649ac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 63.8F.26634.6F073455; Fri,  1 May 2015 08:26:30 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zt004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:29 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqPutwDnU4NgHQYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ6z6/5y14CZHxd2/JxkbGF+xdTFycEgImEj8OqfdxcgJZIpJXLi3HijMxSEkcJlRYsK0
	F8wQzgkmiU97L7KBVLEJ6Eos6mlmArFFBNQkJrYdYgEpYhboYJS4sHwbO8hUYQE/idVbuEFM
	FgFVif3XikDKeQVcJab0PWKDWCYncf74T2aQEk6g+JepiSBhIQEXifvfv7JNYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkmHh2MH5bJ3OIUYCDUYmHl+OkU6gQ
	a2JZcWXuIUZJDiYlUV7bBOdQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK899SBcrwpiZVVqUX5
	MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd5f+UCNgkWp6akVaZk5JQhpJg5OkOFc
	UiLFqXkpqUWJpSUZ8aCoiC8GxgVIigdo70OQdt7igsRcoChE6ylGRSlx3jCQhABIIqM0D24s
	LEW8YhQH+lKYlxWYMIR4gOkFrvsV0GAmoMHnbzmADC5JREhJNTAWnPKYmzL56OdbxoVRYsaq
	r1ek3Ll3ePedD9qhh55terih35F1Cf++Wq9MNim/1OnFzfY1DMknQm/wH4yY/CQxSdIinmXL
	8Qersu6Y3PjM2+W/x/WU6RXGhVJzCyZM0+01Ll7dWFb2rSy6+ZD+Z9EdJeu4vsx5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268125>

Now that lock_ref_sha1_basic() gives us back its error messages via a
strbuf, incorporate its error message into our error message rather
than emitting one error messages to stderr immediately and returning a
second to our caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6077e83..2d0d8bd 100644
--- a/refs.c
+++ b/refs.c
@@ -3830,13 +3830,14 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				&update->type,
 				err);
 		if (!update->lock) {
+			const char *reason;
+
 			ret = (errno == ENOTDIR)
 				? TRANSACTION_NAME_CONFLICT
 				: TRANSACTION_GENERIC_ERROR;
-			error("%s", err->buf);
-			strbuf_reset(err);
-			strbuf_addf(err, "Cannot lock the ref '%s'.",
-				    update->refname);
+			reason = strbuf_detach(err, NULL);
+			strbuf_addf(err, "Cannot lock the ref '%s': %s",
+				    update->refname, reason);
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) && !(update->flags & REF_DELETING)) {
-- 
2.1.4
