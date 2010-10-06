From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 04/17] gitweb/lib - Stat-based cache expiration
Date: Thu,  7 Oct 2010 00:01:49 +0200
Message-ID: <1286402526-13143-5-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5j-0002Gb-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189Ab0JFWCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008Ab0JFWCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:36 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49448bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=URkKTZlF+3AhM9GUk9PWdKvk5hzJyILd23SuytkCC9E=;
        b=r1S/p00Bur3bWW9DE8T60Mn8WQm5/VkyytDNz0jRPwh9PiJ/mf9mbGcgE9aqrUR8OO
         iTUh63F5GUPibdA7zlVkEUzgi9mf8mHOhfmwbnTuGjedCKgyLIxDGO5XDHqaUp+bQvgW
         TY4yqlDs/rOrun1cTLrjjmpH4o/IuB4b+9dw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T3R2e9TX0PPyqTcOxoqqGMgUzt9bByZZU6qYAp3ufYqIfKtPB1jkz3HM5nE/UmD3qd
         hMzamQGznaVBK1rH3WjzoTruB7xJ5k4+1Uwgue4JkFAJ9kR/CmDNLB2bW7mQlW9OGy73
         bAdZnm8WKo6xZuScGYkmsgiPy0I2NyAePzp8A=
Received: by 10.204.131.132 with SMTP id x4mr10360113bks.50.1286402555032;
        Wed, 06 Oct 2010 15:02:35 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158314>

Add stat-based cache expiration to file-based GitwebCache::SimpleFileCache.
Contrary to the way other caching interfaces such as Cache::Cache and CHI
do it, the time cache element expires in is _global_ value associated with
cache instance, and is not local property of cache entry.  (Currently cache
entry does not store any metadata associated with entry... which means that
there is no need for serialization / marshalling / freezing and thawing.)
Default expire time is -1, which means never expire.

To check if cache entry is expired, GitwebCache::SimpleFileCache compares
difference between mtime (last modify time) of a cache file and current time
with (global) time to expire.  It is done using CHI-compatibile is_valid()
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

No significant differences from v4 version of this patch.

Differences from relevant parts of J.H. patch:
* It simply uses stat on last accessed file (checked for existence),
  instead of opening file for reading (without error detection!), running
  stat on it, and then closing it.

* One can use expire time of -1 (or to be more exact less than 0) to set
  expire time to never (cache is considered fresh forever, does not expire).

* There are some tests in t9503 of cache expiration (one of those assume
  that expire time of one day would be not expired in get after set).

* It reuses stat structure (stat(_)), and calculates current time only
  once.

 gitweb/lib/GitwebCache/SimpleFileCache.pm |   39 +++++++++++++++++++++++++++-
 t/t9503/test_cache_interface.pl           |   19 ++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index a54f78f..74d7246 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -57,6 +57,10 @@ our $DEFAULT_NAMESPACE = '';
 #    The number of subdirectories deep to cache object item.  This should be
 #    large enough that no cache directory has more than a few hundred objects.
 #    Defaults to $DEFAULT_CACHE_DEPTH unless explicitly set.
+#  * 'default_expires_in' (Cache::Cache compatibile),
+#    'expires_in' (CHI compatibile) [seconds]
+#    The expiration time for objects place in the cache.
+#    Defaults to -1 (never expire) if not explicitly set.
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -64,7 +68,7 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns);
+	my ($root, $depth, $ns, $expires_in);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -73,14 +77,19 @@ sub new {
 			$p_options_hash_ref->{'cache_depth'} ||
 			$p_options_hash_ref->{'depth'};
 		$ns    = $p_options_hash_ref->{'namespace'};
+		$expires_in =
+			$p_options_hash_ref->{'default_expires_in'} ||
+			$p_options_hash_ref->{'expires_in'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
 	$ns    = $DEFAULT_NAMESPACE   unless defined($ns);
+	$expires_in = -1 unless defined($expires_in); # <0 means never
 
 	$self->set_root($root);
 	$self->set_depth($depth);
 	$self->set_namespace($ns);
+	$self->set_expires_in($expires_in);
 
 	return $self;
 }
@@ -91,7 +100,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace)) {
+foreach my $i (qw(depth root namespace expires_in)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -272,6 +281,31 @@ sub remove {
 		or die "Couldn't remove file '$file': $!";
 }
 
+# $cache->is_valid($key)
+#
+# Returns a boolean indicating whether $key exists in the cache
+# and has not expired (global per-cache 'expires_in').
+sub is_valid {
+	my ($self, $key) = @_;
+
+	my $path = $self->path_to_key($key);
+
+	# does file exists in cache?
+	return 0 unless -f $path;
+	# get its modification time
+	my $mtime = (stat(_))[9] # _ to reuse stat structure used in -f test
+		or die "Couldn't stat file '$path': $!";
+
+	# expire time can be set to never
+	my $expires_in = $self->get_expires_in();
+	return 1 unless (defined $expires_in && $expires_in >= 0);
+
+	# is file expired?
+	my $now = time();
+
+	return (($now - $mtime) < $expires_in);
+}
+
 # Getting and setting
 
 # $cache->set($key, $data);
@@ -295,6 +329,7 @@ sub set {
 sub get {
 	my ($self, $key) = @_;
 
+	return undef unless $self->is_valid($key);
 	my $data = $self->fetch($key)
 		or return undef;
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 6a7b715..adca88d 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -78,4 +78,23 @@ subtest 'CHI interface' => sub {
 	done_testing();
 };
 
+# Test cache expiration
+#
+subtest 'cache expiration' => sub {
+	$cache->set_expires_in(60*60*24); # set expire time to 1 day
+	cmp_ok($cache->get_expires_in(), '>', 0, '"expires in" is greater than 0');
+	is($cache->get($key), $value,            'get returns cached value (not expired in 1d)');
+
+	$cache->set_expires_in(-1); # set expire time to never expire
+	is($cache->get_expires_in(), -1,         '"expires in" is set to never (-1)');
+	is($cache->get($key), $value,            'get returns cached value (not expired)');
+
+	$cache->set_expires_in(0);
+	is($cache->get_expires_in(),  0,         '"expires in" is set to now (0)');
+	$cache->set($key, $value);
+	ok(!defined($cache->get($key)),          'cache is expired');
+
+	done_testing();
+};
+
 done_testing();
-- 
1.7.3
