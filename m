From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote-curl: Obey passed URL
Date: Thu, 6 Oct 2011 09:37:58 -0400
Message-ID: <20111006133758.GA18033@sigill.intra.peff.net>
References: <4E8D4BD5.2090202@drmicha.warpmail.net>
 <2f1eccfa3fa9e732e9bea344fd69dfd9b16697a9.1317906388.git.git@drmicha.warpmail.net>
 <20111006132500.GA1792@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:38:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBo9H-0006Sw-OU
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab1JFNiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 09:38:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54367
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab1JFNiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 09:38:01 -0400
Received: (qmail 7733 invoked by uid 107); 6 Oct 2011 13:38:00 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 09:38:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 09:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20111006132500.GA1792@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182950>

On Thu, Oct 06, 2011 at 09:25:00AM -0400, Jeff King wrote:

> Your analysis is correct, but tweaking the remote object seems kind
> of ugly. I think a nicer solution would be to pass the URL in
> separately to http_init. Of the three existing callers:

Here's what that patch looks like. It's definitely an improvement and
fixes a real bug, so it may be worth applying. But I'm still going to
look into pushing the url examination closer to the point of use.

-- >8 --
Subject: [PATCH] http_init: accept separate URL parameter

The http_init function takes a "struct remote". Part of its
initialization procedure is to look at the remote's url and
grab some auth-related parameters. However, using the url
included in the remote is:

  - wrong; the remote-curl helper may have a separate,
    unrelated URL (e.g., from remote.*.pushurl). Looking at
    the remote's configured url is incorrect.

  - incomplete; http-fetch doesn't have a remote, so passes
    NULL. So http_init never gets to see the URL we are
    actually going to use.

  - cumbersome; http-push has a similar problem to
    http-fetch, but actually builds a fake remote just to
    pass in the URL.

Instead, let's just add a separate URL parameter to
http_init, and all three callsites can pass in the
appropriate information.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-fetch.c  |    2 +-
 http-push.c   |   10 +---------
 http.c        |    8 ++++----
 http.h        |    2 +-
 remote-curl.c |    2 +-
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 3af4c71..e341872 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -63,7 +63,7 @@ int main(int argc, const char **argv)
 
 	git_config(git_default_config, NULL);
 
-	http_init(NULL);
+	http_init(NULL, url);
 	walker = get_http_walker(url);
 	walker->get_tree = get_tree;
 	walker->get_history = get_history;
diff --git a/http-push.c b/http-push.c
index 376331a..215b640 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1747,7 +1747,6 @@ int main(int argc, char **argv)
 	int i;
 	int new_refs;
 	struct ref *ref, *local_refs;
-	struct remote *remote;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -1821,14 +1820,7 @@ int main(int argc, char **argv)
 
 	memset(remote_dir_exists, -1, 256);
 
-	/*
-	 * Create a minimum remote by hand to give to http_init(),
-	 * primarily to allow it to look at the URL.
-	 */
-	remote = xcalloc(sizeof(*remote), 1);
-	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
-	remote->url[remote->url_nr++] = repo->url;
-	http_init(remote);
+	http_init(NULL, repo->url);
 
 #ifdef USE_CURL_MULTI
 	is_running_queue = 0;
diff --git a/http.c b/http.c
index b2ae8de..d9f9938 100644
--- a/http.c
+++ b/http.c
@@ -357,7 +357,7 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
-void http_init(struct remote *remote)
+void http_init(struct remote *remote, const char *url)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
@@ -421,11 +421,11 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
 
-	if (remote && remote->url && remote->url[0]) {
-		http_auth_init(remote->url[0]);
+	if (url) {
+		http_auth_init(url);
 		if (!ssl_cert_password_required &&
 		    getenv("GIT_SSL_CERT_PASSWORD_PROTECTED") &&
-		    !prefixcmp(remote->url[0], "https://"))
+		    !prefixcmp(url, "https://"))
 			ssl_cert_password_required = 1;
 	}
 
diff --git a/http.h b/http.h
index 0bf8592..3c332a9 100644
--- a/http.h
+++ b/http.h
@@ -86,7 +86,7 @@ struct buffer {
 extern void step_active_slots(void);
 #endif
 
-extern void http_init(struct remote *remote);
+extern void http_init(struct remote *remote, const char *url);
 extern void http_cleanup(void);
 
 extern int data_received;
diff --git a/remote-curl.c b/remote-curl.c
index 69831e9..33d3d8c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -852,7 +852,7 @@ int main(int argc, const char **argv)
 
 	url = strbuf_detach(&buf, NULL);
 
-	http_init(remote);
+	http_init(remote, url);
 
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
-- 
1.7.7.37.g0e376
