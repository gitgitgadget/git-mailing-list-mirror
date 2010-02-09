From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 07/10] gitweb/cache.pm - Use locking to avoid 'cache miss stampede' problem
Date: Tue,  9 Feb 2010 11:30:24 +0100
Message-ID: <1265711427-15193-8-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenNf-00041a-7S
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab0BIKbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:31:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:10368 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0BIKax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:53 -0500
Received: by fg-out-1718.google.com with SMTP id e21so291000fga.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=reAJL/JjG/xfND5mIImN2uspEE/E5ykQZEsgEIzVO18=;
        b=ulrgQVBz+PShzz9oMVy1FNHmiCxxqoFNfTLEIQCajKSiMDcynLHb4Q5ITBniBQDOAv
         C5dOdCvvNLIh7V/Yz/py1MHJdATVaFDVvnwYywS+X/OvIlXAK+VDxHtwV5mu+nKpu1kC
         W3hI5mQ42eBaRM9DkOaKG17IgZdMcQTeeiJII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WcCrlsHuujx5PS9O7iatD0ntaSlB+ZYUW6LjbrhakN+xAjwhitjCdb7VobPTktzIRb
         ayffVh54fIn3687G6BxtDjIOaG+p874CtkaBg4+oaI8Ys+i4UopCXyh8JnnHS372d72S
         W01GJ0GMCwHL5JbC9egyxoUFBw0b26UMuyeqI=
Received: by 10.87.63.4 with SMTP id q4mr10921714fgk.59.1265711451248;
        Tue, 09 Feb 2010 02:30:51 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:50 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139392>

In the ->compute($key, $code) method from GitwebCache::SimpleFileCache,
use locking (via flock) to ensure that only one process would generate
data to update/fill-in cache; the rest would wait for the cache to
be (re)generated and would read data from cache.

Currently this feature can not be disabled (via %cache_options).


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

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v1:
* Proper commit message
* ->get_lockname($key) replaced ->_lockfile_to_key($namespace, $key)
* mkpath to ensure that path leading to lockfile exists instead of private
  _Make_Path subroutine (this is a bit of code repetition in new code).
* Testing of removing non-existent key moved to earlier commit

Differences from relevant parts of J.H. patch:
* Locking on separate *.lock file, for simpler work and robustness;
  acquiring exclusive lock might require having file opened for possible
  write, following
    "File Locking Tricks and Traps" (http://perl.plover.com/yak/flock/)
  J.H. patch used separate *.bg file for lock only for background caching 
  (to be implemented in one of next commits).
* Single variable $lock_state, in place of $lockingStatus, $lockStatBG,
  $lockStat, $lockStatus in J.H. patch.
* Use indirect filehandles for lockfiles, instead of barewords, i.e. global
  filehandles: 
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
* Run tests which contain 'sleep 1' in them (which is required to test how
  they handle concurrent access, e.g. testing cache miss stampede situation)
  only when test is run with --long.  This would require update to
  t/test-lib.sh to export GIT_TEST_LONG to external program in test_external
  etc.
* ->get_lockname should perhaps be ->get_lockfile which would return opened
  filehandle, or filehandle + filename like File::Temp::tempfile, or objects
  that functions like filehandle but stringifies to filename like
  File::Temp->new().
* Equivalent of old _Make_Path?
* Would ability to turn this feature off make sense?

 gitweb/cache.pm                 |   29 ++++++++++++++++-
 t/t9503/test_cache_interface.pl |   65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 899a4b4..5c2de7e 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -24,6 +24,7 @@ use File::Path qw(mkpath);
 use File::Spec;
 use File::Temp;
 use Digest::MD5 qw(md5_hex);
+use Fcntl qw(:flock);
 
 # by default, the cache nests all entries on the filesystem two
 # directories deep
@@ -195,6 +196,12 @@ sub path_to_key {
 	return $filepath;
 }
 
+sub get_lockname {
+	my $self = shift;
+
+	return $self->path_to_key(@_) . '.lock';
+}
+
 # ----------------------------------------------------------------------
 # worker methods
 
@@ -330,17 +337,35 @@ sub compute {
 	my ($self, $p_key, $p_coderef) = @_;
 
 	my $data = $self->get($p_key);
-	if (!defined $data) {
+	return $data if defined $data;
+
+	my $dir;
+	my $lockfile = $self->get_lockname($p_key, \$dir);
+
+	# ensure that directory leading to lockfile exists
+	mkpath($dir, 0, 0777) if !-d $dir;
+
+	open my $lock_fh, '+>', $lockfile;
+	#	or die "Can't open lockfile '$lockfile': $!";
+	if (my $lock_state = flock($lock_fh, LOCK_EX | LOCK_NB)) {
+		# acquired writers lock
 		$data = $p_coderef->($self, $p_key);
 		$self->set($p_key, $data);
+	} else {
+		# get readers lock
+		flock($lock_fh, LOCK_SH);
+		$data = $self->fetch($p_key);
 	}
-
+	# closing lockfile releases lock
+	close $lock_fh;
 	return $data;
 }
 
 1;
 } # end of package GitwebCache::SimpleFileCache;
 
+# ======================================================================
+
 # human readable key identifying gitweb output
 sub gitweb_output_key {
 	return href(-replay => 1, -full => 1, -path_info => 0);
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 3945adc..42fe359 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -107,6 +107,71 @@ is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
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
+
 # Test cache expiration for 'expire now'
 #
 $cache->set_expires_in(60*60*24); # set expire time to 1 day
-- 
1.6.6.1
