From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 07/10] gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
Date: Tue, 16 Feb 2010 20:36:42 +0100
Message-ID: <1266349005-15393-8-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTF9-0002i3-PV
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238Ab0BPTh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:26 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:54748 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165Ab0BPThN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:13 -0500
Received: by bwz5 with SMTP id 5so2281353bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cqrxH5LvVVKNAP7Rwnxbev8hh0ksEI5U+Hp5bkMSKYo=;
        b=FwXqyLdbkhCC1dQMX4BJ27I2wyDMYrvQfi7cuhbZATXBFvm4zZZlcFbxOFiOfUjX3X
         Q2NFavt0MqxVkhXjl+YVnYVQOrlRcTDGskwsG+pLZ1eyH1U+BoZ/1f9sWYoDxNrMuVij
         wTLxnsQ8v8bWiBf6nEXVc14l1tphmY7ik5n6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M1zgdMe2U4IBTEKh9omugINnU3HBpUM1SlF2Ssguy/3zG+t0wLn6aT8wxJ90qHUQUc
         Z23Sl0oOJyBkShesXBFq6mFIxdnNoigqL0+g9T/s6MiaEbQcj4AkPwhxffqLC84yIJ+c
         rVutI+As/w2ChwVpc+wQbs2bbEOAPLdLRuzcc=
Received: by 10.204.20.80 with SMTP id e16mr1287174bkb.72.1266349031215;
        Tue, 16 Feb 2010 11:37:11 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:10 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140145>

In the ->compute($key, $code) method from GitwebCache::SimpleFileCache,
use locking (via flock) to ensure that only one process would generate
data to update/fill-in cache; the rest would wait for the cache to
be (re)generated and would read data from cache.  If process that was
to (re)generate data dies or exits, one of the readers would take its
role.

Currently this feature can not be disabled (via %cache_options).
Other future features (like: serving stale data while cache is being
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
Differences from v2:
* More comments.
* Add loop in ->compute(), so if process that was to (re)generate data dies
  or exits, one of the readers would take its role.  Such situation should
  be rare: it can happen if two client access the same invalid URL.
* Add test for such situation in t9503

Differences from relevant parts of J.H. patch:
* Locking on separate *.lock file, for simpler work and robustness;
  acquiring exclusive lock might require having file opened for possible
  write, following
    "File Locking Tricks and Traps" (http://perl.plover.com/yak/flock/)
  J.H. patch used separate *.bg file for lock only for background caching 
  (to be implemented in one of next commits).
* Ensure that ->compute() delivers $data, unless $code fails.  See above
  about adding loop in ->compute() method.
* Single variable $lock_state, in place of $lockingStatus, $lockStatBG,
  $lockStat, $lockStatus in J.H. patch.
* Use indirect (lexical) filehandles for lockfiles, instead of barewords,
  i.e. global filehandles:
    open my $lock_fh, '+>', $lockfile;
  rather than equivalent of
    open LOCK, '>:utf8', $lockfile
* Do not use LOCK_UN: closing lockfile would unlock
* In my opinion much cleaner flow control

Possible improvements:
* When using locking, only one process would be able to write to temporary
  file.  Therefore temporary file can now have non-random name; no need for
  File::Temp nor unique_id (performance).  It would probably be best done
  via ->get_tempfile() method, or something like that.
* Run tests in t9503 which contain 'sleep 1' in them (which is required to
  test how they handle concurrent access, e.g. testing cache miss stampede
  situation) only when test is run with --long.  This would require update
  to t/test-lib.sh to export GIT_TEST_LONG to external program in
  test_external etc.
* ->get_lockname should perhaps be ->get_lockfile which would return opened
  filehandle, or filehandle + filename like File::Temp::tempfile, or objects
  that functions like filehandle but stringifies to filename like
  File::Temp->new().
* Equivalent of old _Make_Path?
* Would ability to turn this feature off make sense?

 gitweb/cache.pm                 |   44 +++++++++++++++-
 t/t9503/test_cache_interface.pl |  107 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index b828102..25f0278 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -25,6 +25,7 @@ use File::Path qw(mkpath);
 use File::Spec;
 use File::Temp;
 use Digest::MD5 qw(md5_hex);
+use Fcntl qw(:flock);
 
 # by default, the cache nests all entries on the filesystem two
 # directories deep
@@ -226,6 +227,13 @@ sub path_to_key {
 	return $filepath;
 }
 
+# Take an human readable key, and return path to be used for lockfile
+sub get_lockname {
+	my $self = shift;
+
+	return $self->path_to_key(@_) . '.lock';
+}
+
 # ----------------------------------------------------------------------
 # worker methods
 
@@ -393,15 +401,45 @@ sub get {
 # get $key; if successful, returns the value.  Otherwise, calls $code
 # and uses the return value as the new value for $key, which is then
 # returned.
+# Uses file locking to have only one process updating value for $key
+# to avoid 'cache miss stampede' (aka 'stampeding herd') problem.
 sub compute {
 	my ($self, $p_key, $p_coderef) = @_;
 
 	my $data = $self->get($p_key);
-	if (!defined $data) {
-		$data = $p_coderef->($self, $p_key);
-		$self->set($p_key, $data);
+	return $data if defined $data;
+
+	my $dir;
+	my $lockfile = $self->get_lockname($p_key, \$dir);
+
+	# ensure that directory leading to lockfile exists
+	if (!-d $dir) {
+		mkpath($dir, 0, 0777)
+			or die "Couldn't mkpath '$dir' for lockfile: $!";
 	}
 
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
+			$data = $p_coderef->($self, $p_key);
+			$self->set($p_key, $data);
+		} else {
+			# get readers lock
+			flock($lock_fh, LOCK_SH);
+			$data = $self->fetch($p_key);
+		}
+		# closing lockfile releases lock
+		close $lock_fh
+			or die "Could't close lockfile '$lockfile': $!";
+	} until (defined $data || $lock_state);
+	# repeat until we have data, or we tried generating data oneself and failed
 	return $data;
 }
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index d28f4df..255fad2 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -89,6 +89,113 @@ is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
 is($cache->compute($key, \&get_value), $value, 'compute 3rd time (get)');
 cmp_ok($call_count, '==', 1, 'get_value() is called once from compute');
 
+# Test 'stampeding herd' / 'cache miss stampede' problem
+# (probably should be run only if GIT_TEST_LONG)
+#
+sub get_value_slow {
+	$call_count++;
+	sleep 1;
+	return $value;
+}
+my ($pid, $kid_fh);
+
+$call_count = 0;
+$cache->remove($key);
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 1
+		unless defined $pid;
+
+	my $data = $cache->get($key);
+	if (!defined $data) {
+		$data = get_value_slow();
+		$cache->set($key, $data);
+	}
+
+	if ($pid) {
+		my $child_count = <$kid_fh>;
+		chomp $child_count;
+
+		waitpid $pid, 0;
+		close $kid_fh;
+
+		$call_count += $child_count;
+	} else {
+		print "$call_count\n";
+		exit 0;
+	}
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
+	my $data = $cache->compute($key, \&get_value_slow);
+
+	if ($pid) {
+		my $child_count = <$kid_fh>;
+		chomp $child_count;
+
+		waitpid $pid, 0;
+		close $kid_fh;
+
+		$call_count += $child_count;
+	} else {
+		print "$call_count\n";
+		exit 0;
+	}
+
+	cmp_ok($call_count, '==', 1, 'parallel compute: get_value_slow() called once');
+}
+
+# Test that it doesn't hang if get_action exits/dies
+#
+sub get_value_die {
+	die "get_value_die\n";
+}
+print STDERR "$$: start\n";
+my $result = eval {
+	$pid = open $kid_fh, '-|';
+ SKIP: {
+		skip "cannot fork: $!", 2
+			unless defined $pid;
+
+		local $SIG{ALRM} = sub { die "alarm\n"; };
+		alarm 4;
+
+		my ($eval_error, $child_eval_error);
+		eval { $cache->compute('No Key', \&get_value_die); };
+		$eval_error = $@;
+
+		if ($pid) {
+			local $/ = "\0";
+
+			$child_eval_error = <$kid_fh>;
+			chomp $child_eval_error;
+
+			waitpid $pid, 0;
+			close $kid_fh;
+		} else {
+
+			print "$eval_error\0";
+			exit 0;
+		}
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
+
 # Test cache expiration for 'expire now'
 #
 $cache->set_expires_in(60*60*24); # set expire time to 1 day
-- 
1.6.6.1
