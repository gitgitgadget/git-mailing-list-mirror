From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] doc/http-backend: give some lighttpd config examples
Date: Wed, 10 Apr 2013 23:36:13 -0400
Message-ID: <20130411033613.GB14551@sigill.intra.peff.net>
References: <20130411033022.GA14462@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Magnus Therning <magnus@therning.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 05:36:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ8JF-0005QU-B4
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936202Ab3DKDgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 23:36:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39636 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758624Ab3DKDgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 23:36:20 -0400
Received: (qmail 11237 invoked by uid 107); 11 Apr 2013 03:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 23:38:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 23:36:13 -0400
Content-Disposition: inline
In-Reply-To: <20130411033022.GA14462@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220811>

The examples in the documentation are all for Apache. Let's
at least cover the basics: an anonymous server, an
authenticated server, and a "half auth" server with
anonymous read and authenticated write.

Signed-off-by: Jeff King <peff@peff.net>
---
I am by no means a lighttpd expert, so there may be better ways to do
some of these. But I did test that they all work as expected.

I was tempted for a moment to provide a mechanism for the t55* tests to
use either lighttpd _or_ apache, so that these could get some automated
testing. But I don't relish the thought of trying to keep both configs
synchronized as people update one or the other.

There are also some advanced setups in the apache part of the doc that I
didn't translate here (e.g., dumb-http fallback, and static serving of
dumb-http files). Mostly because I don't think they are that commonly
used these days, and I do not know enough about lighttpd configuration
to translate them easily. If somebody wants to make a patch on top, they
can.

 Documentation/git-http-backend.txt | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f43980f..cad18ce 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -167,6 +167,61 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
+Lighttpd::
+	Ensure that `mod_cgi`, `mod_alias, `mod_auth`, `mod_setenv` are
+	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
+	all requests to the CGI:
++
+----------------------------------------------------------------
+alias.url += ( "/git" => "/usr/lib/git-core/git-http-backend" )
+$HTTP["url"] =~ "^/git" {
+	cgi.assign = ("" => "")
+	setenv.add-environment = (
+		"GIT_PROJECT_ROOT" => "/var/www/git",
+		"GIT_HTTP_EXPORT_ALL" => ""
+	)
+}
+----------------------------------------------------------------
++
+To enable anonymous read access but authenticated write access:
++
+----------------------------------------------------------------
+$HTTP["querystring"] =~ "service=git-receive-pack" {
+	include "git-auth.conf"
+}
+$HTTP["url"] =~ "^/git/.*/git-receive-pack$" {
+	include "git-auth.conf"
+}
+----------------------------------------------------------------
++
+where `git-auth.conf` looks something like:
++
+----------------------------------------------------------------
+auth.require = (
+	"/" => (
+		"method" => "basic",
+		"realm" => "Git Access",
+		"require" => "valid-user"
+	       )
+)
+# ...and set up auth.backend here
+----------------------------------------------------------------
++
+Note that unlike the similar setup with Apache, we can easily match the
+query string for receive-pack, catching the initial request from the
+client. This means that the server administrator does not have to worry
+about configuring `http.receivepack` for the repositories (the default
+value, which enables it only in the case of authentication, is
+sufficient).
++
+To require authentication for both reads and writes:
++
+----------------------------------------------------------------
+$HTTP["url"] =~ "^/git/private" {
+	include "git-auth.conf"
+}
+----------------------------------------------------------------
+
 
 ENVIRONMENT
 -----------
-- 
1.8.2.rc0.33.gd915649
