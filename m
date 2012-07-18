From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] credential: convert "url" attribute into its parsed
 subparts
Date: Wed, 18 Jul 2012 08:06:26 -0400
Message-ID: <20120718120626.GC6726@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:06:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrT1W-0001H5-G5
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab2GRMGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:06:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39076
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab2GRMG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:06:29 -0400
Received: (qmail 18970 invoked by uid 107); 18 Jul 2012 12:06:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:06:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:06:26 -0400
Content-Disposition: inline
In-Reply-To: <20120718120307.GA6399@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201679>

The git-credential command requires that you feed it a
broken-down credential, which means that the client needs to
parse a URL itself. Since we have our own URL-parsing
routines, we can easily allow the caller to just give us the
URL as-is, saving them some code.

Signed-off-by: Jeff King <peff@peff.net>
---
The implementation turned out to be delightfully simple. I stopped short
of adding an "ident" command to git-credential where you could do
something like:

  $ echo https://user@example.com | git credential ident
  protocol=https
  host=example.com
  username=user

since I had no use for it, but it would obviously be an easy one-liner
to write (it's just "fill" without the actual fill call).

 Documentation/git-credential.txt | 12 ++++++++++++
 credential.c                     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index afd5365..53adee3 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -140,3 +140,15 @@ Git understands the following attributes:
 `password`::
 
 	The credential's password, if we are asking it to be stored.
+
+`url`::
+
+	When this special attribute is read by `git credential`, the
+	value is parsed as a URL and treated as if its constituent parts
+	were read (e.g., `url=https://example.com` would behave as if
+	`protocol=https` and `host=example.com` had been provided). This
+	can help callers avoid parsing URLs themselves.  Note that any
+	components which are missing from the URL (e.g., there is no
+	username in the example above) will be set to empty; if you want
+	to provide a URL and override some attributes, provide the URL
+	attribute first, followed by any overrides.
diff --git a/credential.c b/credential.c
index 2c40007..e54753c 100644
--- a/credential.c
+++ b/credential.c
@@ -172,6 +172,8 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "url")) {
+			credential_from_url(c, value);
 		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
-- 
1.7.10.5.40.g059818d
