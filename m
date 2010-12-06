From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 03/24] gitweb/lib - Very simple file based cache
Date: Tue,  7 Dec 2010 00:10:48 +0100
Message-ID: <1291677069-6559-4-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:19:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkKs-0003Bh-2w
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab0LFXTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:19:04 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:52756 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab0LFXTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:19:01 -0500
Received: by eyg5 with SMTP id 5so8019446eyg.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vpOiihVE4yakECVtLBeJNQ6TndUVaASZXbSuYpuA5ic=;
        b=rK27oPbm8LEVKVQGHBiv2SllFA20t5D74Vr2m+x+lR2J5MAhlQE8qz2Zlr5SCBeq8H
         ld4xwglnncwtVApotng0PSUyJz/LGFuNA424z/813TfnyeiCcUtJivqhpMFmJeyeD1tx
         44EjjY5QD7/m/TAJb+dJdeKp5aSnItoEltB8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M+cOxvHyHIlG+EXCZXOFXF2upRAxzbLV5ixth/UTMJ5MCV4d6CfEettLrzzSJZYzgS
         abvLQnKgAMjSwNwADky+cOq/jOWDSt4n9kj0dCQ7GUDMJQ+8GRWiXuv4rLDdnCmuDL9/
         Hk9sc9fLvi6F0tX9GAURvqLNs9jWcMiTWOsZw=
Received: by 10.213.2.209 with SMTP id 17mr144296ebk.37.1291677108178;
        Mon, 06 Dec 2010 15:11:48 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:46 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163053>

This is first step towards implementing file based output (response)
caching layer that is used on such large sites as kernel.org.

This patch introduces GitwebCaching::SimpleFileCache package, which
follows Cache::Cache / CHI interface, although do not implement it
fully.  The intent of following established convention for cache
interface is to be able to replace our simple file based cache,
e.g. by the one using memcached.

The data is stored in the cache as-is, without adding metadata (like
expiration date), and without serialization (which means that one can
store only scalar data).  At this point there is no support for
expiring cache entries.


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
This version is cleaned up from remainders of old-style code inspired
by code in Cach::Cache distribution, and of cargo-culted code from
examples in Perl documentation; it uses more modern Perl coding
conventions.  Therefore it has significantly less warnings from
Perl::Critic (though they are not eliminated entirely).

Contrary to some earlier versions we do not try to be operating system
agnostic by using File::Spec; concatenating paths with '/' taken as
directory separator is faster, and that is what gitweb uses anyway.

Note that writing to cache entry file is done atomically via File::Temp
and renaming file to final version.  This way we can ensure that gitweb
wouldn't get halfway written file.  Use of File::Temp (which gives
safety but unfortunately has negative impact on performance) will be
made not necessary with introduction of locking.

Because GitwebCache::SimpleFileCache (and its derivatives) use standard
->new, ->get, ->set, ->compute methods / API / interface, then other
caching engines such as Cache::Cache, Cache, CHI, Cache::Memcached or
Cache::FastMmap can be used instead of this one.

Fast spew / fast slurp might be interesting, but they are obsoleted
(unused) when redirecting output directly to cache entry file in later
patch.

 gitweb/lib/GitwebCache/SimpleFileCache.pm |  336 +++++++++++++++++++++++++++++
 t/t9503-gitweb-caching-interface.sh       |   34 +++
 t/t9503/test_cache_interface.pl           |   85 ++++++++
 3 files changed, 455 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/SimpleFileCache.pm
 create mode 100755 t/t9503-gitweb-caching-interface.sh
 create mode 100755 t/t9503/test_cache_interface.pl

diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
new file mode 100644
index 0000000..2f26a6c
--- /dev/null
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -0,0 +1,336 @@
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
+	my $class = shift;
+	my %opts = ref $_[0] ? %{ $_[0] } : @_;
+
+	my $self = {};
+	$self = bless($self, $class);
+
+	my ($root, $depth, $ns);
+	if (%opts) {
+		$root =
+			$opts{'cache_root'} ||
+			$opts{'root_dir'};
+		$depth =
+			$opts{'cache_depth'} ||
+			$opts{'depth'};
+		$ns = $opts{'namespace'};
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
+	push @paths, unpack("(a2)[$self->{'depth'}] a*", $filename);
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
+sub read_file {
+	my $filename = shift;
+
+	# Fast slurp, adapted from File::Slurp::read, with unnecessary options removed
+	# via CHI::Driver::File (from CHI-0.33)
+	my $buf = '';
+	open my $read_fh, '<', $filename
+		or return;
+	binmode $read_fh, ':raw';
+
+	my $size_left = -s $read_fh;
+
+	while ($size_left > 0) {
+		my $read_cnt = sysread($read_fh, $buf, $size_left, length($buf));
+		return unless defined $read_cnt;
+
+		last if $read_cnt == 0;
+		$size_left -= $read_cnt;
+		#last if $size_left <= 0;
+	}
+
+	close $read_fh
+		or die "Couldn't close file '$filename' opened for reading: $!";
+	return $buf;
+}
+
+sub write_fh {
+	my ($write_fh, $filename, $data) = @_;
+
+	# Fast spew, adapted from File::Slurp::write, with unnecessary options removed
+	# via CHI::Driver::File (from CHI-0.33)
+	binmode $write_fh, ':raw';
+
+	my $size_left = length($data);
+	my $offset = 0;
+
+	while ($size_left > 0) {
+		my $write_cnt = syswrite($write_fh, $data, $size_left, $offset);
+		return unless defined $write_cnt;
+
+		$size_left -= $write_cnt;
+		$offset += $write_cnt; # == length($data);
+	}
+
+	close $write_fh
+		or die "Couldn't close file '$filename' opened for writing: $!";
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
+	return unless (defined $file && -f $file);
+
+	return read_file($file);
+}
+
+sub store {
+	my ($self, $key, $data) = @_;
+
+	my $dir;
+	my $file = $self->path_to_key($key, \$dir);
+	return unless (defined $file && defined $dir);
+
+	# ensure that directory leading to cache file exists
+	if (!-d $dir) {
+		# mkpath will croak()/die() if there is an error
+		mkpath($dir, 0, 0777);
+	}
+
+	# generate a temporary file
+	my ($temp_fh, $tempname) = _tempfile_to_path($file, $dir);
+	chmod 0666, $tempname
+		or warn "Couldn't change permissions to 0666 / -rw-rw-rw- for '$tempname': $!";
+
+	write_fh($temp_fh, $tempname, $data);
+
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
+		or return;
+	return unless -f $file;
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
+	return $self->fetch($key);;
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
+		$data = $code->();
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
index 0000000..1a3f374
--- /dev/null
+++ b/t/t9503/test_cache_interface.pl
@@ -0,0 +1,85 @@
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
+
+# Test creating a cache
+#
+BEGIN { use_ok('GitwebCache::SimpleFileCache'); }
+diag("Using lib '$INC[0]'");
+diag("Testing '$INC{'GitwebCache/SimpleFileCache.pm'}'");
+
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
