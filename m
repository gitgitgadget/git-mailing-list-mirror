From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 08/10] gitweb/cache.pm - Use locking to avoid 'stampeding herd' problem (WIP)
Date: Sat, 23 Jan 2010 01:27:31 +0100
Message-ID: <2ae094e73aacb9d855a71fa60d8982645293872c.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrk-0002dP-BE
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab0AWA17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884Ab0AWA14
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:56 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:54861 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394Ab0AWA1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:52 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so1932505fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=DE7TrWHVFKJeFpe9QuT9Z5OxQnraGlMB+WIWZKEBUeQ=;
        b=iUfj7TL+qpJ52XwdHaFStWFqBOlGYYUhkQJFMMr3DHAvSMivLQgt7TRnNyrHQECvtB
         qTC3fppJihy3/PrNiA+lCsJdeFEltgb8l1Qrk9KoVB/CHwP3EV26VLq2FLaoFBjdGh9+
         sMQKPF9SoLXnzIyX4jIT5naZ5UfP3IZ4fwCkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=evPAZqwNRpxNoyeAfipYKA1s+3TLrCYxNuXA4wx2WMNrPQXuSvg6Cs5UZyldg+NgwM
         UWRLlvI/3t6uZCZSGnl4L0KHFYv5b5lk5qbwEXNK2VE6PclJO5m2GboKPvhs8oisi1Nw
         Z2Pt17yln69MVa0SiuN28D5rl+Bpj8Vty5xDs=
Received: by 10.103.50.2 with SMTP id c2mr1943479muk.9.1264206472093;
        Fri, 22 Jan 2010 16:27:52 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:51 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137799>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress.

As you can see we can almost do the same for the cache which supports
only get/set interface... but for replacing ->retrieve() with ->get()
in ->compute().  This is argument for generic_compute subroutine,
mentioned in previous patch.

Note that we actually can and do test that provided mechanism avoid
cache miss stampede (aka 'stampeding herd') problem... although the
test should probably be run only with --long (this would need update
to t/test-lib.sh to pass GIT_TEST_LONG to external tests in
test_external and the like), as we need to sleep at least one second
to ensure that we would have 'stampeding herd' problem.

 gitweb/cache.pm                 |   27 ++++++++++++++--
 t/t9503/test_cache_interface.pl |   66 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 8dd4f39..f514ee9 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -24,6 +24,7 @@ use File::Path qw(make_path);  # requires version >= 2.0
 use File::Spec;
 use File::Temp;
 use Digest::MD5 qw(md5_hex);
+use Fcntl qw(:flock);
 
 # by default, the cache nests all entries on the filesystem two
 # directories deep
@@ -217,7 +218,7 @@ sub _path_to_key {
 	my ($self, $p_namespace, $p_key) = @_;
 
 	return $self->_path_to_hashed_key($p_namespace,
-	                                    _Build_Hashed_Key($p_key));
+	                                  _Build_Hashed_Key($p_key));
 }
 
 # Take hashed key, and return file path
@@ -228,6 +229,13 @@ sub _path_to_hashed_key {
 	                           _Split_Word($p_hashed_key, $self->get_depth()));
 }
 
+sub _lockfile_to_key {
+	my ($self, $p_namespace, $p_key) = @_;
+
+	return $self->_path_to_hashed_key($p_namespace,
+	                                  _Build_Hashed_Key($p_key)) . '.lock';
+}
+
 # Split word into N components, where each component but last is two-letter word
 # e.g. _Split_Word("06b90e786e304a18fdfbd7c7bcc41a6b", 2) == qw(06 b90e786e304a18fdfbd7c7bcc41a6b);
 #      _Split_Word("06b90e786e304a18fdfbd7c7bcc41a6b", 3) == qw(06 b9 0e786e304a18fdfbd7c7bcc41a6b);
@@ -412,17 +420,30 @@ sub compute {
 	my ($self, $p_key, $p_coderef) = @_;
 
 	my $data = $self->get($p_key);
-	if (!defined $data) {
+	return $data if defined $data;
+
+	my $lockfile = $self->_lockfile_to_key($self->get_namespace(), $p_key);
+	_Make_Path($lockfile);
+	open my $lock_fh, '+>', $lockfile;
+	#	or die "Can't open lockfile '$lockfile': $!";
+	if (my $lock_state = flock($lock_fh, LOCK_EX | LOCK_NB)) {
+		# acquired writers lock
 		$data = $p_coderef->($self, $p_key);
 		$self->set($p_key, $data);
+	} else {
+		# get readers lock
+		flock($lock_fh, LOCK_SH);
+		$data = $self->restore($self->get_namespace(), $p_key);
 	}
-
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
index 0870b87..43b806d 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -65,6 +65,8 @@ $cache->set($key, $value);
 is($cache->get($key), $value,          'get after set, returns cached value');
 $cache->remove($key);
 ok(!defined($cache->get($key)),        'get after remove, is undefined');
+eval { $cache->remove('Not-Existent Key'); };
+ok(!$@,                                'remove on non-existent key doesn\'t die');
 
 # Test the getting and setting of a cached value
 # (CHI interface)
@@ -80,6 +82,70 @@ is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
 is($cache->compute($key, \&get_value), $value, 'compute 3rd time (get)');
 cmp_ok($call_count, '==', 1, 'get_value() is called once');
 
+# Test 'stampeding herd' / cache miss stampede problem
+# (probably should be run only if GIT_TEST_LONG)
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
 $cache->set_expires_min(0);
-- 
1.6.6.1
