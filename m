From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 03/10] gitweb/cache.pm - Stat-based cache expiration
Date: Tue,  9 Feb 2010 11:30:20 +0100
Message-ID: <1265711427-15193-4-git-send-email-jnareb@gmail.com>
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
	id 1NenN8-0003mJ-DP
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab0BIKaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:30:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:14295 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0BIKap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:45 -0500
Received: by fg-out-1718.google.com with SMTP id 19so19774fgg.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Z3KqUurmd38vs2gsq3JUgeUiSnXxo84Miqv6TCpELS4=;
        b=ZBUTuwGRi/5nuy4/kNyeICNmiOordPDLqkE8oB1p7qlr2FJH/KFPVWC/rgoD7cJ24Y
         UinSNFOFnO16RF2vMdgMWV9mMQNysPz/eFmXjd3e3igaUmQAIqQstFa7x84qboYcFg9C
         Q8uQjvvChQ6igLZaO9frEAamQiaddbilSUQOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A36L4wArAdpyxjPItU20Fq1WV/eDfJaTXr0lfaSEjoTAA7C3DGXKXVHIcC1DBCJ5M8
         blr5hybQQXd/h/MbH0/MMxyqJjInXO5bLdMHSQpkKb55IqI5t46JISd3t6xwBDTm5/o2
         9Yv9+Icfy/OQDPpU17ZUcfm5mWGPJb/f5/PUM=
Received: by 10.87.61.5 with SMTP id o5mr1832140fgk.79.1265711443639;
        Tue, 09 Feb 2010 02:30:43 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:43 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139383>

Add stat-based cache expiration to file-based GitwebCache::SimpleFileCache.
Contrary to the way other caching interfaces such as Cache::Cache and CHI
do it, the time cache element expires in is _global_ value associated with
cache instance, and is not local property of cache entry.  (Currently cache
entry does not store any metadata associated with entry... which means that
there is no need for serialization / marshaling / freezing and thawing.)
Default expire time is -1, which means never expire.

To check if cache entry is expired, GitwebCache::SimpleFileCache compares
difference between mtime (last modify time) of a cache file and current time
with (global) time to expire.  It is done using CHI-compatible is_valid()
method.

Add some tests checking that expiring works correctly (on the level of API).

To be implemented (from original patch by J.H.):
* actually using this cache in gitweb, except error pages
* adaptive cache expiration, based on average system load
* optional locking interface, where only one process can update cache
  (using flock)
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Now that caching engine supports cache expiration, we can add caching
support to gitweb.

Differences from v1:
* Showing diagnostic if there were parse errors in gitweb/cache.pm
  was moved to previous commit
* ->get_expires_in() and ->set_expires_in($duration) accessors are generated
  rather than written by hand (reducing repetition of very similar code).
* Test that value is not expired with expiration time of 1 day, and not 
  forever ('expires_in' == -1).

Differences from relevant parts of J.H. patch:
* It simply uses stat on last accessed file (checked for existence),
  instead of opening file for reading (without error detection!), running
  stat on it, and then closing it.
* One can use expire time of -1 (or to be more exact less than 0) to set
  expire time to never (cache is considered fresh forever).
* There are some tests in t9503 of cache expiration (one of those assume
  that expire time of one day would be not expired in get after set).

 gitweb/cache.pm                 |   34 ++++++++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl |   10 ++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index aebab01..b59509f 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -52,6 +52,10 @@ our $DEFAULT_CACHE_ROOT = "cache";
 #    The number of subdirectories deep to cache object item.  This should be
 #    large enough that no cache directory has more than a few hundred objects.
 #    Defaults to 1 unless explicitly set.
+#  * 'default_expires_in' (Cache::Cache compatibile),
+#    'expires_in' (CHI compatibile) [seconds]
+#    The expiration time for objects place in the cache.
+#    Defaults to -1 (never expire) if not explicitly set.
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -59,7 +63,7 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns);
+	my ($root, $depth, $ns, $expires_in);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -68,14 +72,19 @@ sub new {
 			$p_options_hash_ref->{'cache_depth'} ||
 			$p_options_hash_ref->{'depth'};
 		$ns    = $p_options_hash_ref->{'namespace'};
+		$expires_in =
+			$p_options_hash_ref->{'default_expires_in'} ||
+			$p_options_hash_ref->{'expires_in'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
 	$ns    = '' unless defined($ns);
+	$expires_in = -1 unless defined($expires_in); # <0 means never
 
 	$self->set_root($root);
 	$self->set_depth($depth);
 	$self->set_namespace($ns);
+	$self->set_expires_in($expires_in);
 
 	return $self;
 }
@@ -85,7 +94,7 @@ sub new {
 
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
-foreach my $i (qw(depth root namespace)) {
+foreach my $i (qw(depth root namespace expires_in)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -232,6 +241,26 @@ sub remove {
 	unlink($file);
 }
 
+# exists in cache and is not expired
+sub is_valid {
+	my ($self, $key) = @_;
+
+	my $path = $self->path_to_key($key);
+
+	# does file exists in cache?
+	return 0 unless -f $path;
+
+	# expire time can be set to never
+	my $expires_in = $self->get_expires_in();
+	return 1 unless (defined $expires_in && $expires_in >= 0);
+
+	# is file expired?
+	my $mtime = (stat(_))[9];
+	my $now = time();
+
+	return (($now - $mtime) < $expires_in);
+}
+
 # Getting and setting
 
 sub set {
@@ -245,6 +274,7 @@ sub set {
 sub get {
 	my ($self, $key) = @_;
 
+	return undef unless $self->is_valid($key);
 	my $data = $self->fetch($key)
 		or return undef;
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 9714f72..8700b71 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -79,6 +79,16 @@ is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
 is($cache->compute($key, \&get_value), $value, 'compute 3rd time (get)');
 cmp_ok($call_count, '==', 1, 'get_value() is called once from compute');
 
+# Test cache expiration for 'expire now'
+#
+$cache->set_expires_in(60*60*24); # set expire time to 1 day
+cmp_ok($cache->get_expires_in(), '>', 0, '"expires in" is greater than 0');
+is($cache->get($key), $value,            'get returns cached value (not expired)');
+$cache->set_expires_in(0);
+is($cache->get_expires_in(), 0,          '"expires in" is set to now (0)');
+$cache->set($key, $value);
+ok(!defined($cache->get($key)),          'cache is expired');
+
 done_testing();
 
 print Dumper($cache);
-- 
1.6.6.1
