From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 08/10] gitweb/cache.pm - Serve stale data when waiting for filling cache
Date: Tue, 16 Feb 2010 20:36:43 +0100
Message-ID: <1266349005-15393-9-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTFB-0002i3-CN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245Ab0BPThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:46 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34515 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933228Ab0BPThT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:19 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so2280988bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lA7Yb2acVTK/ToL5YhlsbYUACCd5Yd9Xbd9ieBWwNhI=;
        b=MIyzGosvkDvaGR8GTkJauPOb1iKrGiupOcm4dPIPF2RthiiW44v0xeWLu+OvdZllB/
         A/kNHUG90PMY8et01M0+KblM8v76g21o8fHU7pGtN/aOD8tu6ZI6XsLkPTX4rcogXDNC
         VghsubXvqA0bfpDCeZzJz6MYOUaQFT7Iv1IzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kb/xqu7JNjlxbAlVezC2AdZDbT6bYfSMxgKgTF287ZG2WLqS+HMle3szca3ok+qly7
         D8SnVDn1AUoIAzapeTLHWrE8+8nPYNfEIeUG/xREq53kbhJ6G9jow8tjaWeXcgKiVTX+
         S8gwfW7PHgLSpfvVy96hdrLObfVR4V2C5ExTs=
Received: by 10.204.33.206 with SMTP id i14mr1926441bkd.52.1266349038543;
        Tue, 16 Feb 2010 11:37:18 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:13 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140147>

When process fails to acquire exclusive (writers) lock, then instead
of waiting for the other process to (re)generate and fill cache, serve
stale (expired) data from cache.  This is of course possible only if
there is some stale data in cache for given key.

This feature of GitwebCache::SimpleFileCache is used only for an
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

When developing this feature, ->is_valid() method acquired additional
extra optional parameter, where one can pass expire time instead of using
whole-cache global (adaptive) expire time.

To be implemented (from original patch by J.H.):
* background building,
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v2:
* 'max_lifetime' described in comment above new() in cache.pm.
* More comments describing code.

Differences from relevant parts of J.H. patch:
* Instead of using $maxCacheLife, use 'max_lifetime' option (with
  'max_cache_lifetime' as optional spelling in GitwebCache::SimpleFileCache
  constructor).
* Use 5*60*60 seconds for 5 hours, rather than 18000 (or 18_000) seconds.
* Serving stale data was enabled only when background cache regeneration was
  enabled; here it is enabled for readers regardless whether background
  generation (introduced in next commit) is turned on or not. 

Possible improvements:
* Run long tests only with --long (well, they are not _that_ long).

 gitweb/cache.pm                 |   33 +++++++++++++++-----
 gitweb/gitweb.perl              |    8 +++++
 t/t9503/test_cache_interface.pl |   63 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 25f0278..1773a7e 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -74,6 +74,11 @@ our $DEFAULT_CACHE_ROOT = "cache";
 #  * 'increase_factor' [seconds / 100% CPU load]
 #    Factor multiplying 'check_load' result when calculating cache lietime.
 #    Defaults to 60 seconds for 100% SPU load ('check_load' returning 1.0).
+#  * 'max_lifetime' [seconds]
+#    If it is greater than 0, and cache entry is expired but not older
+#    than it, serve stale data when waiting for cache entry to be 
+#    regenerated (refreshed).  Non-adaptive.
+#    Defaults to -1 (never expire / always serve stale).
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -83,6 +88,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
+	my ($max_lifetime);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -99,6 +105,9 @@ sub new {
 			$p_options_hash_ref->{'expires_max'};
 		$increase_factor = $p_options_hash_ref->{'expires_factor'};
 		$check_load      = $p_options_hash_ref->{'check_load'};
+		$max_lifetime =
+			$p_options_hash_ref->{'max_lifetime'} ||
+			$p_options_hash_ref->{'max_cache_lifetime'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -108,12 +117,14 @@ sub new {
 		if (!defined($expires_max) && exists $p_options_hash_ref->{'expires_in'});
 	$expires_max = 1200 unless (defined($expires_max));
 	$increase_factor = 60 unless defined($increase_factor);
+	$max_lifetime = -1 unless defined($max_lifetime);
 
 	$self->set_root($root);
 	$self->set_depth($depth);
 	$self->set_namespace($ns);
 	$self->set_expires_min($expires_min);
 	$self->set_expires_max($expires_max);
+	$self->set_max_lifetime($max_lifetime);
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
 
@@ -126,7 +137,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load)) {
+foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load max_lifetime)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -340,12 +351,13 @@ sub remove {
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
 
@@ -356,7 +368,7 @@ sub is_valid {
 		or die "Couldn't stat file '$path': $!";
 
 	# expire time can be set to never
-	my $expires_in = $self->get_expires_in();
+	$expires_in = defined $expires_in ? $expires_in : $self->get_expires_in();
 	return 1 unless (defined $expires_in && $expires_in >= 0);
 
 	# is file expired?
@@ -431,9 +443,14 @@ sub compute {
 			$data = $p_coderef->($self, $p_key);
 			$self->set($p_key, $data);
 		} else {
-			# get readers lock
-			flock($lock_fh, LOCK_SH);
-			$data = $self->fetch($p_key);
+			# try to retrieve stale data
+			$data = $self->fetch($p_key)
+				if $self->is_valid($p_key, $self->get_max_lifetime());
+			if (!defined $data) {
+				# get readers lock if there is no stale data to serve
+				flock($lock_fh, LOCK_SH);
+				$data = $self->fetch($p_key);
+			}
 		}
 		# closing lockfile releases lock
 		close $lock_fh
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2b429d2..ff249b9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -285,6 +285,14 @@ our %cache_options = (
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
 
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 255fad2..2eae9e0 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -34,8 +34,11 @@ ok($return,          "run   gitweb/cache.pm");
 
 # Test creating a cache
 #
-my $cache = new_ok('GitwebCache::SimpleFileCache',
-	[ { 'cache_root' => 'cache', 'cache_depth' => 2 } ]);
+my $cache = new_ok('GitwebCache::SimpleFileCache', [ {
+	'cache_root' => 'cache',
+	'cache_depth' => 2,
+	'max_lifetime' => 0, # turn it off
+} ]);
 
 # Test that default values are defined
 #
@@ -275,6 +278,62 @@ $cache->set($key, $cached_output);
 $test_data = capture_cache_fetch_output();
 is($test_data, $cached_output,        'action output is printed (from cache)');
 
+# Test that cache returns stale data in existing but expired cache situation
+# (probably should be run only if GIT_TEST_LONG)
+#
+my $stale_value = 'Stale Value';
+my $child_data = '';
+$cache->set($key, $stale_value);
+$call_count = 0;
+sub run_compute_forked {
+	my $pid = shift;
+
+	my $data = $cache->compute($key, \&get_value_slow);
+
+	if ($pid) {
+		$child_data = <$kid_fh>;
+		chomp $child_data;
+
+		waitpid $pid, 0;
+		close $kid_fh;
+	} else {
+		print "$data\n";
+		exit 0;
+	}
+
+	return $data;
+}
+$cache->set_expires_in(0);    # expire now
+$cache->set_max_lifetime(-1); # forever
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 2
+		unless defined $pid;
+
+	my $data = run_compute_forked($pid);
+
+	# returning stale data works
+	ok($data eq $stale_value || $child_data eq $stale_value,
+	   'stale data in at least one process when expired');
+
+	$cache->set_expires_in(-1); # never expire for next ->get
+	is($cache->get($key), $value, 'value got set correctly, even if stale data returned');
+}
+$cache->set_expires_in(0);   # expire now
+$cache->set_max_lifetime(0); # don't serve stale data
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 1
+		unless defined $pid;
+
+	my $data = run_compute_forked($pid);
+
+	# no returning stale data
+	ok($data ne $stale_value && $child_data ne $stale_value,
+	   'configured to never return stale data');
+}
+$cache->set_expires_in(-1);
+
 done_testing();
 
 print Dumper($cache);
-- 
1.6.6.1
