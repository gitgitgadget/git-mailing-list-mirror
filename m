From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] remote-curl: always show friendlier 404 message
Date: Fri, 5 Apr 2013 18:20:43 -0400
Message-ID: <20130405222043.GD22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:37:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQL-0001b9-6F
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162980Ab3DEWUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:20:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58243 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162791Ab3DEWUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:20:52 -0400
Received: (qmail 18383 invoked by uid 107); 5 Apr 2013 22:22:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:22:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:20:43 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220219>

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

Since most people are expected to use smart http these days,
it does not make sense to keep the update-server-info hint.

We not only drop the mention of update-server-info, but also
show only the main repo URL, not the full "info/refs" and
service parameter. These elements may be useful for
debugging a broken server configuration, but in the majority
of cases, users are not fetching from their own
repositories, but rather from other people's repositories;
they have neither the power nor interest to fix a broken
configuration, and the extra components just make the
message more confusing. Users who do want to debug can and
should use GIT_CURL_VERBOSE to get more complete information
on the actual URLs visited.

Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously a more stringent version of the last patch, and could
just replace it. I think the last one is a no-brainer, because it lets
well-configured sites replace these messages. This one is less obvious,
because we may be hitting some random poorly configured server that
somebody is trying to set up.

Still, if you think about the number of people fetching (against any
server) versus the number of people configuring new servers, I think the
advice to run update-server-info has a vanishingly small chance of being
useful (and IMHO is misleading if you do not know how dumb-http works,
as it makes you think the server is misconfigured, when it is much more
likely to be a user error).

 remote-curl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 083efdf..5d9f961 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -209,10 +209,8 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		if (!show_http_message(&type, &buffer))
-			die("repository '%s' not found", url);
-		die("%s not found: did you run git update-server-info on the"
-		    " server?", refs_url);
+		show_http_message(&type, &buffer);
+		die("repository '%s' not found", url);
 	case HTTP_NOAUTH:
 		show_http_message(&type, &buffer);
 		die("Authentication failed");
-- 
1.8.2.rc0.33.gd915649
