From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 7/9] gitweb/lib - Very simple file based cache
Date: Thu, 23 Dec 2010 00:57:32 +0100
Message-ID: <20101222235731.7998.3214.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYZW-0008Ag-Aw
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab0LVX6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:58:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39560 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab0LVX6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:58:11 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so6639663fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=OZS4TVUXO5IFPW04kacy2BsCCaaNpZB+AJueUIhhvYQ=;
        b=h8XvcVPL4ccCcycgBGcW2LhBrM53A9UdzHQBB/iHEsnsBwaEP0i+N/rRnPrkLg6gN+
         Ky3oMM22EuTT4CHh7jAqiMngAzwcJzLstpzuf1OBLSE8Lnh6elk5qHJA0JfKi0bkBJI2
         1LowMpvD2VPWxBKZegDeWD28BCB60De8aNt3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=RJFzjmooGD71fmUGUbBBuMVyKhg4mkdiFp5nGpdb8e4Ymfw2YB4p61g1wOiwkPgivn
         46DHwN56fACEj37QPZ8R+tfAwEqQqqT6ZBFexcy6y2C6E4kMQriWZB+NAtr2aBzukaUl
         VtFpJxU1YHZFK+2j61mmZsrbihFVlRsJDyq9A=
Received: by 10.223.83.8 with SMTP id d8mr191086fal.94.1293062289812;
        Wed, 22 Dec 2010 15:58:09 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id o17sm1856712fal.1.2010.12.22.15.58.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:58:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNvWTp008184;
	Thu, 23 Dec 2010 00:57:42 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164108>



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

 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |  452 ++++++++++++++++++++++++
 t/t9511-gitweb-caching-interface.sh            |   34 ++
 t/t9511/test_cache_interface.pl                |  381 ++++++++++++++++++++
 3 files changed, 867 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/FileCacheWithLocking.pm
 create mode 100755 t/t9511-gitweb-caching-interface.sh
 create mode 100755 t/t9511/test_cache_interface.pl


diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
new file mode 100644
index 0000000..ecd0e18
--- /dev/null
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -0,0 +1,452 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+#
+# This program is licensed under the GPLv2
+
+#
+# Gitweb caching engine, file-based cache with flock-based entry locking
+#
+
+# Minimalistic cache that stores data in the filesystem, without serialization.
+# It uses file locks (flock) to have only one process generating data and
+# writing to cache, when using CHI-like interface ->compute_fh() method.
+
+package GitwebCache::FileCacheWithLocking;
+
+use strict;
+use warnings;
+
+use Carp;
+use File::Path qw(mkpath);
+use Digest::MD5 qw(md5_hex);
+use Fcntl qw(:flock);
+use POSIX qw(setsid);
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
+# anything less than 0 means to not expire
+#
+our $NEVER_EXPIRE = -1;
+
+# cache expiration of 0 means that entry is expired
+#
+our $EXPIRE_NOW = 0;
+
+# ......................................................................
+# constructor
+
+# The options are set by passing in hash or a reference to a hash containing
+# any of the following keys:
+#  * 'namespace'
+#    The namespace associated with this cache.  This allows easy separation of
+#    multiple, distinct caches without worrying about key collision.  Defaults
+#    to $DEFAULT_NAMESPACE.  Might be empty string.
+#  * 'cache_root' (Cache::FileCache compatibile),
+#    'root_dir' (CHI::Driver::File compatibile),
+#    The location in the filesystem that will hold the root of the cache.
+#    Defaults to $DEFAULT_CACHE_ROOT.
+#  * 'cache_depth' (Cache::FileCache compatibile),
+#    'depth' (CHI::Driver::File compatibile),
+#    The number of subdirectories deep to cache object item.  This should be
+#    large enough that no cache directory has more than a few hundred objects.
+#    Defaults to $DEFAULT_CACHE_DEPTH unless explicitly set.
+#  * 'default_expires_in' (Cache::Cache compatibile),
+#    'expires_in' (CHI compatibile) [seconds]
+#    The expiration time for objects place in the cache.
+#    Defaults to -1 (never expire) if not explicitly set.
+#  * 'max_lifetime' [seconds]
+#    If it is greater than 0, and cache entry is expired but not older
+#    than it, serve stale data when waiting for cache entry to be 
+#    regenerated (refreshed).  Non-adaptive.
+#  * 'on_error' (similar to CHI 'on_get_error'/'on_set_error')
+#    How to handle runtime errors occurring during cache gets and cache
+#    sets, which may or may not be considered fatal in your application.
+#    Options are:
+#    * "die" (the default) - call die() with an appropriate message
+#    * "warn" - call warn() with an appropriate message
+#    * "ignore" - do nothing
+#    * <coderef> - call this code reference with an appropriate message
+sub new {
+	my $class = shift;
+	my %opts = ref $_[0] ? %{ $_[0] } : @_;
+
+	my $self = {};
+	$self = bless($self, $class);
+
+	$self->{'root'} =
+		exists $opts{'cache_root'} ? $opts{'cache_root'} :
+		exists $opts{'root_dir'}   ? $opts{'root_dir'} :
+		$DEFAULT_CACHE_ROOT;
+	$self->{'depth'} =
+		exists $opts{'cache_depth'} ? $opts{'cache_depth'} :
+		exists $opts{'depth'}       ? $opts{'depth'} :
+		$DEFAULT_CACHE_DEPTH;
+	$self->{'namespace'} =
+		exists $opts{'namespace'} ? $opts{'namespace'} :
+		$DEFAULT_NAMESPACE;
+	$self->{'expires_in'} =
+		exists $opts{'default_expires_in'} ? $opts{'default_expires_in'} :
+		exists $opts{'expires_in'}         ? $opts{'expires_in'} :
+		$NEVER_EXPIRE;
+	$self->{'max_lifetime'} =
+		exists $opts{'max_lifetime'}       ? $opts{'max_lifetime'} :
+		exists $opts{'max_cache_lifetime'} ? $opts{'max_cache_lifetime'} :
+		$NEVER_EXPIRE;
+	$self->{'on_error'} =
+		exists $opts{'on_error'}      ? $opts{'on_error'} :
+		exists $opts{'on_get_error'}  ? $opts{'on_get_error'} :
+		exists $opts{'on_set_error'}  ? $opts{'on_set_error'} :
+		exists $opts{'error_handler'} ? $opts{'error_handler'} :
+		'die';
+
+	# validation could be put here
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
+foreach my $i (qw(depth root namespace expires_in max_lifetime
+                  on_error)) {
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
+# $path = $self->path_to_namespace();
+#
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
+# $self->ensure_path($dir);
+#
+# create $dir (directory) if it not exists, thus ensuring that path exists
+sub ensure_path {
+	my $self = shift;
+	my $dir = shift || return;
+
+	if (!-d $dir) {
+		# mkpath will croak()/die() if there is an error
+		mkpath($dir, 0, 0777);
+	}
+}
+
+# $filename = $self->get_lockname($key);
+#
+# Take an human readable key, and return path to be used for lockfile
+# Ensures that file can be created, if needed.
+sub get_lockname {
+	my ($self, $key) = @_;
+
+	my $lockfile = $self->path_to_key($key, \my $dir) . '.lock';
+
+	# ensure that directory leading to lockfile exists
+	$self->ensure_path($dir);
+
+	return $lockfile;
+}
+
+# ----------------------------------------------------------------------
+# "private" utility functions and methods
+
+# ($fh, $filename) = $self->_tempfile_to_path($path_for_key, $dir_for_key);
+#
+# take a file path to cache entry, and its directory
+# return filehandle and filename of open temporary file,
+# like File::Temp::tempfile
+sub _tempfile_to_path {
+	my ($self, $file, $dir) = @_;
+
+	my $tempname = "$file.tmp";
+	open my $temp_fh, '>', $tempname
+		or die "Couldn't open temporary file '$tempname' for writing: $!";
+
+	return ($temp_fh, $tempname);
+}
+
+# ($fh, $filename) = $self->_wait_for_data($key, $code);
+#
+# Wait for data to be available using (blocking) $code,
+# then return filehandle and filename to read from for $key.
+sub _wait_for_data {
+	my ($self, $key, $sync_coderef) = @_;
+	my @result;
+
+	# wait for data to be available
+	$sync_coderef->();
+	# fetch data
+	@result = $self->fetch_fh($key);
+
+	return @result;
+}
+
+# $self->_handle_error($raw_error)
+#
+# based on _handle_get_error and _dispatch_error_msg from CHI::Driver
+sub _handle_error {
+	my ($self, $error) = @_;
+
+	for ($self->get_on_error()) {
+		(ref($_) eq 'CODE') && do { $_->($error) };
+		/^ignore$/ && do { };
+		/^warn$/   && do { carp $error };
+		/^die$/    && do { croak $error };
+	}
+}
+
+# ----------------------------------------------------------------------
+# nonstandard worker and semi-interface methods
+
+# ($fh, $filename) = $self->fetch_fh($key);
+#
+# Get filehandle to read from for given $key, and filename of cache file.
+# Doesn't check if entry expired.
+sub fetch_fh {
+	my ($self, $key) = @_;
+
+	my $path = $self->path_to_key($key);
+	return unless (defined $path);
+
+	open my $fh, '<', $path or return;
+	return ($fh, $path);
+}
+
+# ($fh, $filename) = $self->get_fh($key, [option => value, ...])
+#
+# Returns filehandle to read from for given $key, and filename of cache file.
+# Returns empty list if entry expired.
+#
+# $key may be followed by one or more name/value parameters:
+# * expires_in [DURATION] - override global expiration time
+sub get_fh {
+	my ($self, $key, %opts) = @_;
+
+	return unless ($self->is_valid($key, $opts{'expires_in'}));
+
+	return $self->fetch_fh($key);
+}
+
+# [($fh, $filename) =] $self->set_coderef_fh($key, $code_fh);
+#
+# Runs $code_fh, passing to it $fh and $filename of file to write to;
+# the contents of this file would be contents of cache entry.
+# Returns what $self->fetch_fh($key) would return.
+sub set_coderef_fh {
+	my ($self, $key, $code) = @_;
+
+	my $path = $self->path_to_key($key, \my $dir);
+	return unless (defined $path && defined $dir);
+
+	# ensure that directory leading to cache file exists
+	$self->ensure_path($dir);
+
+	# generate a temporary file / file to write to
+	my ($fh, $tempfile) = $self->_tempfile_to_path($path, $dir);
+
+	# code writes to filehandle or file
+	$code->($fh, $tempfile);
+
+	close $fh;
+	rename($tempfile, $path)
+		or die "Couldn't rename temporary file '$tempfile' to '$path': $!";
+
+	open $fh, '<', $path or return;
+	return ($fh, $path);
+}
+
+# ======================================================================
+# ......................................................................
+# interface methods
+#
+# note that only those methods use 'on_error' handler;
+# all the rest just use "die"
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
+		or $self->_handle_error("Couldn't remove cache entry file '$file' for key '$key': $!");
+}
+
+# $cache->is_valid($key[, $expires_in])
+#
+# Returns a boolean indicating whether $key exists in the cache
+# and has not expired.  Uses global per-cache expires time, unless
+# passed optional $expires_in argument.
+sub is_valid {
+	my ($self, $key, $expires_in) = @_;
+
+	my $path = $self->path_to_key($key);
+
+	# does file exists in cache?
+	return 0 unless -f $path;
+	# get its modification time
+	my $mtime = (stat(_))[9] # _ to reuse stat structure used in -f test
+		or $self->_handle_error("Couldn't stat file '$path' for key '$key': $!");
+
+	# expire time can be set to never
+	$expires_in = defined $expires_in ? $expires_in : $self->get_expires_in();
+	return 1 unless (defined $expires_in && $expires_in >= 0);
+
+	# is file expired?
+	my $now = time();
+
+	return (($now - $mtime) < $expires_in);
+}
+
+# Getting and setting
+
+# ($fh, $filename) = $cache->compute_fh($key, $code);
+#
+# Combines the get and set operations in a single call.  Attempts to
+# get $key; if successful, returns the filehandle it can be read from.
+# Otherwise, calls $code passing filehandle to write to as a
+# parameter; contents of this file is then used as the new value for
+# $key; returns filehandle from which one can read newly generated data.
+#
+# Uses file locking to have only one process updating value for $key
+# to avoid 'cache miss stampede' (aka 'stampeding herd') problem.
+sub compute_fh {
+	my ($self, $key, $code_fh) = @_;
+
+	my @result = eval { $self->get_fh($key) };
+	return @result if @result;
+	$self->_handle_error($@) if $@;
+
+	my $lockfile = $self->get_lockname($key);
+
+	# this loop is to protect against situation where process that
+	# acquired exclusive lock (writer) dies or exits
+	# before writing data to cache
+	my $lock_state; # needed for loop condition
+	do {
+		open my $lock_fh, '+>', $lockfile
+			or $self->_handle_error("Could't open lockfile '$lockfile': $!");
+
+		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
+		if ($lock_state) {
+			## acquired writers lock, have to generate data
+			@result = eval { $self->set_coderef_fh($key, $code_fh) };
+			$self->_handle_error($@) if $@;
+
+			# closing lockfile releases writer lock
+			flock($lock_fh, LOCK_UN);
+			close $lock_fh
+				or $self->_handle_error("Could't close lockfile '$lockfile': $!");
+
+		} else {
+			## didn't acquire writers lock, get stale data or wait for regeneration
+
+			# try to retrieve stale data
+			eval {
+				@result = $self->get_fh($key,
+					'expires_in' => $self->get_max_lifetime());
+			};
+			return @result if @result;
+			$self->_handle_error($@) if $@;
+
+			# wait for regeneration if no stale data to serve,
+			# using shared / readers lock to sync (wait for data)
+			@result = eval {
+				$self->_wait_for_data($key, sub {
+					flock($lock_fh, LOCK_SH);
+				});
+			};
+			$self->_handle_error($@) if $@;
+			# closing lockfile releases readers lock
+			flock($lock_fh, LOCK_UN);
+			close $lock_fh
+				or $self->_handle_error("Could't close lockfile '$lockfile': $!");
+
+		}
+	} until (@result || $lock_state);
+	# repeat until we have data, or we tried generating data oneself and failed
+	return @result;
+}
+
+
+1;
+__END__
+# end of package GitwebCache::FileCacheWithLocking;
diff --git a/t/t9511-gitweb-caching-interface.sh b/t/t9511-gitweb-caching-interface.sh
new file mode 100755
index 0000000..d8fc946
--- /dev/null
+++ b/t/t9511-gitweb-caching-interface.sh
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
+	'GitwebCache::*Cache* Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9511/test_cache_interface.pl
+
+test_done
diff --git a/t/t9511/test_cache_interface.pl b/t/t9511/test_cache_interface.pl
new file mode 100755
index 0000000..a2b006c
--- /dev/null
+++ b/t/t9511/test_cache_interface.pl
@@ -0,0 +1,381 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use POSIX qw(dup2);
+use Fcntl qw(:DEFAULT);
+use IO::Handle;
+use IO::Select;
+use IO::Pipe;
+use File::Basename;
+
+use Test::More;
+
+# test installed version or source version
+use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
+
+
+# Test creating a cache
+#
+BEGIN { use_ok('GitwebCache::FileCacheWithLocking'); }
+note("Using lib '$INC[0]'");
+note("Testing '$INC{'GitwebCache/FileCacheWithLocking.pm'}'");
+
+my $cache = new_ok('GitwebCache::FileCacheWithLocking');
+
+# Test that default values are defined
+#
+ok(defined $GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_ROOT,
+	'$GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_ROOT defined');
+ok(defined $GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_DEPTH,
+	'$GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_DEPTH defined');
+
+# Test some accessors and some default values for cache
+#
+SKIP: {
+	skip 'default values not defined', 2
+		unless ($GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_ROOT &&
+		        $GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_DEPTH);
+
+	cmp_ok($cache->get_root(),  'eq', $GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_ROOT,
+		"default cache root is '$GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_ROOT'");
+	cmp_ok($cache->get_depth(), '==', $GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_DEPTH,
+		"default cache depth is $GitwebCache::FileCacheWithLocking::DEFAULT_CACHE_DEPTH");
+}
+
+# Test the getting and setting of a cached value,
+# and removal of a cached value
+#
+my $key   = 'Test Key';
+my $value = 'Test Value';
+
+my $call_count = 0;
+sub get_value_fh {
+	my $fh = shift;
+	$call_count++;
+	print {$fh} $value;
+}
+
+# use ->compute_fh($key, $code_fh) interface
+sub cache_compute_fh {
+	my ($cache, $key, $code_fh) = @_;
+
+	my ($fh, $filename) = $cache->compute_fh($key, $code_fh);
+	return unless $fh;
+
+	local $/ = undef;
+	return <$fh>;
+}
+
+# use ->get_fh($key) interface
+sub cache_get_fh {
+	my ($cache, $key) = @_;
+
+	my ($fh, $filename) = $cache->get_fh($key);
+	return unless $fh;
+
+	local $/ = undef;
+	return <$fh>;
+}
+
+# use ->set_coderef_fh($key, $code_fh) to set $key to $value
+sub cache_set_fh {
+	my ($cache, $key, $value) = @_;
+
+	$cache->set_coderef_fh($key, sub { print {$_[0]} $value });
+	return $value;
+}
+
+subtest 'compute_fh interface' => sub {
+	foreach my $method (qw(remove compute_fh)) {
+		can_ok($cache, $method);
+	}
+
+	eval { $cache->remove('Not-Existent Key'); };
+	ok(!$@, 'remove on non-existent key doesn\'t die');
+	diag($@) if $@;
+
+	$cache->remove($key); # just in case
+	is(cache_compute_fh($cache, $key, \&get_value_fh), $value,
+	   "compute_fh 1st time (set) returns '$value'");
+	is(cache_compute_fh($cache, $key, \&get_value_fh), $value,
+	   "compute_fh 2nd time (get) returns '$value'");
+	is(cache_compute_fh($cache, $key, \&get_value_fh), $value,
+	   "compute_fh 3rd time (get) returns '$value'");
+	cmp_ok($call_count, '==', 1, 'get_value_fh() is called once from compute_fh');
+
+	done_testing();
+};
+
+
+# Test cache expiration
+#
+subtest 'cache expiration' => sub {
+	$cache->set_expires_in(60*60*24); # set expire time to 1 day
+	cmp_ok($cache->get_expires_in(), '>', 0, '"expires in" is greater than 0 (set to 1d)');
+	$call_count = 0;
+	cache_compute_fh($cache, $key, \&get_value_fh);
+	cmp_ok($call_count, '==', 0, 'compute_fh didn\'t need to compute data (not expired in 1d)');
+	is(cache_get_fh($cache, $key), $value, 'get_fh returns cached value (not expired in 1d)');
+
+	$cache->set_expires_in(-1); # set expire time to never expire
+	is($cache->get_expires_in(), -1,         '"expires in" is set to never (-1)');
+	is(cache_get_fh($cache, $key), $value,   'get returns cached value (not expired)');
+
+	$cache->set_expires_in(0);
+	is($cache->get_expires_in(),  0,         '"expires in" is set to now (0)');
+	ok(!defined(cache_get_fh($cache, $key)), 'cache is expired, get_fh returns undef');
+	cache_compute_fh($cache, $key, \&get_value_fh);
+	cmp_ok($call_count, '==', 1,             'compute_fh computed and set data');
+
+	done_testing();
+};
+
+
+# ----------------------------------------------------------------------
+# CONCURRENT ACCESS
+sub parallel_run (&); # forward declaration of prototype
+
+# Test 'stampeding herd' / 'cache miss stampede' problem
+#
+my $slow_time = 1; # how many seconds to sleep in mockup of slow generation
+sub get_value_slow_fh {
+	my $fh = shift;
+
+	$call_count++;
+	sleep $slow_time;
+	print {$fh} $value;
+}
+sub get_value_die {
+	$call_count++;
+	die "get_value_die\n";
+}
+my $lock_file = "$0.$$.lock"; # if exists then get_value_die_once_fh was already called
+sub get_value_die_once_fh {
+	if (sysopen my $lock_fh, $lock_file, (O_WRONLY | O_CREAT | O_EXCL)) {
+		close $lock_fh;
+		die "get_value_die_once_fh\n";
+	} else {
+		get_value_slow_fh(@_);
+	}
+}
+
+my @output;    # gathers output from concurrent invocations
+my $sep = '|'; # separate different parts of data for tests
+my $total_count = 0; # number of calls around all concurrent invocations
+
+note("Following tests contain artifical delay of $slow_time seconds");
+subtest 'parallel access' => sub {
+
+	$cache->remove($key);
+	@output = parallel_run {
+		$call_count = 0;
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print $data if defined $data;
+		print "$sep$call_count";
+	};
+	$total_count = 0;
+	foreach (@output) {
+		my ($child_out, $child_count) = split(quotemeta $sep, $_);
+		$total_count += $child_count;
+	}
+	cmp_ok($total_count, '==', 1, 'parallel compute_fh: get_value_slow_fh() called only once');
+	# extract only data, without child count
+	@output = map { s/\Q$sep\E.*$//; $_ } @output;
+	is_deeply(
+		\@output,
+		[ ($value) x 2 ],
+		"parallel compute_fh: both returned '$value'"
+	);
+
+	$cache->set_on_error(sub { die @_; });
+	eval {
+		local $SIG{ALRM} = sub { die "alarm\n"; };
+		alarm 4*$slow_time;
+
+		@output = parallel_run {
+			$call_count = 0;
+			my $data = eval { cache_compute_fh($cache, 'No Key', \&get_value_die); };
+			my $eval_error = $@;
+			print "$data" if defined $data;
+			print "$sep";
+			print "$eval_error" if $eval_error;
+		};
+		is_deeply(
+			\@output,
+			[ ( "${sep}get_value_die\n" ) x 2 ],
+			'parallel compute_fh: get_value_die() died in both'
+		);
+
+		alarm 0;
+	};
+	ok(!$@, 'parallel compute_fh: no alarm call (neither process hung)');
+	diag($@) if $@;
+
+	$cache->remove($key);
+	unlink($lock_file);
+	@output = parallel_run {
+		my $data = eval { cache_compute_fh($cache, $key, \&get_value_die_once_fh); };
+		my $eval_error = $@;
+		print "$data" if defined $data;
+		print "$sep";
+		print "$eval_error" if $eval_error;
+	};
+	is_deeply(
+		[sort @output],
+		[sort ("$value$sep", "${sep}get_value_die_once_fh\n")],
+		'parallel compute_fh: return correct value even if other process died'
+	);
+	unlink($lock_file);
+
+	done_testing();
+};
+
+
+# Test that cache returns stale data in existing but expired cache situation
+#
+my $stale_value = 'Stale Value';
+
+subtest 'serving stale data when regenerating' => sub {
+	cache_set_fh($cache, $key, $stale_value);
+	$cache->set_expires_in(-1);   # never expire, for next check
+	is(cache_get_fh($cache, $key), $stale_value,
+	   'stale value set (prepared) correctly');
+
+	$call_count = 0;
+	$cache->set_expires_in(0);    # expire now (so there are no fresh data)
+	$cache->set_max_lifetime(-1); # forever (always serve stale data)
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print "$call_count$sep";
+		print $data if defined $data;
+	};
+	# returning stale data works
+	is_deeply(
+		[sort @output],
+		[sort ("0$sep$stale_value", "1$sep$value")],
+		'no background: stale data returned by one process (the one not generating data)'
+	);
+	$cache->set_expires_in(-1); # never expire for next ->get
+	is(cache_get_fh($cache, $key), $value,
+	   'no background: value got set correctly, even if stale data returned');
+
+
+	cache_set_fh($cache, $key, $stale_value);
+	$cache->set_expires_in(0);   # expire now
+	$cache->set_max_lifetime(0); # don't serve stale data
+
+	@output = parallel_run {
+		my $data = cache_compute_fh($cache, $key, \&get_value_slow_fh);
+		print $data;
+	};
+	# no returning stale data
+	ok(!scalar(grep { $_ eq $stale_value } @output),
+	   'no stale data if configured');
+
+
+	done_testing();
+};
+$cache->set_expires_in(-1);
+
+
+done_testing();
+
+
+#######################################################################
+#######################################################################
+#######################################################################
+
+# from http://aaroncrane.co.uk/talks/pipes_and_processes/
+sub fork_child (&) {
+	my ($child_process_code) = @_;
+
+	my $pid = fork();
+	die "Failed to fork: $!\n" if !defined $pid;
+
+	return $pid if $pid != 0;
+
+	# Now we're in the new child process
+	$child_process_code->();
+	exit;
+}
+
+sub parallel_run (&) {
+	my $child_code = shift;
+	my $nchildren = 2;
+
+	my %children;
+	my (%pid_for_child, %fd_for_child);
+	my $sel = IO::Select->new();
+	foreach my $child_idx (1..$nchildren) {
+		my $pipe = IO::Pipe->new()
+			or die "Failed to create pipe: $!\n";
+
+		my $pid = fork_child {
+			$pipe->writer()
+				or die "$$: Child \$pipe->writer(): $!\n";
+			dup2(fileno($pipe), fileno(STDOUT))
+				or die "$$: Child $child_idx failed to reopen stdout to pipe: $!\n";
+			close $pipe
+				or die "$$: Child $child_idx failed to close pipe: $!\n";
+
+			# From Test-Simple-0.96/t/subtest/fork.t
+			#
+			# Force all T::B output into the pipe (redirected to STDOUT),
+			# for the parent builder as well as the current subtest builder.
+			{
+				no warnings 'redefine';
+				*Test::Builder::output         = sub { *STDOUT };
+				*Test::Builder::failure_output = sub { *STDOUT };
+				*Test::Builder::todo_output    = sub { *STDOUT };
+			}
+
+			$child_code->();
+
+			*STDOUT->flush();
+			close(STDOUT);
+		};
+
+		$pid_for_child{$pid} = $child_idx;
+		$pipe->reader()
+			or die "Failed to \$pipe->reader(): $!\n";
+		$fd_for_child{$pipe} = $child_idx;
+		$sel->add($pipe);
+
+		$children{$child_idx} = {
+			'pid'    => $pid,
+			'stdout' => $pipe,
+			'output' => '',
+		};
+	}
+
+	while (my @ready = $sel->can_read()) {
+		foreach my $fh (@ready) {
+			my $buf = '';
+			my $nread = sysread($fh, $buf, 1024);
+
+			exists $fd_for_child{$fh}
+				or die "Cannot find child for fd: $fh\n";
+
+			if ($nread > 0) {
+				$children{$fd_for_child{$fh}}{'output'} .= $buf;
+			} else {
+				$sel->remove($fh);
+			}
+		}
+	}
+
+	while (%pid_for_child) {
+		my $pid = waitpid -1, 0;
+		warn "Child $pid_for_child{$pid} ($pid) failed with status: $?\n"
+			if $? != 0;
+		delete $pid_for_child{$pid};
+	}
+
+	return map { $children{$_}{'output'} } keys %children;
+}
+
+__END__
