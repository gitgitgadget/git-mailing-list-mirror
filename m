From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 02/10] gitweb/cache.pm - Very simple file based cache
Date: Tue, 16 Feb 2010 20:36:37 +0100
Message-ID: <1266349005-15393-3-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:37:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTES-0002Gw-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211Ab0BPThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:06 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34515 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0BPTg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:36:59 -0500
Received: by mail-bw0-f213.google.com with SMTP id 5so2280988bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SbqgUWhrOMOw4eeIVHcmLfYWxZTSS3D4+8xwihJgjiU=;
        b=ku035bt+aV3cuzpAN32cPe+F3wR+iAS09HM67M2XrjuSG9vw+FJhFkWDLKN5i8Yiuj
         Wm88ZpcCibeQJkDpZm0I0687IS1SXzZp71Y2qmp8yCVtd91ysruVtJCCkT8vFsdo2qP6
         o4X6QzWiQNJKyi2/Z380l+agALwfN7g9FriVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=prSUumrAKmqFcnwzdIDWsk8Qk46Wnzbk91ypgFRYybWsRViOultLGpt0+IwOrmNXjR
         fzFCmmiGhoNnHgTry/dYGuiLag72yRYa0A50CMZjg+Q0G/7AaGiZY8J4BPaSsPQ8TSMJ
         n7x/I5N670J50bMDMhxlBUkO0Zch9EsFG5TnM=
Received: by 10.204.10.20 with SMTP id n20mr4418825bkn.201.1266349018785;
        Tue, 16 Feb 2010 11:36:58 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.36.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:36:57 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140140>

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
lacks).  It tries to follow more modern CHI architecture, but without
requiring Moose.  It is much simplified compared to both interfaces
and their file-based drivers.

This patch does not yet enable output caching in gitweb (it doesn't
have all required features yet); on the other hand it includes tests
of cache Perl API in t/t9503-gitweb-caching.sh.

Inspired-by-code-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v2:
* Updated copyright info (not fully).
* Added many comments.
* Internal: field names are now 'root' etc, not '_Root' etc.
* path_to_namespace has now shortcut for empty namespace.
* Error reporting via "... or die "Couldn't ...: $!".
* ->remove now test that file exist befor attempting unlink
* ->set returns $data
* t9503 shows $@ if command inside eval die-d.

Differences from relevant parts of J.H. patch:
* Does not use make_path, but older mkpath interface from File::Path;
  this way we do not require File::Path version >= 2.0.
* Uses catfile/catdir from File::Spec (see below)
* Writes to cache file atomically, by writing to unique temporary file
  and then renaming/moving this file to the cache file.  This is to make
  caching more robust, by preventing readers from getting partial data.
  The issue this prevents should be very rare, as we write whole data
  (whole page) at once, after it is generated in full, so this situation
  can theoretically happen only in the case of heavy load, many clients,
  and very large page (over the size of (file)system cache).
* Error reporting is done via "die", not via die_error from gitweb.
  This is to avoid entangling cache.pm and gitweb.perl code (making
  cache.pm dependent on gitweb).  This can be improved further by
  passing die handler (wrapper around die_error in case of gitweb) to
  cache.
* The depth of cache hierarchy is configurable, while J.H. patch uses
  hardcoded depth of 1 subdirectory.  It uses unpack rather than substr.
  For 06b90e786e... key digest it uses 06/b90e786e... (with cache_depth = 1)
  rather than 06/06b90e786e... in J.H. patch.  
* It does not have binary and non-binary cache data separately; it
  does not use '.bin' suffix (extension) for binary-data cache files.
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
* Separate change to t/test-lib.sh, adding exporting TEST_DIRECTORY and
  TRASH_DIRECTORY in test_external to allow its use in external tests,
  to a separate commit (it is required for t9503 to find cache.pm).
* Simplify constructor, and make it manipulate fields directly rather
  than using accessors

 gitweb/cache.pm                 |  306 +++++++++++++++++++++++++++++++++++++++
 t/t9503-gitweb-caching.sh       |   32 ++++
 t/t9503/test_cache_interface.pl |   85 +++++++++++
 t/test-lib.sh                   |    3 +
 4 files changed, 426 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/cache.pm
 create mode 100755 t/t9503-gitweb-caching.sh
 create mode 100755 t/t9503/test_cache_interface.pl

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
new file mode 100644
index 0000000..231b292
--- /dev/null
+++ b/gitweb/cache.pm
@@ -0,0 +1,306 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
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
+# they got explicitely removed).
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
+		if ($self->{'namespace'} ne '') {
+			$self->{'path_to_namespace'} = File::Spec->catfile(
+				$self->{'root'},
+				$self->{'namespace'}
+			);
+		} else {
+			$self->{'path_to_namespace'} = $self->{'root'};
+		}
+	}
+	return $self->{'path_to_namespace'};
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
+	push @paths, unpack("(a2)".($self->{'depth'} || 1)." a*", $filename);
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
+		mkpath($dir, 0, 0777)
+			or die "Couldn't mkpath '$dir': $!";
+	}
+
+	# generate a temporary file
+	my $temp = File::Temp->new(
+		#DIR => $dir,
+		TEMPLATE => "${file}_XXXXX",
+		SUFFIX => ".tmp"
+	) or die "Couldn't create temporary file '${file}_XXXXX': $!";
+	chmod 0666, $temp
+		or die "Couldn't change permissions to 0666 for '$temp': $!";
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
+	close $temp
+		or die "Couldn't close temporary file '$temp' opened for writing: $!";
+	rename($temp, $file)
+		or die "Couldn't rename temporary file '$temp' to '$file': $!";
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
index 0000000..39802b7
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
+diag($@) if $@;
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
