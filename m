From: Jeff King <peff@peff.net>
Subject: [PATCH] t/lib-httpd: pass through GIT_CONFIG_NOSYSTEM env
Date: Tue, 15 Mar 2016 20:56:52 -0400
Message-ID: <20160316005651.GA29541@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 01:57:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzlj-0005yH-PD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbcCPA44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:56:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:60278 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752517AbcCPA4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 20:56:55 -0400
Received: (qmail 22327 invoked by uid 102); 16 Mar 2016 00:56:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 20:56:54 -0400
Received: (qmail 9435 invoked by uid 107); 16 Mar 2016 00:57:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 20:57:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2016 20:56:52 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288935>

We set GIT_CONFIG_NOSYSTEM in our test scripts so that we do
not accidentally read /etc/gitconfig and have it influence
the outcome of the tests. But when running smart-http tests,
Apache will clean the environment, including this variable,
and the "server" side of our http operations will read it.

You can see this breakage by doing something like:

  make
  ./git config --system http.getanyfile false
  make test

which will cause t5561 to fail when it tests the
fallback-to-dumb operation.

We can fix this by instructing Apache to pass through the
variable. Unlike with other variables (e.g., 89c57ab3's
GIT_TRACE), we don't need to set a dummy value to prevent
warnings from Apache. test-lib.sh already makes sure that
GIT_CONFIG_NOSYSTEM is set and exported.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously trivial enough for "maint", but not at all urgent; it has
been this way for ages. I only noticed because I happened to recently
munge my system config to replicate a particular server config which
disables http.getanyfile.

 t/lib-httpd/apache.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index f667e7c..9317ba0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -74,6 +74,7 @@ PassEnv GIT_VALGRIND_OPTIONS
 PassEnv GNUPGHOME
 PassEnv ASAN_OPTIONS
 PassEnv GIT_TRACE
+PassEnv GIT_CONFIG_NOSYSTEM
 
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
-- 
2.8.0.rc2.331.ga574393
