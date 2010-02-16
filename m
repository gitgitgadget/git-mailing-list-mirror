From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 10/10] gitweb: Show appropriate "Generating..." page when regenerating cache
Date: Tue, 16 Feb 2010 20:36:45 +0100
Message-ID: <1266349005-15393-11-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTFA-0002i3-RO
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243Ab0BPThh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:37 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59496 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235Ab0BPThX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:23 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so2281274bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Em5FrB/1uSYpc/6vW/D2B7MH5AbX1uEFHWFemf0q3Mg=;
        b=GXm0vwJ46lioPzg5pELYo0eDXdb+30X0WrN+IMvHykKsPa8QetUeod4IH+vO1Me9H3
         XuQxUTpAxzeWG6SmE2BKI/woCoa+S4Up7v5RiXbbKAtvTyGS6EUeT1yIBjJeZNCs4VDH
         2+sPjclkvRX7qgdA4ztwED0uH90EYUYgecS04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WEGQqO+SFiTU24KvN4RHaQVMKrV1qnxRDuWM7P7i8VSGahJnLfZS1/nisaDGR9uMv5
         SljYwQFmBmk9ACR0j8FCA86YJWooOqxidIqBdyfgA1vOyE0s87P7/3AZl7IghO1lb8oR
         zD35yaCiLSs0KPHzk0Nf7xHEZZtrr25ffuGMc=
Received: by 10.204.10.140 with SMTP id p12mr4013549bkp.54.1266349042692;
        Tue, 16 Feb 2010 11:37:22 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:22 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140148>

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
Differences from v2:
* More comments.
* In more places use just fields directly and not via getter (accessor).
* Before using 'generating_info' in process that writes cache entry
  (in background) and has exclusive lock, reset lock by closing and
  opening lockfile (flock($lockfile, LOCK_UN) doesn't work).
* Fix bug in 'startup_delay' in git_generating_data_html: the test
  was switched condition (thats for taking inspiration from two different
  sources with slightly different code).
* Always use "die $@" instead of simple "die" to re-throw unexpected
  errors (exceptions) in git_generating_data_html.
* exit in git_generating_data_html.
* Better tests in t9503.

Differences from relevant parts of J.H. patch:
* The subroutine that is responsible for doing "Generating..." progress
  info / activity indicator (cacheWaitForUpdate() subroutine in J.H. patch,
  git_generating_data_html() in this patch) is in gitweb.perl, and not in
  cache.pm.  It is passed as callback (as code reference) to $cache
  constructor.
* gitweb prints generating info in more restricted set of situations; the
  set of actions where gitweb does not generate activity indicator is
  larger.  We could probably provide activity indicator also for (possibly)
  non-HTML output, like 'blob_plain' or 'patches', provided that
  'User-Agent' denotes that we are using web browser.
* "Generating..." info behavior can be configured (at least the timings) via
  %generating_options hash, instead of having those options hardcoded.
* There is initial 'startup_delay' (by default 1 second); if the data is
  generated by that time, the "Generating..." page is not shown.
* Waiting is done using blocking flock + alarm, rather than "busy wait"
  loop with non-blocking flock + sleep.
* Basic test for "Generating..." feature.
* Removed (by accident) copyright assignment from "Generating..." page.
  Needs to be updated and brought back.
* Fixed typo in DTD URL.

 gitweb/cache.pm                 |   52 ++++++++++++-
 gitweb/gitweb.perl              |  154 ++++++++++++++++++++++++++++++++++++++-
 t/t9503/test_cache_interface.pl |   61 +++++++++++++++
 3 files changed, 260 insertions(+), 7 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index a3fa6fd..e97d697 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -83,6 +83,12 @@ our $DEFAULT_CACHE_ROOT = "cache";
 #  * 'background_cache' (boolean)
 #    This enables/disables regenerating cache in background process.
 #    Defaults to true.
+#  * 'generating_info'
+#    Subroutine (code) called when process has to wait for cache entry
+#    to be (re)generated (when there is no not-too-stale data to serve
+#    instead), for other process (or bacground process).  It is passed
+#    $cache instance, $key, and opened $lock_fh filehandle to lockfile.
+#    Unset by default (which means no activity indicator).
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -92,7 +98,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
-	my ($max_lifetime, $background_cache);
+	my ($max_lifetime, $background_cache, $generating_info);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -113,6 +119,7 @@ sub new {
 			$p_options_hash_ref->{'max_lifetime'} ||
 			$p_options_hash_ref->{'max_cache_lifetime'};
 		$background_cache = $p_options_hash_ref->{'background_cache'};
+		$generating_info  = $p_options_hash_ref->{'generating_info'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -134,6 +141,7 @@ sub new {
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
 	$self->set_background_cache($background_cache);
+	$self->set_generating_info($generating_info);
 
 	return $self;
 }
@@ -146,7 +154,7 @@ sub new {
 # creates get_depth() and set_depth($depth) etc. methods
 foreach my $i (qw(depth root namespace
                   expires_min expires_max increase_factor check_load
-                  max_lifetime background_cache)) {
+                  max_lifetime background_cache generating_info)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -200,6 +208,17 @@ sub check_load {
 	return $self->{'check_load'}->();
 }
 
+# $cache->generating_info($key, $lock);
+# runs 'generating_info' subroutine, for activity indicator,
+# checking if it is defined first.
+sub generating_info {
+	my $self = shift;
+
+	if (defined $self->{'generating_info'}) {
+		$self->{'generating_info'}->($self, @_);
+	}
+}
+
 # ----------------------------------------------------------------------
 # utility functions and methods
 
@@ -459,7 +478,8 @@ sub compute {
 
 				# fork if there is stale data, for background process
 				# to regenerate/refresh the cache (generate data)
-				$pid = fork() if (defined $stale_data);
+				$pid = fork()
+					if (defined $stale_data || $self->{'generating_info'});
 			}
 			if (!defined $pid || !$pid) {
 				## didn't fork, or are in background process
@@ -476,18 +496,42 @@ sub compute {
 
 				if (defined $pid) {
 					## in background process; parent will serve stale data
+					## or show activity indicator, and serve data
 					close $lock_fh
 						or die "Couldn't close lockfile '$lockfile' (background): $!";
 					exit 0;
 				}
+
+			} else {
+				## forked, in parent process
+
+				# provide "generating page..." info if there is no stale data to serve
+				# might exit, or force web browser to do redirection (refresh)
+				if (!defined $stale_data) {
+					# lock can get inherited across forks; unlock
+					# flock($lock_fh, LOCK_UN); # <-- this doesn't work
+					close $lock_fh
+						or die "Couldn't close lockfile '$lockfile' for reopen: $!";
+					open $lock_fh, '<', $lockfile
+						or die "Couldn't reopen (for reading) lockfile '$lockfile': $!";
+
+					$self->generating_info($p_key, $lock_fh);
+					# generating info may exit, so we can not get there
+					# wait for and get data from background process
+					flock($lock_fh, LOCK_SH);
+					$data = $self->fetch($p_key);
+				}
 			}
-			
+
 		} else {
 			# try to retrieve stale data
 			$stale_data = $self->fetch($p_key)
 				if $self->is_valid($p_key, $self->get_max_lifetime());
 
 			if (!defined $stale_data) {
+				# there is no stale data to serve
+				# provide "generating page..." info
+				$self->generating_info($p_key, $lock_fh);
 				# get readers lock if there is no stale data to serve
 				flock($lock_fh, LOCK_SH);
 				$data = $self->fetch($p_key);
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c391226..18bfbdb 100755
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
@@ -1273,7 +1298,7 @@ sub to_utf8 {
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
 	my $str = shift;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;#'
 	$str =~ s/ /\+/g;
 	return $str;
 }
@@ -3260,6 +3285,129 @@ sub blob_contenttype {
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
+			die $@ if $@ !~ /alarm clock restart/;
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
+	die $@ if ($@ and $@ !~ /timeout/);
+
+	print STDOUT <<"EOF";
+
+</body>
+</html>
+EOF
+
+	exit 0;
+	#return;
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 9643631..33ffb9d 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -338,6 +338,67 @@ SKIP: {
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
+# Catch output printed by ->compute
+# (only for 'print <sth>' and 'printf <sth>')
+sub capture_compute {
+	my $output = '';
+
+	open my $output_fh, '>', \$output;
+	my $oldfh = select($output_fh);
+
+	my $data = $cache->compute($key, \&get_value_slow);
+
+	select($oldfh);
+	close $output_fh;
+
+	return ($output, $data);
+}
+sub run_capture_compute_forked {
+	my $pid = shift;
+
+	my ($output, $data) = capture_compute();
+	my ($child_output, $child_data);
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
+		$output = '' unless defined $output;
+		$data   = '' unless defined $data;
+		print "$output\0$data\0";
+		exit 0;
+	}
+
+	return ($output, $data, $child_output, $child_data);
+}
+SKIP: {
+	$pid = open $kid_fh, '-|';
+	skip "cannot fork: $!", 4
+		unless defined $pid;
+
+	my ($output, $data, $child_output, $child_data) =
+		run_capture_compute_forked($pid);
+
+	is($output,       $progress_info, 'progress info from parent');
+	is($child_output, $progress_info, 'progress info from child');
+	is($data,         $value,         'data info from parent');
+	is($child_data,   $value,         'data info from child');
+}
+
 done_testing();
 
 print Dumper($cache);
-- 
1.6.6.1
