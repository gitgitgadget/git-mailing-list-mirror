From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 14/24] gitweb/lib - Serve stale data when waiting for filling cache
Date: Tue,  7 Dec 2010 00:10:59 +0100
Message-ID: <1291677069-6559-15-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEQ-0008RS-G4
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab0LFXMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:18 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:64271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab0LFXMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:16 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581974ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v8DDBgKp+fG+BE5xzqM/6CnmM+JUqskp0kSmd9TKcxA=;
        b=qUH8Gj2s0DSCgSJfplPmcucMTrjd18G04qp+FuQnCAp2hFmVhztHiBpnCvVkDYb6Rj
         SEs9E/yfyyqkejihIwjSC0FCTEzrf6YlJKSt8f0qDYTPjdNdawB70RZLMVp442lDVCo2
         FIzzSYqJFM+iT2anZ4wO0BnptqleHjCz1LvmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RW0zsZtbSxLIG04zbaouclfh2zblZZTP/XF/9GWZlv+JXX8Fg5E121YWkm+WBLUXP8
         s8RYyfyVuA5/iMz+vPKYIpx6W4J1E3wDIGU2o/zRdO0woxh4GS2T01aof8OUC0l35NLP
         IkUxrX5YEizxnog7R08GBZmWx0N52oB10RmpY=
Received: by 10.213.28.203 with SMTP id n11mr131797ebc.48.1291677136009;
        Mon, 06 Dec 2010 15:12:16 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:15 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163039>

When process fails to acquire exclusive (writers) lock, then instead
of waiting for the other process to (re)generate and fill cache, serve
stale (expired) data from cache.  This is of course possible only if
there is some stale data in cache for given key.

This feature of GitwebCache::FileCacheWithLocking is used only for
->update($key, $code) and ->update_fh($key, $code_fh) methods.  It is
controlled by 'max_lifetime' cache parameter; you can set it to -1 to
always serve stale data if it exists, and you can set it to 0 (or any
value smaller than 'expires_min') to turn this feature off.

This feature, as it is implemented currently, makes ->update() method a
bit asymmetric with respect to process that acquired writers lock and
those processes that didn't, which can be seen in the new test in t9503.
The process that is to regenerate (refresh) data in cache must wait for
the data to be generated in full before showing anything to client, while
the other processes can show stale (expired) data immediately.  In order
to remove or reduce this asymmetry gitweb would need to employ one of
two alternate solutions.  Either data should be (re)generated in background,
so that process that acquired writers lock would generate data in
background while serving stale data, or alternatively the process that
generates data should pass output to original STDOUT while capturing it
("tee" output).

Note that process that got stale data serves it immediately, therefore
it wouldn't be available to regenerate data if process regenerating
data died; see commented-out TODO test in t9503.  Otherwise it would
have to wait to check if data got regenerated, which would negate the
idea of serving stale data for a fast return.

When developing this feature, ->is_valid() method in base class
GitwebCache::SimpleFileCache acquired additional extra optional
parameter, where one can pass expire time instead of using whole-cache
global (adaptive) expire time.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Compared to version in previous version of this series the parallel
access test got much improved (this actually started in earlier
commit).

This is the part that is possible _without_ regenerating cache in
background.

Note that here it is explicit that serving stale data when some
process is regenerating cache is possible only with locking enabled,
i.e. when using GitwebCache::FileCacheWithLocking.

 gitweb/gitweb.perl                             |    8 ++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  105 ++++++++++++++++++++++--
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |   22 ++++--
 t/t9503/test_cache_interface.pl                |   68 +++++++++++++++-
 4 files changed, 189 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 72683be..454766c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -327,6 +327,14 @@ our %cache_options = (
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
 # Set to _initialized_ instance of GitwebCache::Capture compatibile capturing
 # engine, i.e. one implementing ->new() constructor, and ->capture($code)
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 4d8114d..1d32810 100644
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
+	my $class = shift;
+	my %opts = ref $_[0] ? %{ $_[0] } : @_;
+
+	my $self = $class->SUPER::new(\%opts);
+
+	my ($max_lifetime);
+	if (%opts) {
+		$max_lifetime =
+			$opts{'max_lifetime'} ||
+			$opts{'max_cache_lifetime'};
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
@@ -67,7 +148,7 @@ sub _tempfile_to_path {
 
 sub _compute_generic {
 	my ($self, $key,
-	    $get_code, $set_code, $get_locked) = @_;
+	    $get_code, $fetch_code, $set_code, $fetch_locked) = @_;
 
 	my @result = $get_code->();
 	return @result if @result;
@@ -91,17 +172,23 @@ sub _compute_generic {
 				or die "Could't close lockfile '$lockfile': $!";
 
 		} else {
+			# try to retrieve stale data
+			@result = $fetch_code->()
+				if $self->is_valid($key, $self->get_max_lifetime());
+			return @result if @result;
+
 			# get readers lock (wait for writer)
+			# if there is no stale data to serve
 			flock($lock_fh, LOCK_SH);
 			# closing lockfile releases lock
-			if ($get_locked) {
-				@result = $get_code->();
+			if ($fetch_locked) {
+				@result = $fetch_code->();
 				close $lock_fh
 					or die "Could't close lockfile '$lockfile': $!";
 			} else {
 				close $lock_fh
 					or die "Could't close lockfile '$lockfile': $!";
-				@result = $get_code->();
+				@result = $fetch_code->();
 			}
 		}
 	} until (@result || $lock_state);
@@ -126,6 +213,9 @@ sub compute {
 			return $self->get($key);
 		},
 		sub {
+			return $self->fetch($key);
+		},
+		sub {
 			my $data = $code->();
 			$self->set($key, $data);
 			return $data;
@@ -152,9 +242,12 @@ sub compute_fh {
 			return $self->get_fh($key);
 		},
 		sub {
+			return $self->fetch_fh($key);
+		},
+		sub {
 			return $self->set_coderef_fh($key, $code_fh);
 		},
-		1 # $self->get_fh($key); just opens file
+		1 # $self->fetch_fh($key); just opens file
 	);
 }
 
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index aeb91d4..21ec434 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -365,12 +365,13 @@ sub remove {
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
 
@@ -383,7 +384,7 @@ sub is_valid {
 	return 0 unless ((stat(_))[7] > 0);
 
 	# expire time can be set to never
-	my $expires_in = $self->get_expires_in();
+	$expires_in = defined $expires_in ? $expires_in : $self->get_expires_in();
 	return 1 unless (defined $expires_in && $expires_in >= 0);
 
 	# is file expired?
@@ -441,18 +442,25 @@ sub compute {
 # ......................................................................
 # nonstandard interface methods
 
-sub get_fh {
+sub fetch_fh {
 	my ($self, $key) = @_;
 
 	my $path = $self->path_to_key($key);
 	return unless (defined $path);
 
-	return unless ($self->is_valid($key));
-
 	open my $fh, '<', $path or return;
 	return ($fh, $path);
 }
 
+
+sub get_fh {
+	my ($self, $key) = @_;
+
+	return unless ($self->is_valid($key));
+
+	return $self->fetch_fh($key);
+}
+
 sub set_coderef_fh {
 	my ($self, $key, $code) = @_;
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index c6a28f8..8a52261 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -22,7 +22,9 @@ BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
 diag("Using lib '$INC[0]'");
 diag("Testing '$INC{'GitwebCache/FileCacheWithLocking.pm'}'");
 
-my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+my $cache = new_ok('GitwebCache::FileCacheWithLocking', [ {
+	'max_lifetime' => 0, # turn it off
+} ]);
 isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
 # Test that default values are defined
@@ -295,6 +297,70 @@ subtest 'parallel access' => sub {
 	done_testing();
 };
 
+# Test that cache returns stale data in existing but expired cache situation
+# (probably should be run only if GIT_TEST_LONG)
+#
+my $stale_value = 'Stale Value';
+
+subtest 'serving stale data when (re)generating' => sub {
+	$cache->set($key, $stale_value);
+	$call_count = 0;
+	$cache->set_expires_in(0);    # expire now
+	$cache->set_max_lifetime(-1); # forever (always serve stale data)
+
+	@output = parallel_run {
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print $data;
+	};
+	ok(scalar(grep { $_ eq $stale_value } @output),
+	   'stale data in at least one process when expired');
+
+	$cache->set_expires_in(-1); # never expire for next ->get
+	is($cache->get($key), $value,
+	   'value got set correctly, even if stale data returned');
+
+
+# 	$cache->set($key, $stale_value);
+# 	unlink($lock_file);
+# 	@output = parallel_run {
+# 		my $data = eval { cache_compute($cache, $key, \&get_value_die_once); };
+# 		my $eval_error = $@;
+# 		print "$data" if defined $data;
+# 		print "$sep";
+# 		print "$eval_error" if defined $eval_error;
+# 	};
+#  TODO: {
+# 		local $TODO = 'not implemented';
+#
+# 		is_deeply(
+# 			[sort @output],
+# 			[sort ("$value${sep}", "${sep}get_value_die_once\n")],
+# 			'return non-stale value, even if process regenerating it died'
+# 		);
+#
+# 		$cache->set_expires_in(-1); # never expire for next ->get
+# 		is($cache->get($key), $value,
+# 		   'value got regenerated, even if process regenerating it died');
+# 	};
+# 	unlink($lock_file);
+
+	$cache->set($key, $stale_value);
+	$cache->set_expires_in(0);   # expire now
+	$cache->set_max_lifetime(0); # don't serve stale data
+
+	@output = parallel_run {
+		my $data = cache_compute($cache, $key, \&get_value_slow);
+		print $data;
+	};
+	# no returning stale data
+	ok(!scalar(grep { $_ eq $stale_value } @output),
+	   'no stale data if configured');
+
+
+	done_testing();
+};
+$cache->set_expires_in(-1);
+
 done_testing();
 
 
-- 
1.7.3
