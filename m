From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 09/10] gitweb/cache.pm - Regenerate (refresh) cache in background
Date: Tue,  9 Feb 2010 11:30:26 +0100
Message-ID: <1265711427-15193-10-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenNe-00041a-5p
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0BIKbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:31:10 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:57151 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0BIKa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:56 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3026581fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Yr7V+QhOdPIhY6pwlGpXFg5YD8rERFTHgHLJ/c1hdcs=;
        b=S/9PZmFJzl6FtNkoo9fkGuMVRtYWw14pIXklPYAaSYQdn2VLTOsm/LQS94o8fPSrcD
         16QVw6mqVAhLmLeFg9wSR69Bet4OAiRAVHHWahlEVTPqFnju0pXFPUXONeurvvscZMsx
         v8IlADHHqhoTpsIgz2In1OFxha1dMb5gIhSuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cgbax3fmYysuDHcTfYJWsB4S354I4bfVoDAZeWWERrEubXzcl7SzHYPdJCb09Chdp+
         a6rsapl1TDqrmCdcvdRD0Vt4oOZWd3V6U+o4pNhsm4PdNcq/SBkYzKXJe2C5lsKMl7mE
         ZgYgO+TUxMZj5mbHnTxwqgquZq4hW+1WWAhFo=
Received: by 10.223.5.212 with SMTP id 20mr5965104faw.19.1265711454964;
        Tue, 09 Feb 2010 02:30:54 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:54 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139390>

This commit removes assymetry in serving stale data (if it exists)
when regenerating cache in GitwebCache::SimpleFileCache.  The process
that acquired exclusive (writers) lock, and is therefore selected to
be the one that (re)generates data to fill the cache, can now generate
data in background, while serving stale data.

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
This is second part of what was single commit in previous version of
this series.

Differences from v1:
* Proper commit message
* You can now configure whether to use background cache (re)generation with
  'background_cache' parameter (field), which is turned on by default.
* Simplified code for forking writer.
* Close lockfile, releasing lock, before waitpid for child.
* Child (serving stale data) doesn't close lockfile explicitly, although
  that doesn't mean much as lockfile is closed automatically on leaving
  dynamic scope for indirect filehandle $lock_fh (on its desctruction).
  This change perhaps should be reverted.

Differences from relevant parts of J.H. patch:
* Fork (run generating process in background) only if there is stale data to
  serve (and if background cache is turned on).
* In J.H. patch forking was done uncoditionally, only generation or exit
  depended on $backgroundCache.
* Lock before forking (which I am not sure if is a good idea, but on the
  other hand tests passes, so...)
* Tests (currently only of API)
* In my opinion cleaner control flow.

 gitweb/cache.pm                 |   36 +++++++++++++++++++++++++++++-------
 gitweb/gitweb.perl              |    9 +++++++++
 t/t9503/test_cache_interface.pl |   14 ++++++++------
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index e3bbe57..c3a6c26 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -66,7 +66,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
-	my ($max_lifetime);
+	my ($max_lifetime, $background_cache);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -86,6 +86,7 @@ sub new {
 		$max_lifetime =
 			$p_options_hash_ref->{'max_lifetime'} ||
 			$p_options_hash_ref->{'max_cache_lifetime'};
+		$background_cache = $p_options_hash_ref->{'background_cache'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -96,6 +97,7 @@ sub new {
 	$expires_max = 1200 unless (defined($expires_max));
 	$increase_factor = 60 unless defined($increase_factor);
 	$max_lifetime = -1 unless defined($max_lifetime);
+	$background_cache = 1 unless defined($background_cache);
 
 	$self->set_root($root);
 	$self->set_depth($depth);
@@ -105,6 +107,7 @@ sub new {
 	$self->set_max_lifetime($max_lifetime);
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
+	$self->set_background_cache($background_cache);
 
 	return $self;
 }
@@ -114,7 +117,9 @@ sub new {
 
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
-foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load max_lifetime)) {
+foreach my $i (qw(depth root namespace
+                  expires_min expires_max increase_factor check_load
+                  max_lifetime background_cache)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -353,14 +358,31 @@ sub compute {
 
 	open my $lock_fh, '+>', $lockfile;
 	#	or die "Can't open lockfile '$lockfile': $!";
+
+	# try to retrieve stale data
+	$data = $self->fetch($p_key)
+		if $self->is_valid($p_key, $self->get_max_lifetime());
+
 	if (my $lock_state = flock($lock_fh, LOCK_EX | LOCK_NB)) {
 		# acquired writers lock
-		$data = $p_coderef->($self, $p_key);
-		$self->set($p_key, $data);
+		my $pid = fork() if ($data && $self->get_background_cache());
+		if (!defined $pid || $pid) {
+			# parent, or didn't fork
+			$data = $p_coderef->($self, $p_key);
+			$self->set($p_key, $data);
+
+			if ($pid) {
+				# releases lock before waiting and exiting
+				close $lock_fh;
+				# wait for child (which would print) and exit
+				waitpid $pid, 0;
+				exit 0;
+			}
+		} else {
+			# child is to serve stale data
+			return $data;
+		}
 	} else {
-		# try to retrieve stale data
-		$data = $self->fetch($p_key)
-			if $self->is_valid($p_key, $self->get_max_lifetime());
 		if (!defined $data) {
 			# get readers lock if there is no stale data to serve
 			flock($lock_fh, LOCK_SH);
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ea0ad25..8a97e50 100755
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
index 922c7cd..41c7bc3 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -299,32 +299,34 @@ sub run_compute_forked {
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
