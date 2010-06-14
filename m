From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 13/17] gitweb/lib - Use locking to avoid 'cache miss stampede' problem
Date: Mon, 14 Jun 2010 18:08:26 +0200
Message-ID: <1276531710-22945-15-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEt-0002Dq-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab0FNQJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab0FNQJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:09:00 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649718fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bvzH9pa35kViQB0bJssVROnLoSLCq4+O7wPPr9hNM1Y=;
        b=J/mUIBiGtJbu51UaX8r6IkMRQmkLf0DCfrrcumc+sLUGEBD+yS6dC2U9p+7ZhTn292
         qYqvMYkkFZuRtwx/r02Ww9uK0cQvXbEP7pIncxlTpcm3vyzwolGOW0FIx4cLPfdqnC+E
         IkDLPB1rfQTeyhqJxkDaLLNkGU3oDEitNed3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rvwcqkak+2IOqZ4pGIYBJq4JEb6FexSQ9XzL9U9Wem3xN+tHQFxkgPGLgBipUVFrzm
         6g4l/EmGi1uHYP8MfWIcbJShTX5HO8eG0EAhosT4bslgOTQ4gQtwv51Z4M/9ALwHiH5H
         BCNtznn+WWVbMtrZyIfFISD/k3AaMKarFo4TU=
Received: by 10.223.144.79 with SMTP id y15mr5675711fau.22.1276531739495;
        Mon, 14 Jun 2010 09:08:59 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149119>

Create GitwebCache::FileCacheWithLocking module (class), derived from
GitwebCache::SimpleFileCache, where the ->compute($key, $code) method
use locking (via flock) to ensure that only one process would generate
data to update/fill-in cache; the rest would wait for the cache to
be (re)generated and would read data from cache.  If process that was
to (re)generate data dies or exits, one of the readers would take its
role.

Currently this feature can not be disabled via %cache_options,
although you can set $cache to 'GitwebCache::SimpleFileCache' instead.
Future new features (like: serving stale data while cache is being
regenerated, (re)generating cache in background, activity indicator)
all depend on locking.


A test in t9503 shows that in the case where there are two clients
trying to simultaneously access non-existent or stale cache entry,
(and generating data takes (artifically) a bit of time), if they are
using ->compute method the data is (re)generated once, as opposed to
if those clients are just using ->get/->set methods.

To be implemented (from original patch by J.H.):
* background building, and showing stale cache
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Note that there is slight inefficiency, in that filename for lockfile
depends on the filename for cache entry (it just adds '.lock' suffix),
but is recalculated from $key for both paths.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/Makefile                                |    1 +
 gitweb/README                                  |    6 +-
 gitweb/gitweb.perl                             |    4 +-
 gitweb/lib/GitwebCache/CacheOutput.pm          |    2 +-
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   95 ++++++++++++++
 t/t9503-gitweb-caching.sh                      |    2 +-
 t/t9503/test_cache_interface.pl                |  157 +++++++++++++++++++++++-
 7 files changed, 260 insertions(+), 7 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 025060b..c736648 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -114,6 +114,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # gitweb output caching
 GITWEB_MODULES += lib/GitwebCache/CacheOutput.pm
 GITWEB_MODULES += lib/GitwebCache/SimpleFileCache.pm
+GITWEB_MODULES += lib/GitwebCache/FileCacheWithLocking.pm
 GITWEB_MODULES += lib/GitwebCache/Capture.pm
 GITWEB_MODULES += lib/GitwebCache/Capture/SelectFH.pm
 
diff --git a/gitweb/README b/gitweb/README
index 9b3e5d7..7309e8e 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -342,8 +342,12 @@ cache config (see below), and ignore unrecognized options.  Such caching
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
index 5ae5757..411eb0d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -241,7 +241,7 @@ our $maxload = 300;
 our $caching_enabled = 0;
 # Set to _initialized_ instance of cache interface implementing (at least)
 # get($key) and set($key, $data) methods (Cache::Cache and CHI interfaces).
-# If unset, GitwebCache::SimpleFileCache would be used, which is 'dumb'
+# If unset, GitwebCache::FileCacheWithLocking would be used, which is 'dumb'
 # (but fast) file based caching layer, currently without any support for
 # cache size limiting.  It is therefore recommended that the cache directory
 # be periodically completely deleted; this operation is safe to perform.
@@ -1063,7 +1063,7 @@ if ($caching_enabled) {
 	# $cache might be initialized (instantiated) cache, i.e. cache object,
 	# or it might be name of class, or it might be undefined
 	unless (defined $cache && ref($cache)) {
-		$cache ||= 'GitwebCache::SimpleFileCache';
+		$cache ||= 'GitwebCache::FileCacheWithLocking';
 		$cache = $cache->new({
 			%cache_options,
 			#'cache_root' => '/tmp/cache',
diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index de4bd4d..a397a45 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -17,7 +17,7 @@ package GitwebCache::CacheOutput;
 use strict;
 use warnings;
 
-use GitwebCache::SimpleFileCache;
+use GitwebCache::SimpleFileCache; # base class
 use GitwebCache::Capture::SelectFH qw(:all);
 
 use Exporter qw(import);
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
new file mode 100644
index 0000000..c91c0ee
--- /dev/null
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -0,0 +1,95 @@
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
+# Puts dirname of file path in second argument, if it is provided.
+sub get_lockname {
+	my $self = shift;
+
+	return $self->path_to_key(@_) . '.lock';
+}
+
+# ......................................................................
+# interface methods
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
+	my $data = $self->get($key);
+	return $data if defined $data;
+
+	my $dir;
+	my $lockfile = $self->get_lockname($key, \$dir);
+
+	# ensure that directory leading to lockfile exists
+	if (!-d $dir) {
+		eval { mkpath($dir, 0, 0777); 1 }
+			or die "Couldn't mkpath '$dir' for lockfile: $!";
+	}
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
+			$data = $code->($self, $key);
+			$self->set($key, $data);
+		} else {
+			# get readers lock
+			flock($lock_fh, LOCK_SH);
+			$data = $self->fetch($key);
+		}
+		# closing lockfile releases lock
+		close $lock_fh
+			or die "Could't close lockfile '$lockfile': $!";
+	} until (defined $data || $lock_state);
+	# repeat until we have data, or we tried generating data oneself and failed
+	return $data;
+}
+
+1;
+__END__
+# end of package GitwebCache::FileCacheWithLocking
diff --git a/t/t9503-gitweb-caching.sh b/t/t9503-gitweb-caching.sh
index 0afcc0c..56f5aa0 100755
--- a/t/t9503-gitweb-caching.sh
+++ b/t/t9503-gitweb-caching.sh
@@ -26,7 +26,7 @@ fi
 
 # ----------------------------------------------------------------------
 
-test_external 'GitwebCache::SimpleFileCache Perl API (in gitweb/cache.pm)' \
+test_external 'GitwebCache::*FileCache* Perl API (in gitweb/cache.pm)' \
 	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
 
 test_external 'GitwebCache::Capture Perl API (in gitweb/cache.pm)' \
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 37c1f2b..f4e2418 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -4,6 +4,7 @@ use lib (split(/:/, $ENV{GITPERLLIB}));
 use warnings;
 use strict;
 
+use IO::Handle;
 use Test::More;
 
 # test source version
@@ -11,8 +12,9 @@ use lib "$ENV{TEST_DIRECTORY}/../gitweb/lib";
 
 # Test creating a cache
 #
-BEGIN { use_ok('GitwebCache::SimpleFileCache'); }
-my $cache = new_ok('GitwebCache::SimpleFileCache');
+BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
+my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
 # Test that default values are defined
 #
@@ -130,4 +132,155 @@ subtest 'adaptive cache expiration' => sub {
 
 $cache->set_expires_in(-1);
 
+# Test 'stampeding herd' / 'cache miss stampede' problem
+# (probably should be run only if GIT_TEST_LONG)
+#
+my $slow_time = 1; # how many seconds to sleep in mockup of slow generation
+sub get_value_slow {
+	$call_count++;
+	sleep $slow_time;
+	return $value;
+}
+
+sub cache_get_set {
+	my ($cache, $key) = @_;
+
+	my $data = $cache->get($key);
+	if (!defined $data) {
+		$data = get_value_slow();
+		$cache->set($key, $data);
+	}
+
+	return $data;
+}
+
+sub cache_compute {
+	my ($cache, $key) = @_;
+
+	my $data = $cache->compute($key, \&get_value_slow);
+	return $data;
+}
+
+sub run_child {
+	my ($writer, $data) = @_;
+
+	print $writer "$call_count\0";
+	print $writer "$data\0";
+	$writer->flush();
+
+	exit 0;
+}
+
+sub run_parent {
+	my ($reader, $data, $child) = @_;
+
+	local $/ = "\0";
+
+	my @lines = <$reader>;
+	chomp @lines;
+
+	waitpid $child, 0;
+	close $reader;
+
+	my ($child_count, $child_data) = @lines;
+	return ($child_count, $child_data);
+}
+
+sub count_total {
+	my ($kid_fh, $data, $pid) = @_;
+
+	if ($pid) {
+		my ($child_count, $child_data) =
+			run_parent($kid_fh, $data, $pid);
+		$call_count += $child_count;
+
+	} else {
+		run_child(\*STDOUT, $data);
+	}
+}
+
+my ($pid, $kid_fh);
+
+$call_count = 0;
+$cache->remove($key);
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 1
+		unless defined $pid;
+
+	my $data = cache_get_set($cache, $key);
+	count_total($kid_fh, $data, $pid);
+
+	cmp_ok($call_count, '==', 2, 'parallel get/set: get_value_slow() called twice');
+}
+
+$call_count = 0;
+$cache->remove($key);
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 1
+		unless defined $pid;
+
+	my $data = cache_compute($cache, $key);
+	count_total($kid_fh, $data, $pid);
+
+	cmp_ok($call_count, '==', 1, 'parallel compute: get_value_slow() called once');
+}
+
+
+# Test that it doesn't hang if get_action exits/dies
+#
+sub get_value_die {
+	$call_count++;
+	die "get_value_die\n";
+}
+
+sub cache_compute_catch {
+	my ($cache, $key) = @_;
+
+	eval { $cache->compute($key, \&get_value_die); };
+	my $eval_error = $@;
+	return $eval_error;
+}
+
+sub catch_errors {
+	my ($kid_fh, $eval_error, $pid) = @_;
+
+	my $child_eval_error;
+	if ($pid) {
+		(undef, $child_eval_error) =
+			run_parent($kid_fh, $eval_error, $pid);
+
+	} else {
+		run_child(\*STDOUT, $eval_error);
+	}
+
+	return ($eval_error, $child_eval_error);
+}
+
+$call_count = 0;
+my $result = eval {
+	$pid = open $kid_fh, '-|';
+ SKIP: {
+		skip "cannot fork: $!", 2
+			unless defined $pid;
+
+		local $SIG{ALRM} = sub { die "alarm\n"; };
+		alarm 4*$slow_time;
+
+		my $eval_error = cache_compute_catch($cache, 'No Key');
+		my $child_eval_error;
+
+		($eval_error, $child_eval_error) =
+			catch_errors($kid_fh, $eval_error, $pid);
+
+		is($eval_error,       "get_value_die\n", 'get_value_die() died in parent');
+		is($child_eval_error, "get_value_die\n", 'get_value_die() died in child');
+
+		alarm 0;
+	}
+};
+ok(!$@, 'no alarm call (neither process hung)');
+diag($@) if $@;
+
 done_testing();
-- 
1.7.0.1
