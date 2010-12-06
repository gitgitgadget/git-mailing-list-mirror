From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 15/24] gitweb/lib - Regenerate (refresh) cache in background
Date: Tue,  7 Dec 2010 00:11:00 +0100
Message-ID: <1291677069-6559-16-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkMK-0003sT-Oz
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab0LFXUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:20:35 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:58044 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0LFXUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:20:34 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7585290ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GIvmHd7X30gxNsX7+4j4UrvnShWUMBURroWT/BnR380=;
        b=A3QaKPCH0Ne1dCA9QMJ19X737CzSzORXRMPEPnr5Z//2+DrCc6sYmcjFLQi1+yYnIM
         0yJBnvn1JVo/6R7rhzUYcqv1ycY/x/gLIMGkel3s5CyB2A+0zxrJkQoclmlMh36n/KQk
         i5FABSY02JSksBzhujMkVMeDPZBLe3cWdEiAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fVAocgPr3XwL9TV7lR1RgfStk8t2QwUMWqi8Tqfev0zSMKs3PxiHazs3xhluIUKvG+
         mPz1x19l1hT7m1fdiFLui7YhpKEZeF9ThePuemV9dKBT7iP+tlFPPXqE3eFsFI23m9oi
         3SzYvbTAeNgTxUhCBBdGA6vw8Km53yEQ35xK4=
Received: by 10.213.19.83 with SMTP id z19mr164898eba.18.1291677138378;
        Mon, 06 Dec 2010 15:12:18 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163059>

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


The t9503 test got updated to test both case with background generation
enabled and case with background generation disabled.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Compared to previous version of this series ->_set_maybe_background
was extracted (refactored) from ->_compute_generic (in earlier version
it would be just ->compute).  This hopefully makes code easier to
understand.

Differences to approach taken in "Gitweb caching v7" by J.H.
* It is made explicit that background generation depends on using
  locking.  It doesn't matter for J.H. series, as you canot turn off
  using locking there.

* Forking (running generating process in background) is done only if
  there is stale data to serve (and if background cache is turned on).
  In J.H. series forking was done unconditionally, only generation or
  exit depended on $backgroundCache (and technical/for debugging
  $cacheDoFork).

* Locking is done before forking, as forking background process is done
  only for the process regenerating cache.

* Daemonizes background process, detaching it from parent (using
  setsid).  This way whether main process is short-lived (gitweb as CGI)
  or long-lived (mod_perl, PSGI or FastCGI), there would be no need to
  wait and no zombies.

 gitweb/gitweb.perl                             |    9 +++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   64 ++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl                |   40 ++++++++++++++-
 3 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 454766c..f202d6b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -335,6 +335,15 @@ our %cache_options = (
 	# Set it to -1 to always serve existing data if it exists,
 	# set it to 0 to turn off serving stale data - always wait.
 	'max_lifetime' => 5*60*60, # 5 hours
+
+	# This enables/disables background caching.  If it is set to true value,
+	# caching engine would return stale data (if it is not older than
+	# 'max_lifetime' seconds) if it exists, and launch process if regenerating
+	# (refreshing) cache into the background.  If it is set to false value,
+	# the process that fills cache must always wait for data to be generated.
+	# In theory this will make gitweb seem more responsive at the price of
+	# serving possibly stale data.
+	'background_cache' => 1,
 );
 # Set to _initialized_ instance of GitwebCache::Capture compatibile capturing
 # engine, i.e. one implementing ->new() constructor, and ->capture($code)
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 1d32810..82e88f1 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -23,6 +23,7 @@ use warnings;
 
 use File::Path qw(mkpath);
 use Fcntl qw(:flock);
+use POSIX qw(setsid);
 
 # ......................................................................
 # constructor
@@ -70,21 +71,27 @@ use Fcntl qw(:flock);
 #    than it, serve stale data when waiting for cache entry to be 
 #    regenerated (refreshed).  Non-adaptive.
 #    Defaults to -1 (never expire / always serve stale).
+#  * 'background_cache' (boolean)
+#    This enables/disables regenerating cache in background process.
+#    Defaults to true.
 sub new {
 	my $class = shift;
 	my %opts = ref $_[0] ? %{ $_[0] } : @_;
 
 	my $self = $class->SUPER::new(\%opts);
 
-	my ($max_lifetime);
+	my ($max_lifetime, $background_cache);
 	if (%opts) {
 		$max_lifetime =
 			$opts{'max_lifetime'} ||
 			$opts{'max_cache_lifetime'};
+		$background_cache = $opts{'background_cache'};
 	}
 	$max_lifetime = -1 unless defined($max_lifetime);
+	$background_cache = 1 unless defined($background_cache);
 
 	$self->set_max_lifetime($max_lifetime);
+	$self->set_background_cache($background_cache);
 
 	return $self;
 }
@@ -95,7 +102,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(max_lifetime)) {
+foreach my $i (qw(max_lifetime background_cache)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -146,6 +153,52 @@ sub _tempfile_to_path {
 # ......................................................................
 # interface methods
 
+sub _set_maybe_background {
+	my ($self, $key, $fetch_code, $set_code) = @_;
+
+	my $pid;
+	my (@result, @stale_result);
+
+	if ($self->{'background_cache'}) {
+		# try to retrieve stale data
+		@stale_result = $fetch_code->()
+			if $self->is_valid($key, $self->get_max_lifetime());
+
+		# fork if there is stale data, for background process
+		# to regenerate/refresh the cache (generate data)
+		$pid = fork() if (@stale_result);
+	}
+
+	if ($pid) {
+		## forked and are in parent process
+		# reap child, which spawned grandchild process (detaching it)
+		waitpid $pid, 0;
+
+	}	else {
+		## didn't fork, or are in background process
+
+		# daemonize background process, detaching it from parent
+		# see also Proc::Daemonize, Apache2::SubProcess
+		if (defined $pid) {
+			## in background process
+			POSIX::setsid(); # or setpgrp(0, 0);
+			fork() && CORE::exit(0);
+		}
+
+		@result = $set_code->();
+
+		if (defined $pid) {
+			## in background process; parent will serve stale data
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
 sub _compute_generic {
 	my ($self, $key,
 	    $get_code, $fetch_code, $set_code, $fetch_locked) = @_;
@@ -162,16 +215,19 @@ sub _compute_generic {
 	do {
 		open my $lock_fh, '+>', $lockfile
 			or die "Could't open lockfile '$lockfile': $!";
+
 		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
 		if ($lock_state) {
-			# acquired writers lock
-			@result = $set_code->();
+			## acquired writers lock, have to generate data
+			@result = $self->_set_maybe_background($key, $fetch_code, $set_code);
 
 			# closing lockfile releases lock
 			close $lock_fh
 				or die "Could't close lockfile '$lockfile': $!";
 
 		} else {
+			## didn't acquire writers lock, get stale data or wait for regeneration
+
 			# try to retrieve stale data
 			@result = $fetch_code->()
 				if $self->is_valid($key, $self->get_max_lifetime());
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 8a52261..7f08863 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -24,9 +24,13 @@ diag("Testing '$INC{'GitwebCache/FileCacheWithLocking.pm'}'");
 
 my $cache = new_ok('GitwebCache::FileCacheWithLocking', [ {
 	'max_lifetime' => 0, # turn it off
+	'background_cache' => 0,
 } ]);
 isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
+# compute can fork, don't generate zombies
+#local $SIG{CHLD} = 'IGNORE';
+
 # Test that default values are defined
 #
 ok(defined $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
@@ -303,6 +307,9 @@ subtest 'parallel access' => sub {
 my $stale_value = 'Stale Value';
 
 subtest 'serving stale data when (re)generating' => sub {
+	# without background generation
+	$cache->set_background_cache(0);
+
 	$cache->set($key, $stale_value);
 	$call_count = 0;
 	$cache->set_expires_in(0);    # expire now
@@ -312,12 +319,39 @@ subtest 'serving stale data when (re)generating' => sub {
 		my $data = cache_compute($cache, $key, \&get_value_slow);
 		print $data;
 	};
-	ok(scalar(grep { $_ eq $stale_value } @output),
-	   'stale data in at least one process when expired');
+	# returning stale data works
+	is_deeply(
+		[sort @output],
+		[sort ($value, $stale_value)],
+		'no background: stale data returned by one process'
+	);
+
+	$cache->set_expires_in(-1); # never expire for next ->get
+	is($cache->get($key), $value,
+	   'no background: value got set correctly, even if stale data returned');
+
+
+	# with background generation
+	$cache->set_background_cache(1);
+
+	$cache->set($key, $stale_value);
+	$cache->set_expires_in(0);    # set value is now expired
+	@output = parallel_run {
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print $data;
+	};
+	# returning stale data works
+	is_deeply(
+		\@output,
+		[ ($stale_value) x 2 ],
+		'background: stale data returned by both process when expired'
+	);
 
 	$cache->set_expires_in(-1); # never expire for next ->get
+	note('waiting for background process to have time to set data');
+	sleep $slow_time; # wait for background process to have chance to set data
 	is($cache->get($key), $value,
-	   'value got set correctly, even if stale data returned');
+	   'background: value got set correctly by background process');
 
 
 # 	$cache->set($key, $stale_value);
-- 
1.7.3
