Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CDE1FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 09:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbcLAJL0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:11:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:49670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758309AbcLAJEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:04:42 -0500
Received: (qmail 5000 invoked by uid 109); 1 Dec 2016 09:04:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 09:04:34 +0000
Received: (qmail 30697 invoked by uid 111); 1 Dec 2016 09:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 04:05:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 04:04:33 -0500
Date:   Thu, 1 Dec 2016 04:04:33 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: [PATCH 5/6] http: treat http-alternates like redirects
Message-ID: <20161201090432.wtcu2jpacwcf6a4a@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit made HTTP redirects more obvious and
tightened up the default behavior. However, there's another
way for a server to ask a git client to fetch arbitrary
content: by having an http-alternates file (or a regular
alternates file, which is used as a backup).

Similar to the HTTP redirect case, a malicious server can
claim to have refs pointing at object X, return a 404 when
the client asks for X, but point to some other URL via
http-alternates, which the client will transparently fetch.
The end result is that it looks from the user's perspective
like the objects came from the malicious server, as the
other URL is not mentioned at all.

Worse, because we feed the new URL to curl ourselves, the
usual protocol restrictions do not kick in (neither curl's
default of disallowing file://, nor the protocol
whitelisting in f4113cac0 (http: limit redirection to
protocol-whitelist, 2015-09-22).

Let's apply the same rules here as we do for HTTP redirects.
Namely:

  - unless http.followRedirects is set to "always", we will
    not follow remote redirects from http-alternates (or
    alternates) at all

  - set CURLOPT_PROTOCOLS alongside CURLOPT_REDIR_PROTOCOLS
    restrict ourselves to a known-safe set and respect any
    user-provided whitelist.

  - mention alternate object stores on stderr so that the
    user is aware another source of objects may be involved

The first item may prove to be too restrictive. The most
common use of alternates is to point to another path on the
same server. While it's possible for a single-server
redirect to be an attack, it takes a fairly obscure setup
(victim and evil repository on the same host, host speaks
dumb http, and evil repository has access to edit its own
http-alternates file).

So we could make the checks more specific, and only cover
cross-server redirects. But that means parsing the URLs
ourselves, rather than letting curl handle them. This patch
goes for the simpler approach. Given that they are only used
with dumb http, http-alternates are probably pretty rare.
And there's an escape hatch: the user can allow redirects on
a specific server by setting http.<url>.followRedirects to
"always".

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c              |  8 +++++---
 http.c                     |  1 +
 t/t5550-http-fetch-dumb.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 0b2425531..25a8b1ad4 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -274,9 +274,8 @@ static void process_alternates_response(void *callback_data)
 				struct strbuf target = STRBUF_INIT;
 				strbuf_add(&target, base, serverlen);
 				strbuf_add(&target, data + i, posn - i - 7);
-				if (walker->get_verbosely)
-					fprintf(stderr, "Also look at %s\n",
-						target.buf);
+				warning("adding alternate object store: %s",
+					target.buf);
 				newalt = xmalloc(sizeof(*newalt));
 				newalt->next = NULL;
 				newalt->base = strbuf_detach(&target, NULL);
@@ -302,6 +301,9 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	struct alternates_request alt_req;
 	struct walker_data *cdata = walker->data;
 
+	if (http_follow_config != HTTP_FOLLOW_ALWAYS)
+		return;
+
 	/*
 	 * If another request has already started fetching alternates,
 	 * wait for them to arrive and return to processing this request's
diff --git a/http.c b/http.c
index 825118481..051fe6e5a 100644
--- a/http.c
+++ b/http.c
@@ -745,6 +745,7 @@ static CURL *get_curl_handle(void)
 	if (is_transport_allowed("ftps"))
 		allowed_protocols |= CURLPROTO_FTPS;
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
+	curl_easy_setopt(result, CURLOPT_PROTOCOLS, allowed_protocols);
 #else
 	if (transport_restrict_protocols())
 		warning("protocol restrictions not applied to curl redirects because\n"
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 532507b7c..264a1ab8b 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -330,5 +330,43 @@ test_expect_success 'http.followRedirects defaults to "initial"' '
 	test_must_fail git clone $HTTPD_URL/redir-objects/repo.git default
 '
 
+# The goal is for a clone of the "evil" repository, which has no objects
+# itself, to cause the client to fetch objects from the "victim" repository.
+test_expect_success 'set up evil alternates scheme' '
+	victim=$HTTPD_DOCUMENT_ROOT_PATH/victim.git &&
+	git init --bare "$victim" &&
+	git -C "$victim" --work-tree=. commit --allow-empty -m secret &&
+	git -C "$victim" repack -ad &&
+	git -C "$victim" update-server-info &&
+	sha1=$(git -C "$victim" rev-parse HEAD) &&
+
+	evil=$HTTPD_DOCUMENT_ROOT_PATH/evil.git &&
+	git init --bare "$evil" &&
+	# do this by hand to avoid object existence check
+	printf "%s\\t%s\\n" $sha1 refs/heads/master >"$evil/info/refs"
+'
+
+# Here we'll just redirect via HTTP. In a real-world attack these would be on
+# different servers, but we should reject it either way.
+test_expect_success 'http-alternates is a non-initial redirect' '
+	echo "$HTTPD_URL/dumb/victim.git/objects" \
+		>"$evil/objects/info/http-alternates" &&
+	test_must_fail git -c http.followRedirects=initial \
+		clone $HTTPD_URL/dumb/evil.git evil-initial &&
+	git -c http.followRedirects=true \
+		clone $HTTPD_URL/dumb/evil.git evil-initial
+'
+
+# Curl supports a lot of protocols that we'd prefer not to allow
+# http-alternates to use, but it's hard to test whether curl has
+# accessed, say, the SMTP protocol, because we are not running an SMTP server.
+# But we can check that it does not allow access to file://, which would
+# otherwise allow this clone to complete.
+test_expect_success 'http-alternates cannot point at funny protocols' '
+	echo "file://$victim/objects" >"$evil/objects/info/http-alternates" &&
+	test_must_fail git -c http.followRedirects=true \
+		clone "$HTTPD_URL/dumb/evil.git" evil-file
+'
+
 stop_httpd
 test_done
-- 
2.11.0.319.g1f4e1e0

