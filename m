From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv2 02/10] gitweb/cache.pm - Very simple file based caching
Date: Tue,  9 Feb 2010 11:30:19 +0100
Message-ID: <1265711427-15193-3-git-send-email-jnareb@gmail.com>
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
	id 1NenN7-0003mJ-HH
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab0BIKas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:30:48 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:57151 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0BIKan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 05:30:43 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3026581fxm.21
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 02:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OnKLeeARZMU7hOtrGpkKmPT3CltIfWReTkpzD801MZU=;
        b=W8oL/6TfFUnMXi7VFlIkVsEeMz4E4N0NTzKXRYfgqt8sk8x9Q5z2hCU8VwXSz4FhF2
         RHjgNnP/+XDnt2ghmNRIWEJ1l4JABdQ4oIDiCt8CQJRu6DTMM7mhO+dN2293OKLOLAPz
         XJFpiSDmZXEp+nZpOziN9bREUIkZpK5lrDKGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vRiXq2OyEIzJK1lbkyqFY1umfhsE62Vlpq92CUvjkVzBVfeuobV8h5/zr2Li3YUsAu
         x+Jo5zNqNhiysrZgbFmBUCYsmTdgs8T9xL+eELs5tc4ppNyAn1oRf8LtNbUSFF8JcEjS
         R0VMosE9oiXh+okMMYIat8NwSCAsHlxXBZ424=
Received: by 10.223.4.130 with SMTP id 2mr3681663far.100.1265711442019;
        Tue, 09 Feb 2010 02:30:42 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 16sm2344332fxm.8.2010.02.09.02.30.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 02:30:41 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139388>

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
on Cache::FileCache, Cache::FileBackend and Cache::BaseCache, and on
file-based cache in CHI, i.e. on CHI::Driver::File and CHI::Driver
(including implementing atomic write, something that original patch
lacks).

This patch does not yet enable output caching in gitweb (it doesn't
have all required features yet); on the other hand it includes tests,
currently testing only cache Perl API.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Previous version of this patch had large parts of this code are based
_heavily_ on Cache::FileCache implementation (including Cache::FileBackend
and Cache::BaseCache) from Cache::Cache distribution (which is dual licensed
using (Perl) Artistic License and GNU General Public License, like Perl
itself).

This version is based on file-based caching from CHI (Unified Caching
Interface), which is more modern package, and I think better engineered
(with better design).  Nevertheless gitweb/cache.pm is meant to use minimal
dependencies, like gitweb itself, so it won't use Moose / Mouse for OOP
(Object Oriented Programming) like CHI does.  CHI is also licensed "under
the same terms as Perl itself", which means dual Artistic/GPL licensed.

Note that GitwebCache::SimpleFileCache does implement neither CHI interface
nor Cache::Cache interface fully; it is means to be very simple, but
hopefully fast cache.

Differences from v1:
* Allow for alternate CHI-compatible names for parameters passed to
  GitwebCache::SimpleFileCache constructor: 'cache_root' / 'root_dir',
  'cache_depth' / 'depth' (not sure if it is worth it).
* Accessors (getters and setters, i.e. ->get_depth() / ->set_depth($depth)
  methods) are generated, instead of using lot of boilerplate code.  The
  names of fields changed a bit, too.
* Change the design of "engine" part from inspired by older Cache::Cache
  to inspired by newer and more modern CHI.  Among others this means that
  there are no 'private' subroutines (with '_'-prefixed names), and that
  inner (engine) methods no longer pass namespace as parameter - for example
  in place of ->restore($namespace, $key) there is ->fetch($key).
* ->fetch() and ->store() methods use fast slurp (from CHI::Driver::File,
  which in turn has it adapted from File::Slurp), which uses sys{read,write}.
* ->fetch() and ->store() uses ':raw' (binary) mode to read and write data.
* ->set() has protection against writing undefined data (which would fail).
* Does not use new make_path, but older mkpath interface from File::Path;
  this way we do not require File::Path version >= 2.0.

Differences from relevant parts of J.H. patch:
* Does not use make_path, but mkpath from File::Path (see above)
* Uses catfile/catdir from File::Spec (see below)
* Writes to cache file atomically, by writing to unique temporary file
  and then renaming/moving this file to the cache file.  This is to make
  caching more robust, by preventing readers from getting partial data.
  The issue this prevents should be very rare, as we write whole data
  (whole page) at once, after it is generated in full, so this situation
  can theoretically happen only in the case of heavy load, many clients,
  and very large page over the size of (file)system cache.
* Currently it does not do any error reporting, as opposed to J.H. patch,
  in which errors are reported via die_error from gitweb (entangling
  cache.pm and gitweb.perl even more).  This is planned to be fixed in the
  final version of this patch series.
* The depth of cache hierarchy is configurable, while J.H. patch uses
  hardcoded depth of 1 subdirectory.  It uses unpack rather than substr.
  For 06b90e786e... key digest it uses 06/b90e786e... (with cache_depth = 1)
  rather than 06/06b90e786e... in J.H. patch.  It does not have binary
  and non-binary cache data separately; it does not use '.bin' suffix
  (extension) for binary-data cache files.
* GitwebCache::SimpleFileCache uses standard ->get, ->set, ->compute
  methods, which should allow easy replacing it with CHI or Cache::Cache
  cache (see later commit, adding caching support to gitweb).
* Tests of caching API in t/t9503-gitweb-caching.sh
* Better Perl style, more consistent with what gitweb itself uses.

Possible improvements:
* CHI uses fast_catpath from CHI::Util, which for Unix reduces to simple
  join("/", @_).  GitwebCache::SimpleFileCache uses catpath (remainder of
  Cache::FileCache-based code), but gitweb itself uses just "$root/$path",
  so this over-portability just wastes performance.
* We use File::Temp to generate temporary file to write data.  CHI uses
  instead unique ids (Data::UUID to generate initial unique id, then suffix
  it with serial number, in hexadecimal) for efficiency.
  Note that with locking (introduced later in series) we could write to
  temporary file with pre-defined (not randomized/incremental) name.
* GitwebCache::SimpleFileCache over-uses accessors in its methods, where
  referring directly to object fields would be (usually) enough.  Also
  the fields probably should be just named 'field_key' rather than 
  '_Field_key' (again its remainder of old-style Cache::FileCache-based
  code).
* Separate change to t/test-lib.sh, adding exporting TEST_DIRECTORY and
  TRASH_DIRECTORY in test_external to allow its use in external tests,
  to a separate commit (it is required for t9503 to find cache.pm).
* I should probably update copyright statement in cache.pm (just noticed)

 gitweb/cache.pm                 |  269 +++++++++++++++++++++++++++++++++++++++
 t/t9503-gitweb-caching.sh       |   32 +++++
 t/t9503/test_cache_interface.pl |   84 ++++++++++++
 t/test-lib.sh                   |    3 +
 4 files changed, 388 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
new file mode 100644
index 0000000..aebab01
--- /dev/null
+++ b/gitweb/cache.pm
@@ -0,0 +1,269 @@
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
+use File::Path qw(mkpath);
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
+#  * 'cache_root' (Cache::FileCache compatibile),
+#    'root_dir' (CHI::Driver::File compatibile),
+#    The location in the filesystem that will hold the root of the cache.
+#    Defaults to 'cache', relative to gitweb.cgi directory.
+#  * 'cache_depth' (Cache::FileCache compatibile),
+#    'depth' (CHI::Driver::File compatibile),
+#    The number of subdirectories deep to cache object item.  This should be
+#    large enough that no cache directory has more than a few hundred objects.
+#    Defaults to 1 unless explicitly set.
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
+# http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
+
+foreach my $i (qw(depth root namespace)) {
+	my $field = $i;
+	no strict 'refs';
+	*{"get_$field"} = sub {
+		my $self = shift;
+		return $self->{'_'.ucfirst($field)};
+	};
+	*{"set_$field"} = sub {
+		my ($self, $value) = @_;
+		$self->{'_'.ucfirst($field)} = $value;
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
+	if (!exists $self->{'_Path_to_namespace'}) {
+		$self->{'_Path_to_namespace'} = File::Spec->catfile(
+			$self->get_root(),
+			$self->get_namespace()
+		);
+	}
+	return $self->{'_Path_to_namespace'};
+}
+
+# Take an human readable key, and return file path
+sub path_to_key {
+	my ($self, $key, $dir_ref) = @_;
+
+	my @paths = ( $self->path_to_namespace() );
+
+	# Create a unique (hashed) key from human readable key
+	my $filename = md5_hex($key); # or $digester->add($key)->hexdigest()
+
+	# Split filename so that it have DEPTH subdirectories,
+	# where each subdirectory has a two-letter name
+	push @paths, unpack("(a2)".($self->{'_Depth'} || 1)." a*", $filename);
+	$filename = pop @paths;
+
+	# Join paths together, computing dir separately if $dir_ref was passed.
+	my $filepath;
+	if (defined $dir_ref && ref($dir_ref)) {
+		my $dir = File::Spec->catdir(@paths);
+		$filepath = File::Spec->catfile($dir, $filename);
+		$$dir_ref = $dir;
+	} else {
+		$filepath = File::Spec->catfile(@paths, $filename);
+	}
+
+	return $filepath;
+}
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
+	mkpath($dir, 0, 0777) if !-d $dir;
+
+	# generate a temporary file
+	my $temp = File::Temp->new(
+		#DIR => $dir,
+		TEMPLATE => "${file}_XXXXX",
+		SUFFIX => ".tmp"
+	);
+
+	# Fast spew, adapted from File::Slurp::write, with unnecessary options removed
+	# via CHI::Driver::File (from CHI-0.33)
+	my $write_fh = $temp;
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
+	close($temp);
+	rename($temp, $file);
+}
+
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
+sub remove {
+	my ($self, $key) = @_;
+
+	my $file = $self->path_to_key($key)
+		or return undef;
+	unlink($file);
+}
+
+# Getting and setting
+
+sub set {
+	my ($self, $key, $data) = @_;
+
+	return unless (defined $key && defined $data);
+
+	$self->store($key, $data);
+}
+
+sub get {
+	my ($self, $key) = @_;
+
+	my $data = $self->fetch($key)
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
index 0000000..9714f72
--- /dev/null
+++ b/t/t9503/test_cache_interface.pl
@@ -0,0 +1,84 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More;
+use Data::Dumper;
+
+# test source version; there is no installation target for gitweb
+my $cache_pm = "$ENV{TEST_DIRECTORY}/../gitweb/cache.pm";
+
+unless (-f "$cache_pm") {
+	plan skip_all => "$cache_pm not found";
+}
+
+# it is currently not a proper Perl module, so we use 'do FILE'
+# instead of: BEGIN { use_ok('GitwebCache::SimpleFileCache') }
+my $return = do "$cache_pm";
+ok(!$@,              "parse gitweb/cache.pm")
+	or diag("parse error:\n", $@);
+ok(defined $return,  "do    gitweb/cache.pm");
+ok($return,          "run   gitweb/cache.pm");
+
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
+cmp_ok($cache->get_size($key), '>', 0, 'get_size after set, is greater than 0');
+$cache->remove($key);
+ok(!defined($cache->get($key)),        'get after remove, is undefined');
+eval { $cache->remove('Not-Existent Key'); };
+ok(!$@,                                'remove on non-existent key doesn\'t die');
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
+cmp_ok($call_count, '==', 1, 'get_value() is called once from compute');
+
+done_testing();
+
+print Dumper($cache);
diff --git a/t/test-lib.sh b/t/test-lib.sh
index afd3053..a13bdd5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -453,6 +453,9 @@ test_external () {
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
