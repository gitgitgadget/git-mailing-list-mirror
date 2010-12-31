From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 10/9] gitweb: Background cache generation and progress indicator
Date: Fri, 31 Dec 2010 19:03:14 +0100
Message-ID: <201012311903.15333.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 31 19:03:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYjKB-0003D1-1R
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 19:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab0LaSD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 13:03:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35745 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0LaSD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 13:03:27 -0500
Received: by fxm20 with SMTP id 20so12001946fxm.19
        for <git@vger.kernel.org>; Fri, 31 Dec 2010 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cD+Q+Nw4yrltBUodEA8SMPyXPAmIqrAXtVDD/Cnafkg=;
        b=q2LKbCB1WERIh0BOkayTX3Mj4DT4iM2YbuulPc6M70+9N2ore0iM55eXEmYw7rsrTy
         6VDNDqEKK7g6ztxPpr18OBFvnmlXezjk64uXxXclpzvGY6uWdGZGCgq3V3WI3vkDbcYc
         ukmNJp7Jp6YJuFzqyis+NrHxWdy61ymodz0X4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qmvCYrEoScdpzeHYnlcBU3h3WRj9cBL68HfZ7TiSzjIP8M9n5BBnJCel5P+RUBl2M8
         mYD7+ZskVHjQhrnzN/wDZa/rv59c6hBuhkX7aV4YMbIC5A0gVhK4eBBbm8tq/uyBHXPo
         1Km/0iQUNsTQ1M+sLv/VASYqcS6fedw5Goz3o=
Received: by 10.223.70.142 with SMTP id d14mr243253faj.110.1293818605802;
        Fri, 31 Dec 2010 10:03:25 -0800 (PST)
Received: from [192.168.1.13] (abwh151.neoplus.adsl.tpnet.pl [83.8.231.151])
        by mx.google.com with ESMTPS id n3sm4106366fax.7.2010.12.31.10.03.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Dec 2010 10:03:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164394>

This commit removes asymmetry in serving stale data (if stale data exists)
when regenerating cache in GitwebCache::FileCacheWithLocking.  The process
that acquired exclusive (writers) lock, and is therefore selected to
be the one that (re)generates data to fill the cache, can now generate
data in background, while serving stale data.

Those background processes are daemonized, i.e. detached from the main
process (the one returning data or stale data).  Otherwise there might be a
problem when gitweb is running as (part of) long-lived process, for example
from mod_perl or from FastCGI: it would leave unreaped children as zombies
(entries in process table).  We don't want to wait for background process,
and we can't set $SIG{CHLD} to 'IGNORE' in gitweb to automatically reap
child processes, because this interferes with using
  open my $fd, '-|', git_cmd(), 'param', ...
    or die_error(...)
  # read from <$fd>
  close $fd
    or die_error(...)
In the above code "close" for magic "-|" open calls waitpid...  and we
would would die with "No child processes".  Removing 'or die' would
possibly remove ability to react to other errors.

This feature can be enabled or disabled on demand via 'background_cache'
cache parameter.  It is turned on by default.


When there is no stale version suitable to serve the client, currently
we have to wait for the data to be generated in full before showing it.
Add to GitwebCache::FileCacheWithLocking, via 'generating_info' callback,
the ability to show user some activity indicator / progress bar, to
show that we are working on generating data.

Note that without generating data in background, process generating
data wouldn't print progress info, because 'generating_info' can exit
(and in the case of gitweb's git_generating_data_html does exit).

We don't need to daemonize background process in this case, where
there is no stale data to serve, but progress info is on.  This is
because we have to wait for the background process to finish
generating data anyway.

Gitweb itself uses "Generating..." page as activity indicator, which
redirects (via <meta http-equiv="Refresh" ...>) to refreshed version
of the page after the cache is filled (via trick of not closing page
and therefore not closing connection till data is available in cache).
The git_generating_data_html() subroutine, which is used by gitweb to
implement this feature, is highly configurable: you can choose
frequency of writing some data so that connection won't get closed,
and maximum time to wait for data in "Generating..." page (see
comments in %generating_options hash definition), and initial delay
before starting progress indicator page.

The git_generating_data_html() subroutine would return early (not showing
HTML-base progress indicator) if action does not return HTML output, or
if web browser / user agent is a robot / web crawler (or gitweb is run as
standalone script).  In such cases HTML "Generating..." page does not make
much sense.

For this purpose new subroutine browser_is_robot() (which uses
HTTP::BrowserDetect if possible, and fall backs on simple check of
User-Agent string) was added.


The default behavior of cache_output() from GitwebCache::CacheOutput was
changed so that it would cache error pages if they were generated in
detached background process.  This together with default initial delay in
git_generating_data_html progress_info subroutine should ensure that there
are no problems with error pages and progress info interaction.


The t9511 test got updated to test both case with background generation
enabled and case with background generation disabled.  Also adde test for
simple (not exiting) 'generating_info' subroutine, for both case with
background generation disabled and enabled.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There are few changes included in this commit which should be fixed in
original commits/patches earlier in the series.  Namely:

* fix to gitweb/Makefile to use newer names for gitweb caching
  modules, i.e. GitwebCache/FileCacheWithLocking.pm instead of
  GitwebCache/SimpleFileCache.pm, and GitwebCache/Capture/ToFile.pm
  instead of GitwebCache/Capture/Simple.pm

* 'max_lifetime' was introduced in previous commit, so its use in
  %cache_options (setting default value for gitweb) should also be
  done in previous commit.

* gitweb_enable_caching function in tgitweb-lib.sh should use
  "$TRASH_DIRECTORY/cache" as 'cache_root' from beginning, just in
  case


It is worth mentioning that git_generating_data_html does not need to
end with 'die'; it could as well end with 'goto DONE_REQUEST'.  The
'generating_info' subroutine is outside capture anyway.


The issue with error pages should be solved, even in the case when
they are not cached.  There are three layers of defense:

1. git_generating_data_html has initial delay of 1 second, by default.
   This means that if die_error finishes within this initial delay,
   then redirection (and ending the request) wouldn't take place.  The
   error page would be printed by parent process and not cached.

2. In the case where there is no stale data to serve, but there is
   'generating_info' subroutine and it would exit / end request before
   error page is fully generated, background process would be not
   detached, and it would print error page.  The error page would not
   be cached.

   Though I wonder if exit from git_generating_data_html should be
   trapped, so that we can wait for background process; other solution
   would be to use ripper SIGCHLD signal handler for this process...

   Huh, something still to think about...

3. In the case where there is stale data for what is now an error
   condition (e.g. deleted branch or deleted project), and background
   process would generate data being detached from originating
   project, the error page would be captured and cached.

 gitweb/Makefile                                |    4 +-
 gitweb/gitweb.perl                             |  171 +++++++++++++++++++++++-
 gitweb/lib/GitwebCache/CacheOutput.pm          |   10 ++-
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  113 +++++++++++++++-
 t/gitweb-lib.sh                                |    4 +-
 t/t9511/test_cache_interface.pl                |  149 ++++++++++++++++++++-
 6 files changed, 439 insertions(+), 12 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d67c138..7a5c85f 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,8 +115,8 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
 # gitweb output caching
 GITWEB_MODULES += GitwebCache/CacheOutput.pm
-GITWEB_MODULES += GitwebCache/SimpleFileCache.pm
-GITWEB_MODULES += GitwebCache/Capture/Simple.pm
+GITWEB_MODULES += GitwebCache/FileCacheWithLocking.pm
+GITWEB_MODULES += GitwebCache/Capture/ToFile.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index eb02b6b..5ef668d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -307,6 +307,38 @@ our %cache_options = (
 	# The (global) expiration time for objects placed in the cache, in seconds.
 	'expires_in' => 20,
 
+	# Maximum cache file life, in seconds.  If cache entry lifetime exceeds
+	# this value, it wouldn't be served as being too stale when waiting for
+	# cache to be regenerated/refreshed, instead of trying to display
+	# existing cache date.
+	#
+	# Set it to -1 to always serve existing data if it exists.
+	# Set it to  0 to turn off serving stale data, i.e. always wait.
+	'max_lifetime' => 5*60*60, # 5 hours
+
+	# This enables/disables background caching.  If it is set to true value,
+	# caching engine would return stale data (if it is not older than
+	# 'max_lifetime' seconds) if it exists, and launch process if regenerating
+	# (refreshing) cache into the background.  If it is set to false value,
+	# the process that fills cache must always wait for data to be generated.
+	# In theory this will make gitweb seem more responsive at the price of
+	# serving possibly stale data.
+	'background_cache' => 1,
+
+	# Subroutine which would be called when gitweb has to wait for data to
+	# be generated (it can't serve stale data because there isn't any,
+	# or if it exists it is older than 'max_lifetime').  The default
+	# is to use git_generating_data_html(), which creates "Generating..."
+	# page, which would then redirect or redraw/rewrite the page when
+	# data is ready.
+	# Set it to `undef' to disable this feature.
+	#
+	# Such subroutine (if invoked from GitwebCache::FileCacheWithLocking)
+	# is passed the following parameters: $cache instance, human-readable
+	# $key to current page, and $sync_coderef subroutine to invoke to wait
+	# (in a blocking way) for data.
+	'generating_info' => \&git_generating_data_html,
+
 	# How to handle runtime errors occurring during cache gets and cache
 	# sets.  Options are:
 	#  * "die" (the default) - call die() with an appropriate message
@@ -323,10 +355,27 @@ our %cache_options = (
 
 	# Extra options passed to GitwebCache::CacheOutput::cache_output subroutine
 	'cache_output' => {
-		# Enable caching of error pages (boolean).  Default is false.
-		'-cache_errors' => 0,
+		# Enable caching of error pages (tristate, with undef meaning that error
+		# pages will be cached if were generated in detached process).
+		# Default is undef.
+		'-cache_errors' => undef,
 	},
 );
+# You define site-wide options for "Generating..." page (if enabled) here
+# (which means that $cache_options{'generating_info'} is set to coderef);
+# override them with $GITWEB_CONFIG as necessary.
+our %generating_options = (
+	# The delay before displaying "Generating..." page, in seconds.  It is
+	# intended for "Generating..." page to be shown only when really needed.
+	'startup_delay' => 1,
+	# The time between generating new piece of output to prevent from
+	# redirection before data is ready, i.e. time between printing each
+	# dot in activity indicator / progress info, in seconds.
+	'print_interval' => 2,
+	# Maximum time "Generating..." page would be present, waiting for data,
+	# before unconditional redirect, in seconds.
+	'timeout' => $cache_options{'expires_min'},
+);
 # Set to _initialized_ instance of GitwebCache::Capture::ToFile
 # compatibile capturing engine, i.e. one implementing ->new()
 # constructor, and ->capture($code, $file) method.  If unset
@@ -870,6 +919,18 @@ sub evaluate_actions_info {
 	}
 }
 
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
@@ -3660,6 +3721,112 @@ sub get_page_title {
 	return $title;
 }
 
+# creates "Generating..." page when caching enabled and not in cache
+sub git_generating_data_html {
+	my ($cache, $key, $sync_coderef) = @_;
+
+	# when should gitweb show "Generating..." page
+	if ((defined $actions_info{$action}{'output_format'} &&
+	     $actions_info{$action}{'output_format'} eq 'feed') ||
+	    browser_is_robot()) {
+		return;
+	}
+
+	# Initial delay
+	if ($generating_options{'startup_delay'} > 0) {
+		eval {
+			local $SIG{ALRM} = sub { die "alarm clock restart\n" }; # NB: \n required
+			alarm $generating_options{'startup_delay'};
+			$sync_coderef->(); # wait for data
+			alarm 0;           # turn off the alarm
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
+		my $sync_ok;
+		do {
+			# loop is needed here because SIGALRM (from 'alarm')
+			# can interrupt waiting (process of acquiring lock)
+			$sync_ok = $sync_coderef->(); # blocking wait for data
+		} until ($sync_ok);
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
+	die { 'status' => 200 }; # to end request
+	#goto DONE_REQUEST;
+	#exit 0;
+	#return;
+}
+
 sub print_feed_meta {
 	if (defined $project) {
 		my %href_params = get_feed_info();
diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index 792ddb7..188d4ab 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -35,16 +35,24 @@ our %EXPORT_TAGS = (all => [ @EXPORT ]);
 # in ':raw' format (and thus restored in ':raw' from cache)
 #
 # Supported options:
-# * -cache_errors => 0|1  - whether error output should be cached
+# * -cache_errors => undef|0|1  - whether error output should be cached,
+#                                 undef means cache if we are in detached process
 sub cache_output {
 	my ($cache, $capture, $key, $code, %opts) = @_;
 
+
+	my $pid = $$;
 	my ($fh, $filename);
 	my ($capture_fh, $capture_filename);
 	eval { # this `eval` is to catch rethrown error, so we can print captured output
 		($fh, $filename) = $cache->compute_fh($key, sub {
 			($capture_fh, $capture_filename) = @_;
 
+			if (!defined $opts{'-cache_errors'}) {
+				# cache errors if we are in detached process
+				$opts{'-cache_errors'} = ($$ != $pid && getppid() != $pid);
+			}
+
 			# this `eval` is to be able to cache error output (up till 'die')
 			eval { $capture->capture($code, $capture_fh); };
 
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index ecd0e18..291526e 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -73,6 +73,16 @@ our $EXPIRE_NOW = 0;
 #    If it is greater than 0, and cache entry is expired but not older
 #    than it, serve stale data when waiting for cache entry to be 
 #    regenerated (refreshed).  Non-adaptive.
+#  * 'background_cache' (boolean)
+#    This enables/disables regenerating cache in background process.
+#    Defaults to true.
+#  * 'generating_info'
+#    Subroutine (code) called when process has to wait for cache entry
+#    to be (re)generated (when there is no not-too-stale data to serve
+#    instead), for other process (or bacground process).  It is passed
+#    $cache instance, $key, and $wait_code subroutine (code reference)
+#    to invoke (to call) to wait for cache entry to be ready.
+#    Unset by default (which means no activity indicator).
 #  * 'on_error' (similar to CHI 'on_get_error'/'on_set_error')
 #    How to handle runtime errors occurring during cache gets and cache
 #    sets, which may or may not be considered fatal in your application.
@@ -107,6 +117,11 @@ sub new {
 		exists $opts{'max_lifetime'}       ? $opts{'max_lifetime'} :
 		exists $opts{'max_cache_lifetime'} ? $opts{'max_cache_lifetime'} :
 		$NEVER_EXPIRE;
+	$self->{'background_cache'} =
+		exists $opts{'background_cache'} ? $opts{'background_cache'} :
+		1;
+	$self->{'generating_info'} = $opts{'generating_info'}
+		if exists $opts{'generating_info'};
 	$self->{'on_error'} =
 		exists $opts{'on_error'}      ? $opts{'on_error'} :
 		exists $opts{'on_get_error'}  ? $opts{'on_get_error'} :
@@ -127,6 +142,7 @@ sub new {
 
 # creates get_depth() and set_depth($depth) etc. methods
 foreach my $i (qw(depth root namespace expires_in max_lifetime
+                  background_cache generating_info
                   on_error)) {
 	my $field = $i;
 	no strict 'refs';
@@ -140,6 +156,16 @@ foreach my $i (qw(depth root namespace expires_in max_lifetime
 	};
 }
 
+# $cache->generating_info($wait_code);
+# runs 'generating_info' subroutine, for activity indicator,
+# checking if it is defined first.
+sub generating_info {
+	my $self = shift;
+
+	if (defined $self->{'generating_info'}) {
+		$self->{'generating_info'}->($self, @_);
+	}
+}
 
 # ----------------------------------------------------------------------
 # utility functions and methods
@@ -246,6 +272,10 @@ sub _wait_for_data {
 	my ($self, $key, $sync_coderef) = @_;
 	my @result;
 
+	# provide "generating page..." info, if exists
+	$self->generating_info($key, $sync_coderef);
+	# generating info may exit, so we can not get there
+
 	# wait for data to be available
 	$sync_coderef->();
 	# fetch data
@@ -254,6 +284,57 @@ sub _wait_for_data {
 	return @result;
 }
 
+sub _set_maybe_background {
+	my ($self, $key, $code) = @_;
+
+	my ($pid, $detach);
+	my (@result, @stale_result);
+
+	if ($self->{'background_cache'}) {
+		# try to retrieve stale data
+		@stale_result = $self->get_fh($key,
+			'expires_in' => $self->get_max_lifetime());
+
+		# fork if there is stale data, for background process
+		# to regenerate/refresh the cache (generate data),
+		# or if main process would show progress indicator
+		$detach = @stale_result;
+		$pid = fork()
+			if (@stale_result || $self->{'generating_info'});
+	}
+
+	if ($pid) {
+		## forked and are in parent process
+		# reap child, which spawned grandchild process (detaching it)
+		waitpid $pid, 0
+			if $detach;
+
+	} else {
+		## didn't fork, or are in background process
+
+		# daemonize background process, detaching it from parent
+		# see also Proc::Daemonize, Apache2::SubProcess
+		if (defined $pid && $detach) {
+			## in background process
+			POSIX::setsid(); # or setpgrp(0, 0);
+			fork() && CORE::exit(0);
+		}
+
+		@result = $self->set_coderef_fh($key, $code);
+
+		if (defined $pid) { # && !$pid
+			## in background process; parent or grandparent
+			## will serve stale data, or just generated data
+
+			# lockfile will be automatically closed on exit,
+			# and therefore lockfile would be unlocked
+			CORE::exit(0);
+		}
+	}
+
+	return @result > 0 ? @result : @stale_result;
+}
+
 # $self->_handle_error($raw_error)
 #
 # based on _handle_get_error and _dispatch_error_msg from CHI::Driver
@@ -408,14 +489,37 @@ sub compute_fh {
 		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
 		if ($lock_state) {
 			## acquired writers lock, have to generate data
-			@result = eval { $self->set_coderef_fh($key, $code_fh) };
+			eval { @result = $self->_set_maybe_background($key, $code_fh) };
 			$self->_handle_error($@) if $@;
 
 			# closing lockfile releases writer lock
-			flock($lock_fh, LOCK_UN);
+			#flock($lock_fh, LOCK_UN); # it would unlock here and in background process
 			close $lock_fh
 				or $self->_handle_error("Could't close lockfile '$lockfile': $!");
 
+			if (!@result) {
+				# wait for background process to finish generating data
+				open $lock_fh, '<', $lockfile
+					or $self->_handle_error("Couldn't reopen (for reading) lockfile '$lockfile': $!");
+
+				eval {
+					@result = $self->_wait_for_data($key, sub {
+						flock($lock_fh, LOCK_SH);
+						# or 'waitpid -1, 0;', or 'wait;', as we don't detach now in this situation
+					});
+				};
+				$self->_handle_error($@) if $@;
+
+				# closing lockfile releases readers lock used to wait for data
+				flock($lock_fh, LOCK_UN);
+				close $lock_fh
+					or $self->_handle_error("Could't close reopened lockfile '$lockfile': $!");
+
+				# we didn't detach, so wait for the child to reap it
+				# (it should finish working, according to lock status)
+				wait;
+			}
+
 		} else {
 			## didn't acquire writers lock, get stale data or wait for regeneration
 
@@ -429,12 +533,13 @@ sub compute_fh {
 
 			# wait for regeneration if no stale data to serve,
 			# using shared / readers lock to sync (wait for data)
-			@result = eval {
-				$self->_wait_for_data($key, sub {
+			eval {
+				@result = $self->_wait_for_data($key, sub {
 					flock($lock_fh, LOCK_SH);
 				});
 			};
 			$self->_handle_error($@) if $@;
+
 			# closing lockfile releases readers lock
 			flock($lock_fh, LOCK_UN);
 			close $lock_fh
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 4ce067f..8652c91 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -57,7 +57,9 @@ gitweb_enable_caching () {
 		cat >>gitweb_config.perl <<-\EOF &&
 		$caching_enabled = 1;
 		$cache_options{"expires_in"} = -1;      # never expire cache for tests
-		$cache_options{"cache_root"} = "cache"; # to clear the right thing
+		$cache_options{"cache_root"} = "$TRASH_DIRECTORY/cache"; # to clear the right thing
+		$cache_options{"background_cache"} = 0; # no background processes in test suite
+		$cache_options{"generating_info"} = undef; # tests do not use web browser
 		EOF
 		rm -rf cache/
 	'
diff --git a/t/t9511/test_cache_interface.pl b/t/t9511/test_cache_interface.pl
index a2b006c..1e8feb3 100755
--- a/t/t9511/test_cache_interface.pl
+++ b/t/t9511/test_cache_interface.pl
@@ -23,7 +23,13 @@ BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
 note("Using lib '$INC[0]'");
 note("Testing '$INC{'GitwebCache/FileCacheWithLocking.pm'}'");
 
-my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+my $cache = new_ok('GitwebCache::FileCacheWithLocking', [
+	'max_lifetime' => 0, # turn it off
+	'background_cache' => 0,
+]);
+
+# ->compute_fh() can fork, don't generate zombies
+#local $SIG{CHLD} = 'IGNORE';
 
 # Test that default values are defined
 #
@@ -239,6 +245,7 @@ subtest 'parallel access' => sub {
 my $stale_value = 'Stale Value';
 
 subtest 'serving stale data when regenerating' => sub {
+	$cache->remove($key);
 	cache_set_fh($cache, $key, $stale_value);
 	$cache->set_expires_in(-1);   # never expire, for next check
 	is(cache_get_fh($cache, $key), $stale_value,
@@ -246,7 +253,10 @@ subtest 'serving stale data when regenerating' => sub {
 
 	$call_count = 0;
 	$cache->set_expires_in(0);    # expire now (so there are no fresh data)
-	$cache->set_max_lifetime(-1); # forever (always serve stale data)
+	$cache->set_max_lifetime(-1); # stale data is valid forever
+
+	# without background generation
+	$cache->set_background_cache(0);
 
 	@output = parallel_run {
 		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
@@ -264,6 +274,31 @@ subtest 'serving stale data when regenerating' => sub {
 	   'no background: value got set correctly, even if stale data returned');
 
 
+	# with background generation
+	$cache->set_background_cache(1);
+	$call_count = 0;
+	cache_set_fh($cache, $key, $stale_value);
+	$cache->set_expires_in(0);  # expire now (so there are no fresh data)
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print "$call_count$sep";
+		print $data if defined $data;
+	};
+	# returning stale data works
+	is_deeply(
+		[sort @output],
+		[sort ("0$sep$stale_value", "0$sep$stale_value")],
+		'background: stale data returned by both processes'
+	);
+	$cache->set_expires_in(-1); # never expire for next ->get
+	note("waiting $slow_time sec. for background process to have time to set data");
+	sleep $slow_time; # wait for background process to have chance to set data
+	is(cache_get_fh($cache, $key), $value,
+	   'background: value got set correctly by background process');
+	$cache->set_expires_in(0);  # expire now (so there are no fresh data)
+
+
 	cache_set_fh($cache, $key, $stale_value);
 	$cache->set_expires_in(0);   # expire now
 	$cache->set_max_lifetime(0); # don't serve stale data
@@ -282,6 +317,116 @@ subtest 'serving stale data when regenerating' => sub {
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
+
+subtest 'generating progress info' => sub {
+	my @progress;
+
+	# without background generation, and without stale value
+	$cache->set_background_cache(0);
+	$cache->remove($key); # no data and no stale data
+	$call_count = 0;
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print "$sep$call_count$sep";
+		print $data if defined $data;
+	};
+	# split progress and output
+	@progress = map { s/^(.*)\Q${sep}\E//o && $1 } @output;
+	is_deeply(
+		[sort @progress],
+		[sort ("${sep}1", "$progress_info${sep}0")],
+		'no background, no stale data: the process waiting for data prints progress info'
+	);
+	is_deeply(
+		\@output,
+		[ ($value) x 2 ],
+		'no background, no stale data: both processes return correct value'
+	);
+
+
+	# without background generation, with stale value
+	cache_set_fh($cache, $key, $stale_value);
+	$cache->set_expires_in(0);    # set value is now expired
+	$cache->set_max_lifetime(-1); # stale data never expire
+	$call_count = 0;
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print "$sep$call_count$sep";
+		print $data if defined $data;
+	};
+	@progress = map { s/^(.*?)\Q${sep}\E//o && $1 } @output;
+	is_deeply(
+		\@progress,
+		[ ('') x 2],
+		'no background, stale data: neither process prints progress info'
+	);
+	is_deeply(
+		[sort @output],
+		[sort ("1$sep$value", "0$sep$stale_value")],
+		'no background, stale data: generating gets data, other gets stale data'
+	);
+	$cache->set_expires_in(-1);
+
+
+	# with background generation
+	$cache->set_background_cache(1);
+	$cache->remove($key); # no data and no stale value
+	$call_count = 0;
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print $sep;
+		print $data if defined $data;
+	};
+	@progress = map { s/^(.*)\Q${sep}\E//o && $1 } @output;
+	is_deeply(
+		\@progress,
+		[ ($progress_info) x 2],
+		'background, no stale data: both process print progress info'
+	);
+	is_deeply(
+		\@output,
+		[ ($value) x 2 ],
+		'background, no stale data: both processes return correct value'
+	);
+
+
+	# with background generation, with stale value
+	cache_set_fh($cache, $key, $stale_value);
+	$cache->set_expires_in(0);    # set value is now expired
+	$cache->set_max_lifetime(-1); # stale data never expire
+	$call_count = 0;
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print $sep;
+		print $data if defined $data;
+	};
+	@progress = map { s/^(.*)\Q${sep}\E//o && $1 } @output;
+	is_deeply(
+		\@progress,
+		[ ('') x 2],
+		'background, stale data: neither process prints progress info'
+	);
+	note("waiting $slow_time sec. for background process to have time to set data");
+	sleep $slow_time; # wait for background process to have chance to set data
+
+
+	done_testing();
+};
+$cache->set_expires_in(-1);
+
 done_testing();
 
 
-- 
1.7.3
