From: Jeff King <peff@peff.net>
Subject: [PATCH 5/9] remote-curl: consistently report repo url for http errors
Date: Fri, 5 Apr 2013 18:21:14 -0400
Message-ID: <20130405222114.GE22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQL-0001b9-MA
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162899Ab3DEWVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:21:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58246 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162853Ab3DEWVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:21:23 -0400
Received: (qmail 18401 invoked by uid 107); 5 Apr 2013 22:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:23:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:21:14 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220249>

When we report http errors in fetching the initial ref
advertisement, we show the full URL we attempted to use,
including "info/refs?service=git-upload-pack". While this
may be useful for debugging a broken server, it is
unnecessarily verbose and confusing for most cases, in which
the client user is not even the same person as the owner of
the repository.

Let's just show the repository URL; debugging can happen
with GIT_CURL_VERBOSE, which shows way more useful
information, anyway.

At the same time, let's also make sure to mention the
repository URL when we report failed authentication
(previously we said only "Authentication failed"). Knowing
the URL can help the user realize why authentication failed
(e.g., they meant to push to remote A, not remote B).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the same rationale as the latter half of the last patch; if we
take them all, I'd be happy to see them squashed together.

 remote-curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 5d9f961..6c6714b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -213,10 +213,10 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		die("repository '%s' not found", url);
 	case HTTP_NOAUTH:
 		show_http_message(&type, &buffer);
-		die("Authentication failed");
+		die("Authentication failed for '%s'", url);
 	default:
 		show_http_message(&type, &buffer);
-		http_error(refs_url, http_ret);
+		http_error(url, http_ret);
 		die("HTTP request failed");
 	}
 
-- 
1.8.2.rc0.33.gd915649
