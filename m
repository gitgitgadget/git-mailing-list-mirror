From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] fix off-by-one allocation error
Date: Fri, 29 Jan 2010 05:31:30 -0500
Message-ID: <20100129103130.GB6025@coredump.intra.peff.net>
References: <20100129102518.GA5875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nao8Y-0004wH-Jw
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab0A2Kbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 05:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663Ab0A2Kbd
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:31:33 -0500
Received: from peff.net ([208.65.91.99]:39291 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab0A2Kbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 05:31:32 -0500
Received: (qmail 3984 invoked by uid 107); 29 Jan 2010 10:31:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 Jan 2010 05:31:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2010 05:31:30 -0500
Content-Disposition: inline
In-Reply-To: <20100129102518.GA5875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138309>

Caught by valgrind in t5516. Reading the code shows we
malloc enough for our string, but not trailing NUL.

Signed-off-by: Jeff King <peff@peff.net>
---
This bug was introduced in f517f1f (builtin-push: add --delete as
syntactic sugar for :foo, 2009-12-30), not released yet but part of
1.7.0-rc0. So no need for a 'maint' fix.

An obvious alternative would be to convert it to strbuf (which could
also be used to clean up other non-buggy string generation earlier in
the function).

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5df6608..5633f0a 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -52,7 +52,7 @@ static void set_refspecs(const char **refs, int nr)
 		} else if (deleterefs && !strchr(ref, ':')) {
 			char *delref;
 			int len = strlen(ref)+1;
-			delref = xmalloc(len);
+			delref = xmalloc(len+1);
 			strcpy(delref, ":");
 			strcat(delref, ref);
 			ref = delref;
-- 
1.7.0.rc0.41.g538720
