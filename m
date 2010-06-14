From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 05/17] gitweb/lib - Stat-based cache expiration
Date: Mon, 14 Jun 2010 18:08:17 +0200
Message-ID: <1276531710-22945-6-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:09:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCDg-0001Wt-S8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab0FNQI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab0FNQIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:45 -0400
Received: by fxm8 with SMTP id 8so2649718fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G3lJiIN6kNAU/GubdApBkrftilgvfYdPH6dE/fl4Abg=;
        b=FqZRBla3GRApKHKZMEWEos2cGV2FN4mb/NmjAac/4Sx2bgKusPRQPxPLCeGa91XWEk
         7Kxf28lRNC4ZT+7YmSnjonrA4nMyHbw09TqwTA4gynjCEfgTOLiDtitdb95NGIq4aYSI
         d/WIhQ95i620Gr1n0W9xA3/LA8oKN8euvUzd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E5mUhG+PkYpy+FpgBCXkzI07lPXtZe7x+hVHOPpR3SXPPSUWTP5JYmYT7W74Yd9nF8
         KjKSCpVLEkTwilXrmFMQCXf5a+3dzq9nC0xGTGixcDAPI3dTYpemq9t5CKfDST55qK5W
         0/O4ENBDXliSFchZGys/N1kbn+4M4xx6aZmrw=
Received: by 10.223.40.136 with SMTP id k8mr5699949fae.24.1276531723957;
        Mon, 14 Jun 2010 09:08:43 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149104>

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
 gitweb/lib/GitwebCache/SimpleFileCache.pm |   42 ++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl           |   19 +++++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index b51a124..91b3373 100644
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
@@ -257,6 +266,31 @@ sub remove {
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
@@ -280,6 +314,7 @@ sub set {
 sub get {
 	my ($self, $key) = @_;
 
+	return undef unless $self->is_valid($key);
 	my $data = $self->fetch($key)
 		or return undef;
 
@@ -304,7 +339,8 @@ sub compute {
 	return $data;
 }
 
-# end of package GitwebCache::SimpleFileCache;
 1;
+__END__
+# end of package GitwebCache::SimpleFileCache;
 
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 9242129..b1e9036 100755
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
1.7.0.1
