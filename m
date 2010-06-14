From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 16/17] gitweb: Show appropriate "Generating..." page when regenerating cache
Date: Mon, 14 Jun 2010 18:08:29 +0200
Message-ID: <1276531710-22945-18-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEu-0002Dq-Ud
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab0FNQJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33637 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab0FNQJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:09:07 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649923fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AvzkVDBFo75JBl0TAmR01hbC/m1lPVCmeRsuKemCQAw=;
        b=vhE/Ubswfzyge9nfSc2d0ztNYcuSV8zQcAf/Gl27MfjWlke82fCYhRjocbjqgVkhkj
         Sfuy7jWjHqSk1lSTxj2LD5sm0R19JZbXrPqtaDLVGwQZM9akjoHUUu1p9yU8pxGLzLfo
         G9Br6ydMgJD+hOliab2lFAi4uvHylve7cEn5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G5hlgSb95J3BY6b3tVaJQ8JW9vWz9TSvUXFmdygiaOoipMn9uZpwxbROyS7s+gujaJ
         5Ke0i+nT1EJ6u6QW71NW6d4MkQpcyjIVVoagJ6dJPG+Is25KiNifQ19yLkwRhZTGrbc1
         bnGdlgFuyxq8qjDqacvd1tBBph8y3bfCiFV7Q=
Received: by 10.223.23.67 with SMTP id q3mr5654575fab.59.1276531745803;
        Mon, 14 Jun 2010 09:09:05 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.09.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:09:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149118>

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

Currently git_generating_data_html() contains hardcoded "whitelist" of
actions for which such HTML "Generating..." page makes sense.


This implements final feature from the original gitweb output caching
patch by J.H.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                             |  127 +++++++++++++++++++++++-
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   52 +++++++++-
 t/t9503/test_cache_interface.pl                |   61 +++++++++++
 3 files changed, 234 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2ca1ad7..8d7540e 100755
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
 
@@ -308,8 +308,32 @@ our %cache_options = (
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
@@ -3324,6 +3348,105 @@ sub get_page_title {
 	return $title;
 }
 
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
+	# Stop capturing response, just in case (we should be not generating response)
+	#
+	capture_stop(); # or gitweb could use 'print $STDOUT' in place of 'print STDOUT'
+
+	my $title = "[Generating...] " . get_page_title();
+	# TODO: the following line of code duplicates the one
+	# in git_header_html, and it should probably be refactored.
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
+	exit 0;
+	#return;
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index bde1420..ad078e8 100644
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
 
@@ -173,7 +192,8 @@ sub compute {
 
 				# fork if there is stale data, for background process
 				# to regenerate/refresh the cache (generate data)
-				$pid = fork() if (defined $stale_data);
+				$pid = fork()
+					if (defined $stale_data || $self->{'generating_info'});
 			}
 			if (!defined $pid || !$pid) {
 				## didn't fork, or are in background process
@@ -190,18 +210,42 @@ sub compute {
 
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
index 667fb5e..a84faf9 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -345,4 +345,65 @@ SKIP: {
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
1.7.0.1
