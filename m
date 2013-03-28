From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length of
 string parameters
Date: Thu, 28 Mar 2013 17:48:21 -0400
Message-ID: <20130328214821.GD10936@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKgq-0000IF-Or
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab3C1Vs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:48:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44060 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab3C1Vs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:48:28 -0400
Received: (qmail 30778 invoked by uid 107); 28 Mar 2013 21:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:50:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:48:21 -0400
Content-Disposition: inline
In-Reply-To: <20130328214358.GA10685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219466>

This function takes two counted strings: a <pattern, patternlen> pair
and a <pathname, pathlen> pair. But we end up feeding the result to
fnmatch, which expects NUL-terminated strings.

We can fix this by calling the fnmatch_icase_mem function, which
handles re-allocating into a NUL-terminated string if necessary.

While we're at it, we can avoid even calling fnmatch in some cases. In
addition to patternlen, we get "prefix", the size of the pattern that
contains no wildcard characters. We do a straight match of the prefix
part first, and then use fnmatch to cover the rest. But if there are
no wildcards in the pattern at all, we do not even need to call
fnmatch; we would simply be comparing two empty strings.

Signed-off-by: Jeff King <peff@peff.net>
---
New in this iteration.

 dir.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index cc4ce8b..3ad44c3 100644
--- a/dir.c
+++ b/dir.c
@@ -624,11 +624,22 @@ int match_pathname(const char *pathname, int pathlen,
 		if (strncmp_icase(pattern, name, prefix))
 			return 0;
 		pattern += prefix;
+		patternlen -= prefix;
 		name    += prefix;
 		namelen -= prefix;
+
+		/*
+		 * If the whole pattern did not have a wildcard,
+		 * then our prefix match is all we need; we
+		 * do not need to call fnmatch at all.
+		 */
+		if (!patternlen && !namelen)
+			return 1;
 	}
 
-	return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
+	return fnmatch_icase_mem(pattern, patternlen,
+				 name, namelen,
+				 FNM_PATHNAME) == 0;
 }
 
 /* Scan the list and let the last match determine the fate.
-- 
1.8.2.13.g0f18d3c
