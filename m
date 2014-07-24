From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] apply: avoid possible bogus pointer
Date: Thu, 24 Jul 2014 00:43:23 -0400
Message-ID: <20140724044323.GE32355@peff.net>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 06:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAAsR-0004DW-DX
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 06:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934134AbaGXEnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 00:43:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:39365 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751039AbaGXEnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 00:43:31 -0400
Received: (qmail 20761 invoked by uid 102); 24 Jul 2014 04:43:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jul 2014 23:43:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2014 00:43:23 -0400
Content-Disposition: inline
In-Reply-To: <20140724043940.GA31282@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254148>

When parsing "index" lines from a git-diff, we look for a
space followed by the mode. If we don't have a space, then
we set our pointer to the end-of-line. However, we don't
double-check that our end-of-line pointer is valid (e.g., if
we got a truncated diff input), which could lead to some
wrap-around pointer arithmetic.

In most cases this would probably get caught by our "40 <
len" check later in the function, but to be on the safe
side, let's just use strchrnul to treat end-of-string the
same as end-of-line.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9f8f5ba..be2b4ce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1075,7 +1075,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
 
 	line = ptr + 2;
 	ptr = strchr(line, ' ');
-	eol = strchr(line, '\n');
+	eol = strchrnul(line, '\n');
 
 	if (!ptr || eol < ptr)
 		ptr = eol;
-- 
2.0.0.566.gfe3e6b2
