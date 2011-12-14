From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 19:11:56 -0500
Message-ID: <20111214001156.GA21940@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
 <7vaa6wuqjt.fsf@alter.siamese.dyndns.org>
 <20111213231909.GD12432@sigill.intra.peff.net>
 <20111213232053.GE12432@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 01:12:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RacSI-0004tQ-5P
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214Ab1LNAL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 19:11:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49859
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755997Ab1LNAL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:11:58 -0500
Received: (qmail 25685 invoked by uid 107); 14 Dec 2011 00:18:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 19:18:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 19:11:56 -0500
Content-Disposition: inline
In-Reply-To: <20111213232053.GE12432@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187081>

On Tue, Dec 13, 2011 at 06:20:53PM -0500, Jeff King wrote:

> BTW, one other solution, rather than reverting Stefan's patch, is to
> just re-add the "unconditionally ask for a password" behavior back to
> git-http-push, but not to the fetching side. Especially if we hope to
> kill off git-http-push soon (after a deprecation period presumably),
> then that lets it work in the meantime without hurting the other http
> code. And it's really easy to do.

And here's what that patch looks like.

Thinking on it more, this is probably better for a maint release than
reverting Stefan's patch. It un-breaks http-push, and they are no
differently off than they are with the revert. But it leaves the
enhancement in place for the smart-http code.

-- >8 --
Subject: [PATCH] http-push: enable "proactive auth"

Before commit 986bbc08, git was proactive about asking for
http passwords. It assumed that if you had a username in
your URL, you would also want a password, and asked for it
before making any http requests.

However, this could interfere with the use of .netrc (see
986bbc08 for details). And it was also unnecessary, since
the http fetching code had learned to recognize an HTTP 401
and prompt the user then. Furthermore, the proactive prompt
could interfere with the usage of .netrc (see 986bbc08 for
details).

Unfortunately, the http push-over-DAV code never learned to
recognize HTTP 401, and so was broken by this change. This
patch does a quick fix of re-enabling the "proactive auth"
strategy only for http-push, leaving the dumb http fetch and
smart-http as-is.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-fetch.c         |    2 +-
 http-push.c          |    2 +-
 http.c               |    8 +++++++-
 http.h               |    3 ++-
 remote-curl.c        |    2 +-
 t/t5540-http-push.sh |    2 +-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 69299b7..94d47cb 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -67,7 +67,7 @@ int main(int argc, const char **argv)
 
 	git_config(git_default_config, NULL);
 
-	http_init(NULL, url);
+	http_init(NULL, url, 0);
 	walker = get_http_walker(url);
 	walker->get_tree = get_tree;
 	walker->get_history = get_history;
diff --git a/http-push.c b/http-push.c
index 5d01be9..70283e6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1820,7 +1820,7 @@ int main(int argc, char **argv)
 
 	memset(remote_dir_exists, -1, 256);
 
-	http_init(NULL, repo->url);
+	http_init(NULL, repo->url, 1);
 
 #ifdef USE_CURL_MULTI
 	is_running_queue = 0;
diff --git a/http.c b/http.c
index 008ad72..6c90092 100644
--- a/http.c
+++ b/http.c
@@ -43,6 +43,7 @@
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
 static char *user_name, *user_pass, *description;
+static int http_proactive_auth;
 static const char *user_agent;
 
 #if LIBCURL_VERSION_NUM >= 0x071700
@@ -279,6 +280,9 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
+	if (http_proactive_auth)
+		init_curl_http_auth(result);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
@@ -367,7 +371,7 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
-void http_init(struct remote *remote, const char *url)
+void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
@@ -378,6 +382,8 @@ void http_init(struct remote *remote, const char *url)
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
+	http_proactive_auth = proactive_auth;
+
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
 
diff --git a/http.h b/http.h
index 3c332a9..51f6ba7 100644
--- a/http.h
+++ b/http.h
@@ -86,7 +86,8 @@ struct buffer {
 extern void step_active_slots(void);
 #endif
 
-extern void http_init(struct remote *remote, const char *url);
+extern void http_init(struct remote *remote, const char *url,
+		      int proactive_auth);
 extern void http_cleanup(void);
 
 extern int data_received;
diff --git a/remote-curl.c b/remote-curl.c
index 0e720ee..0757b19 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -859,7 +859,7 @@ int main(int argc, const char **argv)
 
 	url = strbuf_detach(&buf, NULL);
 
-	http_init(remote, url);
+	http_init(remote, url, 0);
 
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 3300227..1eea647 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -160,7 +160,7 @@ test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 	"$ROOT_PATH"/test_repo_clone master
 
-test_expect_failure 'push to password-protected repository (user in URL)' '
+test_expect_success 'push to password-protected repository (user in URL)' '
 	test_commit pw-user &&
 	git push "$HTTPD_URL_USER/auth/dumb/test_repo.git" HEAD &&
 	git rev-parse --verify HEAD >expect &&
-- 
1.7.8.17.gfd3524
