From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache (WIP)
Date: Sat, 23 Jan 2010 01:27:33 +0100
Message-ID: <f4660e9c7ffdb4a62da0c56703de002c9df3b598.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrl-0002dP-VQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473Ab0AWA2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482Ab0AWA17
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:59 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:38962 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471Ab0AWA14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:56 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so1932519fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=E7iNW7QqFHTlOOEXAAvu82wN7kgy0ATnWbO7Tf4lV1E=;
        b=MznZEu3ZV+QfotjHCqNV+qpGUNb2tiFLguC8axo/TAkEGa//7cKrmLb8d8mPBi7eyY
         yfHusMIjHCc/hsq6xy1Ho6+T1+boZePRRGsRG4npOV2BbGcjz8TBHmgpHMAtJc0wnm9V
         ZEvUom5Vcv7XqW6VDG6QL0rXH7dVlsjOpJGWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NCdtSAYcfGFtJYuIvo6rZiwowWAyX1/fzkHa+7EF/rpOwgG1gzt3HnjQEDfrUN0oGv
         VfgRpsSNcJK7YmplwAy6nGiooggs8DdlhBsDOjj2p0+dtGFqcrKi9oZURUQd8OWDl/E5
         FIx7m8RLujpk3GopNvXn9u5T4PJBDjP5ANps8=
Received: by 10.103.80.15 with SMTP id h15mr1952269mul.54.1264206475179;
        Fri, 22 Jan 2010 16:27:55 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:54 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137802>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress.

Contrary to the patch by J.H. the subroutine that is responsible for
doing "Generating..." progress info / activity indicator is in
gitweb.perl, and not in cache.pm.  Also it does not use not declared
nor defined $title variable ;-)

Compared with original patch by J.H. gitweb prints generating info in
more restricted set of situations; the set of actions where gitweb
does not generate activity indicator is larger.  We could probably
provide activity indicator also for (possibly) non-HTML output, like
'blob_plain' or 'patches', provided that 'User-Agent' denotes that we
are using web browser.

In the future we would probably want Ajax-y JavaScript-based activity
indicator, without need for busy-wait.

NOTE that I have not tested that it works, only that it should not
contain syntax errors...

 gitweb/cache.pm    |   32 ++++++++++++++++++++-
 gitweb/gitweb.perl |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 1adf467..2c7be3a 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -63,7 +63,8 @@ sub new {
 	$self = bless($self, $class);
 
 	my ($root, $depth, $ns);
-	my ($expires_min, $expires_max, $increase_factor, $check_load);
+	my ($expires_min, $expires_max, $increase_factor,
+	    $check_load, $generating_info);
 	if (defined $p_options_hash_ref) {
 		$root  = $p_options_hash_ref->{'cache_root'};
 		$depth = $p_options_hash_ref->{'cache_depth'};
@@ -76,6 +77,7 @@ sub new {
 			$p_options_hash_ref->{'expires_max'};
 		$increase_factor = $p_options_hash_ref->{'expires_factor'};
 		$check_load      = $p_options_hash_ref->{'check_load'};
+		$generating_info = $p_options_hash_ref->{'generating_info'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -92,6 +94,7 @@ sub new {
 	$self->set_expires_max($expires_max);
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
+	$self->set_generating_info($generating_info);
 
 	return $self;
 }
@@ -186,6 +189,18 @@ sub set_check_load {
 	$self->{'_Check_Load'} = $sub;
 }
 
+sub get_generating_info {
+	my ($self) = @_;
+
+	return $self->{'_Generating_Info'};
+}
+
+sub set_generating_info {
+	my ($self, $sub) = @_;
+
+	$self->{'_Generating_Info'} = $sub;
+}
+
 # ......................................................................
 
 sub get_expires_in {
@@ -203,6 +218,12 @@ sub get_expires_in {
 	return $expires_in;
 }
 
+sub generating_info {
+	if (defined $self->get_generating_info()) {
+		$self->get_generating_info()->($self, @_);
+	}
+}
+
 # ----------------------------------------------------------------------
 # (private) utility functions and methods
 
@@ -434,6 +455,9 @@ sub compute {
 		# acquired writers lock
 		my $pid = fork() if $data;
 		if (!defined $pid || $pid) {
+			# provide "generating page..." info if there is no stale data to serve
+			$self->generating_info($p_key, $lock_fh)
+				unless ($data);
 			# parent, or didn't fork
 			$data = $p_coderef->($self, $p_key);
 			$self->set($p_key, $data);
@@ -451,8 +475,12 @@ sub compute {
 			;
 		}
 	} else {
+		# some else process is (re)generating cache
 		if (!defined $data) {
-			# get readers lock if there is no stale data to serve
+			# there is no stale data to serve
+			# provide "generating page..." info
+			$self->generating_info($p_key, $lock_fh);
+			# get readers lock
 			flock($lock_fh, LOCK_SH);
 			$data = $self->restore($self->get_namespace(), $p_key);
 		}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0394dc8..cb46b8c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -13,7 +13,7 @@ use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
 use Encode;
-use Fcntl ':mode';
+use Fcntl qw(:mode :flock);
 use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
@@ -1023,6 +1023,7 @@ if ($caching_enabled) {
 		'cache_root'  => '/tmp/cache',
 		'cache_depth' => 2,
 		'expires_in'  => 20, # in seconds
+		'generating_info' => \&git_generating_data_html,
 	});
 	cache_fetch($cache, $action);
 } else {
@@ -3215,6 +3216,78 @@ sub blob_contenttype {
 ## ======================================================================
 ## functions printing HTML: header, footer, error page
 
+sub git_generating_data_html {
+	my ($cache, $key, $lock_fh) = @_;
+
+	if ($action eq 'atom' || $action eq 'rss' || $action eq 'opml' || # feeds
+	    $action eq 'blob_plain' || # unknown mimetype
+	    $action eq 'commitdiff_plain' || # text/plain
+	    $action eq 'patch' || $action eq 'patches' || # text/plain
+	    $action eq 'snapshot') { # binary
+		return;
+	}
+
+	my $title = "[Generating...] $site_name";
+	if (defined $project) {
+		$title .= " - " . to_utf8($project);
+		if (defined $action) {
+			$title .= "/$action";
+			if (defined $file_name) {
+				$title .= " - " . esc_path($file_name);
+				if ($action eq "tree" && $file_name !~ m|/$|) {
+					$title .= "/";
+				}
+			}
+		}
+	}
+
+	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
+	print STDOUT $cgi->header(-type => 'text/html', -charset => 'utf-8',
+	                          -status=> '200 OK', -expires => 'now');
+	print STDOUT <<"EOF";
+<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
+                      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
+<!-- git web interface version $version -->
+<!-- git core binaries version $git_version -->
+<head>
+<meta http-equiv="content-type" content="text/html; charset=utf-8" />
+<meta http-equiv="refresh" content="0" />
+<meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version" />
+<meta name="robots" content="noindex, nofollow" />
+<title>$title</title>
+</head>
+<body>
+EOF
+	print STDOUT 'Generating..';
+
+	my $ready;
+	my ($wait, $wait_step, $wait_max); # in seconds
+	$wait = 0;
+	$wait_step = 2;
+	$wait_max = 20;
+	$| = 1; # autoflush
+	do {
+		print STDOUT '.';
+
+		sleep $wait_step if ($wait > 0);
+		$wait += $wait_step;
+
+		$ready = flock($lock_fh, LOCK_SH|LOCK_NB)
+			if $lock_fh;
+
+	} while (!$ready && ($wait < $wait_max));
+
+	print STDOUT <<"EOF";
+
+</body>
+</html>
+EOF
+	#exit 0;
+	return;
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
-- 
1.6.6.1
