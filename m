From: Jeff King <peff@peff.net>
Subject: [PATCH 10/14] http: use hostname in credential description
Date: Mon, 18 Jul 2011 03:52:32 -0400
Message-ID: <20110718075232.GJ12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiid3-00052y-Tu
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab1GRHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:52:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50631
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab1GRHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:52:34 -0400
Received: (qmail 19941 invoked by uid 107); 18 Jul 2011 07:53:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:53:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:52:32 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177353>

Until now, a request for an http password looked like:

  Username:
  Password:

Now it will look like:

  Username for 'example.com':
  Password for 'example.com':

Signed-off-by: Jeff King <peff@peff.net>
---
This has been requested a few times. I think we could go even further
with:

  Username for 'example.com':
  Password for 'user@example.com':

It's not that big a deal if you just typed the username, obviously, but
if the username came out of the config file, it might be a helpful
reminder.

 http.c                |    7 +++----
 t/t5550-http-fetch.sh |    4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 4c047be..d6b2d78 100644
--- a/http.c
+++ b/http.c
@@ -310,7 +310,6 @@ static CURL *get_curl_handle(void)
 static void http_auth_init(const char *url)
 {
 	const char *at, *colon, *cp, *slash, *host, *proto_end;
-	char *decoded;
 	struct strbuf unique = STRBUF_INIT;
 
 	proto_end = strstr(url, "://");
@@ -342,11 +341,11 @@ static void http_auth_init(const char *url)
 		host = at + 1;
 	}
 
+	http_auth.description = url_decode_mem(host, slash - host);
+
 	strbuf_add(&unique, url, proto_end - url);
 	strbuf_addch(&unique, ':');
-	decoded = url_decode_mem(host, slash - host);
-	strbuf_addstr(&unique, decoded);
-	free(decoded);
+	strbuf_addstr(&unique, http_auth.description);
 	http_auth.unique = strbuf_detach(&unique, NULL);
 }
 
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 407e1cb..b04261c 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -51,8 +51,8 @@ test_expect_success 'setup askpass helpers' '
 	GIT_ASKPASS="$PWD/askpass" &&
 	export GIT_ASKPASS &&
 	>askpass-expect-none &&
-	echo "askpass: Password: " >askpass-expect-pass &&
-	{ echo "askpass: Username: " &&
+	echo "askpass: Password for '\''$HTTPD_DEST'\'': " >askpass-expect-pass &&
+	{ echo "askpass: Username for '\''$HTTPD_DEST'\'': " &&
 	  cat askpass-expect-pass
 	} >askpass-expect-both
 '
-- 
1.7.6.rc1.12.g65e2
