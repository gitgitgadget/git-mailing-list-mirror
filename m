From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 17/17] refs: document the lifetime of the refname passed to each_ref_fn
Date: Sun, 19 May 2013 22:27:12 +0200
Message-ID: <1368995232-11042-18-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADa-0004ax-BU
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab3ESU22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:28 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52348 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754787Ab3ESU2X (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:23 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-2f-519935e60606
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BE.AC.02380.6E539915; Sun, 19 May 2013 16:28:22 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5a026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:21 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqPvMdGagwfS1QhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTuj51tYwUqhisUPJjA3ML7i62Lk5JAQMJH4MfMRM4QtJnHh3nq2LkYuDiGBy4wSy+73
	s0A455kknq/8yAJSxSagK7Gop5kJxBYRkJX4fngjI4jNLDCBUWJpfyGILSwQKrFkzUqwOIuA
	qsTetjmsIDavgKvEnxvbWCG2KUhcnrUGbDMnUHxL+y6wuJCAi8S//tusExh5FzAyrGKUS8wp
	zdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQICSm+HYzt62UOMQpwMCrx8Gq8mx4oxJpY
	VlyZe4hRkoNJSZT3ncnMQCG+pPyUyozE4oz4otKc1OJDjBIczEoivHuEgHK8KYmVValF+TAp
	aQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQlec2DsCAkWpaanVqRl5pQgpJk4OEEEF8gG
	HqAN0iCFvMUFibnFmekQRacYFaXEeS+CnCUAksgozYMbAIv+V4ziQP8I89qCtPMAEwdc9yug
	wUxAg1mvTQUZXJKIkJJqYBQ43nfzwYYko/nVTR2uqXsjzvY82Vaawlu4MzmhV+DikQBJBrlU
	keuft8je6/UMZ9COOxJ/wuJ11ccdVRuPLknYts5wJu8Gh2DOiLXTpFI7ppw+OHlKQFfFPSf5
	e6VzL2fwLlx75Ynrtfh2AR62OW8bn3vc+c7jPM/V7NB+i5zkqfrXO08/7lNiKc5I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224914>

The lifetime of the refname was never documented, but some callers
used to assume that its lifetime was essentially permanent.  The
commits leading up to this have disabused such callers of that notion.

The new status quo is that the API explicitly does *not* guarantee
that the refname string lives beyond a single callback invocation.
Document that fact.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch is the ultimate goal of the series, and I include it for
illustration, but it obviously shouldn't be committed before the
object_array questions have been answered and the rest of the code has
been audited more carefully.

 refs.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs.h b/refs.h
index a35eafc..e67fb07 100644
--- a/refs.h
+++ b/refs.h
@@ -15,13 +15,23 @@ struct ref_lock {
 #define REF_ISBROKEN 0x04
 
 /*
- * Calls the specified function for each ref file until it returns
- * nonzero, and returns the value.  Please note that it is not safe to
- * modify references while an iteration is in progress, unless the
- * same callback function invocation that modifies the reference also
- * returns a nonzero value to immediately stop the iteration.
+ * The callback functions for the for_each_*() functions below must
+ * have this signature.  The memory pointed to by the refname argument
+ * is only guaranteed to be valid for the duration of a single
+ * callback invocation.
+ */
+typedef int each_ref_fn(const char *refname,
+			const unsigned char *sha1, int flags, void *cb_data);
+
+/*
+ * The following functions invoke the specified callback function for
+ * each reference indicated.  If the function ever returns a nonzero
+ * value, stop the iteration and return that value.  Please note that
+ * it is not safe to modify references while an iteration is in
+ * progress, unless the same callback function invocation that
+ * modifies the reference also returns a nonzero value to immediately
+ * stop the iteration.
  */
-typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn, void *);
-- 
1.8.2.3
