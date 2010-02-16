From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 09/10] gitweb/cache.pm - Regenerate (refresh) cache in background
Date: Tue, 16 Feb 2010 20:36:44 +0100
Message-ID: <1266349005-15393-10-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:38:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTFA-0002i3-AL
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241Ab0BPTh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:27 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:38796 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230Ab0BPThV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:21 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so2281058bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qkfUDmvyFtXt5X/LLi6FWPHP1ni1eq0e5GqCRjjS1XU=;
        b=D1K+y2zLOTmL/4YU/MFOhAaCyS5FSp2O2o/YGAmxvlA1dW9OP4YPk5ta/kN9io6ZBN
         vbO4XO8y1/4gbJe+utkRCOmw0BlupJZ18LXrkublHv/pbtCIfPoayW29KHxdWFmUVbAK
         8gFbwKMyLzROumL2+QHtykubTpEBzGHIWwFwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r1OvMTkLfF9bGif77qq8XZnxZ7CHGcxk4jvBOn5BruAKM0fWl+b7YuSeAbuYD+Wi+Z
         Eo4P6EBJEzTvE/U/S0UVtWitpa3AMocciMj7dFVjr4cOktWN2iz8HzuK1F34eaEjthkc
         d7FBUo5fdi9chzTDNYfQLgmFQoiRSXEWvYpDc=
Received: by 10.204.132.207 with SMTP id c15mr880784bkt.102.1266349040825;
        Tue, 16 Feb 2010 11:37:20 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:19 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140146>

This commit removes asymmetry in serving stale data (if it exists)
when regenerating cache in GitwebCache::SimpleFileCache.  The process
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
Differences from v2:
* More comments.
* Daemonize background process, detaching it from parent.  This way
  whether main process is short-lived (gitweb as CGI) or long-lived
  (mod_perl), there would be no need to wait and no zombies.

Differences from relevant parts of J.H. patch:
* Fork (run generating process in background) only if there is stale data to
  serve (and if background cache is turned on).
* In J.H. patch forking was done unconditionally, only generation or exit
  depended on $backgroundCache.
* Lock before forking.
* Tests (currently only of API).
* In my opinion cleaner control flow.

 gitweb/cache.pm                 |   61 ++++++++++++++++++++++++++++++++------
 gitweb/gitweb.perl              |    9 ++++++
 t/t9503/test_cache_interface.pl |   16 ++++++----
 3 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 1773a7e..a3fa6fd 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -26,6 +26,7 @@ use File::Spec;
 use File::Temp;
 use Digest::MD5 qw(md5_hex);
 use Fcntl qw(:flock);
+use POSIX qw(setsid);
 
 # by default, the cache nests all entries on the filesystem two
 # directories deep
@@ -79,6 +80,9 @@ our $DEFAULT_CACHE_ROOT = "cache";
 #    than it, serve stale data when waiting for cache entry to be 
 #    regenerated (refreshed).  Non-adaptive.
 #    Defaults to -1 (never expire / always serve stale).
+#  * 'background_cache' (boolean)
+#    This enables/disables regenerating cache in background process.
+#    Defaults to true.
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -88,7 +92,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
-	my ($max_lifetime);
+	my ($max_lifetime, $background_cache);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -108,6 +112,7 @@ sub new {
 		$max_lifetime =
 			$p_options_hash_ref->{'max_lifetime'} ||
 			$p_options_hash_ref->{'max_cache_lifetime'};
+		$background_cache = $p_options_hash_ref->{'background_cache'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -118,6 +123,7 @@ sub new {
 	$expires_max = 1200 unless (defined($expires_max));
 	$increase_factor = 60 unless defined($increase_factor);
 	$max_lifetime = -1 unless defined($max_lifetime);
+	$background_cache = 1 unless defined($background_cache);
 
 	$self->set_root($root);
 	$self->set_depth($depth);
@@ -127,6 +133,7 @@ sub new {
 	$self->set_max_lifetime($max_lifetime);
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
+	$self->set_background_cache($background_cache);
 
 	return $self;
 }
@@ -137,7 +144,9 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load max_lifetime)) {
+foreach my $i (qw(depth root namespace
+                  expires_min expires_max increase_factor check_load
+                  max_lifetime background_cache)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -417,8 +426,9 @@ sub get {
 # to avoid 'cache miss stampede' (aka 'stampeding herd') problem.
 sub compute {
 	my ($self, $p_key, $p_coderef) = @_;
+	my ($data, $stale_data);
 
-	my $data = $self->get($p_key);
+	$data = $self->get($p_key);
 	return $data if defined $data;
 
 	my $dir;
@@ -437,16 +447,47 @@ sub compute {
 	do {
 		open my $lock_fh, '+>', $lockfile
 			or die "Could't open lockfile '$lockfile': $!";
+
 		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
 		if ($lock_state) {
-			# acquired writers lock
-			$data = $p_coderef->($self, $p_key);
-			$self->set($p_key, $data);
+			## acquired writers lock, have to generate data
+			my $pid;
+			if ($self->{'background_cache'}) {
+				# try to retrieve stale data
+				$stale_data = $self->fetch($p_key)
+					if $self->is_valid($p_key, $self->get_max_lifetime());
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
+				$data = $p_coderef->($self, $p_key);
+				$self->set($p_key, $data);
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
-			$data = $self->fetch($p_key)
+			$stale_data = $self->fetch($p_key)
 				if $self->is_valid($p_key, $self->get_max_lifetime());
-			if (!defined $data) {
+
+			if (!defined $stale_data) {
 				# get readers lock if there is no stale data to serve
 				flock($lock_fh, LOCK_SH);
 				$data = $self->fetch($p_key);
@@ -455,9 +496,9 @@ sub compute {
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
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ff249b9..c391226 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -293,6 +293,15 @@ our %cache_options = (
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
 
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 2eae9e0..9643631 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -86,6 +86,7 @@ sub get_value {
 	$call_count++;
 	return $value;
 }
+local $SIG{CHLD} = 'IGNORE'; # compute can fork, don't generate zombies
 can_ok($cache, qw(compute));
 is($cache->compute($key, \&get_value), $value, 'compute 1st time (set)');
 is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
@@ -305,32 +306,35 @@ sub run_compute_forked {
 }
 $cache->set_expires_in(0);    # expire now
 $cache->set_max_lifetime(-1); # forever
+ok($cache->get_background_cache(), 'generate cache in background by default');
 $pid = open $kid_fh, '-|';
 SKIP: {
-	skip "cannot fork: $!", 2
+	skip "cannot fork: $!", 3
 		unless defined $pid;
 
 	my $data = run_compute_forked($pid);
 
 	# returning stale data works
-	ok($data eq $stale_value || $child_data eq $stale_value,
-	   'stale data in at least one process when expired');
+	is($data,       $stale_value, 'stale data in parent when expired');
+	is($child_data, $stale_value, 'stale data in child  when expired');
 
 	$cache->set_expires_in(-1); # never expire for next ->get
+	diag('waiting for background process to have time to set data');
+	sleep 1; # wait for background process to have chance to set data
 	is($cache->get($key), $value, 'value got set correctly, even if stale data returned');
 }
 $cache->set_expires_in(0);   # expire now
 $cache->set_max_lifetime(0); # don't serve stale data
 $pid = open $kid_fh, '-|';
 SKIP: {
-	skip "cannot fork: $!", 1
+	skip "cannot fork: $!", 2
 		unless defined $pid;
 
 	my $data = run_compute_forked($pid);
 
 	# no returning stale data
-	ok($data ne $stale_value && $child_data ne $stale_value,
-	   'configured to never return stale data');
+	isnt($data,       $stale_value, 'no stale data in parent if configured');
+	isnt($child_data, $stale_value, 'no stale data in child  if configured');
 }
 $cache->set_expires_in(-1);
 
-- 
1.6.6.1
