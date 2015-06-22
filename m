From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/19] cmd_update_ref(): make logic more straightforward
Date: Mon, 22 Jun 2015 16:03:09 +0200
Message-ID: <4eaf80adf666bf86beb271779d7226d9eb04d257.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KY-0005pZ-A4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933691AbbFVOD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:58 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42118 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933473AbbFVODj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:39 -0400
X-AuditID: 1207440f-f79df6d000007c0f-b3-558815b9756b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 78.99.31759.9B518855; Mon, 22 Jun 2015 10:03:38 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3CcG030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:37 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLtLtCPU4OIWRouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ+w9/Ymt4C1Hxd51f5kbGBvZuxg5OSQETCQ+zt3FCGGLSVy4t56ti5GLQ0jgMqPElU+b
	2CGck0wSBx48ZgGpYhPQlVjU08wEYosIqElMbDvEAlLELNDBKHFh+TawscIC3hIPnkxlBbFZ
	BFQlvv6fBLaCVyBKomNOKxPEOjmJ88d/MoPYnAIWEvP3/QfrFRIwl5g48xHLBEbeBYwMqxjl
	EnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCgop/B2PXeplDjAIcjEo8vA627aFC
	rIllxZW5hxglOZiURHkPvAYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFtOQuU401JrKxKLcqH
	SUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8PqJdIQKCRalpqdWpGXmlCCkmTg4QYZz
	SYkUp+alpBYllpZkxIOiI74YGB8gKR6gvTkg7bzFBYm5QFGI1lOMilLivJNBEgIgiYzSPLix
	sFTxilEc6Eth3j3CQFU8wDQD1/0KaDAT0OAvuW0gg0sSEVJSDYz1dtOXvtt1aOWi7snTCiev
	iTg0Z7P3ep72Cxvf1KxkkWNjDjDZslS1bcdvZ5sjOodtbbh/5PE8EdA/dstRtvaRrturQLH3
	4QdmT3xlu9Ll7G09jo3rim8IvfnXurnh70Pp9/MZ2ASmzTkdwnppiVrVxbajvCfM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272354>

Restructure the code to avoid clearing oldsha1 when oldval is unset.
It's value is not needed in that case, so this change makes it more
obvious that its initialization is consistent with its later use.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3d79a46..160c7ac 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -408,9 +408,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			die("%s: not a valid SHA1", value);
 	}
 
-	hashclr(oldsha1); /* all-zero hash in case oldval is the empty string */
-	if (oldval && *oldval && get_sha1(oldval, oldsha1))
-		die("%s: not a valid old SHA1", oldval);
+	if (oldval) {
+		if (!*oldval)
+			/*
+			 * The empty string implies that the reference
+			 * must not already exist:
+			 */
+			hashclr(oldsha1);
+		else if (get_sha1(oldval, oldsha1))
+			die("%s: not a valid old SHA1", oldval);
+	}
 
 	if (no_deref)
 		flags = REF_NODEREF;
-- 
2.1.4
