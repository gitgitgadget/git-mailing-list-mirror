From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 05/10] gitweb/cache.pm - Adaptive cache expiration time
Date: Tue,  9 Feb 2010 11:30:22 +0100
Message-ID: <1265711427-15193-6-git-send-email-jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:31:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenN9-0003mJ-Qi
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab0BIKa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:30:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:35227 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab0BIKau (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:50 -0500
Received: by fg-out-1718.google.com with SMTP id 19so19836fgg.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BOlLJju6lb75+ZTmU0Z02D1JTUF9x81xNS36ptSFNKU=;
        b=TmPDk82Ml5NeKJbURsqta2AGxtjMgjkxzXQyQnjK6Q16Oo3qwjqFCzJa6aTzQItosJ
         8B+7IctsAI1q4mA7SJuMzrXibv6maiVn0ZIfwPvCOhKaXhO2+xpoO/xeg7nzFAS3cUtZ
         JXS9cCCoFCD0F02epfn9afNLlCEf2dWedZt7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jQhh6NQzmy0fX/dNUhqrAAUwZ1Nps3ZgLW8FWbGA8SMnArPJ32KALJoy4YRjJXwjTy
         3tNqgW+NY6UV4trtI8m7NjZrMv2M7JBPTo3SjO7MMqcY3h1owwCv/D9xvEIdTAJO++xs
         0Ue4vkCYZT9zAVuWE8xbUXWf73oAYVLKAoj+M=
Received: by 10.87.69.33 with SMTP id w33mr11080076fgk.29.1265711447778;
        Tue, 09 Feb 2010 02:30:47 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:47 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139387>

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
Differences from v1:
* Proper commit message
* Adaptive cache expiration can be configured in gitweb config file by
  changing 'expires_min', 'expires_max', 'increase_factor' in
  %cache_options.  Those parameters are described in detail.
* You can turn adaptive cache expiration by setting 'check_load' to undef.
* By default adaptive cache expiration is turned off; there are extra check
  when to run 'check_load' subroutine.
* Instead of removing ->set_expires_in(), it just sets 'expires_min' and
  'expires_max' to the same value, which turns off adaptive expiration.
* Test assertions for adaptive cache expiration:
    'expires_min' <= $cache->get_expires_in() <= 'expires_max'

Differences from relevant parts of J.H. patch:
* 'increase_factor' is configurable rather than hardcoded
* 'check_load' is passed via conctructor parameter; gitweb by default sets
  it to \&get_loadavg.  This means that cache.pm is not entangled with
  gitweb, at least for this feature.
* options are stored in %cache_options, e.g. as 'expires_max' (compatible
  with Cache::Adaptive), and not as global variables with un-Perlish
  camelCase names like $maxCacheTime.
* API tests

Possible improvements:
* Turn off adaptive cache lifetime by unsetting check_load, and not only by
  using ->set_expires_in()

 gitweb/cache.pm                 |   55 +++++++++++++++++++++++++++++++++++---
 gitweb/gitweb.perl              |   27 +++++++++++++++++-
 t/t9503/test_cache_interface.pl |   22 +++++++++++++++
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 64c333b..d81f6e8 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -63,7 +63,8 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns, $expires_in);
+	my ($root, $depth, $ns);
+	my ($expires_min, $expires_max, $increase_factor, $check_load);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -72,19 +73,31 @@ sub new {
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
 	$ns    = '' unless defined($ns);
-	$expires_in = -1 unless defined($expires_in); # <0 means never
+	$expires_min =   20 unless defined($expires_min);
+	$expires_max = $expires_min
+		if (!defined($expires_max) && exists $p_options_hash_ref->{'expires_in'});
+	$expires_max = 1200 unless (defined($expires_max));
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
@@ -94,7 +107,7 @@ sub new {
 
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
-foreach my $i (qw(depth root namespace expires_in)) {
+foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -107,6 +120,38 @@ foreach my $i (qw(depth root namespace expires_in)) {
 	};
 }
 
+# ......................................................................
+# pseudo-accessors
+
+sub get_expires_in {
+	my ($self) = @_;
+
+	# short-circuit
+	if (!defined $self->get_check_load() ||
+	    $self->get_expires_max() <= $self->get_expires_min()) {
+		return $self->get_expires_min();
+	}
+
+	my $expires_in =
+		#$self->get_expires_min() +
+		$self->get_increase_factor() * $self->get_check_load()->();
+
+	if ($expires_in < $self->get_expires_min()) {
+		return $self->get_expires_min();
+	} elsif ($expires_in > $self->get_expires_max()) {
+		return $self->get_expires_max();
+	}
+
+	return $expires_in;
+}
+
+sub set_expires_in {
+	my ($self, $duration) = @_;
+
+	$self->set_expires_min($duration);
+	$self->set_expires_max($duration);
+}
+
 # ----------------------------------------------------------------------
 # utility functions and methods
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f02ead9..aabed72 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -255,13 +255,36 @@ our %cache_options = (
 	# * File::Spec->catdir(File::Spec->tmpdir(), 'gitweb-cache'),
 	# * '/var/cache/gitweb' (FHS compliant, requires being set up),
 	'cache_root' => 'cache',
+
 	# The number of subdirectories deep to cache object item.  This should be
 	# large enough that no cache directory has more than a few hundred
 	# objects.  Each non-leaf directory contains up to 256 subdirectories
 	# (00-ff).  Must be larger than 0.
 	'cache_depth' => 1,
-	# The (global) expiration time for objects placed in the cache, in seconds.
-	'expires_in' => 20,
+
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
 
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 42c49e9..3945adc 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -118,6 +118,28 @@ $cache->set($key, $value);
 ok(!defined($cache->get($key)),          'cache is expired');
 $cache->set_expires_in(-1);
 
+# Test assertions for adaptive cache expiration
+#
+my $load = 0.0;
+sub load { return $load; }
+my $expires_min = 10;
+my $expires_max = 30;
+$cache->set_expires_min($expires_min);
+$cache->set_expires_max($expires_max);
+$cache->set_check_load(\&load);
+cmp_ok($cache->get_expires_min(), '==', $expires_min, '"expires min" set correctly');
+cmp_ok($cache->get_expires_max(), '==', $expires_max, '"expires max" set correctly');
+cmp_ok($cache->get_expires_in(), '>=', $expires_min,
+       '"expires in" bound from down for load=0');
+cmp_ok($cache->get_expires_in(), '<=', $expires_max,
+       '"expires in" bound from up   for load=0');
+$load = 1_000;
+cmp_ok($cache->get_expires_in(), '>=', $expires_min,
+       '"expires in" bound from down for heavy load');
+cmp_ok($cache->get_expires_in(), '<=', $expires_max,
+       '"expires in" bound from up   for heavy load');
+$cache->set_expires_in(-1);
+
 # ......................................................................
 
 # Prepare for testing cache_fetch from $cache_pm
-- 
1.6.6.1
