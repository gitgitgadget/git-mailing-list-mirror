From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 08/10] gitweb/cache.pm - Serve stale data when waiting for filling cache
Date: Tue,  9 Feb 2010 11:30:25 +0100
Message-ID: <1265711427-15193-9-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenNd-00041a-EF
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab0BIKbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:31:06 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:37995 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab0BIKa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:56 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3026604fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kIzscT1S2Jum7Q4GzlT//i8ewKNLWxLNDemTpemUSRo=;
        b=QAjNYHATxgawQOcU5S+PIcp8AozzpkZx5Ts9/K9QGLI839603nxkEsdeWuEFKIyGXt
         JFgCXK4nPfWQ27P+VIjbalxfy97CMxVQeiPl+IQnzylpFKaTc4y82dHBYJu0Yg0cIwip
         wbs7tj0oFYWnF68JwQ6U8tsHT+OOMWVqZjyWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n+9J3e9Q+WLcs5JP0AbmJw+jvwHyj2ZRsTYCwcgX40l7+g2CcP4YLLhFgMch4ZqS9U
         NfS5gqDM9rhUd+JRKpBOEHFYaszY8ek2c2GWmaOAE/eK0uTIPWPfJuoUEmtAx7oHLvtZ
         66JQZFYWOmPauDB09VYqdaT6aNHnWBhAqsY1s=
Received: by 10.87.5.15 with SMTP id h15mr10637135fgi.43.1265711453337;
        Tue, 09 Feb 2010 02:30:53 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:52 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139389>

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
bit assymetric with respect to process that acquired writers lock and
those processes that didn't, which can be seen in the new test in t9503.
The process that is to regenerate (refresh) data in cache must wait for
the data to be generated in full before showing anything to client, while
the other processes show stale (expired) data immediately.  In order to
remove or reduce this assymetry gitweb would need to employ one of the two
alternate solutions.  Either data should be (re)generated in background,
so that process that acquired writers lock would generate data in
background while serving stale data, or alternatively the process that
generates data should pass output to original STDOUT while capturing it
("tee" otput).

When developing this feature, ->is_valid() method acquired additional
extra optional parameter, where one cap pass expire time instead of using
cache-wode global expire time.

To be implemented (from original patch by J.H.):
* background building,
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v1:
* Proper commit messages
* Both serving stale data (this patch) and background generation (next
  patch) were together in a single patch in previous version of this
  series.
* There is limit (like in J.H. patch) how stale can cache entry be to be
  eligible to be served while waiting for cache to be refreshed.  You can
  set 'max_lifetime' to -1 to always serve stale data if it exists, no
  matter how long ago it was generated (this is the default, like in v1).
* The above led to modifying ->is_valid() to accept optional parameter
  specifying max age.  Note that this max age is not influenced by
  'check_load' (is not adaptive).
* Because background cache generation was split in separate patch, for now
  serving stale data is used only for readers (processes which would have to
  wait for refreshing cache).
* This feature is turned off in tests, and turned on only for testng this
  feature.  Extra test that this feature can be turned off, which caused
  refactoring common code.

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

 gitweb/cache.pm                 |   23 ++++++++++----
 gitweb/gitweb.perl              |    8 +++++
 t/t9503/test_cache_interface.pl |   63 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 5c2de7e..e3bbe57 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -66,6 +66,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
+	my ($max_lifetime);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -82,6 +83,9 @@ sub new {
 			$p_options_hash_ref->{'expires_max'};
 		$increase_factor = $p_options_hash_ref->{'expires_factor'};
 		$check_load      = $p_options_hash_ref->{'check_load'};
+		$max_lifetime =
+			$p_options_hash_ref->{'max_lifetime'} ||
+			$p_options_hash_ref->{'max_cache_lifetime'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -91,12 +95,14 @@ sub new {
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
 
@@ -108,7 +114,7 @@ sub new {
 
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
-foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load)) {
+foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load max_lifetime)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -295,7 +301,7 @@ sub remove {
 
 # exists in cache and is not expired
 sub is_valid {
-	my ($self, $key) = @_;
+	my ($self, $key, $expires_in) = @_;
 
 	my $path = $self->path_to_key($key);
 
@@ -303,7 +309,7 @@ sub is_valid {
 	return 0 unless -f $path;
 
 	# expire time can be set to never
-	my $expires_in = $self->get_expires_in();
+	$expires_in = defined $expires_in ? $expires_in : $self->get_expires_in();
 	return 1 unless (defined $expires_in && $expires_in >= 0);
 
 	# is file expired?
@@ -352,9 +358,14 @@ sub compute {
 		$data = $p_coderef->($self, $p_key);
 		$self->set($p_key, $data);
 	} else {
-		# get readers lock
-		flock($lock_fh, LOCK_SH);
-		$data = $self->fetch($p_key);
+		# try to retrieve stale data
+		$data = $self->fetch($p_key)
+			if $self->is_valid($p_key, $self->get_max_lifetime());
+		if (!defined $data) {
+			# get readers lock if there is no stale data to serve
+			flock($lock_fh, LOCK_SH);
+			$data = $self->fetch($p_key);
+		}
 	}
 	# closing lockfile releases lock
 	close $lock_fh;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aabed72..ea0ad25 100755
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
index 42fe359..922c7cd 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -53,8 +53,11 @@ ok($return,          "run   gitweb/cache.pm");
 
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
@@ -269,6 +272,62 @@ if ((my $use_perlio_util = $test_perlio_util)) {
 	is($test_data, $cached_output,             'action output is printed (from cache)');
 }
 
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
