From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 5/6] gitweb: Make possible to run under mod_perl without SetupEnv
Date: Thu, 28 Dec 2006 00:49:12 +0100
Message-ID: <200612280049.13385.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:04:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzikc-0002G6-Lm
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWL1ADr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWL1ADq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836AbWL1ADk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021260uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BNcFK/qEeU/ha3ZF4saVR0frQP0niX6m+d/BKCSJDdqkWJSehpjqrdCKGxuiqxBV6t0mOGuegkou3FPGkaRFiaYFjAtCh3KHr/Cla/5Z2HNt/0esJPpxTmVKqf313FndSRPihTNeWyqKWIdq1i9bix4aV6sjDiW+WIyyeOKpubQ=
Received: by 10.67.91.6 with SMTP id t6mr4022262ugl.1167264219826;
        Wed, 27 Dec 2006 16:03:39 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.39;
        Wed, 27 Dec 2006 16:03:39 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612272355.31923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35493>

Make possible to run gitweb under mod_perl without need to set up CGI
environmental variables (i.e. "PerlOptions -SetupEnv" in mod_perl 2.0,
"PerlSetupEnv Off" in mod_perl 1.0).

Actually ModPerl::Registry / Apache::Registry populates %ENV hash,
without need to actually set environmental variables.


Pass the request variable $r to CGI constructor if CGI.pm module is
new enough (at least CGI version 2.93, and at least 3.11 for mod_perl
2.0).

Replace $ENV{'PATH_INFO'} by $r->path_info() if we use mod_perl.

Replace $ENV{'SERVER_NAME'} by $r->server()->server_hostname() if we
use mod_perl.

Uniquify using of %ENV to $ENV{'NAME'}, while at it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch appears to be unnecessary, at least for now, because
mod_perl Registry populates %ENV hash (and does not need to set
envirionmental variables). Still, it prepares the way for future
running gitweb as mod_perl handler, and not under Registry.

Perhaps the cleanup part of this patch should be put into separate
patch...

 gitweb/gitweb.perl |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9983e9e..2900ae6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -32,11 +32,16 @@ BEGIN {
 	# use appropriate mod_perl modules (conditional use)
 	if (MP_GEN == 2) {
 		require Apache2::RequestRec;
+		require Apache2::ServerRec;
+		require Apache2::Response;
 		require Apache2::Const;
+		Apache2::RequestRec->import();
+		Apache2::ServerRec->import();
 		Apache2::Const->import(-compile => qw(:common :http));
 	} elsif (MP_GEN == 1) {
 		require Apache;
 		require Apache::Constants;
+		import Apache;
 		Apache::Constants->import(qw(:common :http));
 	}
 
@@ -48,7 +53,15 @@ BEGIN {
 my $r;
 $r = shift @_ if MP_GEN;
 
-our $cgi = new CGI;
+our $cgi;
+if ((MP_GEN == 1 && $CGI::VERSION >= 2.93) ||
+    (MP_GEN == 2 && $CGI::VERSION >= 3.11)) {
+	# CGI.pm is new enough
+	$cgi = new CGI($r);
+} else {
+	$cgi = new CGI;
+}
+
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
@@ -70,7 +83,8 @@ our $home_link_str = "++GITWEB_HOME_LINK_STR++";
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
 our $site_name = "++GITWEB_SITENAME++"
-                 || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
+                 || (($r ? $r->server()->server_hostname() : $ENV{'SERVER_NAME'})
+                     || "Untitled") . " Git";
 
 # filename of html text to include at top of each page
 our $site_header = "++GITWEB_SITE_HEADER++";
@@ -403,7 +417,7 @@ if (defined $searchtype) {
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
-	my $path_info = $ENV{"PATH_INFO"};
+	my $path_info = $r ? $r->path_info() : $ENV{'PATH_INFO'};
 	return if !$path_info;
 	$path_info =~ s,^/+,,;
 	return if !$path_info;
-- 
1.4.4.3
