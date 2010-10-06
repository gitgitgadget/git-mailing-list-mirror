From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Thu,  7 Oct 2010 00:01:48 +0200
Message-ID: <1286402526-13143-4-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:02:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c4N-0001X4-H1
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034Ab0JFWCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab0JFWCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:34 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N9vGGnTL/8wl7xF0S5TXo5QDRqBWpSoZWn3b73wS0M8=;
        b=oqeNmauFzoJI5DU0+QPxqBmFT2jelJJZvocmuTZFYvb+vWqlD4i4AyI+RZEKj4jOi1
         yawiW7rruvZo66sf1LYWPMCFlheep90RQaYjq5awT0+iz9MHwmLINXxOGfe4RYc2A9vp
         z/lftcyfUuACsiHjO/gXcJaTN0npuRWvcGML0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s2JNuh9NSVHUurQxuZxwaWRJuCafg2prVVwTtvQha7070tnWkpvCqIrUAQc0Nq7Oyb
         iHqS4+0Kuh86n2dNwYJLiLCsBJABC2Iul4yHQV+Bqy3uqiPCfXzHvnMwP1y37tErlHor
         l8kYW1Ymk30GjRcrsSOCm6a5FCisx6hdHfemw=
Received: by 10.204.117.13 with SMTP id o13mr10324201bkq.48.1286402552775;
        Wed, 06 Oct 2010 15:02:32 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158312>

This is first step towards implementing file based output (response)
caching layer that is used on such large sites as kernel.org.

This patch introduces GitwebCaching::SimpleFileCache package, which
follows Cache::Cache / CHI interface, although do not implement it
fully.  The intent of following established convention for cache
interface is to be able to replace our simple file based cache,
e.g. by the one using memcached.

Like in original patch by John 'Warthog9' Hawley (J.H.) (the one this
commit intends to be incremental step to), the data is stored in the
case as-is, without adding metadata (like expiration date), and
without serialization (which means that one can store only scalar
data).

To be implemented (from original patch by J.H.):
* cache expiration (based on file stats, current time and global
  expiration time); currently elements in cache do not expire at all
* actually using this cache in gitweb, with exception of error pages
* adaptive cache expiration, based on average system load
* optional locking interface, where only one process can update cache
  (using flock)
* server-side progress indicator when waiting for filling cache,
  which in turn requires separating situations (like snapshots and
  other non-HTML responses) where we should not show 'please wait'
  message

Possible extensions (beyound what was in original patch):
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
  this)

The code of GitwebCaching::SimpleFileCache package in gitweb/lib
was heavily based on file-based cache in Cache::Cache package, i.e.
on Cache::FileCache, Cache::FileBackend and Cache::BaseCache, and on
file-based cache in CHI, i.e. on CHI::Driver::File and CHI::Driver
(including implementing atomic write, something that original patch
lacks).  It tries to follow more modern CHI architecture, but without
requiring Moose.  It is much simplified compared to both interfaces
and their file-based drivers.

This patch does not yet enable output caching in gitweb (it doesn't
have all required features yet); on the other hand it includes tests
of cache Perl API in t/t9503-gitweb-caching-interface.sh.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v4:
* The test got renamed a bit, because separate external tests would be
  invoked by separate test scripts, for 'prove' to work correctly
  (as test_external doesn't yet work as subtest).

  The t/t9503-gitweb-caching-interface.sh gets a long description,
  and is updated to follow conventions used post-TAPification.

* The t/t9503/test_cache_interface.pl uses GIT_BUILD_DIR rather than
  TEST_DIRECTORY, and respect GITWEBLIBDIR to make it possible to test
  installed version of module.

* Generating a temporary file to write to is refactored into "private"
  method _tempfile_to_path

* The call to 'mkdir' is enveloped in eval, as it dies on error.
  make_path would be better here, but is not available for File::Path
  before v2.00, which is in core only since 5.10


Differences from relevant parts of J.H. patch:
* Does not use make_path, but older mkpath interface from File::Path;
  this way we do not require File::Path version >= 2.0.

* Writes to cache file atomically, by writing to unique temporary file
  (from File::Temp at this point of series) and then renaming/moving
  this file to the cache file.  This is to make caching more robust,
  by preventing readers from getting partial data.  The issue this
  prevents should be very rare, as we write whole data (whole page) at
  once, after it is generated in full, so this situation can
  theoretically happen only in the case of heavy load, many clients,
  and very large page (over the size of (file)system cache).

* Error reporting is done via "die", not via die_error from gitweb.
  This is to avoid entangling cache.pm and gitweb.perl code (making
  cache.pm dependent on gitweb).  This can be improved further by
  passing die handler (wrapper around die_error in case of gitweb) to
  cache (see CHI source code for how it can be solved).

* The depth of cache hierarchy is configurable, while J.H. patch uses
  hardcoded depth of 1 subdirectory.  It uses unpack rather than substr.
  For 06b90e786e... key digest it uses 06/b90e786e... (with cache_depth = 1)
  rather than 06/06b90e786e... in J.H. patch.  

* GitwebCache::SimpleFileCache uses OO (object-oriented) interface,
  with constructor that takes param names that are compatibile with
  other cache engines (like CHI or Cache::Cache).

  GitwebCache::SimpleFileCache is a proper Perl module.

* GitwebCache::SimpleFileCache uses standard ->get, ->set, ->compute
  methods, which should allow easy replacing it with CHI or Cache::Cache
  cache (see later commit, adding caching support to gitweb).

* Support for namespaces (though default is to have no namespace, at
  least at this point of series).

* ->fetch($key) and ->store($key, $data) use fast slurp / spew,
  adapted from File::Slurp read and write subroutines, via
  CHI::Driver::File

* Tests of caching API in t/t9503-gitweb-caching-interface.sh

* Better Perl style, more consistent with what gitweb itself uses.


 gitweb/lib/GitwebCache/SimpleFileCache.pm |  324 +++++++++++++++++++++++++++++
 t/t9503-gitweb-caching-interface.sh       |   34 +++
 t/t9503/test_cache_interface.pl           |   81 +++++++
 3 files changed, 439 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/SimpleFileCache.pm
 create mode 100755 t/t9503-gitweb-caching-interface.sh
 create mode 100755 t/t9503/test_cache_interface.pl

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
new file mode 100644
index 0000000..a54f78f
--- /dev/null
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -0,0 +1,324 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Gitweb caching engine, simple file-based cache
+#
+
+# Minimalistic cache that stores data in the filesystem, without serialization
+# and currently without any kind of cache expiration (all keys last forever till
+# they got explicitely removed).
+#
+# It follows Cache::Cache and CHI interfaces (but does not implement it fully)
+
+package GitwebCache::SimpleFileCache;
+
+use strict;
+use warnings;
+
+use File::Path qw(mkpath);
+use File::Temp qw(tempfile);
+use Digest::MD5 qw(md5_hex);
+
+# by default, the cache nests all entries on the filesystem single
+# directory deep, i.e. '60/b725f10c9c85c70d97880dfe8191b3' for
+# key name (key digest) 60b725f10c9c85c70d97880dfe8191b3.
+#
+our $DEFAULT_CACHE_DEPTH = 1;
+
+# by default, the root of the cache is located in 'cache'.
+#
+our $DEFAULT_CACHE_ROOT = "cache";
+
+# by default we don't use cache namespace (empty namespace);
+# empty namespace does not allow for simple implementation of clear() method.
+#
+our $DEFAULT_NAMESPACE = '';
+
+# ......................................................................
+# constructor
+
+# The options are set by passing in a reference to a hash containing
+# any of the following keys:
+#  * 'namespace'
+#    The namespace associated with this cache.  This allows easy separation of
+#    multiple, distinct caches without worrying about key collision.  Defaults
+#    to $DEFAULT_NAMESPACE.
+#  * 'cache_root' (Cache::FileCache compatibile),
+#    'root_dir' (CHI::Driver::File compatibile),
+#    The location in the filesystem that will hold the root of the cache.
+#    Defaults to $DEFAULT_CACHE_ROOT.
+#  * 'cache_depth' (Cache::FileCache compatibile),
+#    'depth' (CHI::Driver::File compatibile),
+#    The number of subdirectories deep to cache object item.  This should be
+#    large enough that no cache directory has more than a few hundred objects.
+#    Defaults to $DEFAULT_CACHE_DEPTH unless explicitly set.
+sub new {
+	my ($proto, $p_options_hash_ref) = @_;
+
+	my $class = ref($proto) || $proto;
+	my $self  = {};
+	$self = bless($self, $class);
+
+	my ($root, $depth, $ns);
+	if (defined $p_options_hash_ref) {
+		$root  =
+			$p_options_hash_ref->{'cache_root'} ||
+			$p_options_hash_ref->{'root_dir'};
+		$depth =
+			$p_options_hash_ref->{'cache_depth'} ||
+			$p_options_hash_ref->{'depth'};
+		$ns    = $p_options_hash_ref->{'namespace'};
+	}
+	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
+	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
+	$ns    = $DEFAULT_NAMESPACE   unless defined($ns);
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
+# http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
+
+# creates get_depth() and set_depth($depth) etc. methods
+foreach my $i (qw(depth root namespace)) {
+	my $field = $i;
+	no strict 'refs';
+	*{"get_$field"} = sub {
+		my $self = shift;
+		return $self->{$field};
+	};
+	*{"set_$field"} = sub {
+		my ($self, $value) = @_;
+		$self->{$field} = $value;
+	};
+}
+
+# ----------------------------------------------------------------------
+# utility functions and methods
+
+# Return root dir for namespace (lazily built, cached)
+sub path_to_namespace {
+	my ($self) = @_;
+
+	if (!exists $self->{'path_to_namespace'}) {
+		if (defined $self->{'namespace'} &&
+		    $self->{'namespace'} ne '') {
+			$self->{'path_to_namespace'} = "$self->{'root'}/$self->{'namespace'}";
+		} else {
+			$self->{'path_to_namespace'} =  $self->{'root'};
+		}
+	}
+	return $self->{'path_to_namespace'};
+}
+
+# $path = $cache->path_to_key($key);
+# $path = $cache->path_to_key($key, \$dir);
+#
+# Take an human readable key, and return file path.
+# Puts dirname of file path in second argument, if it is provided.
+sub path_to_key {
+	my ($self, $key, $dir_ref) = @_;
+
+	my @paths = ( $self->path_to_namespace() );
+
+	# Create a unique (hashed) key from human readable key
+	my $filename = md5_hex($key); # or $digester->add($key)->hexdigest();
+
+	# Split filename so that it have DEPTH subdirectories,
+	# where each subdirectory has a two-letter name
+	push @paths, unpack("(a2)".($self->{'depth'} || 1)." a*", $filename);
+	$filename = pop @paths;
+
+	# Join paths together, computing dir separately if $dir_ref was passed.
+	my $filepath;
+	if (defined $dir_ref && ref($dir_ref)) {
+		my $dir = join('/', @paths);
+		$filepath = "$dir/$filename";
+		$$dir_ref = $dir;
+	} else {
+		$filepath = join('/', @paths, $filename);
+	}
+
+	return $filepath;
+}
+
+# ----------------------------------------------------------------------
+# "private" utility functions and methods
+
+# take a file path to cache entry, and its directory
+# return filehandle and filename of open temporary file,
+# like File::Temp::tempfile
+sub _tempfile_to_path {
+	my ($file, $dir) = @_;
+
+	# tempfile will croak() if there is an error
+	return tempfile("${file}_XXXXX",
+		#DIR => $dir,
+		'UNLINK' => 0, # ensure that we don't unlink on close; file is renamed
+		'SUFFIX' => '.tmp');
+}
+
+
+# ----------------------------------------------------------------------
+# worker methods
+
+sub fetch {
+	my ($self, $key) = @_;
+
+	my $file = $self->path_to_key($key);
+	return undef unless (defined $file && -f $file);
+
+	# Fast slurp, adapted from File::Slurp::read, with unnecessary options removed
+	# via CHI::Driver::File (from CHI-0.33)
+	my $buf = '';
+	open my $read_fh, '<', $file
+		or return undef;
+	binmode $read_fh, ':raw';
+
+	my $size_left = -s $read_fh;
+
+	while ($size_left > 0) {
+		my $read_cnt = sysread($read_fh, $buf, $size_left, length($buf));
+		return undef unless defined $read_cnt;
+
+		last if $read_cnt == 0;
+		$size_left -= $read_cnt;
+		#last if $size_left <= 0;
+	}
+
+	close $read_fh
+		or die "Couldn't close file '$file' opened for reading: $!";
+	return $buf;
+}
+
+sub store {
+	my ($self, $key, $data) = @_;
+
+	my $dir;
+	my $file = $self->path_to_key($key, \$dir);
+	return undef unless (defined $file && defined $dir);
+
+	# ensure that directory leading to cache file exists
+	if (!-d $dir) {
+		eval { mkpath($dir, 0, 0777); 1 }
+			or die "Couldn't create leading directory '$dir' (mkpath): $!";
+	}
+
+	# generate a temporary file
+	my ($temp_fh, $tempname) = $self->_tempfile_to_path($file, $dir);
+	chmod 0666, $tempname
+		or warn "Couldn't change permissions to 0666 / -rw-rw-rw- for '$tempname': $!";
+
+	# Fast spew, adapted from File::Slurp::write, with unnecessary options removed
+	# via CHI::Driver::File (from CHI-0.33)
+	my $write_fh = $temp_fh;
+	binmode $write_fh, ':raw';
+
+	my $size_left = length($data);
+	my $offset = 0;
+
+	while ($size_left > 0) {
+		my $write_cnt = syswrite($write_fh, $data, $size_left, $offset);
+		return undef unless defined $write_cnt;
+		
+		$size_left -= $write_cnt;
+		$offset += $write_cnt; # == length($data);
+	}
+
+	close $temp_fh
+		or die "Couldn't close temporary file '$tempname' opened for writing: $!";
+	rename($tempname, $file)
+		or die "Couldn't rename temporary file '$tempname' to '$file': $!";
+}
+
+# get size of an element associated with the $key (not the size of whole cache)
+sub get_size {
+	my ($self, $key) = @_;
+
+	my $path = $self->path_to_key($key)
+		or return undef;
+	if (-f $path) {
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
+# $cache->remove($key)
+#
+# Remove the data associated with the $key from the cache.
+sub remove {
+	my ($self, $key) = @_;
+
+	my $file = $self->path_to_key($key)
+		or return undef;
+	return undef unless -f $file;
+	unlink($file)
+		or die "Couldn't remove file '$file': $!";
+}
+
+# Getting and setting
+
+# $cache->set($key, $data);
+#
+# Associates $data with $key in the cache, overwriting any existing entry.
+# Returns $data.
+sub set {
+	my ($self, $key, $data) = @_;
+
+	return unless (defined $key && defined $data);
+
+	$self->store($key, $data);
+
+	return $data;
+}
+
+# $data = $cache->get($key);
+#
+# Returns the data associated with $key.  If $key does not exist
+# or has expired, returns undef.
+sub get {
+	my ($self, $key) = @_;
+
+	my $data = $self->fetch($key)
+		or return undef;
+
+	return $data;
+}
+
+# $data = $cache->compute($key, $code);
+#
+# Combines the get and set operations in a single call.  Attempts to
+# get $key; if successful, returns the value.  Otherwise, calls $code
+# and uses the return value as the new value for $key, which is then
+# returned.
+sub compute {
+	my ($self, $key, $code) = @_;
+
+	my $data = $self->get($key);
+	if (!defined $data) {
+		$data = $code->($self, $key);
+		$self->set($key, $data);
+	}
+
+	return $data;
+}
+
+1;
+__END__
+# end of package GitwebCache::SimpleFileCache;
diff --git a/t/t9503-gitweb-caching-interface.sh b/t/t9503-gitweb-caching-interface.sh
new file mode 100755
index 0000000..819da1d
--- /dev/null
+++ b/t/t9503-gitweb-caching-interface.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jakub Narebski
+#
+
+test_description='gitweb caching interface
+
+This test checks caching interface used in gitweb caching, and caching
+infrastructure (GitwebCache::* modules).'
+
+# for now we are running only cache interface tests
+. ./test-lib.sh
+
+# this test is present in gitweb-lib.sh
+if ! test_have_prereq PERL; then
+	skip_all='perl not available, skipping test'
+	test_done
+fi
+
+"$PERL_PATH" -MTest::More -e 0 >/dev/null 2>&1 || {
+	skip_all='perl module Test::More unavailable, skipping test'
+	test_done
+}
+
+# ----------------------------------------------------------------------
+
+# The external test will outputs its own plan
+test_external_has_tap=1
+
+test_external \
+	'GitwebCache::* Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
+
+test_done
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
new file mode 100755
index 0000000..6a7b715
--- /dev/null
+++ b/t/t9503/test_cache_interface.pl
@@ -0,0 +1,81 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More;
+
+# test source version
+use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
+
+# Test creating a cache
+#
+BEGIN { use_ok('GitwebCache::SimpleFileCache'); }
+my $cache = new_ok('GitwebCache::SimpleFileCache');
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
+	cmp_ok($cache->get_root(),  'eq', $GitwebCache::SimpleFileCache::DEFAULT_CACHE_ROOT,
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
+
+subtest 'Cache::Cache interface' => sub {
+	foreach my $method (qw(get set remove)) {
+		can_ok($cache, $method);
+	}
+
+	$cache->set($key, $value);
+	cmp_ok($cache->get_size($key), '>', 0, 'get_size after set, is greater than 0');
+	is($cache->get($key), $value,          'get after set, returns cached value');
+	$cache->remove($key);
+	ok(!defined($cache->get($key)),        'get after remove, is undefined');
+
+	eval { $cache->remove('Not-Existent Key'); };
+	ok(!$@,                                'remove on non-existent key doesn\'t die');
+	diag($@) if $@;
+
+	done_testing();
+};
+
+# Test the getting and setting of a cached value
+# (CHI interface)
+#
+my $call_count = 0;
+sub get_value {
+	$call_count++;
+	return $value;
+}
+subtest 'CHI interface' => sub {
+	can_ok($cache, qw(compute));
+
+	is($cache->compute($key, \&get_value), $value, "compute 1st time (set) returns '$value'");
+	is($cache->compute($key, \&get_value), $value, "compute 2nd time (get) returns '$value'");
+	is($cache->compute($key, \&get_value), $value, "compute 3rd time (get) returns '$value'");
+	cmp_ok($call_count, '==', 1, 'get_value() is called once from compute');
+
+	done_testing();
+};
+
+done_testing();
-- 
1.7.3
