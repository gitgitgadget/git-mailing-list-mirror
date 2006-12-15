X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add some mod_perl specific support
Date: Fri, 15 Dec 2006 22:18:05 +0100
Message-ID: <11662174851575-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Fri, 15 Dec 2006 21:15:54 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=ANrfjyX4MREBQN7YdBp6u0RtGk2DLdr17qOWaZwm+fiOaS4qlonbprfHM9Qb07OILcpPtNCYqQoE0u+MB0s1NtarhuAKQYkECpt9H/D6WhSpiSQw3ey04MB8tqS2nDvIUoEeLGG7VvTb1qbWivrX1RXz+sQMxBj59zJ9Ue1kqGI=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34552>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKPA-00018G-7R for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753312AbWLOVPj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbWLOVPj
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:15:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:34005 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753312AbWLOVPi (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 16:15:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so919885uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 13:15:37 -0800 (PST)
Received: by 10.66.248.5 with SMTP id v5mr514800ugh.1166217336869; Fri, 15
 Dec 2006 13:15:36 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 e33sm4758326ugd.2006.12.15.13.15.36; Fri, 15 Dec 2006 13:15:36 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBFLI6YE004821; Fri, 15 Dec 2006 22:18:07 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBFLI6hS004820; Fri, 15 Dec 2006 22:18:06 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add $r variable which holds Apache::RequestRec if script is run under
mod_perl (if $ENV{MOD_PERL} is defined). It is used as argument to
constructor of CGI object (needs CGI module version at least 2.93).
It is needed for further mod_perl support, for example adding
headers using Apache::RequestRec methods instead of making Apache
to have to parse headers (to add it's own HTTP headers like Server:
header).

Following advice from CGI(3pm) man page, precompile all CGI routines
for mod_perl.

Use $r->path_info() instead of $ENV{"PATH_INFO"}.

All this makes gitweb slightly faster under mod_perl (436 +/-  23.9 ms
for summary of git.git before, 429 +/- 12.0 ms after, according to
'ab -n 10 -k "http://localhost/perl/gitweb/gitweb.cgi?p=git.git"').

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is the same patch as previous
  'gitweb: Sprinkle some mod_perl goodies'

 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 902c514..7df253c 100755
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
