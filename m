From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 14/17] gitweb/lib - Serve stale data when waiting for filling cache
Date: Mon, 14 Jun 2010 18:08:27 +0200
Message-ID: <1276531710-22945-16-git-send-email-jnareb@gmail.com>
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
	id 1OOCEt-0002Dq-UD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab0FNQJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab0FNQJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:09:02 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3xnDgEja63JeTN4ea90QHYHhpN9RddGq9LOP9Hgx0aI=;
        b=vIDwt6ykeaknBCfu55i2Mu2ZNIUqPqbMuKh/oa35hfeZvLcnwdRjdW5jy+0NzDSFoe
         9Di80lM82sakMCAesxPTM8Pt9HHSVgt+2bP/KYPSGivIkmmRD5HdBNm21o/G6f2qZUlz
         PCVXUgckW5MxjlHvPlEcIJpArbHvktqpnOM/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rhDVUj/UyLW4nH4rPMAt0bjrEcSQr+e+dmv6RtXLsE5NBtDszK2ii42fIk3hjZmg+T
         kCQhLIkYVMmiyTSjjDYEsEqnnW4YuegQLfhX2lKcP2KUqS8jDtR33/LsW09/A2Zw0Rin
         /YEH7yzwWFiKnMcwUYQrOBrDJzDVNgFAd+aRE=
Received: by 10.223.21.22 with SMTP id h22mr5618362fab.106.1276531741237;
        Mon, 14 Jun 2010 09:09:01 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:09:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149113>

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
 gitweb/gitweb.perl                             |    8 ++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   94 +++++++++++++++++++++++-
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |    9 +-
 t/t9503/test_cache_interface.pl                |   58 ++++++++++++++-
 4 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 411eb0d..5aee9a1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -291,6 +291,14 @@ our %cache_options = (
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
index c91c0ee..266114c 100644
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
@@ -78,9 +159,14 @@ sub compute {
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
index e3548dc..5289894 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -337,12 +337,13 @@ sub remove {
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
 
@@ -353,7 +354,7 @@ sub is_valid {
 		or die "Couldn't stat file '$path': $!";
 
 	# expire time can be set to never
-	my $expires_in = $self->get_expires_in();
+	$expires_in = defined $expires_in ? $expires_in : $self->get_expires_in();
 	return 1 unless (defined $expires_in && $expires_in >= 0);
 
 	# is file expired?
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index f4e2418..185307e 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -13,7 +13,9 @@ use lib "$ENV{TEST_DIRECTORY}/../gitweb/lib";
 # Test creating a cache
 #
 BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
-my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+my $cache = new_ok('GitwebCache::FileCacheWithLocking', [ {
+	'max_lifetime' => 0, # turn it off
+} ]);
 isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
 # Test that default values are defined
@@ -283,4 +285,58 @@ my $result = eval {
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
1.7.0.1
