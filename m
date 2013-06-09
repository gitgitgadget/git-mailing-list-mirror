From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] t/lib-httpd/apache.conf: configure an MPM module for
 apache 2.4
Date: Sun, 9 Jun 2013 04:09:32 -0400
Message-ID: <20130609080932.GD32139@sigill.intra.peff.net>
References: <20130609080722.GA31699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 10:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulah4-00049j-W5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 10:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab3FIIJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 04:09:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:33144 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab3FIIJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 04:09:35 -0400
Received: (qmail 21632 invoked by uid 102); 9 Jun 2013 08:10:24 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 03:10:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 04:09:32 -0400
Content-Disposition: inline
In-Reply-To: <20130609080722.GA31699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226947>

Versions of Apache before 2.4 always had a "MultiProcessing
Module" (MPM) statically built in, which manages the worker
threads/processes. We do not care which one, as it is
largely a performance issue, and we put only a light load on
the server during our testing.

As of Apache 2.4, the MPM module is loadable just like any
other module, but exactly one such module must be loaded. On
a system where the MPMs are compiled dynamically (e.g.,
Debian unstable), this means that our test Apache server
will not start unless we provide the appropriate
configuration.

Unfortunately, we do not actually know which MPM modules are
available or appropriate for the system on which the tests
are running. This patch picks the "prefork" module, as it
is likely to be available on all Unix-like systems.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 4883b8c..56ae548 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -57,6 +57,9 @@ ErrorLog error.log
 <IfModule !mod_access_compat.c>
 	LoadModule access_compat_module modules/mod_access_compat.so
 </IfModule>
+<IfModule !mod_mpm_prefork.c>
+	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
-- 
1.8.3.rc2.14.g7eee6b3
