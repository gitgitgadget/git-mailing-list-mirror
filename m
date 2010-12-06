From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 04/24] gitweb/lib - Stat-based cache expiration
Date: Tue,  7 Dec 2010 00:10:49 +0100
Message-ID: <1291677069-6559-5-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkJK-0002Ke-Af
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0LFXR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:17:29 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:37279 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0LFXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:17:28 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2010 18:17:05 EST
Received: by mail-ey0-f171.google.com with SMTP id 5so8018462eyg.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hdi86TlPMxxO6kjGerwQhrBCSAu5SkHRZc6Kk6fFea4=;
        b=qy48HexesDbdgfODfSTsbEUFd8w1nH4M7WEdilK8cvwy7MGf0QkmU578CbNL8NYCyD
         Qwov6d+nOsGPlaa4U1VG72Oty9df3IU/HG3uR/HYPGET8s3Y6W3H0w3VcrttXUfGoPQb
         a5L8oWdfmFWHDkvZ0YDs9qYHwXANRo0z/snMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GKpgL1Hglu30DrEVPIliUanftBysTiU0Sr/TzhwCWaPmGWK3bhfHAxp25MmoW0n9Uv
         yvvm1BBw64k9NGhVR71XEpYFbaSSo+PywByCZhmNCVQqgwRm2J0CUVLNrfIeYaNq6Tx+
         yTC9r6tEch9/1mmOZZoyxImhOqMQtfzYSz40Q=
Received: by 10.213.17.199 with SMTP id t7mr6618877eba.22.1291677113011;
        Mon, 06 Dec 2010 15:11:53 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:51 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163050>

Add stat-based cache expiration to file-based GitwebCache::SimpleFileCache.
Contrary to the way other caching interfaces such as Cache::Cache and CHI
do it, the time when cache element expires in is _global_ value associated
with cache instance, and is not local property of cache entry.  (Currently
cache entry does not store any metadata associated with entry... which
means that there is no need for serialization / marshalling / freezing and
thawing.)  Default expire time is -1, which means never expire.

To check if cache entry is expired, GitwebCache::SimpleFileCache compares
difference between mtime (last modify time) of a cache file and current time
with (global) time to expire.  It is done using CHI-compatible is_valid()
method.

Includes some tests checking that expiring works correctly (on the level of
API) in t9503.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Compared to "Gitweb caching v7" series, checking if cache entry is
expired (based on mtime of cache file) is simpler: we reuse stat
structure from test if file even exists (via stat(_)).

 gitweb/lib/GitwebCache/SimpleFileCache.pm |   40 +++++++++++++++++++++++++++-
 t/t9503/test_cache_interface.pl           |   19 +++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 2f26a6c..790383d 100644
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
 	my $class = shift;
 	my %opts = ref $_[0] ? %{ $_[0] } : @_;
@@ -64,7 +68,7 @@ sub new {
 	my $self = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns);
+	my ($root, $depth, $ns, $expires_in);
 	if (%opts) {
 		$root =
 			$opts{'cache_root'} ||
@@ -73,14 +77,19 @@ sub new {
 			$opts{'cache_depth'} ||
 			$opts{'depth'};
 		$ns = $opts{'namespace'};
+		$expires_in =
+			$opts{'default_expires_in'} ||
+			$opts{'expires_in'};
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
@@ -92,7 +101,7 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(depth root namespace)) {
+foreach my $i (qw(depth root namespace expires_in)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -287,6 +296,31 @@ sub remove {
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
@@ -310,6 +344,8 @@ sub set {
 sub get {
 	my ($self, $key) = @_;
 
+	return unless $self->is_valid($key);
+
 	return $self->fetch($key);;
 }
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 1a3f374..1517fb6 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -82,4 +82,23 @@ subtest 'CHI interface' => sub {
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
