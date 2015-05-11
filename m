From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/18] ref_transaction_commit(): provide better error messages
Date: Mon, 11 May 2015 17:25:18 +0200
Message-ID: <1431357920-25090-17-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpaw-0002iU-V4
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbbEKP0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:26:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48239 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849AbbEKPZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:58 -0400
X-AuditID: 12074412-f79e46d0000036b4-70-5550ca057d47
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.B7.14004.50AC0555; Mon, 11 May 2015 11:25:57 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnS002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:56 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqMt6KiDU4OU3Q4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8a5Rc8YCxZwVKw8P4u5gXEbWxcjB4eEgInEqVneXYycQKaYxIV769lA
	bCGBy4wSU3bZdDFyAdnHmSQWzVzICJJgE9CVWNTTzARiiwioSUxsO8QCUsQssItR4t7SqSwg
	CWGBQImOSafBbBYBVYkLvYtYQWxeAVeJe1/PMENsk5M4f/wnmM0JFF969TILxGYXiabH91gm
	MPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESYkI7GNeflDvEKMDB
	qMTDa3DBP1SINbGsuDL3EKMkB5OSKO+vvQGhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4ldcA
	5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHjfnABqFCxKTU+tSMvM
	KUFIM3FwggznkhIpTs1LSS1KLC3JiAdFRnwxMDZAUjxAe7+CtPMWFyTmAkUhWk8xKkqJ894D
	SQiAJDJK8+DGwhLHK0ZxoC+FeT+CVPEAkw5c9yugwUxAgx3jwAaXJCKkpBoYJ6YdszbyjL4i
	xS8b9LHOIap+9dkLd3ysnpfcj+bZMOdTQNW3vqSHDlU++4VnpPEuKmvec6jm74Sclr97HVnP
	XC6rj7H5O+/D3c9fuhUfPdm+2f6sIcPOt3+NPHZF+bG/tr7jFCz3d6ft6SPBpv9m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268787>

Now that lock_ref_sha1_basic() gives us back its error messages via a
strbuf, incorporate its error message into our error message rather
than emitting one error messages to stderr immediately and returning a
second to our caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 87c1ad1..ecaf804 100644
--- a/refs.c
+++ b/refs.c
@@ -3838,13 +3838,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				&update->type,
 				err);
 		if (!update->lock) {
+			char *reason;
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
+			free(reason);
 			goto cleanup;
 		}
 	}
-- 
2.1.4
