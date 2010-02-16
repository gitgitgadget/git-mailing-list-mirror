From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 03/10] gitweb/cache.pm - Stat-based cache expiration
Date: Tue, 16 Feb 2010 20:36:38 +0100
Message-ID: <1266349005-15393-4-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTEf-0002Nw-5O
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227Ab0BPThT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:19 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:38796 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213Ab0BPThI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:37:08 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so2281058bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7nwC038VWn26O0hihoABY2W+mHWHblT3rnuYr1vcxzk=;
        b=rIRaEuWdAbV6D6HCfP5bjxn/wBj9ZU83HdQIN1jDity9k1k6bThpoG072eDUSjm/Ht
         SBBZmq1MCuUAjdoWlAepddug0PndAH2IwLzcRYhHKApCeWXZwhoMaxtwvvtlAr2w/pQi
         ucKV2DaUC9vTtm09E5JifOyCogjzA24/K02Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QOrCARYP32tEY3G6wfI9i6wZvaZkNFkwrbgHiAPPYctfp2R6zdETPB9O2luHFtdeBn
         wvQ3Cq7VBGwpkq9C0T2mLaiR+bx57ARNPdXtsbIyWgq/+bw+Ne62/eJO1ee899W2gcgR
         4t5Pf35R7ph1vhucd/xdcGVIEBCIMNsXqd7JU=
Received: by 10.204.32.206 with SMTP id e14mr4512591bkd.45.1266349020866;
        Tue, 16 Feb 2010 11:37:00 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.36.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:36:59 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140141>

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

Differences from v2:
* More comments explaining code
* Fixed bug in ->is_valid(): stat(_) should be used after '-f $path',
  and not after ->get_expires_in()... which runs -f '/proc/loadavg'
  (otherwise stat(_) is about '/proc/loadavg' and not $path).

Differences from relevant parts of J.H. patch:
* It simply uses stat on last accessed file (checked for existence),
  instead of opening file for reading (without error detection!), running
  stat on it, and then closing it.
* One can use expire time of -1 (or to be more exact less than 0) to set
  expire time to never (cache is considered fresh forever, does not expire).
* There are some tests in t9503 of cache expiration (one of those assume
  that expire time of one day would be not expired in get after set).

 gitweb/cache.pm                 |   39 +++++++++++++++++++++++++++++++++++++--
 t/t9503/test_cache_interface.pl |   10 ++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 231b292..7f1bd5f 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -53,6 +53,10 @@ our $DEFAULT_CACHE_ROOT = "cache";
 #    The number of subdirectories deep to cache object item.  This should be
 #    large enough that no cache directory has more than a few hundred objects.
 #    Defaults to 1 unless explicitly set.
+#  * 'default_expires_in' (Cache::Cache compatibile),
+#    'expires_in' (CHI compatibile) [seconds]
+#    The expiration time for objects place in the cache.
+#    Defaults to -1 (never expire) if not explicitly set.
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -60,7 +64,7 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns);
+	my ($root, $depth, $ns, $expires_in);
 	if (defined $p_options_hash_ref) {
 		$root  =
 			$p_options_hash_ref->{'cache_root'} ||
@@ -69,14 +73,19 @@ sub new {
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
@@ -87,7 +96,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace)) {
+foreach my $i (qw(depth root namespace expires_in)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -253,6 +262,31 @@ sub remove {
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
+	# reuse stat structure
+	my $mtime = (stat(_))[9]
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
@@ -276,6 +310,7 @@ sub set {
 sub get {
 	my ($self, $key) = @_;
 
+	return undef unless $self->is_valid($key);
 	my $data = $self->fetch($key)
 		or return undef;
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 39802b7..ec92207 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -80,6 +80,16 @@ is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
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
