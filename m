From: Jeff King <peff@peff.net>
Subject: [PATCH] http_init: accept separate URL parameter
Date: Wed, 12 Oct 2011 17:43:16 -0400
Message-ID: <20111012214316.GA4393@sigill.intra.peff.net>
References: <4E95FDC8.5030009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:43:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6aD-0003bi-Up
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab1JLVnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 17:43:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58914
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356Ab1JLVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 17:43:19 -0400
Received: (qmail 18354 invoked by uid 107); 12 Oct 2011 21:43:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 17:43:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 17:43:16 -0400
Content-Disposition: inline
In-Reply-To: <4E95FDC8.5030009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183418>

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
On Wed, Oct 12, 2011 at 10:51:20PM +0200, Michael J Gruber wrote:

> > Here's what that patch looks like. It's definitely an improvement and
> > fixes a real bug, so it may be worth applying. But I'm still going to
> > look into pushing the url examination closer to the point of use.
> 
> It definitely is an improvement. I've been running happily with this
> (and without my askpass helper/workaround). Are you going forward with
> this one?

I think we should go ahead with this one. I gave some thought to
tweaking the http code to figure out authentication closer to the point
of use, so we could be adaptive to things like redirects. But it's quite
an invasive change, since we now have to start possibly keeping a string
of credentials, each mapped from their context.

But more importantly, it changes the user-visible behavior. If I do
something like:

  git fetch https://user@git.foo.com/repo.git

and give it a password, and then it redirects me to "git2.foo.com" or
something, then right now we will retry the same credential. I'm not
sure if people rely on that or not.

Arguably, it's wrong to do so in the general case. If I redirect to
"git.someotherdomain.com", you probably _do_ want to re-ask the
credential. So maybe it should be changed, and there should be some
magic with comparing the old and new contexts. I dunno.

At any rate, this is certainly an improvement in the meantime. If the
url parameter to http_init eventually goes away, it is easy enough to do
on top of this.

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
index 6e8f6d0..ecbfae5 100644
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
index d6b2d78..65d3aa7 100644
--- a/http.c
+++ b/http.c
@@ -356,7 +356,7 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
-void http_init(struct remote *remote)
+void http_init(struct remote *remote, const char *url)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
@@ -420,11 +420,11 @@ void http_init(struct remote *remote)
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
index 6c24ab1..d4d0910 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -850,7 +850,7 @@ int main(int argc, const char **argv)
 
 	url = strbuf_detach(&buf, NULL);
 
-	http_init(remote);
+	http_init(remote, url);
 
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF)
-- 
1.7.7.rc2.21.gb9948
