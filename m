From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] strtoul_ui: reject negative values
Date: Thu, 17 Sep 2015 16:37:26 +0200
Message-ID: <1442500646-15293-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, max@max630.net,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 17 16:37:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcaJl-0003UG-6M
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 16:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbbIQOhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 10:37:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39537 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbbIQOhk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 10:37:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HEbQA7031644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Sep 2015 16:37:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8HEbSOf026571;
	Thu, 17 Sep 2015 16:37:28 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZcaJU-000472-K9; Thu, 17 Sep 2015 16:37:28 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2015 16:37:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8HEbQA7031644
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443105451.04967@Vh/HLqPIdZIcaJaR0ldwjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278118>

strtoul_ui uses strtoul to get a long unsigned, then checks that casting
to unsigned does not lose information and return the casted value.

On 64 bits architecture, checking that the cast does not change the value
catches most errors, but when sizeof(int) == sizeof(long) (e.g. i386),
the check does nothing. Unfortunately, strtoul silently accepts negative
values, and as a result strtoul_ui("-1", ...) raised no error.

This patch catches negative values before it's too late, i.e. before
calling strtoul. We still silently accept very large integers that wrap
to a valid "unsigned int".

Reported-by: Max Kirillov <max@max630.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
So, here's a proper patch (I mean, a band-aid patch, but properly
send ;-) ).

It should be merged before Kartik's series (or inserted at the start
of the series) so that we get the fix before the test breakage.

 git-compat-util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index f649e81..1df82fa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -814,6 +814,9 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	char *p;
 
 	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
 	ul = strtoul(s, &p, base);
 	if (errno || *p || p == s || (unsigned int) ul != ul)
 		return -1;
-- 
2.5.0.402.g8854c44
