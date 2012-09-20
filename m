From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 13:05:17 -0400
Message-ID: <20120920170517.GB18981@sigill.intra.peff.net>
References: <20120920165938.GB18655@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEkBu-0004h6-15
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 19:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab2ITRFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 13:05:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51587 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab2ITRFU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 13:05:20 -0400
Received: (qmail 17665 invoked by uid 107); 20 Sep 2012 17:05:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 13:05:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 13:05:17 -0400
Content-Disposition: inline
In-Reply-To: <20120920165938.GB18655@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206059>

Usually there is no need for users to specify whether an
http remote is smart or dumb; the protocol is designed so
that a single initial request is made, and the client can
determine the server's capability from the response.

However, some misconfigured dumb-only servers may not like
the initial request by a smart client, as it contains a
query string. Until recently, commit 703e6e7 worked around
this by making a second request. However, that commit was
recently reverted due to its side effect of masking the
initial request's error code.

This patch takes a different approach to the workaround. We
assume that the common case is that the server is either
smart-http or a reasonably configured dumb-http. If that is
not the case, we provide both a per-remote config option and
an environment variable with which the user can manually
work around the issue.

Signed-off-by: Jeff King <peff@peff.net>
---
I added the config item as remote.foo.smarthttp. You could also allow
"http.$url.smart" (and just "http.smart", for that matter), which could
be more flexible if you have multiple remotes pointing to the same
broken server. However, it is also more complex to use, and is a lot
more code. Since we don't know if any such servers even exist, I tried
to give the minimal escape hatch, and we can easily build more features
on it later if people complain.

 Documentation/config.txt | 11 +++++++++++
 remote-curl.c            |  3 ++-
 remote.c                 |  3 +++
 remote.h                 |  1 +
 t/t5551-http-fetch.sh    | 17 +++++++++++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6416cae..651b23c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1871,6 +1871,17 @@ remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
 	option \--upload-pack of linkgit:git-fetch-pack[1].
 
+remote.<name>.smartHttp::
+	If true, this remote will attempt to use git's smart http
+	protocol when making remote http requests. Normally git sends an
+	initial smart-http request, and falls back to the older "dumb"
+	protocol if the server does not claim to support the smart
+	protocol. However, some misconfigured dumb-only servers may
+	produce confusing results for the initial request. Setting this
+	option to false disables the initial smart request, which can
+	workaround problems with such servers. You should not generally
+	need to set this. Defaults to `true`.
+
 remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>. Setting it to \--tags will fetch every
diff --git a/remote-curl.c b/remote-curl.c
index c0b98cc..8829bfb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -102,7 +102,8 @@ static struct discovery* discover_refs(const char *service)
 	free_discovery(last);
 
 	strbuf_addf(&buffer, "%sinfo/refs", url);
-	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
+	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
+	     git_env_bool("GIT_SMART_HTTP", remote->smart_http)) {
 		maybe_smart = 1;
 		if (!strchr(url, '?'))
 			strbuf_addch(&buffer, '?');
diff --git a/remote.c b/remote.c
index 04fd9ea..a334390 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(const char *name, int len)
 		ret->name = xstrndup(name, len);
 	else
 		ret->name = xstrdup(name);
+	ret->smart_http = 1;
 	return ret;
 }
 
@@ -453,6 +454,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 					 key, value);
 	} else if (!strcmp(subkey, ".vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, ".smarthttp")) {
+		remote->smart_http = git_config_bool(key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 251d8fd..9031d18 100644
--- a/remote.h
+++ b/remote.h
@@ -40,6 +40,7 @@ struct remote {
 	int fetch_tags;
 	int skip_default_update;
 	int mirror;
+	int smart_http;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 2db5c35..48173ed 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -129,6 +129,23 @@ test_expect_success 'clone from auth-only-for-push repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'disable dumb http on server' '
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config http.getanyfile false
+'
+
+test_expect_success 'GIT_SMART_HTTP can disable smart http' '
+	(GIT_SMART_HTTP=0 &&
+	 export GIT_SMART_HTTP &&
+	 cd clone &&
+	 test_must_fail git fetch)
+'
+
+test_expect_success 'remote.*.smartHTTP can disable smart http' '
+	(cd clone &&
+	 test_must_fail git -c remote.origin.smartHTTP=false fetch)
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.7.11.7.15.g085c6bd
