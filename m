From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: require $ENV{'GITWEB_CONFIG'}
Date: Wed, 2 Aug 2006 22:29:36 +0200
Message-ID: <E1G8NLU-0006TL-J7@moooo.ath.cx>
References: <20060802192333.GA30861@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:29:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NLb-00066J-TO
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWHBU3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWHBU3k
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:29:40 -0400
Received: from moooo.ath.cx ([85.116.203.178]:8087 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932229AbWHBU3k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:29:40 -0400
To: Jeff King <peff@peff.net>
Mail-Followup-To: Jeff King <peff@peff.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060802192333.GA30861@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24677>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
With this patch it is possible to use gitweb.perl for developing by
loading the configuration from $GITWEB_CONFIG.  This might also be
useful for normal usage of gitweb.  Example:
% cat cfg 
$GIT = '/usr/bin/git';
$projectroot = '/home/matled/src/git';
$projects_list = '/home/matled/src/git/git/gitweb/list';
% cat run
#!/bin/sh
export GATEWAY_INTERFACE="CGI/1.1"
export HTTP_ACCEPT="*/*"
export REQUEST_METHOD="GET"
export GITWEB_CONFIG='./cfg'
export QUERY_STRING=""$1""
exec ./gitweb.perl
% time ./run p=git/.git > /dev/null 
./run p=git/.git > /dev/null  0.47s user 0.58s system 102% cpu 1.025
total

This makes it easy to check for warnings and do performance tests
after changes, you can also pipe this to lynx -dump -force-html
/dev/stdin to get more than just html :)

This also documents the original patch adding require $GITWEB_CONFIG.
---
 gitweb/README      |    5 +++++
 gitweb/gitweb.perl |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index b91d42a..dc4b850 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -23,6 +23,11 @@ You can specify the following configurat
    Points to the location where you put gitweb.css on your web server.
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server.
+ * GITWEB_CONFIG
+   This file will be loaded using 'require'.  If the environment
+   $GITWEB_CONFIG is set when gitweb.cgi is executed the file in the
+   environment variable will be loaded additionally (after) the file
+   specified when gitweb.cgi was created.
 
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f4c0d87..efcc926 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -63,6 +63,10 @@ our $mimetypes_file = undef;
 our $GITWEB_CONFIG = '@@GITWEB_CONFIG@@';
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
+if (defined($ENV{'GITWEB_CONFIG'}) && -e $ENV{'GITWEB_CONFIG'}) {
+	require $ENV{'GITWEB_CONFIG'};
+}
+
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
-- 
1.4.2.rc2.g4713
