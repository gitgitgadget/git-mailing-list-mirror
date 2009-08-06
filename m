From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 1/3] gitweb: Add optional "time to generate page" info in footer
Date: Thu,  6 Aug 2009 19:11:50 +0200
Message-ID: <1249578712-3862-2-git-send-email-jnareb@gmail.com>
References: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6Vt-00048i-Dx
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341AbZHFRMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756342AbZHFRMO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:12:14 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:42728 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325AbZHFRMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:12:13 -0400
Received: by gxk9 with SMTP id 9so1289858gxk.13
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oYGhVI7D8eXhHQzgs60sRRcv6BpJHSoYp+tABVZ2xB0=;
        b=l7kfyDINYmkYo6RC248KhmUK3ajEjzLkj0uGVRy2e64vqzcWXE6KHHMJPeL3RJoL0F
         +UAu2XRlKUprPZ+U/KmN9abAWW9uSeS6YJBXallkwCEfZugFBx5EnisVKxfCVDbVfXVR
         N8/DcFwYyOylTqlfO8rIOZVLwkoAd8uJlXpCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=atLgSJI1UKtA2LQ+MpTJAd5k1w61uHCnE9gKOlvz1d3IAel3Mh+S0Rk9wzWvDet1+g
         eiahi4lZZNCV91ppbN+eLaJycm1lMKSHpEs6v7cjUkDwpDyeCx52+OBVTR4MhfomIu94
         Mkl661NLMSOqE6YrVj+rP0jPBYJrIKPDKnJrU=
Received: by 10.90.33.16 with SMTP id g16mr87919agg.37.1249578734018;
        Thu, 06 Aug 2009 10:12:14 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.24])
        by mx.google.com with ESMTPS id 21sm660987agb.65.2009.08.06.10.12.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 10:12:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n76HC94h003899;
	Thu, 6 Aug 2009 19:12:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n76HC9UQ003898;
	Thu, 6 Aug 2009 19:12:09 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125093>

Add "This page took XXXs and Y git commands to generate" to page
footer, if global feature 'timed' is enabled (disabled by default).
Requires Time::HiRes installed for high precision 'wallclock' time.

Note that setting $t0 variable should be fairly early to have running
time of the whole script.  The same for $number_of_git_cmds.

This code is based on example code by Petr 'Pasky' Baudis.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from previous version.

Current formatting is very basic, just like before.  It simply uses 
'page_footer' style.  At least "time to generate page" info should
be clearly separate from the gitweb footer proper.

 gitweb/gitweb.perl |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2cb60be..c6894e2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,6 +18,12 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
+our $t0;
+if (eval { require Time::HiRes; 1; }) {
+	$t0 = [Time::HiRes::gettimeofday()];
+}
+our $number_of_git_cmds = 0;
+
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
@@ -394,6 +400,13 @@ our %feature = (
 		'sub' => \&feature_avatar,
 		'override' => 0,
 		'default' => ['']},
+
+	# Enable displaying how much time and how many git commands
+	# it took to generate and display page.  Disabled by default.
+	# Project specific override is not supported.
+	'timed' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -507,6 +520,7 @@ if (-e $GITWEB_CONFIG) {
 
 # version of the core git binary
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+$number_of_git_cmds++;
 
 $projects_list ||= $projectroot;
 
@@ -1955,6 +1969,7 @@ sub get_feed_info {
 
 # returns path to the core git executable and the --git-dir parameter as list
 sub git_cmd {
+	$number_of_git_cmds++;
 	return $GIT, '--git-dir='.$git_dir;
 }
 
@@ -3205,6 +3220,20 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
+	if (defined $t0 && gitweb_check_feature('timed')) {
+		print "<div id=\"generate_info\" class=\"page_footer\">\n";
+		print 'This page took '.
+		      '<span id="generate_time" class="time_span">'.
+		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).'s'.
+		      '</span>'.
+		      ' and '.
+		      '<span id="generate_cmd">'.
+		      $number_of_git_cmds.
+		      '</span> git commands '.
+		      " to generate.\n";
+		print "</div>\n"; # class="page_footer"
+	}
+
 	if (-f $site_footer) {
 		insert_file($site_footer);
 	}
-- 
1.6.3.3
