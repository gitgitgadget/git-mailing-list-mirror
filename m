X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Sprinkle some mod_perl goodies
Date: Tue, 12 Dec 2006 17:55:59 +0100
Message-ID: <1165942559879-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Tue, 12 Dec 2006 16:54:11 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=jOVy/lYzF6pAc+UT4pPY9/cewjSe0R7OGZb9o+e0aPfmrLWHEEWo8pfI3l47QcqtSMJuU49OXo1Uu9xVp/GX9O061GpPE3OvBuX/+Hv7gETKR3UA84WQqU+f2rfsSZIVuDUAXDdBvszOX0UvIxiTEaH6BYbXcGN1rmwiAzM7I2M=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34111>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuAtF-00012e-9P for gcvg-git@gmane.org; Tue, 12 Dec
 2006 17:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751494AbWLLQx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 11:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWLLQx6
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 11:53:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:41716 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751494AbWLLQx5 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 11:53:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1719860uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 08:53:56 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr12033307ugm.1165942436248; Tue, 12
 Dec 2006 08:53:56 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 j34sm7011046ugc.2006.12.12.08.53.55; Tue, 12 Dec 2006 08:53:55 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBCGu9aQ030930; Tue, 12 Dec 2006 17:56:11 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBCGu0st030926; Tue, 12 Dec 2006 17:56:00 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add $r variable which holds Apache::RequestRec if script is run under
mod_perl (if $ENV{MOD_PERL} is defined). It is used as argument to
constructor of CGI object (needs CGI module version at least 2.93).

Following advice from CGI(3pm) man page, precompile all CGI routines
for mod_perl.

Use $r->path_info() instead of $ENV{"PATH_INFO"}.

All this makes gitweb slightly faster under mod_perl.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 040ee71..ebe59b8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,11 +18,18 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
-our $cgi = new CGI;
+# mod_perl request
+my $r;
+$r = shift @_ if $ENV{MOD_PERL};
+
+our $cgi = new CGI($r);
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
+# speeding up mod_perl and FastCGI (later)
+$cgi->compile() if $r;
+
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
 our $GIT = "++GIT_BINDIR++/git";
@@ -364,7 +371,7 @@ if (defined $searchtype) {
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
-	my $path_info = $ENV{"PATH_INFO"};
+	my $path_info = $r ? $r->path_info() : $ENV{"PATH_INFO"};
 	return if !$path_info;
 	$path_info =~ s,^/+,,;
 	return if !$path_info;
-- 
1.4.4.1
