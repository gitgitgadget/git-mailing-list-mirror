From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 04/10] gitweb/cache.pm - Stat-based cache expiration
Date: Sat, 23 Jan 2010 01:27:27 +0100
Message-ID: <c59ba5d8c0a907340c7f2cff5b3a0c006530293d.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrj-0002dP-6j
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab0AWA1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756458Ab0AWA1u
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:50 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:38962 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab0AWA1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:47 -0500
Received: by fxm20 with SMTP id 20so1932519fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=BR7901KH7bRg+PM7TJEt82eHICoHJF3+10mJIeIg5vU=;
        b=SJMdrKsLz4GrrcB0WgsYd8xbVpBEuw0pMkp2Shq3JJiwPf7as/VBKDFzgEUQnl+vTq
         931lHg6ESY9aJOxR5JZoeYMeEFzKfIY5DOXc+ZVHVxk9KJfiSkXKwS+OqdHGIqESFhlz
         ETMNlWN0roFNCBdkZIWb//c2xmzXe78/K1tQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fUDm6yxH2eUolBO35GwdmDX+FeKVpFnz0gkpqWw868lDkYUpcnU72ZuJ9SDPNyDeaz
         2iLwR0S7/OSVpJt61dfTneKntEt/t0EQzlqdh2d1MsproiTPkqo1BVcyGvvOVYsXls3P
         prviND2hthva87uwbPsGg5i+G5X9HGQW8XTGA=
Received: by 10.102.211.9 with SMTP id j9mr1836211mug.130.1264206465777;
        Fri, 22 Jan 2010 16:27:45 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:44 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137797>

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

Add test checking that expire time of 0 (expire now) works correctly.


While at it show diagnostic if there were parse errors in gitweb/cache.pm
(TO BE MOVED TO PREVIOUS COMMIT).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The main difference from the way J.H. did it in his patch adding output
caching to gitweb is that here I uses imply stat, and not open/stat/close.

Now that cahcing engine supports cache expiration, we can add caching
support to gitweb.

 gitweb/cache.pm                 |   47 ++++++++++++++++++++++++++++++++++++++-
 t/t9503/test_cache_interface.pl |   11 ++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index ea544b0..12a7a78 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -50,6 +50,10 @@ our $DEFAULT_CACHE_ROOT = "cache";
 #    The number of subdirectories deep to cache object item.  This should be
 #    large enough that no cache directory has more than a few hundred objects.
 #    Defaults to 2 unless explicitly set.
+#  * 'default_expires_in' (Cache::Cache compatibile),
+#    'expires_in' (CHI compatibile) [seconds]
+#    The expiration time for objects place in the cache.
+#    Defaults to $EXPIRES_NEVER if not explicitly set.
 sub new {
 	my ($proto, $p_options_hash_ref) = @_;
 
@@ -57,19 +61,24 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns);
+	my ($root, $depth, $ns, $expires_in);
 	if (defined $p_options_hash_ref) {
 		$root  = $p_options_hash_ref->{'cache_root'};
 		$depth = $p_options_hash_ref->{'cache_depth'};
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
@@ -115,6 +124,20 @@ sub set_namespace {
 	$self->{'_Namespace'} = $namespace;
 }
 
+sub get_expires_in {
+	my ($self) = @_;
+
+	return $self->{'_Expires_In'};
+}
+
+
+sub set_expires_in {
+	my ($self, $expires_in) = @_;
+
+	$self->{'_Expires_In'} = $expires_in;
+}
+
+
 # ----------------------------------------------------------------------
 # (private) utility functions and methods
 
@@ -282,6 +305,27 @@ sub remove {
 	$self->delete_key($self->get_namespace(), $p_key);
 }
 
+# exists in cache and is not expired
+sub is_valid {
+	my ($self, $p_key) = @_;
+
+	# should there be namespace variant of this function?
+	my $path = $self->_path_to_key($self->get_namespace(), $p_key);
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
@@ -293,6 +337,7 @@ sub set {
 sub get {
 	my ($self, $p_key) = @_;
 
+	return undef unless $self->is_valid($p_key);
 	my $data = $self->restore($self->get_namespace(), $p_key)
 		or return undef;
 
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 0b6628b..3644ca8 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -16,7 +16,8 @@ unless (-f "$cache_pm") {
 # it is currently not a proper Perl module, so we use 'do FILE'
 #ok(eval { do "$cache_pm"; 1 or die $!; }, "loading gitweb/cache.pm");
 my $return = do "$cache_pm";
-ok(!$@,              "parse gitweb/cache.pm");
+ok(!$@,              "parse gitweb/cache.pm")
+	or diag("parse error:\n", $@);
 ok(defined $return,  "do    gitweb/cache.pm");
 ok($return,          "run   gitweb/cache.pm");
 # instead of: BEGIN { use_ok('GitwebCache::SimpleFileCache') }
@@ -74,4 +75,12 @@ is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
 is($cache->compute($key, \&get_value), $value, 'compute 3rd time (get)');
 cmp_ok($call_count, '==', 1, 'get_value() is called once');
 
+# Test cache expiration for 'expire now'
+#
+$cache->set_expires_in(0);
+is($cache->get_expires_in(), 0,        '"expires in" is set to now (0)');
+$cache->set($key, $value);
+ok(!defined($cache->get($key)),        'cache is expired');
+
+
 done_testing();
-- 
1.6.6.1
