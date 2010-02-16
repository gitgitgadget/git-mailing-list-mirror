From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 05/10] gitweb/cache.pm - Adaptive cache expiration time
Date: Tue, 16 Feb 2010 20:36:40 +0100
Message-ID: <1266349005-15393-6-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:37:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTF8-0002i3-My
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab0BPThV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:21 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59496 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933214Ab0BPThK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:10 -0500
Received: by bwz5 with SMTP id 5so2281274bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hEiScmSy83BKBTz6iQc8qkFl5mbSyEzFRqThvcB86v0=;
        b=od8NkNb0+KOJeZ9bOrVOgSJ1JsJu/Bco6tSqui0al7sAbPE62GAXMmOGg3b4VuNxCA
         c00Adzyuc6RC5fRwkrSBeAC83Pfdi8nmfyWylI76B2jjsja8SSUG6I3aYwlqQ7XmMqD/
         YhcWwJKChfU0B4JtEnAqiWjPYzcXNx6qkJkJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ido5vNHL7Y7L/nhBbeqL9+xdwhin8oNKwtSOo2BZPI7+SxiLgrm0DAR4v/3uTG8kQw
         BssKuPZbTQBh0UZkM95pJPao/+YICnrnrY+Pwh7XrH8q6zzSPlnE1C2fw3wbX2hd4PPh
         7WanxzI36sh1zZubbFIM7OHorubTJnae+I/uk=
Received: by 10.204.34.136 with SMTP id l8mr2629188bkd.163.1266349026202;
        Tue, 16 Feb 2010 11:37:06 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.37.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:37:05 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140143>

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
Differences from v2:
* Comments about new parameters for the constructor
* More comments
* Access fields directly ($self->{'check_load'}, instead of using accessors
  ($self->get_check_load()).
* Add ->check_load() method (note: does not check if 'check_load' exists).

Differences from relevant parts of J.H. patch:
* 'increase_factor' is configurable rather than hardcoded
* 'check_load' is passed via conctructor parameter; gitweb by default sets
  it to \&get_loadavg.  This means that cache.pm is not entangled with
  gitweb.
* options are stored in %cache_options, e.g. as 'expires_max' (compatible
  with Cache::Adaptive), and not as global variables with un-Perlish
  camelCase names like $maxCacheTime.
* API tests

Possible improvements:
* Turn off adaptive cache lifetime in t9503 test by unsetting
  check_load, and not only by using ->set_expires_in()

 gitweb/cache.pm                 |   80 ++++++++++++++++++++++++++++++++++++--
 gitweb/gitweb.perl              |   27 ++++++++++++-
 t/t9503/test_cache_interface.pl |   22 +++++++++++
 3 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 151e029..dcddd28 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -57,6 +57,22 @@ our $DEFAULT_CACHE_ROOT = "cache";
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
 
@@ -64,7 +80,8 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns, $expires_in);
+	my ($root, $depth, $ns);
+	my ($expires_min, $expires_max, $increase_factor, $check_load);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -73,19 +90,31 @@ sub new {
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
@@ -96,7 +125,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace expires_in)) {
+foreach my $i (qw(depth root namespace expires_min expires_max increase_factor check_load)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -109,6 +138,47 @@ foreach my $i (qw(depth root namespace expires_in)) {
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
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7073e1b..2b429d2 100755
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
index 7c7f00c..d28f4df 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -100,6 +100,28 @@ $cache->set($key, $value);
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
