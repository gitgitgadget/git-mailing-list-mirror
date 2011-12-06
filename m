From: Jeff King <peff@peff.net>
Subject: [PATCHv2 04/13] credential: add function for parsing url components
Date: Tue, 6 Dec 2011 01:22:41 -0500
Message-ID: <20111206062241.GD29233@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoQr-0004m6-E4
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978Ab1LFGWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:22:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975Ab1LFGWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:22:43 -0500
Received: (qmail 1146 invoked by uid 107); 6 Dec 2011 06:29:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:29:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:22:41 -0500
Content-Disposition: inline
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186324>

All of the components of a credential struct can be found in
a URL.  For example, the URL:

  http://foo:bar@example.com/repo.git

contains:

  protocol=http
  host=example.com
  path=repo.git
  username=foo
  password=bar

We want to be able to turn URLs into broken-down credential
structs so that we know two things:

  1. Which parts of the username/password we still need

  2. What the context of the request is (for prompting or
     as a key for storing credentials).

This code is based on http_auth_init in http.c, but needed a
few modifications in order to get all of the components that
the credential object is interested in.

Once the http code is switched over to the credential API,
then http_auth_init can just go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-credentials.txt |    4 ++
 credential.c                                |   52 +++++++++++++++++++++++++++
 credential.h                                |    1 +
 3 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index f624aef..21ca6a2 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -67,6 +67,10 @@ Functions
 	that they may store the result to be used again.  Any errors
 	from helpers are ignored.
 
+`credential_from_url`::
+
+	Parse a URL into broken-down credential fields.
+
 Example
 -------
 
diff --git a/credential.c b/credential.c
index 86397f3..c349b9a 100644
--- a/credential.c
+++ b/credential.c
@@ -2,6 +2,7 @@
 #include "credential.h"
 #include "string-list.h"
 #include "run-command.h"
+#include "url.h"
 
 void credential_init(struct credential *c)
 {
@@ -232,3 +233,54 @@ void credential_reject(struct credential *c)
 	c->password = NULL;
 	c->approved = 0;
 }
+
+void credential_from_url(struct credential *c, const char *url)
+{
+	const char *at, *colon, *cp, *slash, *host, *proto_end;
+
+	credential_clear(c);
+
+	/*
+	 * Match one of:
+	 *   (1) proto://<host>/...
+	 *   (2) proto://<user>@<host>/...
+	 *   (3) proto://<user>:<pass>@<host>/...
+	 */
+	proto_end = strstr(url, "://");
+	if (!proto_end)
+		return;
+	cp = proto_end + 3;
+	at = strchr(cp, '@');
+	colon = strchr(cp, ':');
+	slash = strchrnul(cp, '/');
+
+	if (!at || slash <= at) {
+		/* Case (1) */
+		host = cp;
+	}
+	else if (!colon || at <= colon) {
+		/* Case (2) */
+		c->username = url_decode_mem(cp, at - cp);
+		host = at + 1;
+	} else {
+		/* Case (3) */
+		c->username = url_decode_mem(cp, colon - cp);
+		c->password = url_decode_mem(colon + 1, at - (colon + 1));
+		host = at + 1;
+	}
+
+	if (proto_end - url > 0)
+		c->protocol = xmemdupz(url, proto_end - url);
+	if (slash - host > 0)
+		c->host = url_decode_mem(host, slash - host);
+	/* Trim leading and trailing slashes from path */
+	while (*slash == '/')
+		slash++;
+	if (*slash) {
+		char *p;
+		c->path = url_decode(slash);
+		p = c->path + strlen(c->path) - 1;
+		while (p > c->path && *p == '/')
+			*p-- = '\0';
+	}
+}
diff --git a/credential.h b/credential.h
index 2ea7d49..8a6d162 100644
--- a/credential.h
+++ b/credential.h
@@ -24,5 +24,6 @@ struct credential {
 void credential_reject(struct credential *);
 
 int credential_read(struct credential *, FILE *);
+void credential_from_url(struct credential *, const char *url);
 
 #endif /* CREDENTIAL_H */
-- 
1.7.8.rc4.4.g884ec
