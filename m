From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache
Date: Tue,  9 Feb 2010 11:30:27 +0100
Message-ID: <1265711427-15193-11-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenNA-0003mJ-CG
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab0BIKbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:31:01 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:57696 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab0BIKa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:58 -0500
Received: by fxm20 with SMTP id 20so3026840fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7sAEyL74WwiXG0ilqE3+CS0VMXezBWCXVNtsHDBeBX0=;
        b=B0ib7Qi7wlrPncBDFo0UF28hryduzCOTs8GIP3kqwI8ALHO1Szp9drKOZbJnq4chrr
         kRFOt0KG3i8E/RKl4i0/dhLNfErVNI7wWJJAbLNgX8BRSFDnS9ctmAsyU88/H3MoEvFC
         5BjHHxvQp/2i4NWdMqcdv1/tG//xWXcsB4O5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rKHe0hMxgbtsMmZnvFZwuiZOauP5vOsEfG1ZbGY3WVvir7J3dhIpT8F1V/OIQxQvnd
         5TtON3RcG8rzBO9FcSmZqm8pDzQ51X5gQl2sPj2SpRVuaFMdHFQLpGqezM41Eh/BPmlb
         yHHrGauVp1db9GNHlBQnx2cw4HQ0BnAzr4Am4=
Received: by 10.223.17.70 with SMTP id r6mr5409709faa.22.1265711456781;
        Tue, 09 Feb 2010 02:30:56 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:56 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139386>

When there exist stale/expired (but not too stale) version of
(re)generated page in cache, gitweb returns stale version (and updates
cache in background, assuming 'background_cache' is set to true value).
When there is no stale version suitable to serve the client, currently
we have to wait for the data to be generated in full before showing it.
Add to GitwebCache::SimpleFileCache, via 'generating_info' callback,
the ability to show user some activity indicator / progress bar, to
show that we are working on generating data.

Gitweb itself uses "Generating..." page as activity indicator, which
redirects (via <meta http-equiv="Refresh" ...>) to refreshed version
of the page after the cache is filled (via trick of not closing page
and therefore not closing connection till data is available in cache,
checked by getting shared/readers lock on lockfile for cache entry).
The git_generating_data_html() subroutine, which is used by gitweb
to implement this feature, is highly configurable: you can choose
initial delay, frequency of writing some data so that connection
won't get closed, and maximum time to wait for data in "Generating..."
page (see %generating_options hash).

Currently git_generating_data_html() contains hardcoded "whitelist" of
actions for which such HTML "Generating..." page makes sense.


This implements final feature from the original gitweb output caching
patch by J.H.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v1:
* Proper commit message.
* get/set_generating_info accessors are now generated.
* Fixed bug in ->generating_info() method, caught by new tests.
* You can now turn off "Generating..." feature, by unsetting 9setting to
  undef or deleting) of the 'generating_info' key in %cache_options
* git_generating_data_html() uses whitelist of actions where "Generating..."
  page is allowed, instead of blacklist of actions where it should not be
  used.
* Action check is done using extended regexp rather than comparing with
  strings with 'eq'.
* git_generating_data_html() must now stop capturing response; with 
  'print $out <sth>' it was easy to ensure printing activity indicator
  to client (to standard output).

Differences from v1, which are also differences from J.H. patch:
* "Generating..." info behavior can be configured (at least the timings) via
  %generating_options hash, instead of having those options hardcoded.
* There is initial 'startup_delay' (by default 1 second); if the data is
  generated by that time, the "Generating..." page is not shown.
* Waiting is done using blocking flock + alarm, rather than "busy wait"
  loop with non-blocking flock + sleep.
* Basic test for "Generating..." feature (but which didn't caught error
  mentioned below), but only when PerlIO::Util is available.

Differences from relevant parts of J.H. patch:
* The subroutine that is responsible for doing "Generating..." progress
  info / activity indicator (cacheWaitForUpdate() subroutine in J.H. patch,
  git_generating_data_html() in this patch) is in gitweb.perl, and not in
  cache.pm.  It is passed as callback (as code reference) to $cache
  constructor: this method should be used also for other subroutines from
  gitweb which are needed in cache, namely key generation and data
  generation subroutines.
* gitweb prints generating info in more restricted set of situations; the
  set of actions where gitweb does not generate activity indicator is
  larger.  We could probably provide activity indicator also for (possibly)
  non-HTML output, like 'blob_plain' or 'patches', provided that
  'User-Agent' denotes that we are using web browser.
* Removed (by accident) copyright assignment from "Genrating..." page.
  Needs to be updated and brought back.
* Fixed typo in DTD URL.

Required improvements:
* I have just realized that tests of this feature do test the case when
  ->generating_info does redirect.  We need to fork (if enabled) if there
  is stale data to serve OR (what is currently missing) if there is
  ->get_generating_info (and if it is marked as redirecting).
* Remove accidental "#'" needed to fix font-locking (syntax highlighting)
  that got confused in esc_param.

Possible improvements:
* Ajax-y JavaScript-based activity indicator, without need for http-equiv
  refresh trick.  Proof of concept patch of mentioned method was present in
  previous series.

 gitweb/cache.pm                 |   23 +++++-
 gitweb/gitweb.perl              |  154 ++++++++++++++++++++++++++++++++++++++-
 t/t9503/test_cache_interface.pl |   45 +++++++++++
 3 files changed, 216 insertions(+), 6 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index c3a6c26..df74ea1 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -66,7 +66,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
-	my ($max_lifetime, $background_cache);
+	my ($max_lifetime, $background_cache, $generating_info);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -87,6 +87,7 @@ sub new {
 			$p_options_hash_ref->{'max_lifetime'} ||
 			$p_options_hash_ref->{'max_cache_lifetime'};
 		$background_cache = $p_options_hash_ref->{'background_cache'};
+		$generating_info  = $p_options_hash_ref->{'generating_info'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -108,6 +109,7 @@ sub new {
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
 	$self->set_background_cache($background_cache);
+	$self->set_generating_info($generating_info);
 
 	return $self;
 }
@@ -119,7 +121,7 @@ sub new {
 
 foreach my $i (qw(depth root namespace
                   expires_min expires_max increase_factor check_load
-                  max_lifetime background_cache)) {
+                  max_lifetime background_cache generating_info)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -164,6 +166,14 @@ sub set_expires_in {
 	$self->set_expires_max($duration);
 }
 
+sub generating_info {
+	my $self = shift;
+
+	if (defined $self->get_generating_info()) {
+		$self->get_generating_info()->($self, @_);
+	}
+}
+
 # ----------------------------------------------------------------------
 # utility functions and methods
 
@@ -367,6 +377,9 @@ sub compute {
 		# acquired writers lock
 		my $pid = fork() if ($data && $self->get_background_cache());
 		if (!defined $pid || $pid) {
+			# provide "generating page..." info if there is no stale data to serve
+			$self->generating_info($p_key, $lock_fh)
+				unless ($data);
 			# parent, or didn't fork
 			$data = $p_coderef->($self, $p_key);
 			$self->set($p_key, $data);
@@ -383,8 +396,12 @@ sub compute {
 			return $data;
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
 			$data = $self->fetch($p_key);
 		}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8a97e50..27c1adf 100755
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
@@ -302,8 +302,33 @@ our %cache_options = (
 	# In theory this will make gitweb seem more responsive at the price of
 	# serving possibly stale data.
 	'background_cache' => 1,
-);
 
+	# Subroutine which would be called when gitweb has to wait for data to
+	# be generated (it can't serve stale data because there isn't any,
+	# or if it exists it is older than 'max_lifetime').  The default
+	# is to use git_generating_data_html(), which creates "Generating..."
+	# page, which would then redirect or redraw/rewrite the page when
+	# data is ready.
+	# Set it to `undef' to disable this feature.
+	#
+	# Such subroutine (if invoked from GitwebCache::SimpleFileCache)
+	# is passed the following parameters: $cache instance, human-readable
+	# $key to current page, and filehandle $lock_fh to lockfile.
+	'generating_info' => \&git_generating_data_html,
+);
+# You define site-wide options for "Generating..." page (if enabled) here;
+# override them with $GITWEB_CONFIG as necessary.
+our %generating_options = (
+	# The delay before displaying "Generating..." page, in seconds. It is
+	# intended for "Generating..." page to be shown only when really needed.
+	'startup_delay' => 1,
+	# The time before generating new piece of output, to prevent from
+	# redirection before data is ready, in seconds.
+	'print_interval' => 2,
+	# Maximum time "Generating..." page would be present, waiting for data,
+	# before unconditional redirect, in seconds.
+	'timeout' => $cache_options{'expires_min'},
+);
 
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
@@ -1265,7 +1290,7 @@ sub to_utf8 {
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
 	my $str = shift;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;#'
 	$str =~ s/ /\+/g;
 	return $str;
 }
@@ -3252,6 +3277,129 @@ sub blob_contenttype {
 ## ======================================================================
 ## functions printing HTML: header, footer, error page
 
+# creates "Generating..." page when caching enabled and not in cache
+sub git_generating_data_html {
+	my ($cache, $key, $lock_fh) = @_;
+
+	# whitelist of actions that should get "Generating..." page
+	unless ($action =~ /(?:blame(?:|_incremental) | blobdiff | blob |
+	                     commitdiff | commit | forks | heads | tags |
+	                     log | shortlog | history | search |
+	                     tag | tree | summary | project_list)/x) {
+		return;
+	}
+	# blacklist of actions that should not have "Generating..." page
+	#if ($action =~ /(?:atom | rss | opml |
+	#                 blob_plain | blobdiff_plain | commitdiff_plain |
+	#                 patch | patches |
+	#                 blame_data | search_help | object | project_index |
+	#                 snapshot/x) { # binary
+	#	return;
+	#}
+
+	# Stop capturing response
+	#
+	# NOTE: this would not be needed if gitweb would do 'print $out',
+	# and one could rely on printing to STDOUT to be not captured
+	cache_stop(); # or gitweb could use 'print $STDOUT' in place of 'print STDOUT'
+
+	# Initial delay
+	if ($generating_options{'startup_delay'} > 0) {
+		eval {
+			local $SIG{ALRM} = sub { die "alarm clock restart\n" }; # NB: \n required
+			alarm $generating_options{'startup_delay'};
+			flock($lock_fh, LOCK_SH); # blocking readers lock
+			alarm 0;
+		};
+		if ($@) {
+			# propagate unexpected errors
+			die unless $@ !~ /alarm clock restart/;
+		} else {
+			# we got response within 'startup_delay' timeout
+			return;
+		}
+	}
+
+	my $title = "[Generating...] $site_name";
+	# TODO: the following fragment of code duplicates the one
+	# in git_header_html, and it should be refactored.
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
+	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
+
+	# Use the trick that 'refresh' HTTP header equivalent (set via http-equiv)
+	# with timeout of 0 seconds would redirect as soon as page is finished.
+	# This "Generating..." redirect page should not be cached (externally).
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
+	print STDOUT 'Generating...';
+
+	local $| = 1; # autoflush
+	my $total_time = 0;
+	my $interval = $generating_options{'print_interval'} || 1;
+	my $timeout  = $generating_options{'timeout'};
+	my $alarm_handler = sub {
+		print STDOUT '.';
+		$total_time += $interval;
+		if ($total_time > $timeout) {
+			die "timeout\n";
+		}
+	};
+	eval {
+		# check if we can use functions from Time::HiRes
+		if (defined $t0) {
+			local $SIG{ALRM} = $alarm_handler;
+			Time::HiRes::alarm($interval, $interval);
+		} else {
+			local $SIG{ALRM} = sub {
+				$alarm_handler->();
+				alarm($interval);
+			};
+			alarm($interval);
+		}
+		flock($lock_fh, LOCK_SH); # blocking readers lock
+		alarm 0;
+	};
+	# It doesn't really matter if we got lock, or timed-out
+	# but we should re-throw unknown (unexpected) errors
+	die if ($@ and $@ !~ /timeout/);
+
+	print STDOUT <<"EOF";
+
+</body>
+</html>
+EOF
+
+	#exit 0;
+	return;
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 41c7bc3..ac760a2 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -330,6 +330,51 @@ SKIP: {
 }
 $cache->set_expires_in(-1);
 
+# Test 'generating_info' feature
+#
+$cache->remove($key);
+my $progress_info = "Generating...";
+sub test_generating_info {
+	local $| = 1;
+	print "$progress_info";
+}
+$cache->set_generating_info(\&test_generating_info);
+# NOTE: I coulnd't be bothered to rewrite those tests to work without PerlIO::Util
+$pid = open $kid_fh, '-|' if $perlio_util;
+my ($data, $output, $child_output);
+SKIP: {
+	skip "No PerlIO::Util", 2
+		unless $perlio_util;
+	skip "cannot fork: $!", 2
+		unless defined $pid;
+
+	*STDOUT->push_layer(scalar => \$output);
+	$data = $cache->compute($key, \&get_value_slow);
+	*STDOUT->pop_layer();
+
+	if ($pid) {
+		local $/ = "\0";
+		chomp($child_output = <$kid_fh>);
+		chomp($child_data   = <$kid_fh>);
+
+		waitpid $pid, 0;
+		close $kid_fh;
+	} else {
+		local $| = 1;
+		print "$output\0$data\0";
+		exit 0;
+	}
+
+	is("$output$data",             "$progress_info$value",
+	   'progress info and data from parent');
+	is("$child_output$child_data", "$progress_info$value",
+	   'progress info and data from child');
+}
+diag("parent output is $output");
+diag("parent data   is $data");
+diag("child  output is $child_output");
+diag("child  data   is $child_data");
+
 done_testing();
 
 print Dumper($cache);
-- 
1.6.6.1
