From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 15/17] gitweb/lib - Regenerate (refresh) cache in background
Date: Mon, 14 Jun 2010 18:08:28 +0200
Message-ID: <1276531710-22945-17-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEv-0002Dq-Er
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab0FNQJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38593 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab0FNQJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:09:05 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649905fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lc0Y2aBZLbbeXoQpQ8XI8IBZ11IsF1HxLc6MNnJn6QQ=;
        b=Mz7wFEi7BGkqqElSUV74zK9NgCH15x3O2MVByE5LY8dXKVSbBZlugp7qelDr6cjgIa
         yL6NoCLFWT1mS2skHWm/KEl+LLD3LLNaO6/mumz+3FgAq/JqAjDxdA5PxXUsT0xwqsSt
         dy8Gxo5o5W63t+djB9h5hK9lpxylQ7Y8my3r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=woNMyNHLCWZrnwjEAYJ3uyBaycNyaf/wn3HH/e4a3JILu9bhSaHkOONvnksk0DEmkT
         gG8iwn3Urqu1Czp76l7KFUv6FBIBpWiRZnT875OaqHTt6668oB58fzdS3DAawzn5JTTR
         5EBorUAXjzLRyXsTrFQ1S3ynhlpjTOaktS11A=
Received: by 10.223.117.164 with SMTP id r36mr5682198faq.28.1276531743496;
        Mon, 14 Jun 2010 09:09:03 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.09.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:09:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149115>

This commit removes asymmetry in serving stale data (if it exists)
when regenerating cache in GitwebCache::FileCacheWithLocking.  The process
that acquired exclusive (writers) lock, and is therefore selected to
be the one that (re)generates data to fill the cache, can now generate
data in background, while serving stale data.

Those background processes are daemonized, i.e. detached from the main
process (the one returning data or stale data).  Otherwise there might be a
problem when gitweb is running as (part of) long-lived process, for example
from mod_perl (or in the future from FastCGI): it would leave unreaped
children as zombies (entries in process table).  We don't want to wait for
background process, and we can't set $SIG{CHLD} to 'IGNORE' in gitweb to
automatically reap child processes, because this interferes with using
  open my $fd, '-|', git_cmd(), 'param', ...
    or die_error(...)
  # read from <$fd>
  close $fd
    or die_error(...)
In the above code "close" for magic "-|" open calls waitpid...  and we
would would die with "No child processes".  Removing 'or die' would
possibly remove ability to react to other errors.

This feature can be enabled or disabled on demand via 'background_cache'
cache parameter.  It is turned on by default.


To be implemented (from original patch by J.H.):
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                             |    9 ++++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   61 +++++++++++++++++++----
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |    3 +-
 t/t9503/test_cache_interface.pl                |   12 ++++-
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5aee9a1..2ca1ad7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -299,6 +299,15 @@ our %cache_options = (
 	# Set it to -1 to always serve existing data if it exists,
 	# set it to 0 to turn off serving stale data - always wait.
 	'max_lifetime' => 5*60*60, # 5 hours
+
+	# This enables/disables background caching.  If it is set to true value,
+	# caching engine would return stale data (if it is not older than
+	# 'max_lifetime' seconds) if it exists, and launch process if regenerating
+	# (refreshing) cache into the background.  If it is set to false value,
+	# the process that fills cache must always wait for data to be generated.
+	# In theory this will make gitweb seem more responsive at the price of
+	# serving possibly stale data.
+	'background_cache' => 1,
 );
 
 
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 266114c..bde1420 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -23,6 +23,7 @@ use warnings;
 
 use File::Path qw(mkpath);
 use Fcntl qw(:flock);
+use POSIX qw(setsid);
 
 # ......................................................................
 # constructor
@@ -70,21 +71,27 @@ use Fcntl qw(:flock);
 #    than it, serve stale data when waiting for cache entry to be 
 #    regenerated (refreshed).  Non-adaptive.
 #    Defaults to -1 (never expire / always serve stale).
+#  * 'background_cache' (boolean)
+#    This enables/disables regenerating cache in background process.
+#    Defaults to true.
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
 	my $class = ref($proto) || $proto;
 	my $self = $class->SUPER::new($p_options_hash_ref);
 
-	my ($max_lifetime);
+	my ($max_lifetime, $background_cache);
 	if (defined $p_options_hash_ref) {
 		$max_lifetime =
 			$p_options_hash_ref->{'max_lifetime'} ||
 			$p_options_hash_ref->{'max_cache_lifetime'};
+		$background_cache = $p_options_hash_ref->{'background_cache'};
 	}
 	$max_lifetime = -1 unless defined($max_lifetime);
+	$background_cache = 1 unless defined($background_cache);
 
 	$self->set_max_lifetime($max_lifetime);
+	$self->set_background_cache($background_cache);
 
 	return $self;
 }
@@ -95,7 +102,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(max_lifetime)) {
+foreach my $i (qw(max_lifetime background_cache)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -132,9 +139,10 @@ sub get_lockname {
 # Uses file locking to have only one process updating value for $key
 # to avoid 'cache miss stampede' (aka 'stampeding herd') problem.
 sub compute {
-	my ($self, $key, $code) = @_;
+	my ($self, $key, $coderef) = @_;
+	my ($data, $stale_data);
 
-	my $data = $self->get($key);
+	$data = $self->get($key);
 	return $data if defined $data;
 
 	my $dir;
@@ -153,16 +161,47 @@ sub compute {
 	do {
 		open my $lock_fh, '+>', $lockfile
 			or die "Could't open lockfile '$lockfile': $!";
+
 		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
 		if ($lock_state) {
-			# acquired writers lock
-			$data = $code->($self, $key);
-			$self->set($key, $data);
+			## acquired writers lock, have to generate data
+			my $pid;
+			if ($self->{'background_cache'}) {
+				# try to retrieve stale data
+				$stale_data = $self->fetch($key)
+					if $self->is_valid($key, $self->get_max_lifetime());
+
+				# fork if there is stale data, for background process
+				# to regenerate/refresh the cache (generate data)
+				$pid = fork() if (defined $stale_data);
+			}
+			if (!defined $pid || !$pid) {
+				## didn't fork, or are in background process
+
+				# daemonize background process, detaching it from parent
+				# see also Proc::Daemonize, Apache2::SubProcess
+				if (defined $pid) {
+					POSIX::setsid();  # or setpgrp(0, 0);
+					fork() && exit 0;
+				}
+
+				$data = $coderef->($self, $key);
+				$self->set($key, $data);
+
+				if (defined $pid) {
+					## in background process; parent will serve stale data
+					close $lock_fh
+						or die "Couldn't close lockfile '$lockfile' (background): $!";
+					exit 0;
+				}
+			}
+			
 		} else {
 			# try to retrieve stale data
-			$data = $self->fetch($key)
+			$stale_data = $self->fetch($key)
 				if $self->is_valid($key, $self->get_max_lifetime());
-			if (!defined $data) {
+
+			if (!defined $stale_data) {
 				# get readers lock if there is no stale data to serve
 				flock($lock_fh, LOCK_SH);
 				$data = $self->fetch($key);
@@ -171,9 +210,9 @@ sub compute {
 		# closing lockfile releases lock
 		close $lock_fh
 			or die "Could't close lockfile '$lockfile': $!";
-	} until (defined $data || $lock_state);
+	} until (defined $data || defined $stale_data || $lock_state);
 	# repeat until we have data, or we tried generating data oneself and failed
-	return $data;
+	return defined $data ? $data : $stale_data;
 }
 
 1;
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 5289894..9eb4896 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -129,7 +129,8 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load)) {
+foreach my $i (qw(depth root namespace
+                  expires_min expires_max increase_factor check_load)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 185307e..667fb5e 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -18,6 +18,9 @@ my $cache = new_ok('GitwebCache::FileCacheWithLocking', [ {
 } ]);
 isa_ok($cache, 'GitwebCache::SimpleFileCache');
 
+# compute can fork, don't generate zombies
+#local $SIG{CHLD} = 'IGNORE';
+
 # Test that default values are defined
 #
 ok(defined $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
@@ -309,18 +312,21 @@ sub run_compute_forked {
 }
 $cache->set_expires_in(0);    # expire now
 $cache->set_max_lifetime(-1); # forever (always serve stale data)
+ok($cache->get_background_cache(), 'generate cache in background by default');
 $pid = open $kid_fh, '-|';
 SKIP: {
-	skip "cannot fork: $!", 2
+	skip "cannot fork: $!", 3
 		unless defined $pid;
 
 	my ($data, $child_data) = run_compute_forked($pid, $kid_fh);
 
 	# returning stale data works
-	ok($data eq $stale_value || $child_data eq $stale_value,
-	   'stale data in at least one process when expired');
+	is($data,       $stale_value, 'stale data in parent when expired');
+	is($child_data, $stale_value, 'stale data in child  when expired');
 
 	$cache->set_expires_in(-1); # never expire for next ->get
+	diag('waiting for background process to have time to set data');
+	sleep $slow_time; # wait for background process to have chance to set data
 	is($cache->get($key), $value, 'value got set correctly, even if stale data returned');
 }
 
-- 
1.7.0.1
