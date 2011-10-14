From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 6/6] http_init: accept separate URL parameter
Date: Fri, 14 Oct 2011 09:40:40 +0200
Message-ID: <57f0b2e5fedc91f22962517af620da8c209642ec.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:41:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcOA-0006DO-W7
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab1JNHk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:56 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39406 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932654Ab1JNHky (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:54 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 55D9E20B99;
	Fri, 14 Oct 2011 03:40:54 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 14 Oct 2011 03:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Ux
	6+t4/O48C+7Tfd1nwNr625qyg=; b=STj2T1usqJ1y2SHccbkMG3FuIqvV6GLH3U
	9PMbf9aDuhyuJrvsx3MjxpkDmCvVLXO6KYBoc3zwev6q9gB2g8BsEdlbHzGzBSBJ
	mZHEAX3v31zowgWRiaGRqDl/Bt/6iYpWyyMH929YbaXdgQgyUPCLplG7Hh7WlDIn
	ka0WMG8Hk=
X-Sasl-enc: VkpXgxwth0X+vSrVcAolK1voCoOO5K17Xhq5CoSa8XaW 1318578053
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A92AB4833FD;
	Fri, 14 Oct 2011 03:40:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183550>

From: Jeff King <peff@peff.net>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 149e116..b181c8a 100644
--- a/http.c
+++ b/http.c
@@ -367,7 +367,7 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
-void http_init(struct remote *remote)
+void http_init(struct remote *remote, const char *url)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
@@ -431,11 +431,11 @@ void http_init(struct remote *remote)
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
@@ -86,7 +86,7 @@ extern void add_fill_function(void *data, int (*fill)(void *));
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
1.7.7.338.g0156b
