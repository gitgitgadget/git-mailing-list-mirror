From: Jeff King <peff@peff.net>
Subject: [PATCH 3/9] remote-curl: let servers override http 404 advice
Date: Fri, 5 Apr 2013 18:17:40 -0400
Message-ID: <20130405221740.GC22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:32:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQG-0001b9-In
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162964Ab3DEWRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:17:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58239 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162833Ab3DEWRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:17:49 -0400
Received: (qmail 18359 invoked by uid 107); 5 Apr 2013 22:19:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:19:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:17:40 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220216>

When we get an http 404 trying to get the initial list of
refs from the server, we try to be helpful and remind the
user that update-server-info may need to be run. This looks
like:

  $ git clone https://github.com/non/existent
  Cloning into 'existent'...
  fatal: https://github.com/non/existent/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?

Suggesting update-server-info may be a good suggestion for
users who are in control of the server repo and who are
planning to set up dumb http. But for users of smart http,
and especially users who are not in control of the server
repo, the advice is useless and confusing.

The previous patch taught remote-curl to show custom advice
from the server when it is available. When we have shown
messages from the server, we can also drop our custom
advice; what the server has to say is likely to be more
accurate and helpful.

We not only drop the mention of update-server-info, but also
show only the main repo URL, not the full "info/refs" and
service parameter. These elements may be useful for
debugging a broken server configuration, but again, anything
the server has provided is likely to be more useful (and one
can still use GIT_CURL_VERBOSE to get much more complete
debugging information).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4fea94f..083efdf 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -209,7 +209,8 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &buffer);
+		if (!show_http_message(&type, &buffer))
+			die("repository '%s' not found", url);
 		die("%s not found: did you run git update-server-info on the"
 		    " server?", refs_url);
 	case HTTP_NOAUTH:
-- 
1.8.2.rc0.33.gd915649
