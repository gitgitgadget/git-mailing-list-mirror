From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 11/17] gitweb/lib - Adaptive cache expiration time
Date: Mon, 14 Jun 2010 18:08:24 +0200
Message-ID: <1276531710-22945-13-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:09:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCDh-0001Wt-Sr
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab0FNQJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38593 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab0FNQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:58 -0400
Received: by fxm8 with SMTP id 8so2649905fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=clLDHpebDwe4i24o0p0fDizEpdiri26zFnFKXG2MR4g=;
        b=X4IJ53MUrcqzC8BNSAwyVZ7Bu8ZM5iBmbfjwFfF9yVBZEgfWMoORx6ygiXccC2K1ia
         uJVcH99XIdHfWstMRnIcGRnk91wnU8MaPrfuUUuK7GlB2WhWa+qCmOepAqMQHWElwutm
         0bmvbwh0USD7u6eR4AW1xtfYDlsrCwL7asysw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aN/k1F8qDlJ9QPfnkZ9O7DyUZeUQJR+YS3lq4wbOR7IM/LpVzOIcxrYnBOI4Q9fbQK
         LbvFaw3QxXSklA5ctV9TwUq4jD3iHzSsv2rakfECCES/NS+ZeHLUpCnWOnbo3X0lRATF
         S4ySLQ5PpjrX5DixafWOexW36H3kWe9d8l97A=
Received: by 10.223.100.141 with SMTP id y13mr5702075fan.15.1276531736408;
        Mon, 14 Jun 2010 09:08:56 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149106>

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
 gitweb/gitweb.perl                        |   27 +++++++++-
 gitweb/lib/GitwebCache/SimpleFileCache.pm |   80 +++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl           |   33 ++++++++++++
 3 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6772f6e..5ae5757 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -261,13 +261,36 @@ our %cache_options = (
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
 
 
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 7c90350..e3548dc 100644
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
@@ -113,6 +142,47 @@ foreach my $i (qw(depth root namespace expires_in)) {
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
+	#return &{$self->{'check_load'}}();
+	return $self->{'check_load'}->();
+}
+
 # ----------------------------------------------------------------------
 # utility functions and methods
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index b1e9036..37c1f2b 100755
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
1.7.0.1
