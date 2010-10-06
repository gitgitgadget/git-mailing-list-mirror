From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 13/17] gitweb/lib - Serve stale data when waiting for filling cache
Date: Thu,  7 Oct 2010 00:01:58 +0200
Message-ID: <1286402526-13143-14-git-send-email-jnareb@gmail.com>
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
	id 1P3c5o-0002Gb-3D
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218Ab0JFWDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972Ab0JFWC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:56 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wlAbP+mRGhsRUbHRGI0ICK7W0Qe06rQBW0QSd2vVEMA=;
        b=YRMcmA0PnFs21nToLh4X9qLbdZpI8otcOjfqa4wOL+Kzexxnfo5geLNrfpHSpYpaLI
         Gypw7yCaCwtg2L1uYvr3KXjLcKblgaYVq86hJJjYLlV/uqxafPj4UE+YRR3hUKcJj5Qg
         K5DIyqXQCD4e5H8QGplFLVGX73pN4mMxXNoHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PbH2xXoziZtYyZLaZPTgF4+fkpE6k6F7i3t/lI0jXq1DAWhVc9M9gbZPOcwIe5A1nU
         HxXpUAzbwk0HDqkNvaKd28bh67cY6Sd0HJxeuJiPt7Ubfsmd4spksIKZ8bXIxiknQVw9
         55132i8sHL6Ra9VqlefVLf9mS1Gk+lKij6Hpc=
Received: by 10.204.73.1 with SMTP id o1mr7869773bkj.71.1286402575944;
        Wed, 06 Oct 2010 15:02:55 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158323>

When process fails to acquire exclusive (writers) lock, then instead
of waiting for the other process to (re)generate and fill cache, serve
stale (expired) data from cache.  This is of course possible only if
there is some stale data in cache for given key.

This feature of GitwebCache::FileCacheWithLocking is used only for an
->update($key, $code) method.  It is controlled by 'max_lifetime'
cache parameter; you can set it to -1 to always serve stale data
if it exists, and you can set it to 0 (or any value smaller than
'expires_min') to turn this feature off.

This feature, as it is implemented currently, makes ->update() method a
bit asymmetric with respect to process that acquired writers lock and
those processes that didn't, which can be seen in the new test in t9503.
The process that is to regenerate (refresh) data in cache must wait for
the data to be generated in full before showing anything to client, while
the other processes show stale (expired) data immediately.  In order to
remove or reduce this asymmetry gitweb would need to employ one of the two
alternate solutions.  Either data should be (re)generated in background,
so that process that acquired writers lock would generate data in
background while serving stale data, or alternatively the process that
generates data should pass output to original STDOUT while capturing it
("tee" output).

When developing this feature, ->is_valid() method in base class
GitwebCache::SimpleFileCache acquired additional extra optional
parameter, where one can pass expire time instead of using whole-cache
global (adaptive) expire time.

To be implemented (from original patch by J.H.):
* background building,
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No changes since v4 of gitweb caching series.


Differences from relevant parts of J.H. patch:
* Instead of using $maxCacheLife, use 'max_lifetime' option (with
  'max_cache_lifetime' as optional spelling in GitwebCache::SimpleFileCache
  constructor).

* Use 5*60*60 seconds for 5 hours, rather than 18000 (or 18_000) seconds.

* Serving stale data was enabled only when background cache regeneration was
  enabled; here it is enabled for readers regardless whether background
  generation (introduced in next commit) is turned on or not. 

* It is explicit that serving stale data when some process is
  regenerating cache is possible only with locking enabled, i.e. when
  using GitwebCache::FileCacheWithLocking.

* Tests of API

 gitweb/gitweb.perl                             |    8 ++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   94 +++++++++++++++++++++++-
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |    9 +-
 t/t9503/test_cache_interface.pl                |   58 ++++++++++++++-
 4 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5da9651..c920656 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -319,6 +319,14 @@ our %cache_options = (
 	# lifetime control.
 	# (Compatibile with Cache::Adaptive.)
 	'check_load' => \&get_loadavg,
+
+	# Maximum cache file life, in seconds.  If cache entry lifetime exceeds
+	# this value, it wouldn't be served as being too stale when waiting for
+	# cache to be regenerated/refreshed, instead of trying to display
+	# existing cache date.
+	# Set it to -1 to always serve existing data if it exists,
+	# set it to 0 to turn off serving stale data - always wait.
+	'max_lifetime' => 5*60*60, # 5 hours
 );
 
 
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index e69047e..73cc9ec 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -25,7 +25,88 @@ use File::Path qw(mkpath);
 use Fcntl qw(:flock);
 
 # ......................................................................
-# constructor is inherited from GitwebCache::SimpleFileCache
+# constructor
+
+# The options are set by passing in a reference to a hash containing
+# any of the following keys:
+#  * 'namespace'
+#    The namespace associated with this cache.  This allows easy separation of
+#    multiple, distinct caches without worrying about key collision.  Defaults
+#    to $DEFAULT_NAMESPACE.
+#  * 'cache_root' (Cache::FileCache compatibile),
+#    'root_dir' (CHI::Driver::File compatibile),
+#    The location in the filesystem that will hold the root of the cache.
+#    Defaults to $DEFAULT_CACHE_ROOT.
+#  * 'cache_depth' (Cache::FileCache compatibile),
+#    'depth' (CHI::Driver::File compatibile),
+#    The number of subdirectories deep to cache object item.  This should be
+#    large enough that no cache directory has more than a few hundred objects.
+#    Defaults to $DEFAULT_CACHE_DEPTH unless explicitly set.
+#  * 'default_expires_in' (Cache::Cache compatibile),
+#    'expires_in' (CHI compatibile) [seconds]
+#    The expiration time for objects place in the cache.
+#    Defaults to -1 (never expire) if not explicitly set.
+#    Sets 'expires_min' to given value.
+#  * 'expires_min' [seconds]
+#    The minimum expiration time for objects in cache (e.g. with 0% CPU load).
+#    Used as lower bound in adaptive cache lifetime / expiration.
+#    Defaults to 20 seconds; 'expires_in' sets it also.
+#  * 'expires_max' [seconds]
+#    The maximum expiration time for objects in cache.
+#    Used as upper bound in adaptive cache lifetime / expiration.
+#    Defaults to 1200 seconds, if not set; 
+#    defaults to 'expires_min' if 'expires_in' is used.
+#  * 'check_load'
+#    Subroutine (code) used for adaptive cache lifetime / expiration.
+#    If unset, adaptive caching is turned off; defaults to unset.
+#  * 'increase_factor' [seconds / 100% CPU load]
+#    Factor multiplying 'check_load' result when calculating cache lietime.
+#    Defaults to 60 seconds for 100% SPU load ('check_load' returning 1.0).
+#
+# (all the above are inherited from GitwebCache::SimpleFileCache)
+#
+#  * 'max_lifetime' [seconds]
+#    If it is greater than 0, and cache entry is expired but not older
+#    than it, serve stale data when waiting for cache entry to be 
+#    regenerated (refreshed).  Non-adaptive.
+#    Defaults to -1 (never expire / always serve stale).
+sub new {
+	my ($proto, $p_options_hash_ref) = @_;
+
+	my $class = ref($proto) || $proto;
+	my $self = $class->SUPER::new($p_options_hash_ref);
+
+	my ($max_lifetime);
+	if (defined $p_options_hash_ref) {
+		$max_lifetime =
+			$p_options_hash_ref->{'max_lifetime'} ||
+			$p_options_hash_ref->{'max_cache_lifetime'};
+	}
+	$max_lifetime = -1 unless defined($max_lifetime);
+
+	$self->set_max_lifetime($max_lifetime);
+
+	return $self;
+}
+
+# ......................................................................
+# accessors
+
+# http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
+
+# creates get_depth() and set_depth($depth) etc. methods
+foreach my $i (qw(max_lifetime)) {
+	my $field = $i;
+	no strict 'refs';
+	*{"get_$field"} = sub {
+		my $self = shift;
+		return $self->{$field};
+	};
+	*{"set_$field"} = sub {
+		my ($self, $value) = @_;
+		$self->{$field} = $value;
+	};
+}
 
 # ----------------------------------------------------------------------
 # utility functions and methods
@@ -94,9 +175,14 @@ sub compute {
 			$data = $code->($self, $key);
 			$self->set($key, $data);
 		} else {
-			# get readers lock
-			flock($lock_fh, LOCK_SH);
-			$data = $self->fetch($key);
+			# try to retrieve stale data
+			$data = $self->fetch($key)
+				if $self->is_valid($key, $self->get_max_lifetime());
+			if (!defined $data) {
+				# get readers lock if there is no stale data to serve
+				flock($lock_fh, LOCK_SH);
+				$data = $self->fetch($key);
+			}
 		}
 		# closing lockfile releases lock
 		close $lock_fh
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 72ab77a..39f24f8 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -350,12 +350,13 @@ sub remove {
 		or die "Couldn't remove file '$file': $!";
 }
 
-# $cache->is_valid($key)
+# $cache->is_valid($key[, $expires_in])
 #
 # Returns a boolean indicating whether $key exists in the cache
-# and has not expired (global per-cache 'expires_in').
+# and has not expired.  Uses global per-cache expires time, unless
+# passed optional $expires_in argument.
 sub is_valid {
-	my ($self, $key) = @_;
+	my ($self, $key, $expires_in) = @_;
 
 	my $path = $self->path_to_key($key);
 
@@ -368,7 +369,7 @@ sub is_valid {
 	return 0 unless ((stat(_))[7] > 0);
 
 	# expire time can be set to never
-	my $expires_in = $self->get_expires_in();
+	$expires_in = defined $expires_in ? $expires_in : $self->get_expires_in();
 	return 1 unless (defined $expires_in && $expires_in >= 0);
 
 	# is file expired?
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 4a941d8..303bcf0 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -12,7 +12,9 @@ use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
 # Test creating a cache
 #
 BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
-my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+my $cache = new_ok('GitwebCache::FileCacheWithLocking', [ {
+	'max_lifetime' => 0, # turn it off
+} ]);
 isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
 # Test that default values are defined
@@ -282,4 +284,58 @@ my $result = eval {
 ok(!$@, 'no alarm call (neither process hung)');
 diag($@) if $@;
 
+# Test that cache returns stale data in existing but expired cache situation
+# (probably should be run only if GIT_TEST_LONG)
+#
+my $stale_value = 'Stale Value';
+$cache->set($key, $stale_value);
+$call_count = 0;
+sub run_compute_forked {
+	my ($pid, $kid_fh) = @_;
+
+	my $data = $cache->compute($key, \&get_value_slow);
+
+	my $child_data;
+	if ($pid) {
+		(undef, $child_data) =
+			run_parent($kid_fh, $data, $pid);
+
+	} else {
+		run_child(\*STDOUT, $data);
+	}
+
+	return ($data, $child_data);
+}
+$cache->set_expires_in(0);    # expire now
+$cache->set_max_lifetime(-1); # forever (always serve stale data)
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 2
+		unless defined $pid;
+
+	my ($data, $child_data) = run_compute_forked($pid, $kid_fh);
+
+	# returning stale data works
+	ok($data eq $stale_value || $child_data eq $stale_value,
+	   'stale data in at least one process when expired');
+
+	$cache->set_expires_in(-1); # never expire for next ->get
+	is($cache->get($key), $value, 'value got set correctly, even if stale data returned');
+}
+
+$cache->set_expires_in(0);   # expire now
+$cache->set_max_lifetime(0); # don't serve stale data
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 2
+		unless defined $pid;
+
+	my ($data, $child_data) = run_compute_forked($pid, $kid_fh);
+
+	# no returning stale data
+	isnt($data,       $stale_value, 'no stale data in parent if configured');
+	isnt($child_data, $stale_value, 'no stale data in child  if configured');
+}
+$cache->set_expires_in(-1);
+
 done_testing();
-- 
1.7.3
