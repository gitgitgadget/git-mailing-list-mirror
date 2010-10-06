From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 09/17] gitweb/lib - Adaptive cache expiration time
Date: Thu,  7 Oct 2010 00:01:54 +0200
Message-ID: <1286402526-13143-10-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5n-0002Gb-1D
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187Ab0JFWCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0JFWCu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:50 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=a2zGGyNpV5Pbmqmxp8KGzNbC1Iy5Qk1vu+l/nVkB+pI=;
        b=AKWxsruZ7CXAv+OB60fEp0wvkRYLNdWxeXOxMrLNtmu6vrzXmfjvNlKwLBkkIYTTZ/
         Ngurx0/JkF4FO9BgtQ8zpgd7+Jf5rh/ODlEAjqbfZhohWhEGrlsfl1F1LCmS1RlTLhsk
         ml4P945l20VQc0/K+oLtd9MOlFEgWlOJ+Fez0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rh2PV7CmvxGTXgCKwr+Tk9WJxpJImMTyObAfXo8XZgHzgFOm/tNUR6nyoVl+gPNL1m
         tNbFVw/u6NiS4pBW9L+LQp7wL+8xG9huvlqQ4fSdgkX0z1xXTA4rCKOaVbzSFG/cNSQq
         jCQ2zwu39KvItKdIktSBrYvyi+P66UIjmkCKE=
Received: by 10.204.122.206 with SMTP id m14mr10317925bkr.61.1286402567026;
        Wed, 06 Oct 2010 15:02:47 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158319>

Add to GitwebCache::SimpleFileCache support for adaptive lifetime
(cache expiration) control.  Cache lifetime can be increased or
decreased by any factor, e.g. load average, through the definition
of the 'check_load' callback.

Note that using ->set_expires_in, or unsetting 'check_load' via
->set_check_load(undef) turns off adaptive caching.

Make gitweb automatically adjust cache lifetime by load, using
get_loadavg() function.  Define and describe default parameters for
dynamic (adaptive) cache expiration time control.

There are some very basic tests of dynamic expiration time in t9503,
namely checking if dynamic expire time is within given upper and lower
bounds.

To be implemented (from original patch by J.H.):
* optional locking interface, where only one process can update cache
  (using flock)
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There are no significant difference from v4 (previous version)

Differences from relevant parts of J.H. patch:
* 'increase_factor' is configurable rather than hardcoded

* 'check_load' is passed via conctructor parameter; gitweb by default
  sets it to \&get_loadavg.  This means that the caching engine is not
  entangled with gitweb.

* options are stored in %cache_options, e.g. as 'expires_max' (compatible
  with Cache::Adaptive), and not as global variables with un-Perlish
  camelCase names like $maxCacheTime.

* API tests


 gitweb/gitweb.perl                        |   25 ++++++++-
 gitweb/lib/GitwebCache/SimpleFileCache.pm |   79 +++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl           |   33 ++++++++++++
 3 files changed, 130 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f81a4a2..e89f469 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -296,8 +296,29 @@ our %cache_options = (
 	# (00-ff).  Must be larger than 0.
 	'cache_depth' => 1,
 
-	# The (global) expiration time for objects placed in the cache, in seconds.
-	'expires_in' => 20,
+	# The (global) minimum expiration time for objects placed in the cache,
+	# in seconds.  If the dynamic adaptive cache exporation time is lower
+	# than this number, we set cache timeout to this minimum.
+	'expires_min' => 20,   # 20 seconds
+
+	# The (global) maximum expiration time for dynamic (adaptive) caching
+	# algorithm, in seconds.  If the adaptive cache lifetime exceeds this
+	# number, we set cache timeout to this maximum.
+	# (If 'expires_min' >= 'expires_max', there is no adaptive cache timeout,
+	# and 'expires_min' is used as expiration time for objects in cache.)
+	'expires_max' => 1200, # 20 minutes
+
+	# Cache lifetime will be increased by applying this factor to the result
+	# from 'check_load' callback (see below).
+	'expires_factor' => 60, # expire time in seconds for 1.0 (100% CPU) load
+
+	# User supplied callback for deciding the cache policy, usually system
+	# load.  Multiplied by 'expires_factor' gives adaptive expiration time,
+	# in seconds, subject to the limits imposed by 'expires_min' and
+	# 'expires_max' bounds.  Set to undef (or delete) to turn off dynamic
+	# lifetime control.
+	# (Compatibile with Cache::Adaptive.)
+	'check_load' => \&get_loadavg,
 );
 
 
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 6833699..72ab77a 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -61,6 +61,22 @@ our $DEFAULT_NAMESPACE = '';
 #    'expires_in' (CHI compatibile) [seconds]
 #    The expiration time for objects place in the cache.
 #    Defaults to -1 (never expire) if not explicitly set.
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
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -68,7 +84,8 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns, $expires_in);
+	my ($root, $depth, $ns);
+	my ($expires_min, $expires_max, $increase_factor, $check_load);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -77,19 +94,31 @@ sub new {
 			$p_options_hash_ref->{'cache_depth'} ||
 			$p_options_hash_ref->{'depth'};
 		$ns    = $p_options_hash_ref->{'namespace'};
-		$expires_in =
+		$expires_min =
+			$p_options_hash_ref->{'expires_min'} ||
 			$p_options_hash_ref->{'default_expires_in'} ||
 			$p_options_hash_ref->{'expires_in'};
+		$expires_max =
+			$p_options_hash_ref->{'expires_max'};
+		$increase_factor = $p_options_hash_ref->{'expires_factor'};
+		$check_load      = $p_options_hash_ref->{'check_load'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
 	$ns    = $DEFAULT_NAMESPACE   unless defined($ns);
-	$expires_in = -1 unless defined($expires_in); # <0 means never
+	$expires_min = -1 unless defined($expires_min);
+	$expires_max = $expires_min
+		if (!defined($expires_max) && exists $p_options_hash_ref->{'expires_in'});
+	$expires_max = -1 unless (defined($expires_max));
+	$increase_factor = 60 unless defined($increase_factor);
 
 	$self->set_root($root);
 	$self->set_depth($depth);
 	$self->set_namespace($ns);
-	$self->set_expires_in($expires_in);
+	$self->set_expires_min($expires_min);
+	$self->set_expires_max($expires_max);
+	$self->set_increase_factor($increase_factor);
+	$self->set_check_load($check_load);
 
 	return $self;
 }
@@ -100,7 +129,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace expires_in)) {
+foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -113,6 +142,46 @@ foreach my $i (qw(depth root namespace expires_in)) {
 	};
 }
 
+# ......................................................................
+# pseudo-accessors
+
+# returns adaptive lifetime of cache entry for given $key [seconds]
+sub get_expires_in {
+	my ($self) = @_;
+
+	# short-circuit
+	if (!defined $self->{'check_load'} ||
+	    $self->{'expires_max'} <= $self->{'expires_min'}) {
+		return $self->{'expires_min'};
+	}
+
+	my $expires_in =
+		#$self->{'expires_min'} +
+		$self->{'increase_factor'} * $self->check_load();
+
+	if ($expires_in < $self->{'expires_min'}) {
+		return $self->{'expires_min'};
+	} elsif ($expires_in > $self->{'expires_max'}) {
+		return $self->{'expires_max'};
+	}
+
+	return $expires_in;
+}
+
+# sets expiration time to $duration, turns off adaptive cache lifetime
+sub set_expires_in {
+	my ($self, $duration) = @_;
+
+	$self->{'expires_min'} = $self->{'expires_max'} = $duration;
+}
+
+# runs 'check_load' subroutine, for adaptive cache lifetime.
+# Note: check in caller that 'check_load' exists.
+sub check_load {
+	my $self = shift;
+	return $self->{'check_load'}->();
+}
+
 # ----------------------------------------------------------------------
 # utility functions and methods
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index adca88d..0ac0ed7 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -97,4 +97,37 @@ subtest 'cache expiration' => sub {
 	done_testing();
 };
 
+# Test assertions for adaptive cache expiration
+#
+my $load = 0.0;
+sub load { return $load; }
+my $expires_min = 10;
+my $expires_max = 30;
+$cache->set_expires_in(-1);
+$cache->set_expires_min($expires_min);
+$cache->set_expires_max($expires_max);
+$cache->set_check_load(\&load);
+subtest 'adaptive cache expiration' => sub {
+	cmp_ok($cache->get_expires_min(), '==', $expires_min,
+	       '"expires min" set correctly');
+	cmp_ok($cache->get_expires_max(), '==', $expires_max,
+	       '"expires max" set correctly');
+
+	$load = 0.0;
+	cmp_ok($cache->get_expires_in(), '>=', $expires_min,
+	       '"expires in" bound from down for load=0');
+	cmp_ok($cache->get_expires_in(), '<=', $expires_max,
+	       '"expires in" bound from up   for load=0');
+	
+	$load = 1_000;
+	cmp_ok($cache->get_expires_in(), '>=', $expires_min,
+	       '"expires in" bound from down for heavy load');
+	cmp_ok($cache->get_expires_in(), '<=', $expires_max,
+	       '"expires in" bound from up   for heavy load');
+
+	done_testing();
+};
+
+$cache->set_expires_in(-1);
+
 done_testing();
-- 
1.7.3
