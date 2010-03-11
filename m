From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Thu, 11 Mar 2010 16:37:15 +0000
Message-ID: <20100311163715.GE7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 17:38:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NplOc-0006by-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 17:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251Ab0CKQhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 11:37:18 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:62705 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933240Ab0CKQhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 11:37:17 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 869985CC5;
	Thu, 11 Mar 2010 16:56:26 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 869985CC5
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id DD367D73;
	Thu, 11 Mar 2010 16:37:15 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id CF796BAAE; Thu, 11 Mar 2010 16:37:15 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141985>

Many of our supported platforms do not have this declaration, for
example solaris2.6 thru 2.7.  Lack of ss_family implies no IPV6
support, so we can wrap all the ss_family references in an ifndef
NO_IPV6, and assume sockaddr_in otherwise.

Actually, the test for setting NO_IPV6 at configure time is still
too optimistic and I have to manually pass '-DNO_IPV6' in CPPFLAGS
at build time on aix-5.2.0.0 and earlier, and irix-6.5 and older
for them to pick up the right branch.
---
 daemon.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 6bc1c23..c9ea500 100644
--- a/daemon.c
+++ b/daemon.c
@@ -591,17 +591,23 @@ static int execute(struct sockaddr *addr)
 static int addrcmp(const struct sockaddr_storage *s1,
     const struct sockaddr_storage *s2)
 {
+#ifndef NO_IPV6
 	if (s1->ss_family != s2->ss_family)
 		return s1->ss_family - s2->ss_family;
 	if (s1->ss_family == AF_INET)
 		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
 		    &((struct sockaddr_in *)s2)->sin_addr,
 		    sizeof(struct in_addr));
-#ifndef NO_IPV6
 	if (s1->ss_family == AF_INET6)
 		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
 		    &((struct sockaddr_in6 *)s2)->sin6_addr,
 		    sizeof(struct in6_addr));
+#else
+	/* Assume AF_INET or equivalent for the likes of Solaris 2.7,
+	   HP/UX 11.00 and others do not implement ss_family */
+	return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
+	    &((struct sockaddr_in *)s2)->sin_addr,
+	    sizeof(struct in_addr));
 #endif
 	return 0;
 }
-- 
1.7.0.2

-- 
Gary V. Vaughan (gary@thewrittenword.com)
