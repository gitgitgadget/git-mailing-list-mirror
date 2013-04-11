From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] doc/http-backend: clarify "half-auth" repo configuration
Date: Wed, 10 Apr 2013 23:32:11 -0400
Message-ID: <20130411033211.GA14551@sigill.intra.peff.net>
References: <20130411033022.GA14462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 05:32:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ8FM-000873-7W
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936257Ab3DKDcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 23:32:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39629 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759688Ab3DKDcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 23:32:19 -0400
Received: (qmail 11210 invoked by uid 107); 11 Apr 2013 03:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 23:34:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 23:32:11 -0400
Content-Disposition: inline
In-Reply-To: <20130411033022.GA14462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220810>

When the http-backend is set up to allow anonymous read but
authenticated write, the http-backend manual suggests
catching only the "/git-receive-pack" POST of the packfile,
not the initial "info/refs?service=git-receive-pack" GET in
which we advertise refs.

This does work and is secure, as we do not allow any write
during the info/refs request, and the information in the ref
advertisement is the same that you would get from a fetch.

However, the configuration required by the server is
slightly more complex. The default `http.receivepack`
setting is to allow pushes if the webserver tells us that
the user authenticated, and otherwise to return a 403
("Forbidden"). That works fine if authentication is turned
on completely; the initial request requires authentication,
and http-backend realizes it is OK to do a push.

But for this "half-auth" state, no authentication has
occurred during the initial ref advertisement. The
http-backend CGI therefore does not think that pushing
should be enabled, and responds with a 403. The client
cannot continue, even though the server would have allowed
it to run if it had provided credentials.

It would be much better if the server responded with a 401,
asking for credentials during the initial contact. But
git-http-backend does not know about the server's auth
configuration (so a 401 would be confusing in the case of a
true anonymous server). Unfortunately, configuring Apache to
recognize the query string and apply the auth appropriately
to receive-pack (but not upload-pack) initial requests is
non-trivial.

The site admin can work around this by just turning on
http.receivepack explicitly in its repositories. Let's
document this workaround.

Signed-off-by: Jeff King <peff@peff.net>
---
My understanding is that you can do query-string matching through a
clever use of mod-rewrite. I am not nearly clever nor interested in
Apache enough to figure it out, but if somebody does, it would be nice
to put the recipe here.

 Documentation/git-http-backend.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 7b1e85c..f43980f 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -91,6 +91,15 @@ require authorization with a LocationMatch directive:
 </LocationMatch>
 ----------------------------------------------------------------
 +
+In this mode, the server will not request authentication until the
+client actually starts the object negotiation phase of the push, rather
+than during the initial contact.  For this reason, you must also enable
+the `http.receivepack` config option in any repositories that should
+accept a push. The default behavior, if `http.receivepack` is not set,
+is to reject any pushes by unauthenticated users; the initial request
+will therefore report `403 Forbidden` to the client, without even giving
+an opportunity for authentication.
++
 To require authentication for both reads and writes, use a Location
 directive around the repository, or one of its parent directories:
 +
-- 
1.8.2.rc0.33.gd915649
