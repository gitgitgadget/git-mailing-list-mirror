From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 5/8] Canonicalize earlier in a couple spots.
Date: Sat, 28 Jul 2012 02:47:49 -0700
Message-ID: <1343468872-72133-6-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3dw-0005QI-5q
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab2G1Jsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42332 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab2G1JsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503059pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SrOnD2HHoFKcxpEKK8ta/QiP74eWiO1UgEuQ0nCm6RY=;
        b=ntjcWhwxnNVHp1uio8/8V7fTY78iFstzlnmuOM6winDKeTnVMxJMwU6m9yTGNzWIr3
         oI9UDI1IHY88GAjcyJEy7zJ5yIxkJC5BhTV28OtexNhv1mMdR73Lx09P3zGjwHwYTJuJ
         I5gNCIgYzBUP3pbNYKhpveWtnVPnghHOVeYhznQulwld6Zn3nlqKWvug+GYE/iWwDuFa
         EjLli2rPjJqMY83wt7fWP1OI+NjSlUnZT0aNKJbk4FeSORu8UIC0qviUYJjT7Uib9AYF
         +43LLCotcOmOW2uh/dh997aL4yPrFEOjc0QYG3SurcpijMfyIzmI8MUrjHa/d0PAlRpg
         wz5A==
Received: by 10.68.195.202 with SMTP id ig10mr20382541pbc.37.1343468888964;
        Sat, 28 Jul 2012 02:48:08 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202425>

From: "Michael G. Schwern" <schwern@pobox.com>

Just a few things I noticed.  Its good to canonicalize as early as
possible.
---
 git-svn.perl       | 6 +++---
 perl/Git/SVN/Ra.pm | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6e97545..6b90765 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1436,16 +1436,16 @@ sub cmd_info {
 	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
 	$path = "." if $path eq "";
 
-	my $full_url = $url . ($fullpath eq "" ? "" : "/$fullpath");
+	my $full_url = canonicalize_url( $url . ($fullpath eq "" ? "" : "/$fullpath") );
 
 	if ($_url) {
-		print canonicalize_url($full_url), "\n";
+		print "$full_url\n";
 		return;
 	}
 
 	my $result = "Path: $path\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
-	$result .= "URL: " . canonicalize_url($full_url) . "\n";
+	$result .= "URL: $full_url\n";
 
 	eval {
 		my $repos_root = $gs->repos_root;
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index ed9dbe9..eee7c00 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -69,7 +69,7 @@ sub _auth_providers () {
 
 sub new {
 	my ($class, $url) = @_;
-	$url =~ s!/+$!!;
+	$url = canonicalize_url($url);
 	return $RA if ($RA && $RA->url eq $url);
 
 	::_req_svn();
@@ -101,7 +101,7 @@ sub new {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
 	} # no warnings 'once'
-	my $self = SVN::Ra->new(url => canonicalize_url($url), auth => $baton,
+	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
-- 
1.7.11.3
