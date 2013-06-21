From: Jeff King <peff@peff.net>
Subject: [PATCH] lib-httpd/apache.conf: check version only after mod_version
 loads
Date: Fri, 21 Jun 2013 14:12:51 -0400
Message-ID: <20130621181250.GA5290@sigill.intra.peff.net>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
 <20130621043052.GA5318@sigill.intra.peff.net>
 <20130621044236.GA5798@sigill.intra.peff.net>
 <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
 <20130621044953.GA5962@sigill.intra.peff.net>
 <D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com>
 <20130621180334.GA4499@sigill.intra.peff.net>
 <1B9251F9-C1AF-41F7-8BF8-D36DDB27EF09@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq5pR-00051M-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423568Ab3FUSMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:12:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:40302 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423509Ab3FUSMx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:12:53 -0400
Received: (qmail 21074 invoked by uid 102); 21 Jun 2013 18:13:53 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Jun 2013 13:13:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 14:12:51 -0400
Content-Disposition: inline
In-Reply-To: <1B9251F9-C1AF-41F7-8BF8-D36DDB27EF09@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228640>

On Fri, Jun 21, 2013 at 02:08:49PM -0400, Brian Gernhardt wrote:

> On Jun 21, 2013, at 2:03 PM, Jeff King <peff@peff.net> wrote:
> 
> > IfVersion comes from mod_version. I assume that if it were not
> > loaded, apache would complain about the directive entirely. But it's
> > true that we don't load it until later. Maybe try moving the
> > IfVersion/Lockfile stanza down below the mod_version LoadModule
> > line?
> 
> Apache is apparently overly accepting.  Moving the IfVersion below all
> the IfModules fixes it.

Cool. I think the patch should look like the one below, then.

Just to double-check that I have explained the issue correctly, can you
share the output of "apache2 -l"? Mine has:

  $ apache2 -l
  Compiled in modules:
    core.c
    mod_log_config.c
    mod_logio.c
    mod_version.c
    prefork.c
    http_core.c
    mod_so.c

which explains why it works here. I'm assuming you will not have
mod_version.c compiled in.

-- >8 --
Subject: lib-httpd/apache.conf: check version only after mod_version loads

Commit 0442743 introduced an <IfVersion> directive near the
top of the apache config file. However, at that point we
have not yet checked for and loaded the mod_version module.
This means that the directive will behave oddly if
mod_version is dynamically loaded, failing to match when it
should.

We can fix this by moving the whole block below the
LoadModule directive for mod_version.

Reported-by: Brian Gernhardt <brian@gernhardtsoftware.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 56ae548..dd17e3a 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -1,7 +1,4 @@ ServerName dummy
 ServerName dummy
-<IfVersion < 2.4>
-LockFile accept.lock
-</IfVersion>
 PidFile httpd.pid
 DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
@@ -26,6 +23,10 @@ ErrorLog error.log
 	LoadModule version_module modules/mod_version.so
 </IfModule>
 
+<IfVersion < 2.4>
+LockFile accept.lock
+</IfVersion>
+
 <IfVersion < 2.1>
 <IfModule !mod_auth.c>
 	LoadModule auth_module modules/mod_auth.so
-- 
1.8.3.rc2.14.g7eee6b3
