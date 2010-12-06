From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 17/24] gitweb: Show appropriate "Generating..." page when regenerating cache
Date: Tue,  7 Dec 2010 00:11:02 +0100
Message-ID: <1291677069-6559-18-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkER-0008RS-Gf
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab0LFXM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:26 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab0LFXMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:24 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581974ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8Wy+Qz6Gj0ToptdGvheZMaZCisEDKQZNz9quVfX+zTs=;
        b=Sy6xtt+Gp3NfwLVMGwgtcecjnDKlVMvZsV8TU662a7PBOarGSu1JJ9FaKtAvSk3fVR
         tnLvPVQvbVFHQS5XPjyJTVbjyB5aix++nBlvX5NGUgyN6hVLhbLPk0ZBPuiVMZq7UPwK
         9wE+bxaDjCIbS/btPjPHSQ5YhW6eySqucx+qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LDXSjw7fWXhgSn4EYrkY686HQGqDXaSllZOTBpmWcK+T8o0q3yPb50/wauIaIlfzZh
         X66a/eRfAgXnJpektURTL/iU83eYIHzEgcflGyQs0NcLtRJXUevRzU3ieQCzyQ9U4QDu
         kLF0vua8H7TdwbYQKQze1HxOPQGtMLI/uP4vM=
Received: by 10.14.11.147 with SMTP id 19mr5339825eex.14.1291677143301;
        Mon, 06 Dec 2010 15:12:23 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163040>

When there exist stale/expired (but not too stale) version of
(re)generated page in cache, gitweb returns stale version (and updates
cache in background, assuming 'background_cache' is set to true value).
When there is no stale version suitable to serve the client, currently
we have to wait for the data to be generated in full before showing it.
Add to GitwebCache::FileCacheWithLocking, via 'generating_info' callback,
the ability to show user some activity indicator / progress bar, to
show that we are working on generating data.

Note that without generating data in background, process generating
data wouldn't print progress info, because 'generating_info' can exit
(and in the case of gitweb's git_generating_data_html does exit).


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

The git_generating_data_html() subroutine would return early (not showing
HTML-base progress indicator) if action does not return HTML output, or
if web browser / user agent is a robot / web crawler (or gitweb is run as
standalone script).  In such cases HTML "Generating..." page does not make
much sense.

For this purpose new subrotuines action_outputs_html($action) (which uses
%actions_info introduced in earlier commit) and browser_is_robot() (which
uses HTTP::BrowserDetect if possible, and fall backs on simple check of
User-Agent string) were added.


WARNING: If 'generating_info' subroutine always exits, like
git_generating_data_html() currently does, then there would be problems
with error pages, which are not cached... unless the process generating
data does not use 'generating_info', see the next commit.  The initial
delay introduced in 2nd next commit migitates this issue somewhat.

Alternate solution would be to print output when generating data
('tee'-ing it).


Add test for simple (not exiting) 'generating_info' subroutine, for both
case with background generation disabled and enabled to t9503.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
NOTE that after patch introducing DONE_REQUEST, it is this label that
should be used as target label at the end of git_generating_data_html()
rather than DONE_GITWEB.


Previous version of this patch lacked browser_is_robot() check in
git_generating_data_html().  We also now assume that Time::HiRes is
always available (it is in core for Perl 5.8.x that is requirement for
running gitweb).

Differences from relevant parts of "Gitweb caching v7" series by J.H.:
* When providing "Generating..." page for process which acquired writers
  lock, and spawned background process to (re)generate data in cache, we
  have to drop writers lock for 'generating_info' subroutine to try to get
  readers lock to know when data is finished generating.  This is done by
  closing lockfile, and then reopening; I have found that LOCK_UN doesn't
  work reliably enough.

  Note that there might be problem with error pages (die_error exists,
  and its output does not enter cache); it is addressed in next commit
  in this series.  I am not sure if in J.H. patch process generating
  data also shows "Generating..." page; on the other hand if I
  understand it correctly it has initial delay of 2 seconds, which also
  solves this issue as described in 2nd next commit.

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
  that 'User-Agent' denotes that we are using web browser (is not a
  robot... which we now check).

* "Generating..." info behavior can be configured (at least the timings)
  via %generating_options hash, instead of having those options hardcoded.

* Waiting is done using blocking flock + alarm, rather than "busy wait"
  loop with non-blocking flock + sleep.

* The page title shows that it is progress info, and for what action
  (for git_generating_data_html()).

* Ability to use sub-second precision.

* Basic test for "Generating..." feature, though not for the
  git_generating_data_html(); see commit message.

 gitweb/gitweb.perl                             |  131 +++++++++++++++++++++++-
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   84 ++++++++++++----
 t/gitweb-lib.sh                                |    1 +
 t/t9503/test_cache_interface.pl                |   79 ++++++++++++++
 4 files changed, 276 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da95388..181b85d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -22,7 +22,7 @@ use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
 use Encode;
-use Fcntl ':mode';
+use Fcntl qw(:mode :flock);
 use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
@@ -344,6 +344,31 @@ our %cache_options = (
 	# In theory this will make gitweb seem more responsive at the price of
 	# serving possibly stale data.
 	'background_cache' => 1,
+
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
 );
 # Set to _initialized_ instance of GitwebCache::Capture compatibile capturing
 # engine, i.e. one implementing ->new() constructor, and ->capture($code)
@@ -837,6 +862,23 @@ sub evaluate_actions_info {
 	$actions_info{'snapshot'}{'output_format'} = 'binary';
 }
 
+sub action_outputs_html {
+	my $action = shift;
+	return $actions_info{$action}{'output_format'} eq 'html';
+}
+
+sub browser_is_robot {
+	return 1 if !exists $ENV{'HTTP_USER_AGENT'}; # gitweb run as script
+	if (eval { require HTTP::BrowserDetect; }) {
+		my $browser = HTTP::BrowserDetect->new();
+		return $browser->robot();
+	}
+	# fallback on detecting known web browsers
+	return 0 if ($ENV{'HTTP_USER_AGENT'} =~ /\b(?:Mozilla|Opera|Safari|IE)\b/);
+	# be conservative; if not sure, assume non-interactive
+	return 1;
+}
+
 # fill %input_params with the CGI parameters. All values except for 'opt'
 # should be single values, but opt can be an array. We should probably
 # build an array of parameters that can be multi-valued, but since for the time
@@ -3555,6 +3597,93 @@ sub get_page_title {
 	return $title;
 }
 
+# creates "Generating..." page when caching enabled and not in cache
+sub git_generating_data_html {
+	my ($cache, $key, $lock_fh) = @_;
+
+	# whitelist of actions that should get "Generating..." page
+	if (!action_outputs_html($action) ||
+	    browser_is_robot()) {
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
+	my %no_cache = (
+		# HTTP/1.0
+		-Pragma => 'no-cache',
+		# HTTP/1.1
+		-Cache_Control => join(', ', qw(private no-cache no-store must-revalidate
+		                                max-age=0 pre-check=0 post-check=0)),
+	);
+	print STDOUT $cgi->header(-type => 'text/html', -charset => 'utf-8',
+	                          -status=> '200 OK', -expires => 'now',
+	                          %no_cache);
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
+		local $SIG{ALRM} = $alarm_handler;
+		Time::HiRes::alarm($interval, $interval);
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
index 82e88f1..694c318 100644
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
 	my $class = shift;
 	my %opts = ref $_[0] ? %{ $_[0] } : @_;
 
 	my $self = $class->SUPER::new(\%opts);
 
-	my ($max_lifetime, $background_cache);
+	my ($max_lifetime, $background_cache, $generating_info);
 	if (%opts) {
 		$max_lifetime =
 			$opts{'max_lifetime'} ||
 			$opts{'max_cache_lifetime'};
 		$background_cache = $opts{'background_cache'};
+		$generating_info  = $opts{'generating_info'};
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
 
@@ -153,6 +172,33 @@ sub _tempfile_to_path {
 # ......................................................................
 # interface methods
 
+sub _wait_for_data {
+	my ($self, $key,
+	    $lock_fh, $lockfile,
+	    $fetch_code, $fetch_locked) = @_;
+	my @result;
+
+	# provide "generating page..." info, if exists
+	$self->generating_info($key, $lock_fh);
+	# generating info may exit, so we can not get there
+
+	# get readers lock, i.e. wait for writer,
+	# which might be background process
+	flock($lock_fh, LOCK_SH);
+	# closing lockfile releases lock
+	if ($fetch_locked) {
+		@result = $fetch_code->();
+		close $lock_fh
+			or die "Could't close lockfile '$lockfile': $!";
+	} else {
+		close $lock_fh
+			or die "Could't close lockfile '$lockfile': $!";
+		@result = $fetch_code->();
+	}
+
+	return @result;
+}
+
 sub _set_maybe_background {
 	my ($self, $key, $fetch_code, $set_code) = @_;
 
@@ -165,8 +211,10 @@ sub _set_maybe_background {
 			if $self->is_valid($key, $self->get_max_lifetime());
 
 		# fork if there is stale data, for background process
-		# to regenerate/refresh the cache (generate data)
-		$pid = fork() if (@stale_result);
+		# to regenerate/refresh the cache (generate data),
+		# or if main process would show progress indicator
+		$pid = fork()
+			if (@stale_result || $self->{'generating_info'});
 	}
 
 	if ($pid) {
@@ -221,10 +269,19 @@ sub _compute_generic {
 			## acquired writers lock, have to generate data
 			@result = $self->_set_maybe_background($key, $fetch_code, $set_code);
 
-			# closing lockfile releases lock
+			# closing lockfile releases writer lock
 			close $lock_fh
 				or die "Could't close lockfile '$lockfile': $!";
 
+			if (!@result) {
+				# wait for background process to finish generating data
+				open $lock_fh, '<', $lockfile
+					or die "Couldn't reopen (for reading) lockfile '$lockfile': $!";
+
+				@result = $self->_wait_for_data($key, $lock_fh, $lockfile,
+				                                $fetch_code, $fetch_locked);
+			}
+
 		} else {
 			## didn't acquire writers lock, get stale data or wait for regeneration
 
@@ -233,19 +290,10 @@ sub _compute_generic {
 				if $self->is_valid($key, $self->get_max_lifetime());
 			return @result if @result;
 
-			# get readers lock (wait for writer)
-			# if there is no stale data to serve
-			flock($lock_fh, LOCK_SH);
-			# closing lockfile releases lock
-			if ($fetch_locked) {
-				@result = $fetch_code->();
-				close $lock_fh
-					or die "Could't close lockfile '$lockfile': $!";
-			} else {
-				close $lock_fh
-					or die "Could't close lockfile '$lockfile': $!";
-				@result = $fetch_code->();
-			}
+			# wait for regeneration
+			@result = $self->_wait_for_data($key, $lock_fh, $lockfile,
+			                                $fetch_code, $fetch_locked);
+
 		}
 	} until (@result || $lock_state);
 	# repeat until we have data, or we tried generating data oneself and failed
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 4ce067f..d191f0e 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -58,6 +58,7 @@ gitweb_enable_caching () {
 		$caching_enabled = 1;
 		$cache_options{"expires_in"} = -1;      # never expire cache for tests
 		$cache_options{"cache_root"} = "cache"; # to clear the right thing
+		$cache_options{"generating_info"} = undef;
 		EOF
 		rm -rf cache/
 	'
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 7f08863..81f0b76 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -395,6 +395,85 @@ subtest 'serving stale data when (re)generating' => sub {
 };
 $cache->set_expires_in(-1);
 
+
+# Test 'generating_info' feature
+#
+$cache->remove($key);
+my $progress_info = "Generating...";
+sub test_generating_info {
+	local $| = 1;
+	print "$progress_info";
+}
+$cache->set_generating_info(\&test_generating_info);
+
+subtest 'generating progress info' => sub {
+	my @progress;
+
+	# without background generation
+	$cache->set_background_cache(0);
+	$cache->remove($key);
+
+	@output = parallel_run {
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print "$sep$data";
+	};
+	@progress = map { s/^(.*)\Q${sep}\E//o && $1 } @output;
+	is_deeply(
+		[sort @progress],
+		[sort ('', $progress_info)],
+		'no background: one process waiting for data prints progress info'
+	);
+	is_deeply(
+		\@output,
+		[ ($value) x 2 ],
+		'no background: both processes return correct value'
+	);
+
+
+	# without background generation, with stale value
+	$cache->set($key, $stale_value);
+	$cache->set_expires_in(0);    # set value is now expired
+	$cache->set_max_lifetime(-1); # stale data never expire
+	@output = parallel_run {
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print "$sep$data";
+	};
+	is_deeply(
+		[sort @output],
+	## no progress for generating process without background generation;
+	#	[sort ("$progress_info$sep$value", "$sep$stale_value")],
+		[sort ("$sep$value", "$sep$stale_value")],
+		'no background, stale data: generating gets data, other gets stale data'
+	) or diag('@output is ', join ", ", sort @output);
+	$cache->set_expires_in(-1);
+
+
+	# with background generation
+	$cache->set_background_cache(1);
+	$cache->remove($key);
+
+	@output = parallel_run {
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print "$sep$data";
+	};
+	@progress = map { s/^(.*)\Q${sep}\E//o && $1 } @output;
+	is_deeply(
+		\@progress,
+		[ ($progress_info) x 2],
+		'background: both process print progress info'
+	);
+	is_deeply(
+		\@output,
+		[ ($value) x 2 ],
+		'background: both processes return correct value'
+	);
+
+
+	done_testing();
+};
+$cache->set_expires_in(-1);
+
+
 done_testing();
 
 
-- 
1.7.3
