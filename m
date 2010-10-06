From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5/RFC 16/17] gitweb: Show appropriate "Generating..." page when regenerating cache
Date: Thu,  7 Oct 2010 00:02:01 +0200
Message-ID: <1286402526-13143-17-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5p-0002Gb-3z
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234Ab0JFWDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932921Ab0JFWDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:04 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49448bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pZg256KlVZVexfooUOhwM0mjYSTf0K3tlpQfOm6rhuA=;
        b=qLOhC7yvVDPs1XLRntRn76blR3UNsOerR1D33EnOyXYky+0Q8IbeszpLODfaYi83fY
         Lets/rO+gky50rAGO+GemeXdXutp7ko3mkqqcG5iY7KTxPOkvtFVe7r4YHZP5Aps9gnU
         kn6xp4a7rZMoul2Vh+dTeSmSh+DR5fLtq45lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uTqBLQqtIIx1nTAY7klFfI1jG9soKw1SlwQp8KFSICHkmjw5OSgHw7lSDynpWLxOt/
         8npQ9J8KYQaju8t9XqRNwgSmXc/ugmc3hQW47xKYccQ5tOP0KPT/6SPvrA4ylb75WFb9
         zmEIvC06yMRWk+G+4L/2kCW/+pl9BRkB0WQcw=
Received: by 10.204.179.9 with SMTP id bo9mr10294944bkb.80.1286402582458;
        Wed, 06 Oct 2010 15:03:02 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.03.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:03:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158317>

When there exist stale/expired (but not too stale) version of
(re)generated page in cache, gitweb returns stale version (and updates
cache in background, assuming 'background_cache' is set to true value).
When there is no stale version suitable to serve the client, currently
we have to wait for the data to be generated in full before showing it.
Add to GitwebCache::FileCacheWithLocking, via 'generating_info' callback,
the ability to show user some activity indicator / progress bar, to
show that we are working on generating data.

Gitweb itself uses "Generating..." page as activity indicator, which
redirects (via <meta http-equiv="Refresh" ...>) to refreshed version
of the page after the cache is filled (via trick of not closing page
and therefore not closing connection till data is available in cache,
checked by getting shared/readers lock on lockfile for cache entry).
The git_generating_data_html() subroutine, which is used by gitweb
to implement this feature, is highly configurable: you can choose
frequency of writing some data so that connection won't get closed,
and maximum time to wait for data in "Generating..." page (see comments
in %generating_options hash definition).

git_generating_data_html() is run only for actions that have HTML
output; only for those actions HTML "Generating..." page makes sense.


This implements final feature from the original gitweb output caching
patch by J.H.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v4:
* New action_outputs_html() subroutine in gitweb, used for whitelisting in
  git_generating_data_html().

* No capture_stop(), as it is not needed: the 'generating_info' subroutine
  (e.g. git_generating_data_html()) is run outside capturing output.

* git_generating_data_html() now ends with 'goto DONE_GITWEB'


Differences from relevant parts of J.H. patch:
* When providing "Generating..." page for process which acquired writers
  lock, and spawned background process to (re)generate data in cache, we
  have to drop writers lock for 'generating_info' subroutine to try to get
  readers lock to know when data is finished generating.  This is done by
  closing lockfile, and then reopening; I have found that LOCK_UN doesn't
  work reliably enough.

* The subroutine that is responsible for doing "Generating..." progress
  info / activity indicator (cacheWaitForUpdate() subroutine in
  J.H. patch, git_generating_data_html() in this patch) resides in
  gitweb.perl, and not in caching module.  It is passed as callback (as
  code reference) to $cache constructor, as 'generating_info' parameter.

* The idea how git_generating_data_html() works for web browsers without
  Ajax, using only plain HTML and server-side scripting is somewhat
  described in comments.

* gitweb prints generating info in more restricted set of situations; the
  set of actions where gitweb does not generate activity indicator is
  larger.  We could probably provide activity indicator also for
  (possibly) non-HTML output, like 'blob_plain' or 'patches', provided
  that 'User-Agent' denotes that we are using web browser.

* "Generating..." info behavior can be configured (at least the timings)
  via %generating_options hash, instead of having those options hardcoded.

* Waiting is done using blocking flock + alarm, rather than "busy wait"
  loop with non-blocking flock + sleep.

* The page title shows that it is progress info, and for what action
  (for git_generating_data_html()).

* Ability to use sub-second precision if Time::HiRes is available
  (for git_generating_data_html()).

* Basic test for "Generating..." feature, though not for the
  git_generating_data_html().

* Fixed typo in DTD URL.


 gitweb/gitweb.perl                             |  120 +++++++++++++++++++++++-
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   52 ++++++++++-
 t/t9503/test_cache_interface.pl                |   61 ++++++++++++
 3 files changed, 227 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 26d5619..07fa825 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -21,7 +21,7 @@ use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
 use Encode;
-use Fcntl ':mode';
+use Fcntl qw(:mode :flock);
 use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
@@ -336,8 +336,32 @@ our %cache_options = (
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
+# You define site-wide options for "Generating..." page (if enabled) here
+# (which means that $cache_options{'generating_info'} is set to coderef);
+# override them with $GITWEB_CONFIG as necessary.
+our %generating_options = (
+	# The time between generating new piece of output to prevent from
+	# redirection before data is ready, i.e. time between printing each
+	# dot in activity indicator / progress info, in seconds.
+	'print_interval' => 2,
+	# Maximum time "Generating..." page would be present, waiting for data,
+	# before unconditional redirect, in seconds.
+	'timeout' => $cache_options{'expires_min'},
+);
 
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
@@ -826,6 +850,11 @@ sub evaluate_actions_info {
 	$actions_info{'snapshot'}{'output_format'} = 'binary';
 }
 
+sub action_outputs_html {
+	my $action = shift;
+	return $actions_info{$action}{'output_format'} eq 'html';
+}
+
 # fill %input_params with the CGI parameters. All values except for 'opt'
 # should be single values, but opt can be an array. We should probably
 # build an array of parameters that can be multi-valued, but since for the time
@@ -3532,6 +3561,93 @@ sub get_page_title {
 	return $title;
 }
 
+# creates "Generating..." page when caching enabled and not in cache
+sub git_generating_data_html {
+	my ($cache, $key, $lock_fh) = @_;
+
+	# whitelist of actions that should get "Generating..." page
+	unless (action_outputs_html($action)) {
+		return;
+	}
+
+	my $title = "[Generating...] " . get_page_title();
+	# TODO: the following line of code duplicates the one
+	# in git_header_html, and it should probably be refactored.
+	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
+
+	# Use the trick that 'refresh' HTTP header equivalent (set via http-equiv)
+	# with timeout of 0 seconds would redirect as soon as page is finished.
+	# It assumes that browser would display partially received page.
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
+
+	local $| = 1; # autoflush
+	print STDOUT 'Generating...';
+
+	my $total_time = 0;
+	my $interval = $generating_options{'print_interval'} || 1;
+	my $timeout  = $generating_options{'timeout'};
+	my $alarm_handler = sub {
+		local $! = 1;
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
+		my $lock_acquired;
+		do {
+			# loop is needed here because SIGALRM (from 'alarm')
+			# can interrupt process of acquiring lock
+			$lock_acquired = flock($lock_fh, LOCK_SH); # blocking readers lock
+		} until ($lock_acquired);
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
+	# after refresh web browser would reload page and send new request
+	goto DONE_GITWEB;
+	#exit 0;
+	#return;
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index f0d9d6f..9211a9a 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -74,24 +74,32 @@ use POSIX qw(setsid);
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
 
 	my $class = ref($proto) || $proto;
 	my $self = $class->SUPER::new($p_options_hash_ref);
 
-	my ($max_lifetime, $background_cache);
+	my ($max_lifetime, $background_cache, $generating_info);
 	if (defined $p_options_hash_ref) {
 		$max_lifetime =
 			$p_options_hash_ref->{'max_lifetime'} ||
 			$p_options_hash_ref->{'max_cache_lifetime'};
 		$background_cache = $p_options_hash_ref->{'background_cache'};
+		$generating_info  = $p_options_hash_ref->{'generating_info'};
 	}
 	$max_lifetime = -1 unless defined($max_lifetime);
 	$background_cache = 1 unless defined($background_cache);
 
 	$self->set_max_lifetime($max_lifetime);
 	$self->set_background_cache($background_cache);
+	$self->set_generating_info($generating_info);
 
 	return $self;
 }
@@ -102,7 +110,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(max_lifetime background_cache)) {
+foreach my $i (qw(max_lifetime background_cache generating_info)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -115,6 +123,17 @@ foreach my $i (qw(max_lifetime background_cache)) {
 	};
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
 
@@ -189,7 +208,8 @@ sub compute {
 
 				# fork if there is stale data, for background process
 				# to regenerate/refresh the cache (generate data)
-				$pid = fork() if (defined $stale_data);
+				$pid = fork()
+					if (defined $stale_data || $self->{'generating_info'});
 			}
 			if (!defined $pid || !$pid) {
 				## didn't fork, or are in background process
@@ -206,18 +226,42 @@ sub compute {
 
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
+					$self->generating_info($key, $lock_fh);
+					# generating info may exit, so we can not get there
+					# wait for and get data from background process
+					flock($lock_fh, LOCK_SH);
+					$data = $self->fetch($key);
+				}
 			}
-			
+
 		} else {
 			# try to retrieve stale data
 			$stale_data = $self->fetch($key)
 				if $self->is_valid($key, $self->get_max_lifetime());
 
 			if (!defined $stale_data) {
+				# there is no stale data to serve
+				# provide "generating page..." info
+				$self->generating_info($key, $lock_fh);
 				# get readers lock if there is no stale data to serve
 				flock($lock_fh, LOCK_SH);
 				$data = $self->fetch($key);
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 7ee628f..1f876bd 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -344,4 +344,65 @@ SKIP: {
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
-- 
1.7.3
