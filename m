From: Jeff King <peff@peff.net>
Subject: [PATCH 3/2] doc/http-backend: match query-string in apache half-auth
 example
Date: Fri, 12 Apr 2013 23:33:36 -0400
Message-ID: <20130413033336.GA20333@sigill.intra.peff.net>
References: <20130411033022.GA14462@sigill.intra.peff.net>
 <20130411033613.GB14551@sigill.intra.peff.net>
 <5166E935.2080206@gmail.com>
 <20130411170233.GB1255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Magnus Therning <magnus@therning.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 05:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQrDm-0005ng-3R
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 05:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab3DMDdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 23:33:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43566 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab3DMDdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 23:33:40 -0400
Received: (qmail 972 invoked by uid 107); 13 Apr 2013 03:35:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 23:35:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 23:33:36 -0400
Content-Disposition: inline
In-Reply-To: <20130411170233.GB1255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221043>

When setting up a "half-auth" repository in which reads can
be done anonymously but writes require authentication, it is
best if the server can require authentication for both the
ref advertisement and the actual receive-pack POSTs. This
alleviates the need for the admin to set http.receivepack in
the repositories, and means that the client is challenged
for credentials immediately, instead of partway through the
push process (and git clients older than v1.7.11.7 had
trouble handling these challenges).

Since detecting a push during the ref advertisement requires
matching the query string, and this is non-trivial to do in
Apache, we have traditionally punted and instructed users to
just protect "/git-receive-pack$".  This patch provides the
mod_rewrite recipe to actually match the ref advertisement,
which is preferred.

While we're at it, let's add the recipe to our test scripts
so that we can be sure that it works, and doesn't get broken
(either by our changes or by changes in Apache).

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of the jk/doc-http-backend topic.

Note that I have never used this in production, but it was pieced
together from various advice I found on the web, and I did confirm that
it works.

I kind of assume mod-rewrite is everywhere these days, so we could
potentially drop the fallback config completely, as it is likely to
confuse people.

 Documentation/git-http-backend.txt | 32 ++++++++++++++++++++++++--------
 t/lib-httpd/apache.conf            | 18 ++++++++++++++++++
 t/t5541-http-push.sh               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index cad18ce..e3bcdb5 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -80,7 +80,30 @@ To enable anonymous read access but authenticated write access,
 ----------------------------------------------------------------
 +
 To enable anonymous read access but authenticated write access,
-require authorization with a LocationMatch directive:
+require authorization for both the initial ref advertisement (which we
+detect as a push via the service parameter in the query string), and the
+receive-pack invocation itself:
++
+----------------------------------------------------------------
+RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
+RewriteCond %{REQUEST_URI} /git-receive-pack$
+RewriteRule ^/git/ - [E=AUTHREQUIRED:yes]
+
+<LocationMatch "^/git/">
+	Order Deny,Allow
+	Deny from env=AUTHREQUIRED
+
+	AuthType Basic
+	AuthName "Git Access"
+	Require group committers
+	Satisfy Any
+	...
+</LocationMatch>
+----------------------------------------------------------------
++
+If you do not have `mod_rewrite` available to match against the query
+string, it is sufficient to just protect `git-receive-pack` itself,
+like:
 +
 ----------------------------------------------------------------
 <LocationMatch "^/git/.*/git-receive-pack$">
@@ -207,13 +230,6 @@ auth.require = (
 # ...and set up auth.backend here
 ----------------------------------------------------------------
 +
-Note that unlike the similar setup with Apache, we can easily match the
-query string for receive-pack, catching the initial request from the
-client. This means that the server administrator does not have to worry
-about configuring `http.receivepack` for the repositories (the default
-value, which enables it only in the case of authentication, is
-sufficient).
-+
 To require authentication for both reads and writes:
 +
 ----------------------------------------------------------------
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 938b4cf..542241b 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -40,6 +40,9 @@ ErrorLog error.log
 <IfModule !mod_authz_user.c>
 	LoadModule authz_user_module modules/mod_authz_user.so
 </IfModule>
+<IfModule !mod_authz_host.c>
+	LoadModule authz_host_module modules/mod_authz_host.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
@@ -110,6 +113,21 @@ SSLEngine On
 	Require valid-user
 </LocationMatch>
 
+RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
+RewriteCond %{REQUEST_URI} /git-receive-pack$
+RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
+
+<Location /half-auth-complete/>
+  Order Deny,Allow
+  Deny from env=AUTHREQUIRED
+
+  AuthType Basic
+  AuthName "Git Access"
+  AuthUserFile passwd
+  Require valid-user
+  Satisfy Any
+</Location>
+
 <IfDefine DAV>
 	LoadModule dav_module modules/mod_dav.so
 	LoadModule dav_fs_module modules/mod_dav_fs.so
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 4086f02..beb00be 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -294,5 +294,35 @@ test_expect_success 'push to auth-only-for-push repo' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create repo without http.receivepack set' '
+	cd "$ROOT_PATH" &&
+	git init half-auth &&
+	(
+		cd half-auth &&
+		test_commit one
+	) &&
+	git clone --bare half-auth "$HTTPD_DOCUMENT_ROOT_PATH/half-auth.git"
+'
+
+test_expect_success 'clone via half-auth-complete does not need password' '
+	cd "$ROOT_PATH" &&
+	set_askpass wrong &&
+	git clone "$HTTPD_URL"/half-auth-complete/smart/half-auth.git \
+		half-auth-clone &&
+	expect_askpass none
+'
+
+test_expect_success 'push into half-auth-complete requires password' '
+	cd "$ROOT_PATH/half-auth-clone" &&
+	echo two >expect &&
+	test_commit two &&
+	set_askpass user@host &&
+	git push "$HTTPD_URL/half-auth-complete/smart/half-auth.git" &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/half-auth.git" \
+		log -1 --format=%s >actual &&
+	expect_askpass both user@host &&
+	test_cmp expect actual
+'
+
 stop_httpd
 test_done
-- 
1.8.2.rc0.33.gd915649
