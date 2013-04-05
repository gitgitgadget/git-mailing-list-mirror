From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] remote-curl: show server content on http errors
Date: Fri, 5 Apr 2013 18:17:23 -0400
Message-ID: <20130405221723.GB22163@sigill.intra.peff.net>
References: <20130405221331.GA21209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:58:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQG-0001b9-2F
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162924Ab3DEWRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:17:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58236 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162867Ab3DEWRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 18:17:32 -0400
Received: (qmail 18342 invoked by uid 107); 5 Apr 2013 22:19:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 18:19:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 18:17:23 -0400
Content-Disposition: inline
In-Reply-To: <20130405221331.GA21209@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220248>

If an http request to a remote git server fails, we show
only the http response code, or sometimes a custom message
for particular codes. This gives the server no opportunity
to offer a more detailed explanation of the reason for the
failure, or to give extra advice.

This patch teaches remote-curl to record and display the
body content of a failed http response. We only display such
responses when the content-type is advertised as text/plain,
as it is the most likely to look presentable on the user's
terminal (and it is hoped to be a good indication that the
message is intended for git clients, and not for a web
browser).

Each line of the new output is prepended with "remote:".
Example output may look like this (assuming the server is
configured to display such a helpful message):

  $ GIT_SMART_HTTP=0 git clone https://example.com/some/repo.git
  Cloning into 'repo'...
  remote: Sorry, fetching via dumb http is forbidden.
  remote: Please upgrade your git client to v1.6.6 or greater
  remote: and make sure that smart-http is enabled.
  error: The requested URL returned error: 403 while accessing http://localhost:5001/some/repo.git/info/refs
  fatal: HTTP request failed

For the sake of simplicity, we only record and display these
errors during the initial fetch of the ref list, as that is
the initial contact with the server and where the most
common, interesting errors happen (and there is already
precedent, as that is the only place we currently massage
http error codes into more helpful messages).

Signed-off-by: Jeff King <peff@peff.net>
---
I took Jonathan's suggestion of just respecting text/plain to signify a
message that git can show on the terminal. It is the most sensible
content-type to use, I think, but I'm a little worried that
random servers may produce totally uninteresting text/plain (e.g., many
servers ship with 404 pages that just say "404" again with more useless
text). But such pages tend to be text/html, so we may be able to get
away with assuming text/plain will be useful.

 remote-curl.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 93a09a6..4fea94f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -151,6 +151,33 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
+static int show_http_message(struct strbuf *type, struct strbuf *msg)
+{
+	const char *p, *eol;
+
+	/*
+	 * We only show text/plain parts, as other types are likely
+	 * to be ugly to look at on the user's terminal.
+	 *
+	 * TODO should handle "; charset=XXX", and re-encode into
+	 * logoutputencoding
+	 */
+	if (strcasecmp(type->buf, "text/plain"))
+		return -1;
+
+	strbuf_trim(msg);
+	if (!msg->len)
+		return -1;
+
+	p = msg->buf;
+	do {
+		eol = strchrnul(p, '\n');
+		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
+		p = eol + 1;
+	} while(*eol);
+	return 0;
+}
+
 static struct discovery* discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
@@ -176,16 +203,20 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);
 
-	http_ret = http_get_strbuf(refs_url, &type, &buffer, HTTP_NO_CACHE);
+	http_ret = http_get_strbuf(refs_url, &type, &buffer,
+				   HTTP_NO_CACHE | HTTP_KEEP_ERROR);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
+		show_http_message(&type, &buffer);
 		die("%s not found: did you run git update-server-info on the"
 		    " server?", refs_url);
 	case HTTP_NOAUTH:
+		show_http_message(&type, &buffer);
 		die("Authentication failed");
 	default:
+		show_http_message(&type, &buffer);
 		http_error(refs_url, http_ret);
 		die("HTTP request failed");
 	}
-- 
1.8.2.rc0.33.gd915649
