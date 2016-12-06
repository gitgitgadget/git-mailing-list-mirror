Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBAAD1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbcLFSZi (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:25:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:52588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbcLFSZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:25:30 -0500
Received: (qmail 4606 invoked by uid 109); 6 Dec 2016 18:24:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:24:36 +0000
Received: (qmail 15697 invoked by uid 111); 6 Dec 2016 18:25:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:25:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:24:35 -0500
Date:   Tue, 6 Dec 2016 13:24:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v2 2/6] http: always update the base URL for redirects
Message-ID: <20161206182435.3o5viseqbisxmc6b@sigill.intra.peff.net>
References: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a malicious server redirects the initial ref
advertisement, it may be able to leak sha1s from other,
unrelated servers that the client has access to. For
example, imagine that Alice is a git user, she has access to
a private repository on a server hosted by Bob, and Mallory
runs a malicious server and wants to find out about Bob's
private repository.

Mallory asks Alice to clone an unrelated repository from her
over HTTP. When Alice's client contacts Mallory's server for
the initial ref advertisement, the server issues an HTTP
redirect for Bob's server. Alice contacts Bob's server and
gets the ref advertisement for the private repository. If
there is anything to fetch, she then follows up by asking
the server for one or more sha1 objects. But who is the
server?

If it is still Mallory's server, then Alice will leak the
existence of those sha1s to her.

Since commit c93c92f30 (http: update base URLs when we see
redirects, 2013-09-28), the client usually rewrites the base
URL such that all further requests will go to Bob's server.
But this is done by textually matching the URL. If we were
originally looking for "http://mallory/repo.git/info/refs",
and we got pointed at "http://bob/other.git/info/refs", then
we know that the right root is "http://bob/other.git".

If the redirect appears to change more than just the root,
we punt and continue to use the original server. E.g.,
imagine the redirect adds a URL component that Bob's server
will ignore, like "http://bob/other.git/info/refs?dummy=1".

We can solve this by aborting in this case rather than
silently continuing to use Mallory's server. In addition to
protecting from sha1 leakage, it's arguably safer and more
sane to refuse a confusing redirect like that in general.
For example, part of the motivation in c93c92f30 is
avoiding accidentally sending credentials over clear http,
just to get a response that says "try again over https". So
even in a non-malicious case, we'd prefer to err on the side
of caution.

The downside is that it's possible this will break a
legitimate but complicated server-side redirection scheme.
The setup given in the newly added test does work, but it's
convoluted enough that we don't need to care about it. A
more plausible case would be a server which redirects a
request for "info/refs?service=git-upload-pack" to just
"info/refs" (because it does not do smart HTTP, and for some
reason really dislikes query parameters).  Right now we
would transparently downgrade to dumb-http, but with this
patch, we'd complain (and the user would have to set
GIT_SMART_HTTP=0 to fetch).

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                        | 12 ++++++++----
 t/lib-httpd/apache.conf       |  8 ++++++++
 t/t5551-http-fetch-smart.sh   |  4 ++++
 t/t5812-proto-disable-http.sh |  1 +
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index d4034a14b..718d2109b 100644
--- a/http.c
+++ b/http.c
@@ -1491,9 +1491,9 @@ static int http_request(const char *url,
  *
  * Note that this assumes a sane redirect scheme. It's entirely possible
  * in the example above to end up at a URL that does not even end in
- * "info/refs".  In such a case we simply punt, as there is not much we can
- * do (and such a scheme is unlikely to represent a real git repository,
- * which means we are likely about to abort anyway).
+ * "info/refs".  In such a case we die. There's not much we can do, such a
+ * scheme is unlikely to represent a real git repository, and failing to
+ * rewrite the base opens options for malicious redirects to do funny things.
  */
 static int update_url_from_redirect(struct strbuf *base,
 				    const char *asked,
@@ -1511,10 +1511,14 @@ static int update_url_from_redirect(struct strbuf *base,
 
 	new_len = got->len;
 	if (!strip_suffix_mem(got->buf, &new_len, tail))
-		return 0; /* insane redirect scheme */
+		die(_("unable to update url base from redirection:\n"
+		      "  asked for: %s\n"
+		      "   redirect: %s"),
+		    asked, got->buf);
 
 	strbuf_reset(base);
 	strbuf_add(base, got->buf, new_len);
+
 	return 1;
 }
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 018a83a5a..9a355fb1c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -132,6 +132,14 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
 RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
 RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
 
+# The first rule issues a client-side redirect to something
+# that _doesn't_ look like a git repo. The second rule is a
+# server-side rewrite, so that it turns out the odd-looking
+# thing _is_ a git repo. The "[PT]" tells Apache to match
+# the usual ScriptAlias rules for /smart.
+RewriteRule ^/insane-redir/(.*)$ /intern-redir/$1/foo [R=301]
+RewriteRule ^/intern-redir/(.*)/foo$ /smart/$1 [PT]
+
 # Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
 # And as RewriteCond does not allow testing for non-matches, we match
 # the desired case first (one has abra, two has cadabra), and let it
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 2f375eb94..d8826acde 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -110,6 +110,10 @@ test_expect_success 'redirects re-root further requests' '
 	git clone $HTTPD_URL/smart-redir-limited/repo.git repo-redir-limited
 '
 
+test_expect_success 're-rooting dies on insane schemes' '
+	test_must_fail git clone $HTTPD_URL/insane-redir/repo.git insane
+'
+
 test_expect_success 'clone from password-protected repository' '
 	echo two >expect &&
 	set_askpass user@host pass@host &&
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 0d105d541..044cc152f 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -18,6 +18,7 @@ test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
 
 test_expect_success 'curl redirects respect whitelist' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
+			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
 	{
 		test_i18ngrep "ftp.*disabled" stderr ||
-- 
2.11.0.191.gdb26c57

