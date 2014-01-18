From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/17] rename_tmp_log(): on SCLD_VANISHED, retry
Date: Sat, 18 Jan 2014 23:49:01 +0100
Message-ID: <1390085341-2553-18-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiQ-0005K4-MV
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbaARWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:50:05 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42704 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696AbaARWtu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:50 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-4e-52db050d0f1d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 28.A7.19161.D050BD25; Sat, 18 Jan 2014 17:49:49 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN9A030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:48 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqMvLejvIYOtZNouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M64v24Xa0EDe8WEXxfYGhhv
	sHYxcnJICJhIHGp/ygJhi0lcuLeerYuRi0NI4DKjxKmzU1khnBNMEpfaV7ODVLEJ6Eos6mlm
	ArFFBNQkJrYdAutmFnCQ2Py5kRHEFhZwlvizdBMziM0ioCpxeNU5sBpeAReJI90vgDZwAG1T
	kFh9XQgkzAkSnn8BbKQQUOvN10/YJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6yX
	m1mil5pSuokREip8Oxjb18scYhTgYFTi4T3AdDtIiDWxrLgy9xCjJAeTkiivMkiILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCG/whltBQrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalF
	MFkZDg4lCV5vFqChgkWp6akVaZk5JQhpJg5OEMEFsoEHZANIIW9xQWJucWY6RNEpRkUpcV55
	kIQASCKjNA9uACyqXzGKA/0jzBsOUsUDTAhw3a+ABjMBDRaJvQkyuCQRISXVwMiwtEr0Elvb
	XbsDbOGPGIPFc8RPyiVVvF+lK5vi9adX6fSz9AR2D6vWADm2s29nCRzftOKp+MxgOYP5BueS
	zWyPKgpquT1s0Ldo9cqxvX8oyTqrecsGZ8mw3b7XXr44e0g/rXHuO5eFi5r2SXx/uUV8QptS
	+zEFZW2dZyuDmHYdEszy7lRZr8RSnJFoqMVcVJwIAIfcmSvFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240663>

If safe_create_leading_directories() fails because a file along the
path unexpectedly vanished, try again from the beginning.  Try at most
4 times.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 134d5aa..0148bbd 100644
--- a/refs.c
+++ b/refs.c
@@ -2533,7 +2533,14 @@ static int rename_tmp_log(const char *newrefname)
 	int attempts_remaining = 4;
 
  retry:
-	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+	switch (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+	case SCLD_OK:
+		break; /* success */
+	case SCLD_VANISHED:
+		if (--attempts_remaining > 0)
+			goto retry;
+		/* fall through */
+	default:
 		error("unable to create directory for %s", newrefname);
 		return -1;
 	}
-- 
1.8.5.2
