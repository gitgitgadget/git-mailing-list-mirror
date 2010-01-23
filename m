From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 03/10] gitweb/cache.pm - Very simple file based caching
Date: Sat, 23 Jan 2010 01:27:26 +0100
Message-ID: <b2f4605fcab798843fc6096783873f6808a68af1.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTtf-000356-Es
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab0AWA2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756437Ab0AWA2r
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:28:47 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:54861 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452Ab0AWA1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:45 -0500
Received: by fxm20 with SMTP id 20so1932505fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=/to3THTNdsHQklUGYSLZRgicrVeHcWWKoq31Iaov67U=;
        b=oTUCiu/MNFplXFSi5p25GUANXQSUMMl1EX+aNEpOKA9hd+qJn0TiU9cE0ZmpP2VecQ
         HGeQnbiAbpaT1yhjoT6X4yecGevRBKwgbzKkxfFhrsJckwWEiipQDu5gYdXps82x8jQ7
         5S0puU62M6awvB6zhUFUEmQ+94DR1L7YXgda4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PdotjZQkb21HYXz3c4EYVNLJgaizFCdJNsGs16YiowmY5GEvLaXJw7yQW7RlsVJIJb
         xRcC6aY6g3e5G9zuy8pHWF40CvIIQfENzAQPQpCYJyxwVL4TBNJB74cNQOsPTNuvsQxI
         m1hnzATMw642EWlag1sEblJtr7Xu8ph1VeIGY=
Received: by 10.102.17.15 with SMTP id 15mr1897156muq.133.1264206463506;
        Fri, 22 Jan 2010 16:27:43 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:43 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137804>

This is first step towards implementing file based output (response)
caching layer that is used on such large sites as kernel.org.

This patch introduces GitwebCaching::SimpleFileCache package, which
follows Cache::Cache / CHI interface, although do not implement it
fully.  The intent of following established convention is to be able
in the future to replace our simple file based cache e.g. by one using
memcached.

Like in original patch by John 'Warthog9' Hawley (J.H.) (the one this
commit intends to be incremental step to), the data is stored in the
case as-is, without adding metadata (like expiration date), and
without serialization (which means only scalar data).

To be implemented (from original patch by J.H.):
* cache expiration (based on file stats, current time and global
  expiration time); currently elements in cache do not expire
* actually using this cache in gitweb, except error pages
* adaptive cache expiration, based on average system load
* optional locking interface, where only one process can update cache
  (using flock)
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Possible extensions (beyond what was in original patch):
* (optionally) show information about cache utilization
* AJAX (JavaScript-based) progress indicator
* JavaScript code to update relative dates in cached output
* make cache size-aware (try to not exceed specified maximum size)
* utilize X-Sendfile header (or equivalent) to show cached data
  (optional, as it makes sense only if web server supports sendfile
  feature and have it enabled)
* variable expiration feature from CHI, allowing items to expire a bit
  earlier than the stated expiration time to prevent cache miss
  stampedes (although locking, if available, should take care of
  this).

The code of GitwebCaching::SimpleFileCache package in gitweb/cache.pm
was heavily based on file-based cache in Cache::Cache package, i.e.
on Cache::FileCache, Cache::FileBackend and Cache::BaseCache
(including implementing atomic write, something that original patch
lacks).

This patch does not yet enable output caching in gitweb (it doesn't
have all required features yet); on the other hand it includes tests,
currently testing only cache Perl API.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Large parts of this code are based _heavily_ on Cache::FileCache
implementation (including Cache::FileBackend and Cache::BaseCache)
from Cache::Cache distribution (which is dual licensed using
(Perl) Artistic License and GNU General Public License, like Perl
itself).  In the final version of code it should probably be
cleaned up.

Also although it implements 'compute' interface from CHI (Unified
cache interface), actual CHI code was not used even as reference.
(Nevertheless gitweb/cache.pm is meant to use minimal dependencies,
like gitweb itself, so it won't use Moose / Mouse for OO).

 gitweb/cache.pm                 |  317 +++++++++++++++++++++++++++++++++++++++
 t/t9503-gitweb-caching.sh       |   32 ++++
 t/t9503/test_cache_interface.pl |   77 ++++++++++
 t/test-lib.sh                   |    3 +
 4 files changed, 429 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
new file mode 100644
index 0000000..ea544b0
--- /dev/null
+++ b/gitweb/cache.pm
@@ -0,0 +1,317 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+#
+# This program is licensed under the GPLv2
+
+#
+# Gitweb caching engine
+#
+
+{
+# Minimalistic cache that stores data in the filesystem, without serialization
+# and currently without any kind of cache expiration (all keys last forever till
+# they got explicitely removed)
+#
+# It follows Cache::Cache and CHI interface (but does not implement it fully)
+
+package GitwebCache::SimpleFileCache;
+
+use strict;
+use warnings;
+
+use File::Path qw(make_path);  # requires version >= 2.0
+use File::Spec;
+use File::Temp;
+use Digest::MD5 qw(md5_hex);
+
+# by default, the cache nests all entries on the filesystem two
+# directories deep
+
+our $DEFAULT_CACHE_DEPTH = 2;
+
+# by default, the root of the cache is located in 'cache'.
+
+our $DEFAULT_CACHE_ROOT = "cache";
+
+# ......................................................................
+# constructor
+
+# The options are set by passing in a reference to a hash containing
+# any of the following keys:
+#  * 'namespace'
+#    The namespace associated with this cache.  This allows easy separation of
+#    multiple, distinct caches without worrying about key collision.  Defaults
+#    to '' (which does not allow for simple implementation of clear() method).
+#  * 'cache_root'
+#    The location in the filesystem that will hold the root of the cache.
+#    Defaults to 'cache', relative to gitweb.cgi directory.
+#  * 'cache_depth'
+#    The number of subdirectories deep to cache object item.  This should be
+#    large enough that no cache directory has more than a few hundred objects.
+#    Defaults to 2 unless explicitly set.
+sub new {
+	my ($proto, $p_options_hash_ref) = @_;
+
+	my $class = ref($proto) || $proto;
+	my $self  = {};
+	$self = bless($self, $class);
+
+	my ($root, $depth, $ns);
+	if (defined $p_options_hash_ref) {
+		$root  = $p_options_hash_ref->{'cache_root'};
+		$depth = $p_options_hash_ref->{'cache_depth'};
+		$ns    = $p_options_hash_ref->{'namespace'};
+	}
+	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
+	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
+	$ns    = '' unless defined($ns);
+
+	$self->set_root($root);
+	$self->set_depth($depth);
+	$self->set_namespace($ns);
+
+	return $self;
+}
+
+# ......................................................................
+# accessors
+
+sub get_depth {
+	my ($self) = @_;
+
+	return $self->{'_Depth'};
+}
+
+sub set_depth {
+	my ($self, $depth) = @_;
+
+	$self->{'_Depth'} = $depth;
+}
+
+sub get_root {
+	my ($self) = @_;
+
+	return $self->{'_Root'};
+}
+
+
+sub set_root {
+	my ($self, $root) = @_;
+
+	$self->{'_Root'} = $root;
+}
+
+sub get_namespace {
+	my ($self) = @_;
+
+	return $self->{'_Namespace'};
+}
+
+
+sub set_namespace {
+	my ($self, $namespace) = @_;
+
+	$self->{'_Namespace'} = $namespace;
+}
+
+# ----------------------------------------------------------------------
+# (private) utility functions and methods
+
+# Take an human readable key, and create a unique (hashed) key from it
+sub _Build_Hashed_Key {
+	my ($p_key) = @_;
+
+	return md5_hex($p_key);
+}
+
+# Take an human readable key, and return file path
+sub _path_to_key {
+	my ($self, $p_namespace, $p_key) = @_;
+
+	return $self->_path_to_hashed_key($p_namespace,
+	                                    _Build_Hashed_Key($p_key));
+}
+
+# Take hashed key, and return file path
+sub _path_to_hashed_key {
+	my ($self, $p_namespace, $p_hashed_key) = @_;
+
+	return File::Spec->catfile($self->get_root(), $p_namespace,
+	                           _Split_Word($p_hashed_key, $self->get_depth()));
+}
+
+# Split word into N components, where each component but last is two-letter word
+# e.g. _Split_Word("06b90e786e304a18fdfbd7c7bcc41a6b", 2) == qw(06 b90e786e304a18fdfbd7c7bcc41a6b);
+#      _Split_Word("06b90e786e304a18fdfbd7c7bcc41a6b", 3) == qw(06 b9 0e786e304a18fdfbd7c7bcc41a6b);
+sub _Split_Word {
+	my ($p_word, $p_depth) = @_;
+
+	$p_depth--; # now it is number of leading 2-letter components
+	return unpack("(a2)$p_depth a*", $p_word);
+}
+
+sub _Read_File {
+	my ($p_path) = @_;
+
+	-e $p_path
+		or return undef;
+
+	open(my $fh, '<', $p_path)
+		or return undef;
+
+	local $/ = undef;
+	my $data = <$fh>;
+
+	close($fh);
+
+	return $data;
+}
+
+# write a file atomically, assuming that path leading to file exists
+sub _Write_File {
+	my ($p_path, $p_data) = @_;
+
+	my ($volume, $directory, $filename) = File::Spec->splitpath($p_path);
+	if (defined $directory and defined $volume) {
+		$directory = File::Spec->catpath($volume, $directory, '');
+	}
+
+	my $temp = File::Temp->new(DIR => $directory,
+	                          TEMPLATE => "${filename}_XXXXX",
+	                          SUFFIX => '.tmp');
+	binmode($temp);
+	print {$temp} $p_data;
+	close($temp);
+
+	rename($temp, $p_path);
+}
+
+# ensures that directory leading to path exists, or dies
+sub _Make_Path {
+	my ($p_path, $p_dir) = @_;
+
+	my ($volume, $directory, $filename) = File::Spec->splitpath($p_path);
+	if (defined $directory and defined $volume) {
+		$directory = File::Spec->catpath($volume, $directory, "");
+	}
+
+	return
+		unless (defined $directory and not -d $directory);
+
+	my $numdirs = make_path($directory,
+	                        { mode => 0777, error => \my $mkdirerr });
+	if (@$mkdirerr) {
+		my $mkdirerrmsg = "";
+		for my $diag (@$mkdirerr) {
+			my ($file, $message) = %$diag;
+			if ($file eq '' ){
+				$mkdirerrmsg .= "general error: $message\n";
+			} else {
+				$mkdirerrmsg .= "problem unlinking $file: $message\n";
+			}
+		}
+		#die_error(500, "Could not create cache directory | $mkdirerrmsg");
+	}
+}
+
+sub _Remove_File {
+	my ($p_path) = @_;
+
+	if (-f $p_path) {
+		unlink($p_path);
+	}
+}
+
+# _read_data and _write_data methods do deserialization/serialization
+# in original implementation in Cache::Cache distribution
+
+sub _read_data {
+	my ($self, $p_path) = @_;
+
+	return _Read_File($p_path);
+}
+
+sub _write_data {
+	my ($self, $p_path, $p_data) = @_;
+
+	_Make_Path($p_path);
+	_Write_File($p_path, $p_data);
+}
+
+# ----------------------------------------------------------------------
+# worker methods (explicit namespace)
+
+sub restore {
+	my ($self, $p_namespace, $p_key) = @_;
+
+	return $self->_read_data($self->_path_to_key($p_namespace, $p_key));
+}
+
+sub store {
+	my ($self, $p_namespace, $p_key, $p_data) = @_;
+
+	$self->_write_data($self->_path_to_key($p_namespace, $p_key),
+	                   $p_data);
+}
+
+sub delete_key {
+	my ($self, $p_namespace, $p_key) = @_;
+
+	_Remove_File($self->_path_to_key($p_namespace, $p_key));
+}
+
+sub get_size {
+	my ($self, $p_namespace, $p_key) = @_;
+
+	my $path = $self->_path_to_key($p_namespace, $p_key);
+	if (-e $path) {
+		return -s $path;
+	}
+	return 0;
+}
+
+# ......................................................................
+# interface methods
+
+# Removing and expiring
+
+sub remove {
+	my ($self, $p_key) = @_;
+
+	$self->delete_key($self->get_namespace(), $p_key);
+}
+
+# Getting and setting
+
+sub set {
+	my ($self, $p_key, $p_data) = @_;
+
+	$self->store($self->get_namespace(), $p_key, $p_data);
+}
+
+sub get {
+	my ($self, $p_key) = @_;
+
+	my $data = $self->restore($self->get_namespace(), $p_key)
+		or return undef;
+
+	return $data;
+}
+
+sub compute {
+	my ($self, $p_key, $p_coderef) = @_;
+
+	my $data = $self->get($p_key);
+	if (!defined $data) {
+		$data = $p_coderef->($self, $p_key);
+		$self->set($p_key, $data);
+	}
+
+	return $data;
+}
+
+1;
+} # end of package GitwebCache::SimpleFileCache;
+
+1;
diff --git a/t/t9503-gitweb-caching.sh b/t/t9503-gitweb-caching.sh
new file mode 100755
index 0000000..768080c
--- /dev/null
+++ b/t/t9503-gitweb-caching.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jakub Narebski
+#
+
+test_description='caching interface to be used in gitweb'
+#test_description='caching interface used in gitweb, gitweb caching
+#
+#This test checks cache (interface) used in gitweb caching, caching
+#infrastructure and gitweb response (output) caching (the last by
+#running gitweb as CGI script from commandline).'
+
+# for now we are running only cache interface tests
+. ./test-lib.sh
+
+# this test is present in gitweb-lib.sh
+if ! test_have_prereq PERL; then
+	say 'perl not available, skipping test'
+	test_done
+fi
+
+"$PERL_PATH" -MTest::More -e 0 >/dev/null 2>&1 || {
+	say 'perl module Test::More unavailable, skipping test'
+	test_done
+}
+
+# ----------------------------------------------------------------------
+
+test_external 'GitwebCache::* Perl API (in gitweb/cache.pm)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
+
+test_done
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
new file mode 100755
index 0000000..0b6628b
--- /dev/null
+++ b/t/t9503/test_cache_interface.pl
@@ -0,0 +1,77 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More;
+
+# test source version; there is no installation target for gitweb
+my $cache_pm = "$ENV{TEST_DIRECTORY}/../gitweb/cache.pm";
+
+unless (-f "$cache_pm") {
+	plan skip_all => "gitweb/cache.pm not found";
+}
+
+# it is currently not a proper Perl module, so we use 'do FILE'
+#ok(eval { do "$cache_pm"; 1 or die $!; }, "loading gitweb/cache.pm");
+my $return = do "$cache_pm";
+ok(!$@,              "parse gitweb/cache.pm");
+ok(defined $return,  "do    gitweb/cache.pm");
+ok($return,          "run   gitweb/cache.pm");
+# instead of: BEGIN { use_ok('GitwebCache::SimpleFileCache') }
+
+# Test creating a cache
+#
+my $cache = new_ok('GitwebCache::SimpleFileCache',
+	[ { 'cache_root' => 'cache', 'cache_depth' => 2 } ]);
+
+# Test that default values are defined
+#
+ok(defined $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
+	'$DEFAULT_CACHE_ROOT defined');
+ok(defined $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH,
+	'$DEFAULT_CACHE_DEPTH defined');
+
+# Test accessors and default values for cache
+#
+SKIP: {
+	skip 'default values not defined', 3
+		unless ($GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT &&
+		        $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH);
+
+	is($cache->get_namespace(), '', "default namespace is ''");
+	is($cache->get_root(), $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
+		"default cache root is '$GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT'");
+	cmp_ok($cache->get_depth(), '==', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH,
+		"default cache depth is $GitwebCache::SimpleFileCache::DEFAULT_CACHE_DEPTH");
+}
+
+# Test the getting, setting, and removal of a cached value
+# (Cache::Cache interface)
+#
+my $key = 'Test Key';
+my $value = 'Test Value';
+can_ok($cache, qw(get set remove));
+#ok(!defined($cache->get($key)),        'get before set')
+#	or diag("get returned '", $cache->get($key), "' for $key");
+$cache->set($key, $value);
+is($cache->get($key), $value,          'get after set, returns cached value');
+$cache->remove($key);
+ok(!defined($cache->get($key)),        'get after remove, is undefined');
+
+# Test the getting and setting of a cached value
+# (CHI interface)
+#
+my $call_count = 0;
+sub get_value {
+	$call_count++;
+	return $value;
+}
+can_ok($cache, qw(compute));
+is($cache->compute($key, \&get_value), $value, 'compute 1st time (set)');
+is($cache->compute($key, \&get_value), $value, 'compute 2nd time (get)');
+is($cache->compute($key, \&get_value), $value, 'compute 3rd time (get)');
+cmp_ok($call_count, '==', 1, 'get_value() is called once');
+
+done_testing();
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 142f36f..9282d9e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -429,6 +429,9 @@ test_external () {
 		# Announce the script to reduce confusion about the
 		# test output that follows.
 		say_color "" " run $test_count: $descr ($*)"
+		# Export TEST_DIRECTORY and TRASH_DIRECTORY
+		# to be able to use them in script
+		export TEST_DIRECTORY TRASH_DIRECTORY
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
-- 
1.6.6.1
