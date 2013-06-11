From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/4] resolve_ref_unsafe(): handle the case of an SHA-1 within loop
Date: Tue, 11 Jun 2013 16:26:18 +0200
Message-ID: <1370960780-1055-3-git-send-email-mhagger@alum.mit.edu>
References: <20130507023802.GA22940@sigill.intra.peff.net>
 <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 16:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPXR-0005vU-0C
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab3FKO0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:26:55 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54765 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753804Ab3FKO0p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 10:26:45 -0400
X-AuditID: 12074412-b7f656d00000102f-01-51b733a4853a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 2D.C5.04143.4A337B15; Tue, 11 Jun 2013 10:26:44 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BEQVIT026521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 10:26:43 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLvEeHugwekGXYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xuuMMc8Fq3oq/swwaGOdxdTFyckgImEjcnNbHDGGLSVy4t56ti5GLQ0jgMqPEvRWN
	TBDOBSaJZ2f2MoJUsQnoSizqaWYCsUUE1CQmth1iASliFmhnlHjXvA9slLBAkMTlvbvAilgE
	VCVeHl0JFucVcJZ4MGsmG8Q6OYn3d3YBNXNwcAq4SJxulAEJCwmUSExZ9ZZlAiPvAkaGVYxy
	iTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghISW0g3H9SblDjAIcjEo8vAmM2wKF
	WBPLiitzDzFKcjApifJOMdgeKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt1EOKMebklhZlVqU
	D5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMHragTUKFiUmp5akZaZU4KQZuLgBBFc
	IBt4gDYwgRTyFhck5hZnpkMUnWJUlBLnjQdJCIAkMkrz4AbAov8VozjQP8K8LiBVPMDEAdf9
	CmgwE9DgKepbQAaXJCKkpBoY14d/4A/jvyeR2VXp0tefvuW9rMCT2ECPr6mBn3Xe3bVZKjrn
	2/N0hQVGrlxiJxqnisy0l/6/XOXn14fKjVIT1K7X3lfkqmbRUz/zJt1NWs5K2S5MaKblcvuS
	jhmL3+y+7/JP8Uii7YGDebePHp/77fe+9+dzV8ruUVCNn8ct1mv43UqhgGW/Ektx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227444>

There is only one "break" statement within the loop, which jumps to
the code after the loop that handles the case of a file that holds a
SHA-1.  So move that code from below the loop into the if statement
where the break was previously located.  This makes the logic flow
more local and also opens the way for nesting the checking code in
an inner loop.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 1acce17..2722f75 100644
--- a/refs.c
+++ b/refs.c
@@ -1295,8 +1295,19 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (prefixcmp(buffer, "ref:"))
-			break;
+		if (prefixcmp(buffer, "ref:")) {
+			/*
+			 * Please note that FETCH_HEAD has a second
+			 * line containing other data.
+			 */
+			if (get_sha1_hex(buffer, sha1) ||
+			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
+				if (flag)
+					*flag |= REF_ISBROKEN;
+				return NULL;
+			}
+			return refname;
+		}
 		if (flag)
 			*flag |= REF_ISSYMREF;
 		buf = buffer + 4;
@@ -1309,13 +1320,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		}
 		refname = strcpy(refname_buffer, buf);
 	}
-	/* Please note that FETCH_HEAD has a second line containing other data. */
-	if (get_sha1_hex(buffer, sha1) || (buffer[40] != '\0' && !isspace(buffer[40]))) {
-		if (flag)
-			*flag |= REF_ISBROKEN;
-		return NULL;
-	}
-	return refname;
 }
 
 char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag)
-- 
1.8.3
