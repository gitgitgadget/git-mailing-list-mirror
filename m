From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/25] register_ref(): make a copy of the bad reference SHA-1
Date: Sat, 25 May 2013 11:08:23 +0200
Message-ID: <1369472904-12875-25-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATz-0005No-7X
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab3EYJJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:40 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:53319 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755068Ab3EYJJe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:34 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-e6-51a07fcd18bb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.43.02380.DCF70A15; Sat, 25 May 2013 05:09:33 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gv0000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:32 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHu2fkGgwe318hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzmjb+oat4ApHxeeNfWwNjN3sXYycHBICJhL3rt1jg7DFJC7cWw9k
	c3EICVxmlDjwuIEJwrnAJPG+t4MJpIpNQFdiUU8zmC0i4Chx4sF1VpAiZoFeRomHj76DJYQF
	AiTuzWkDG8sioCqx4lgXUJyDg1fAVeJ7qynENgWJy7PWMIOEOYHCb09wgoSFBFwknn86xzqB
	kXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJAw49vB2L5e5hCjAAej
	Eg+vQPn8QCHWxLLiytxDjJIcTEqivPy1CwKF+JLyUyozEosz4otKc1KLDzFKcDArifAypADl
	eFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvB51QI2CRanpqRVpmTkl
	CGkmDk4QwQWygQdow1mQQt7igsTc4sx0iKJTjIpS4rwTQRICIImM0jy4AbCE8IpRHOgfYd4F
	IFU8wGQC1/0KaDAT0OCbufNBBpckIqSkGhi118q98pq+9qFZ8jGRLq9g3j6RzhcHo9Wb57q8
	3PrHYs6HU2z/t1kWbUs8eb3obXShtAybgUao0MVKpvSICZ9lO6oZvvwMZBBdUvfk1+OfM/jZ
	axPXGjhpyywUfrAu3PpIseKZF66qLzqM5HfdO7/CgNNiAlvEJpGleQ6n03ov6p2Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225506>

The lifetime of the sha1 parameter passed to an each_ref_fn callback
is not guaranteed, so make a copy for later use.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 bisect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 374d9e2..71c1958 100644
--- a/bisect.c
+++ b/bisect.c
@@ -15,7 +15,7 @@
 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
 
-static const unsigned char *current_bad_sha1;
+static unsigned char *current_bad_sha1;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
@@ -404,7 +404,8 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
-		current_bad_sha1 = sha1;
+		current_bad_sha1 = xmalloc(20);
+		hashcpy(current_bad_sha1, sha1);
 	} else if (!prefixcmp(refname, "good-")) {
 		sha1_array_append(&good_revs, sha1);
 	} else if (!prefixcmp(refname, "skip-")) {
-- 
1.8.2.3
