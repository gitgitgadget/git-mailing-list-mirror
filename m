From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 12/24] gitweb/lib - Use locking to avoid 'cache miss stampede' problem
Date: Tue,  7 Dec 2010 00:10:57 +0100
Message-ID: <1291677069-6559-13-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEp-0000Cr-QO
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0LFXMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:15 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab0LFXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:12 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581974ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7NKNAQ8Fyi1cCZelEFe1gl6h2gVrfb+0nxI/mWWhvwk=;
        b=b0bvHJru6beQUsvFCHwCvBDzXdWy1GrKMhBiviXxstCUlBuYarK+hdIr5+/kkrqrrz
         LmX928Qpa8zPcEJ+7XXw44p3ZpkSZYMEX5znKPYWoBI8PN9wFqYKm+7UpwO1mXZtqkMF
         +/ieFwXxPZigZvDVCW2ByJiK4DDUaNZ7xLTLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZHZpWbbwxb/pxdDv41H4Qmbg9cAnZAozwLmHXq/znEIRorKiiu3VxBqm4QhcwRO/0v
         oLXn3omsr/qDP4ndsCrj88+PKyvQkLz+499Bgvhb5X03Y/EHzToeqPA0n1M0eBF+TPTQ
         1asbgn3gFFR8GDg0+r8XiEZCDju2ZF0GbnXrM=
Received: by 10.213.2.137 with SMTP id 9mr6702947ebj.15.1291677131339;
        Mon, 06 Dec 2010 15:12:11 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:10 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163045>

Create GitwebCache::FileCacheWithLocking module (class), derived from
GitwebCache::SimpleFileCache, where the ->compute($key, $code) method
use locking (via flock) to ensure that only one process would generate
data to update/fill-in cache; the rest would wait for the cache to
be (re)generated and would read data from cache.  If process that was
to (re)generate data dies or exits, one of the readers would take its
role.  This also means that if some data is not cached (like e.g. error
pages in gitweb), then it would work correctly even in rare case of
simultaneous access to the same non-cached entry.

Currently this feature can not be disabled via %cache_options,
although you can set $cache to 'GitwebCache::SimpleFileCache' instead.
Future new features (like: serving stale data while cache is being
regenerated, (re)generating cache in background, activity indicator)
all depend on locking.


A test in t9503 shows that in the case where there are two clients
trying to simultaneously access non-existent or stale cache entry,
(and generating data takes (artifically) a bit of time), if they are
using ->compute method the data is (re)generated once, as opposed to
situation when those clients are just using ->get/->set methods.

The situation where subroutine used to generate data dies is also
tested in t9503.

Note that there is slight inefficiency, in that filename for lockfile
depends on the filename for cache entry (it just adds '.lock' suffix),
but is recalculated from $key for both paths.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The idea of using locking to ensure that only one precess is updating
cache entry was inspired by original patch by J.H. about output caching
in gitweb (and perhaps also, to lesser extent, locking in Cache module).

The way file locking is implemented, with a separate *.lock file, was
based in

  "File Locking Tricks and Traps" (http://perl.plover.com/yak/flock/)

In "Gitweb caching v7" locking is done usually on the cache entry file,
i.e. one read from/written to.  It looks like there are in some cases
multiple locks for the same entry...

This code does not use LOCK_UN: closing lockfile would unlock.  LOCK_UN
doesn't always work as intended (see mentioned article; also tested that
LOCK_UN does not work found by tests provided, either this or in the
future commit).

Note that flock(..., LOCK_EX | LOCK_NB) is used to select the process
that would be (re)generating cache entry, and it is used to create
critical section - this means that it is unlocked when cache entry file
is written in full.  flock(..., LOCK_SH) on the other hand is used to
wait for aid process to finish; it is used only for synchronization.
In sane situation, i.e. when cache expiration time is longer than it
takes to read from cache, shared (readers) lock can be released just
after acquiring, but just in case opening file is in critical section
protected by this lock.

->compute and ->compute_fh ensure that data is generated even if process
generating data fails... unless no process can generate data.  It is
done thank to loop that waits either for data, or for a chance to
regenerate it themselves.  This shouldn't matter in most situations.


Compared to previous version of this series there was no ->compute_fh
(and was no common ->_compute_generic).


Alternate solution to locking to prevent 'cache miss stampede' problem,
is "expires_variance" (float) parameter used by CHI, which allows items
to expire little earlier than stated expiration time.  CHI also has
deprecated "busy_lock" (duration) which bumps expiration time, but it
doubles number of writes.

Comparing (benchmarking) those different solutions is yet to be done...

 gitweb/Makefile                                |    1 +
 gitweb/README                                  |    6 +-
 gitweb/gitweb.perl                             |    4 +-
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  147 ++++++++++++
 t/t9503/test_cache_interface.pl                |  283 ++++++++++++++++++++++--
 5 files changed, 424 insertions(+), 17 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d67c138..acc4f5c 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -116,6 +116,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # gitweb output caching
 GITWEB_MODULES += GitwebCache/CacheOutput.pm
 GITWEB_MODULES += GitwebCache/SimpleFileCache.pm
+GITWEB_MODULES += GitwebCache/FileCacheWithLocking.pm
 GITWEB_MODULES += GitwebCache/Capture/Simple.pm
 
 GITWEB_REPLACE = \
diff --git a/gitweb/README b/gitweb/README
index 3dc01bd..98e8101 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -351,8 +351,12 @@ cache config (see below), and ignore unrecognized options.  Such caching
 engine should also implement (at least) ->get($key) and ->set($key, $data)
 methods (Cache::Cache and CHI compatible interface).
 
+You can set $cache to 'GitwebCache::SimpleFileCache' if you don't want
+to use locking, but then some advanced features, like generating data in
+background, wouldn't work because they require locking.
+
 If $cache is left unset (if it is left undefined), then gitweb would use
-GitwebCache::SimpleFileCache as caching engine.  This engine is 'dumb' (but
+GitwebCache::FileCacheWithLocking as caching engine.  This engine is 'dumb' (but
 fast) file based caching layer, currently without any support for cache size
 limiting, or even removing expired / grossly expired entries.  It has
 therefore the downside of requiring a huge amount of disk space if there are
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 12e04a1..72683be 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -277,7 +277,7 @@ our $caching_enabled = 0;
 # Set to _initialized_ instance of cache interface implementing (at least)
 # get($key) and set($key, $data) methods (Cache::Cache and CHI interfaces),
 # or to name of class of cache interface implementing said methods.
-# If unset, GitwebCache::SimpleFileCache would be used, which is 'dumb'
+# If unset, GitwebCache::FileCacheWithLocking would be used, which is 'dumb'
 # (but fast) file based caching layer, currently without any support for
 # cache size limiting.  It is therefore recommended that the cache directory
 # be periodically completely deleted; this operation is safe to perform.
@@ -1245,7 +1245,7 @@ sub configure_caching {
 	# $cache might be initialized (instantiated) cache, i.e. cache object,
 	# or it might be name of class, or it might be undefined
 	unless (defined $cache && ref($cache)) {
-		$cache ||= 'GitwebCache::SimpleFileCache';
+		$cache ||= 'GitwebCache::FileCacheWithLocking';
 		eval "require $cache";
 		die $@ if $@;
 		$cache = $cache->new({
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
new file mode 100644
index 0000000..1ea0e60
--- /dev/null
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -0,0 +1,147 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Gitweb caching engine, simple file-based cache, with locking
+#
+
+# Based on GitwebCache::SimpleFileCache, minimalistic cache that
+# stores data in the filesystem, without serialization.
+#
+# It uses file locks (flock) to have only one process generating data
+# and writing to cache, when using CHI interface ->compute() method.
+
+package GitwebCache::FileCacheWithLocking;
+use base qw(GitwebCache::SimpleFileCache);
+
+use strict;
+use warnings;
+
+use File::Path qw(mkpath);
+use Fcntl qw(:flock);
+
+# ......................................................................
+# constructor is inherited from GitwebCache::SimpleFileCache
+
+# ----------------------------------------------------------------------
+# utility functions and methods
+
+# Take an human readable key, and return path to be used for lockfile
+# Ensures that file can be created, if needed.
+sub get_lockname {
+	my ($self, $key) = @_;
+
+	my $lockfile = $self->path_to_key($key, \my $dir) . '.lock';
+
+	# ensure that directory leading to lockfile exists
+	if (!-d $dir) {
+		eval { mkpath($dir, 0, 0777); 1 }
+			or die "Couldn't mkpath '$dir' for lockfile: $!";
+	}
+
+	return $lockfile;
+}
+
+# ......................................................................
+# interface methods
+
+sub _compute_generic {
+	my ($self, $key,
+	    $get_code, $set_code, $get_locked) = @_;
+
+	my @result = $get_code->();
+	return @result if @result;
+
+	my $lockfile = $self->get_lockname($key);
+
+	# this loop is to protect against situation where process that
+	# acquired exclusive lock (writer) dies or exits (die_error)
+	# before writing data to cache
+	my $lock_state; # needed for loop condition
+	do {
+		open my $lock_fh, '+>', $lockfile
+			or die "Could't open lockfile '$lockfile': $!";
+		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
+		if ($lock_state) {
+			# acquired writers lock
+			@result = $set_code->();
+
+			# closing lockfile releases lock
+			close $lock_fh
+				or die "Could't close lockfile '$lockfile': $!";
+
+		} else {
+			# get readers lock (wait for writer)
+			flock($lock_fh, LOCK_SH);
+			# closing lockfile releases lock
+			if ($get_locked) {
+				@result = $get_code->();
+				close $lock_fh
+					or die "Could't close lockfile '$lockfile': $!";
+			} else {
+				close $lock_fh
+					or die "Could't close lockfile '$lockfile': $!";
+				@result = $get_code->();
+			}
+		}
+	} until (@result || $lock_state);
+	# repeat until we have data, or we tried generating data oneself and failed
+	return @result;
+}
+
+# $data = $cache->compute($key, $code);
+#
+# Combines the get and set operations in a single call.  Attempts to
+# get $key; if successful, returns the value.  Otherwise, calls $code
+# and uses the return value as the new value for $key, which is then
+# returned.
+#
+# Uses file locking to have only one process updating value for $key
+# to avoid 'cache miss stampede' (aka 'stampeding herd') problem.
+sub compute {
+	my ($self, $key, $code) = @_;
+
+	return ($self->_compute_generic($key,
+		sub {
+			return $self->get($key);
+		},
+		sub {
+			my $data = $code->();
+			$self->set($key, $data);
+			return $data;
+		},
+		0 # $self->get($key); is outside LOCK_SH critical section
+	))[0]; # return single value: $data
+}
+
+# ($fh, $filename) = $cache->compute_fh($key, $code);
+#
+# Combines the get and set operations in a single call.  Attempts to
+# get $key; if successful, returns the filehandle it can be read from.
+# Otherwise, calls $code passing filehandle to write to as a
+# parameter; contents of this file is then used as the new value for
+# $key; returns filehandle from which one can read newly generated data.
+#
+# Uses file locking to have only one process updating value for $key
+# to avoid 'cache miss stampede' (aka 'stampeding herd') problem.
+sub compute_fh {
+	my ($self, $key, $code_fh) = @_;
+
+	return $self->_compute_generic($key,
+		sub {
+			return $self->get_fh($key);
+		},
+		sub {
+			return $self->set_coderef_fh($key, $code_fh);
+		},
+		1 # $self->get_fh($key); just opens file
+	);
+}
+
+1;
+__END__
+# end of package GitwebCache::FileCacheWithLocking
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 0b4b09f..c6a28f8 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -4,6 +4,12 @@ use lib (split(/:/, $ENV{GITPERLLIB}));
 use warnings;
 use strict;
 
+use POSIX qw(dup2);
+use Fcntl qw(:DEFAULT);
+use IO::Handle;
+use IO::Select;
+use IO::Pipe;
+
 use Test::More;
 
 # test source version
@@ -12,11 +18,12 @@ use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
 
 # Test creating a cache
 #
-BEGIN { use_ok('GitwebCache::SimpleFileCache'); }
+BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
 diag("Using lib '$INC[0]'");
-diag("Testing '$INC{'GitwebCache/SimpleFileCache.pm'}'");
+diag("Testing '$INC{'GitwebCache/FileCacheWithLocking.pm'}'");
 
-my $cache = new_ok('GitwebCache::SimpleFileCache');
+my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
 # Test that default values are defined
 #
@@ -39,6 +46,9 @@ SKIP: {
 		"default cache depth is $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH");
 }
 
+# ----------------------------------------------------------------------
+# CACHE API
+
 # Test the getting, setting, and removal of a cached value
 # (Cache::Cache interface)
 #
@@ -91,23 +101,15 @@ sub write_value {
 	$call_count++;
 	print {$fh} $value;
 }
-sub compute_fh_output {
-	my ($cache, $key, $code_fh) = @_;
-
-	my ($fh, $filename) = $cache->compute_fh($key, $code_fh);
-
-	local $/ = undef;
-	return <$fh>;
-}
 subtest 'compute_fh interface' => sub {
 	can_ok($cache, qw(compute_fh));
 
 	$cache->remove($key);
-	is(compute_fh_output($cache, $key, \&write_value), $value,
+	is(cache_compute_fh($cache, $key, \&write_value), $value,
 	   "compute_fh 1st time (set) returns '$value'");
-	is(compute_fh_output($cache, $key, \&write_value), $value,
+	is(cache_compute_fh($cache, $key, \&write_value), $value,
 	   "compute_fh 2nd time (get) returns '$value'");
-	is(compute_fh_output($cache, $key, \&write_value), $value,
+	is(cache_compute_fh($cache, $key, \&write_value), $value,
 	   "compute_fh 3rd time (get) returns '$value'");
 	cmp_ok($call_count, '==', 1, 'write_value() is called once from compute_fh');
 
@@ -166,4 +168,257 @@ subtest 'adaptive cache expiration' => sub {
 
 $cache->set_expires_in(-1);
 
+# ----------------------------------------------------------------------
+# CONCURRENT ACCESS
+sub parallel_run (&); # forward declaration of prototype
+
+# Test 'stampeding herd' / 'cache miss stampede' problem
+#
+
+my $slow_time = 1; # how many seconds to sleep in mockup of slow generation
+sub get_value_slow {
+	$call_count++;
+	sleep $slow_time;
+	return $value;
+}
+sub get_value_slow_fh {
+	my $fh = shift;
+
+	$call_count++;
+	sleep $slow_time;
+	print {$fh} $value;
+}
+
+sub get_value_die {
+	$call_count++;
+	die "get_value_die\n";
+}
+
+my $lock_file = "$0.$$.lock";
+sub get_value_die_once {
+	if (sysopen my $fh, $lock_file, (O_WRONLY | O_CREAT | O_EXCL)) {
+		close $fh;
+		die "get_value_die_once\n";
+	} else {
+		sleep $slow_time;
+		return $value;
+	}
+}
+
+my @output;
+my $sep = '|';
+my $total_count = 0;
+
+note("Following tests contain artifical delay of $slow_time seconds");
+subtest 'parallel access' => sub {
+	$cache->remove($key);
+	@output = parallel_run {
+		$call_count = 0;
+		my $data = cache_get_set($cache, $key, \&get_value_slow);
+		print "$data$sep$call_count";
+	};
+	$total_count = 0;
+	foreach (@output) {
+		my ($child_out, $child_count) = split(quotemeta $sep, $_);
+		#is($child_out, $value, "get/set (parallel) returns '$value'");
+		$total_count += $child_count;
+	}
+	cmp_ok($total_count, '==', 2, 'parallel get/set: get_value_slow() called twice');
+
+	$cache->remove($key);
+	@output = parallel_run {
+		$call_count = 0;
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print "$data$sep$call_count";
+	};
+	$total_count = 0;
+	foreach (@output) {
+		my ($child_out, $child_count) = split(quotemeta $sep, $_);
+		#is($child_out, $value, "compute (parallel) returns '$value'");
+		$total_count += $child_count;
+	}
+	cmp_ok($total_count, '==', 1, 'parallel compute: get_value_slow() called once');
+
+	$cache->remove($key);
+	@output = parallel_run {
+		$call_count = 0;
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print "$data$sep$call_count";
+	};
+	$total_count = 0;
+	foreach (@output) {
+		my ($child_out, $child_count) = split(quotemeta $sep, $_);
+		#is($child_out, $value, "compute_fh (parallel) returns '$value'");
+		$total_count += $child_count;
+	}
+	cmp_ok($total_count, '==', 1, 'parallel compute_fh: get_value_slow_fh() called once');
+
+	eval {
+		local $SIG{ALRM} = sub { die "alarm\n"; };
+		alarm 4*$slow_time;
+
+		@output = parallel_run {
+			$call_count = 0;
+			my $data = eval { cache_compute($cache, 'No Key', \&get_value_die); };
+			my $eval_error = $@;
+			print "$data" if defined $data;
+			print "$sep";
+			print "$eval_error" if defined $eval_error;
+		};
+		is_deeply(
+			\@output,
+			[ ( "${sep}get_value_die\n" ) x 2 ],
+			'parallel compute: get_value_die() died in both'
+		);
+
+		alarm 0;
+	};
+	ok(!$@, 'parallel compute: no alarm call (neither process hung)');
+	diag($@) if $@;
+
+	$cache->remove($key);
+	unlink($lock_file);
+	@output = parallel_run {
+		my $data = eval { cache_compute($cache, $key, \&get_value_die_once); };
+		my $eval_error = $@;
+		print "$data" if defined $data;
+		print "$sep";
+		print "$eval_error" if defined $eval_error;
+	};
+	is_deeply(
+		[sort @output],
+		[sort ("$value$sep", "${sep}get_value_die_once\n")],
+		'parallel compute: return correct value even if other process died'
+	);
+	unlink($lock_file);
+
+	done_testing();
+};
+
 done_testing();
+
+
+#######################################################################
+#######################################################################
+#######################################################################
+
+# use ->get($key) and ->set($key, $data) interface
+sub cache_get_set {
+	my ($cache, $key, $code) = @_;
+
+	my $data = $cache->get($key);
+	if (!defined $data) {
+		$data = $code->();
+		$cache->set($key, $data);
+	}
+
+	return $data;
+}
+
+# use ->compute($key, $code) interface
+sub cache_compute {
+	my ($cache, $key, $code) = @_;
+
+	my $data = $cache->compute($key, $code);
+	return $data;
+}
+# use ->compute_fh($key, $code_fh) interface
+sub cache_compute_fh {
+	my ($cache, $key, $code_fh) = @_;
+
+	my ($fh, $filename) = $cache->compute_fh($key, $code_fh);
+
+	local $/ = undef;
+	return <$fh>;
+}
+
+# from http://aaroncrane.co.uk/talks/pipes_and_processes/
+sub fork_child (&) {
+	my ($child_process_code) = @_;
+
+	my $pid = fork();
+	die "Failed to fork: $!\n" if !defined $pid;
+
+	return $pid if $pid != 0;
+
+	# Now we're in the new child process
+	$child_process_code->();
+	exit;
+}
+
+sub parallel_run (&) {
+	my $child_code = shift;
+	my $nchildren = 2;
+
+	my %children;
+	my (%pid_for_child, %fd_for_child);
+	my $sel = IO::Select->new();
+	foreach my $child_idx (1..$nchildren) {
+		my $pipe = IO::Pipe->new()
+			or die "Failed to create pipe: $!\n";
+
+		my $pid = fork_child {
+			$pipe->writer()
+				or die "$$: Child \$pipe->writer(): $!\n";
+			dup2(fileno($pipe), fileno(STDOUT))
+				or die "$$: Child $child_idx failed to reopen stdout to pipe: $!\n";
+			close $pipe
+				or die "$$: Child $child_idx failed to close pipe: $!\n";
+
+			# From Test-Simple-0.96/t/subtest/fork.t
+			#
+			# Force all T::B output into the pipe (redirected to STDOUT),
+			# for the parent builder as well as the current subtest builder.
+			{
+				no warnings 'redefine';
+				*Test::Builder::output         = sub { *STDOUT };
+				*Test::Builder::failure_output = sub { *STDOUT };
+				*Test::Builder::todo_output    = sub { *STDOUT };
+			}
+
+			$child_code->();
+
+			*STDOUT->flush();
+			close(STDOUT);
+		};
+
+		$pid_for_child{$pid} = $child_idx;
+		$pipe->reader()
+			or die "Failed to \$pipe->reader(): $!\n";
+		$fd_for_child{$pipe} = $child_idx;
+		$sel->add($pipe);
+
+		$children{$child_idx} = {
+			'pid'    => $pid,
+			'stdout' => $pipe,
+			'output' => '',
+		};
+	}
+
+	while (my @ready = $sel->can_read()) {
+		foreach my $fh (@ready) {
+			my $buf = '';
+			my $nread = sysread($fh, $buf, 1024);
+
+			exists $fd_for_child{$fh}
+				or die "Cannot find child for fd: $fh\n";
+
+			if ($nread > 0) {
+				$children{$fd_for_child{$fh}}{'output'} .= $buf;
+			} else {
+				$sel->remove($fh);
+			}
+		}
+	}
+
+	while (%pid_for_child) {
+		my $pid = waitpid -1, 0;
+		warn "Child $pid_for_child{$pid} ($pid) failed with status: $?\n"
+			if $? != 0;
+		delete $pid_for_child{$pid};
+	}
+
+	return map { $children{$_}{'output'} } keys %children;
+}
+
+__END__
-- 
1.7.3
