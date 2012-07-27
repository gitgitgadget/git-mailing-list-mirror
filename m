From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 3/5] Make Git::SVN::Ra use an accessor for URLs
Date: Fri, 27 Jul 2012 13:00:50 -0700
Message-ID: <1343419252-9447-4-git-send-email-schwern@pobox.com>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 22:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suqj1-0003Oo-48
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab2G0UBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:01:21 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46497 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2G0UBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:01:19 -0400
Received: by gglu4 with SMTP id u4so3601077ggl.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=imsr5/jZ+q5Vhs+yvyXd8aZOBUNnD0Cn1aYu9WyFNeo=;
        b=uLRbq0dFwbbyDouZPktk5K4iyMsHOZ2dEizQOszLyCcMoLNQA3Bh+8pUoWgqSplf8D
         k+N8orssM5zGL1yE6kdmV7oWdZoQcPh4ZMuGpyRiv3ICeaRcr2wiP3x+2sbiPX35BXVx
         34Oj8ZtNUCiY1w8gaTfVw+sCupUsLZTWIzUOKOzoBUjKOBtaojEUcBAq1uCASJWOzrHa
         /CEfKrAVTTCsFAY5xSgF5GtOcUxRfo+ipX7CN0yPTTNuEiEboao2HwXvATrUBtgEVEMb
         rkLrAd085m81MwQeM7Mqkk/GVsxq03baUO6V8y9LDhMECx2Y+WtKOkMMP/Wa+uvpRasl
         i6Og==
Received: by 10.66.89.4 with SMTP id bk4mr7831396pab.44.1343419278406;
        Fri, 27 Jul 2012 13:01:18 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id sk5sm2489907pbc.7.2012.07.27.13.01.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 13:01:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202370>

From: "Michael G. Schwern" <schwern@pobox.com>

Later it can canonicalize automatically.

A later change will make other things use the accessor.

No functional change.
---
 perl/Git/SVN/Ra.pm | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 23ff43e..329f855 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -84,7 +84,7 @@ sub escape_url {
 sub new {
 	my ($class, $url) = @_;
 	$url =~ s!/+$!!;
-	return $RA if ($RA && $RA->{url} eq $url);
+	return $RA if ($RA && $RA->url eq $url);
 
 	::_req_svn();
 
@@ -119,15 +119,33 @@ sub new {
 	                      config => $config,
 			      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
-	$self->{url} = $url;
+	$RA = bless $self, $class;
+
+	# Make sure its canonicalized
+	$self->url($url);
 	$self->{svn_path} = $url;
 	$self->{repos_root} = $self->get_repos_root;
 	$self->{svn_path} =~ s#^\Q$self->{repos_root}\E(/|$)##;
 	$self->{cache} = { check_path => { r => 0, data => {} },
 	                   get_dir => { r => 0, data => {} } };
-	$RA = bless $self, $class;
+
+	return $RA;
+}
+
+
+sub url {
+    my $self = shift;
+
+    if( @_ ) {
+        my $url = shift;
+        $self->{url} = $url;
+        return;
+    }
+
+    return $self->{url};
 }
 
+
 sub check_path {
 	my ($self, $path, $r) = @_;
 	my $cache = $self->{cache}->{check_path};
@@ -285,7 +303,7 @@ sub gs_do_switch {
 	my $path = $gs->{path};
 	my $pool = SVN::Pool->new;
 
-	my $full_url = $self->{url};
+	my $full_url = $self->url;
 	my $old_url = $full_url;
 	$full_url .= '/' . $path if length $path;
 	my ($ra, $reparented);
@@ -300,7 +318,7 @@ sub gs_do_switch {
 		$ra_invalid = 1;
 	} elsif ($old_url ne $full_url) {
 		SVN::_Ra::svn_ra_reparent($self->{session}, $full_url, $pool);
-		$self->{url} = $full_url;
+		$self->url($full_url);
 		$reparented = 1;
 	}
 
@@ -313,7 +331,7 @@ sub gs_do_switch {
 
 	if ($reparented) {
 		SVN::_Ra::svn_ra_reparent($self->{session}, $old_url, $pool);
-		$self->{url} = $old_url;
+		$self->url($old_url);
 	}
 
 	$pool->clear;
@@ -362,7 +380,7 @@ sub gs_fetch_loop_common {
 	my $inc = $_log_window_size;
 	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
 	my $longest_path = longest_common_path($gsv, $globs);
-	my $ra_url = $self->{url};
+	my $ra_url = $self->url;
 	my $find_trailing_edge;
 	while (1) {
 		my %revs;
@@ -508,7 +526,7 @@ sub match_globs {
 				 ($self->check_path($p, $r) !=
 				  $SVN::Node::dir));
 			next unless $p =~ /$g->{path}->{regex}/;
-			$exists->{$p} = Git::SVN->init($self->{url}, $p, undef,
+			$exists->{$p} = Git::SVN->init($self->url, $p, undef,
 					 $g->{ref}->full_path($de), 1);
 		}
 	}
@@ -532,7 +550,7 @@ sub match_globs {
 			next if ($self->check_path($pathname, $r) !=
 			         $SVN::Node::dir);
 			$exists->{$pathname} = Git::SVN->init(
-			                      $self->{url}, $pathname, undef,
+			                      $self->url, $pathname, undef,
 			                      $g->{ref}->full_path($p), 1);
 		}
 		my $c = '';
@@ -548,7 +566,7 @@ sub match_globs {
 
 sub minimize_url {
 	my ($self) = @_;
-	return $self->{url} if ($self->{url} eq $self->{repos_root});
+	return $self->url if ($self->url eq $self->{repos_root});
 	my $url = $self->{repos_root};
 	my @components = split(m!/!, $self->{svn_path});
 	my $c = '';
@@ -568,7 +586,7 @@ sub can_do_switch {
 	unless (defined $can_do_switch) {
 		my $pool = SVN::Pool->new;
 		my $rep = eval {
-			$self->do_switch(1, '', 0, $self->{url},
+			$self->do_switch(1, '', 0, $self->url,
 			                 SVN::Delta::Editor->new, $pool);
 		};
 		if ($@) {
-- 
1.7.11.3
