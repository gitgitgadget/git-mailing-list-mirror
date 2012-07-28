From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 4/8] Replace hand rolled URL escapes with canonicalization
Date: Sat, 28 Jul 2012 02:47:48 -0700
Message-ID: <1343468872-72133-5-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3e6-0005aT-Jv
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab2G1Jsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2G1JsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503035pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GdlixFXskvdGTRmTOH2VR9eq1anxi1RFRlZ9FbmzKao=;
        b=h0rsN/GQkN61eEqUxjh67gH3iEufAXitm5RiXpZohURVyViDTeQbLol1ziI7iKljrs
         STawHEJ57hIiKZ0LluFUyixy0PTPPShNtg4s1h0BNN3fZv+XIFCAMw7tK6FQj6AjPsPA
         yi3oodDb4vwCAA8zy++AgzILUc9Ip8Ga/YWToZ7QBkFypw1cq0CvSgDawUr4W3lpAyq8
         DnkcctvyeF9WNpHj3pvxMC9hHmL3G5ZLVGPIg5Xc42TYLdQMst0DSFfU2hpxxC+XELK+
         wSZqGPyndnlB0Bm0I7+/zYO/YsYm82aG9T0ItjPxJAxXPWg5YCf9Mz9pYD55zlLUvi/G
         QwGw==
Received: by 10.68.238.166 with SMTP id vl6mr20183678pbc.96.1343468888006;
        Sat, 28 Jul 2012 02:48:08 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202426>

From: "Michael G. Schwern" <schwern@pobox.com>

Continuing to move towards getting everything canonicalizing the same way.

* Git::SVN->init_remote_config and Git::SVN::Ra->minimize_url both
  have to canonicalize the same way else init_remote_config
  will incorrectly think they're different URLs causing
  t9107-git-svn-migrate.sh to fail.
---
 git-svn.perl       | 24 +++---------------------
 perl/Git/SVN.pm    |  2 +-
 perl/Git/SVN/Ra.pm | 27 +++++----------------------
 3 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 6e3e240..6e97545 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1412,24 +1412,6 @@ sub cmd_commit_diff {
 	}
 }
 
-sub escape_uri_only {
-	my ($uri) = @_;
-	my @tmp;
-	foreach (split m{/}, $uri) {
-		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
-		push @tmp, $_;
-	}
-	join('/', @tmp);
-}
-
-sub escape_url {
-	my ($url) = @_;
-	if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
-		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
-		$url = "$scheme://$domain$uri";
-	}
-	$url;
-}
 
 sub cmd_info {
 	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
@@ -1457,18 +1439,18 @@ sub cmd_info {
 	my $full_url = $url . ($fullpath eq "" ? "" : "/$fullpath");
 
 	if ($_url) {
-		print escape_url($full_url), "\n";
+		print canonicalize_url($full_url), "\n";
 		return;
 	}
 
 	my $result = "Path: $path\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
-	$result .= "URL: " . escape_url($full_url) . "\n";
+	$result .= "URL: " . canonicalize_url($full_url) . "\n";
 
 	eval {
 		my $repos_root = $gs->repos_root;
 		Git::SVN::remove_username($repos_root);
-		$result .= "Repository Root: " . escape_url($repos_root) . "\n";
+		$result .= "Repository Root: " . canonicalize_url($repos_root) . "\n";
 	};
 	if ($@) {
 		$result .= "Repository Root: (offline)\n";
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index cb6d83a..4219e5b 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -296,7 +296,7 @@ sub find_existing_remote {
 
 sub init_remote_config {
 	my ($self, $url, $no_write) = @_;
-	$url =~ s!/+$!!; # strip trailing slash
+	$url = canonicalize_url($url);
 	my $r = read_all_remotes();
 	my $existing = find_existing_remote($url, $r);
 	if ($existing) {
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index ef7b3dd..ed9dbe9 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -66,24 +66,6 @@ sub _auth_providers () {
 	\@rv;
 }
 
-sub escape_uri_only {
-	my ($uri) = @_;
-	my @tmp;
-	foreach (split m{/}, $uri) {
-		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
-		push @tmp, $_;
-	}
-	join('/', @tmp);
-}
-
-sub escape_url {
-	my ($url) = @_;
-	if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
-		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
-		$url = "$scheme://$domain$uri";
-	}
-	$url;
-}
 
 sub new {
 	my ($class, $url) = @_;
@@ -119,7 +101,7 @@ sub new {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
 	} # no warnings 'once'
-	my $self = SVN::Ra->new(url => escape_url($url), auth => $baton,
+	my $self = SVN::Ra->new(url => canonicalize_url($url), auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
@@ -314,7 +296,7 @@ sub gs_do_switch {
 
 	if ($old_url =~ m#^svn(\+ssh)?://# ||
 	    ($full_url =~ m#^https?://# &&
-	     escape_url($full_url) ne $full_url)) {
+	     canonicalize_url($full_url) ne $full_url)) {
 		$_[0] = undef;
 		$self = undef;
 		$RA = undef;
@@ -327,7 +309,7 @@ sub gs_do_switch {
 	}
 
 	$ra ||= $self;
-	$url_b = escape_url($url_b);
+	$url_b = canonicalize_url($url_b);
 	my $reporter = $ra->do_switch($rev_b, '', 1, $url_b, $editor, $pool);
 	my @lock = (::compare_svn_version('1.2.0') >= 0) ? (undef) : ();
 	$reporter->set_path('', $rev_a, 0, @lock, $pool);
@@ -582,7 +564,8 @@ sub minimize_url {
 			$ra->get_log("", $latest, 0, 1, 0, 1, sub {});
 		};
 	} while ($@ && ($c = shift @components));
-	$url;
+
+	return canonicalize_url($url);
 }
 
 sub can_do_switch {
-- 
1.7.11.3
