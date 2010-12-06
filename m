From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 20/24] gitweb/lib - Add support for setting error handler in cache
Date: Tue,  7 Dec 2010 00:11:05 +0100
Message-ID: <1291677069-6559-21-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkL3-0003IR-QB
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0LFXTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:19:10 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:52756 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0LFXTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:19:09 -0500
Received: by mail-ey0-f171.google.com with SMTP id 5so8019446eyg.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JAulONxyCu2zR0U69x+eZvJ6h0vvhwXb21//CjCQjJ0=;
        b=a73MkCYFWQlAdHyDdpoSsg4FKjgQSdl1SzNHhZLVyW6LFl2l/GiHCpXcbhBt/46JJo
         ApAAYD21XUx6lDyq3bhQQaDU69SlGnzKy+vOnvEsHC0OI1RQXnAn/JRB68icdGNa9GVE
         pBQSaT1XLzChO89qox4+ZGXYlsvLY/gh9OewA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ui5Nj9rDkKZUlGnDIKiJVYg5CHLTKqGUBLRJ9sEGI8tHkhYPzgVLR29Uz9J11R2gvQ
         Q2RRH0UzvOQ2LeRliJQI3eC39z9hQ8PIaeWME8xBJHBIZ/ondcx1G/TlsPOwj0JR2t29
         rkD3FOfmyShstdHLY9dKkkP7urBAmv6TLEej8=
Received: by 10.213.3.20 with SMTP id 20mr5046143ebl.89.1291677152465;
        Mon, 06 Dec 2010 15:12:32 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:31 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163054>

GitwebCache::SimpleFileCache and GitwebCache::FileCacheWithLocking
acquired support for 'on_error'/'error_handler' parameter, which
accepts the same values as 'on_get_error' and 'on_set_error' option in
CHI, with exception of support for "log".  The default is "die" (as it
was before), though it now uses "croak" from Carp, rather than plain
"die".

Added basic test for 'on_error' in t9503: setting it to error handler
that dies, and setting it to 'ignore'.


The way error handler coderef is invoked is slightly different from
the way CHI does it: the error handler doesn't pass key and raw error
message as subsequent parameters.

Because '$self->_handle_error($msg)' is used in place of 'die $msg',
read_file and write_fh subroutines had to be converted to methods, to
have access to $self.  Alternate solution would be to catch errors
using "eval BLOCK" in ->get() and ->set() etc., like in CHI::Driver.

Note that external subroutines that croak()/die() on error (like
'mkpath' or 'tempfile') are now wrapped in eval block (this would be
not necessary if alternate solution described above was used).


While at it refactor ensuring that directory exists (for opening file
for writing, possibly creating it) into ->ensure_path($dir) method.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This and the next patch are new and were not present in previous version
of this series.  That is why this and next patch are marked as RFC.

The way CHI does it, by wrapping commands in eval { ... } (or using
Try::Tiny) in ->get, ->set (and in our case also ->compute and
->compute_fh, as those no longer are defined in term of ->get and ->set,
or ->get/->set-like operations) could be a better solution.  Some
dicsussion / thinking on it is required.


In "Gitweb caching v7" series cache.pl / cache.pm used die_error
directly, and that is why it couldn't be a proper Perl module, and why
it had to be loaded using 'do <file>' rather than 'require <package>'.

Note however that compared to "Gitweb caching v7" in this patch we
leak more, possibly sensitive, information like exact file that was
attempted to open and location in source file.  OTOH it helps
debugging errors in gitweb.


Note that we might want to treat on_set_error and on_get_error
differently, especially ENOSPC (No space left on device) on set.
This is left for (optionally) the future commit.

 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   25 ++++---
 gitweb/lib/GitwebCache/SimpleFileCache.pm      |   88 +++++++++++++++++------
 t/t9503/test_cache_interface.pl                |   44 ++++++++++++
 3 files changed, 124 insertions(+), 33 deletions(-)

diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 0823c55..d994b3a 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -63,6 +63,14 @@ use POSIX qw(setsid);
 #  * 'increase_factor' [seconds / 100% CPU load]
 #    Factor multiplying 'check_load' result when calculating cache lietime.
 #    Defaults to 60 seconds for 100% SPU load ('check_load' returning 1.0).
+#  * 'on_error' (similar to CHI 'on_get_error'/'on_set_error')
+#    How to handle runtime errors occurring during cache gets and cache
+#    sets, which may or may not be considered fatal in your application.
+#    Options are:
+#    * "die" (the default) - call die() with an appropriate message
+#    * "warn" - call warn() with an appropriate message
+#    * "ignore" - do nothing
+#    * <coderef> - call this code reference with an appropriate message
 #
 # (all the above are inherited from GitwebCache::SimpleFileCache)
 #
@@ -155,10 +163,7 @@ sub get_lockname {
 	my $lockfile = $self->path_to_key($key, \my $dir) . '.lock';
 
 	# ensure that directory leading to lockfile exists
-	if (!-d $dir) {
-		eval { mkpath($dir, 0, 0777); 1 }
-			or die "Couldn't mkpath '$dir' for lockfile: $!";
-	}
+	$self->ensure_path($dir);
 
 	return $lockfile;
 }
@@ -174,7 +179,7 @@ sub _tempfile_to_path {
 
 	my $tempname = "$file.tmp";
 	open my $temp_fh, '>', $tempname
-		or die "Couldn't open temporary file '$tempname' for writing: $!";
+		or $self->_handle_error("Couldn't open temporary file '$tempname' for writing: $!");
 
 	return ($temp_fh, $tempname);
 }
@@ -199,10 +204,10 @@ sub _wait_for_data {
 	if ($fetch_locked) {
 		@result = $fetch_code->();
 		close $lock_fh
-			or die "Could't close lockfile '$lockfile': $!";
+			or $self->_handle_error("Could't close lockfile '$lockfile': $!");
 	} else {
 		close $lock_fh
-			or die "Could't close lockfile '$lockfile': $!";
+			or $self->_handle_error("Could't close lockfile '$lockfile': $!");
 		@result = $fetch_code->();
 	}
 
@@ -273,7 +278,7 @@ sub _compute_generic {
 	my $lock_state; # needed for loop condition
 	do {
 		open my $lock_fh, '+>', $lockfile
-			or die "Could't open lockfile '$lockfile': $!";
+			or $self->_handle_error("Could't open lockfile '$lockfile': $!");
 
 		$lock_state = flock($lock_fh, LOCK_EX | LOCK_NB);
 		if ($lock_state) {
@@ -282,12 +287,12 @@ sub _compute_generic {
 
 			# closing lockfile releases writer lock
 			close $lock_fh
-				or die "Could't close lockfile '$lockfile': $!";
+				or $self->_handle_error("Could't close lockfile '$lockfile': $!");
 
 			if (!@result) {
 				# wait for background process to finish generating data
 				open $lock_fh, '<', $lockfile
-					or die "Couldn't reopen (for reading) lockfile '$lockfile': $!";
+					or $self->_handle_error("Couldn't reopen (for reading) lockfile '$lockfile': $!");
 
 				@result = $self->_wait_for_data($key, $lock_fh, $lockfile,
 				                                $fetch_code, $fetch_locked);
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 21ec434..8d0a6d9 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -20,6 +20,7 @@ package GitwebCache::SimpleFileCache;
 use strict;
 use warnings;
 
+use Carp;
 use File::Path qw(mkpath);
 use File::Temp qw(tempfile);
 use Digest::MD5 qw(md5_hex);
@@ -77,6 +78,14 @@ our $DEFAULT_NAMESPACE = '';
 #  * 'increase_factor' [seconds / 100% CPU load]
 #    Factor multiplying 'check_load' result when calculating cache lietime.
 #    Defaults to 60 seconds for 100% SPU load ('check_load' returning 1.0).
+#  * 'on_error' (similar to CHI 'on_get_error'/'on_set_error')
+#    How to handle runtime errors occurring during cache gets and cache
+#    sets, which may or may not be considered fatal in your application.
+#    Options are:
+#    * "die" (the default) - call die() with an appropriate message
+#    * "warn" - call warn() with an appropriate message
+#    * "ignore" - do nothing
+#    * <coderef> - call this code reference with an appropriate message
 sub new {
 	my $class = shift;
 	my %opts = ref $_[0] ? %{ $_[0] } : @_;
@@ -86,6 +95,7 @@ sub new {
 
 	my ($root, $depth, $ns);
 	my ($expires_min, $expires_max, $increase_factor, $check_load);
+	my ($on_error);
 	if (%opts) {
 		$root =
 			$opts{'cache_root'} ||
@@ -102,6 +112,11 @@ sub new {
 			$opts{'expires_max'};
 		$increase_factor = $opts{'expires_factor'};
 		$check_load      = $opts{'check_load'};
+		$on_error =
+			$opts{'on_error'} ||
+			$opts{'on_get_error'} ||
+			$opts{'on_set_error'} ||
+			$opts{'error_handler'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
@@ -111,6 +126,9 @@ sub new {
 		if (!defined($expires_max) && exists $opts{'expires_in'});
 	$expires_max = -1 unless (defined($expires_max));
 	$increase_factor = 60 unless defined($increase_factor);
+	$on_error = "die"
+		unless (defined $on_error &&
+		        (ref($on_error) eq 'CODE' || $on_error =~ /^die|warn|ignore$/));
 
 	$self->set_root($root);
 	$self->set_depth($depth);
@@ -119,6 +137,7 @@ sub new {
 	$self->set_expires_max($expires_max);
 	$self->set_increase_factor($increase_factor);
 	$self->set_check_load($check_load);
+	$self->set_on_error($on_error);
 
 	return $self;
 }
@@ -131,7 +150,8 @@ sub new {
 
 # creates get_depth() and set_depth($depth) etc. methods
 foreach my $i (qw(depth root namespace
-                  expires_min expires_max increase_factor check_load)) {
+                  expires_min expires_max increase_factor check_load
+                  on_error)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -234,7 +254,7 @@ sub path_to_key {
 }
 
 sub read_file {
-	my $filename = shift;
+	my ($self, $filename) = @_;
 
 	# Fast slurp, adapted from File::Slurp::read, with unnecessary options removed
 	# via CHI::Driver::File (from CHI-0.33)
@@ -255,12 +275,12 @@ sub read_file {
 	}
 
 	close $read_fh
-		or die "Couldn't close file '$filename' opened for reading: $!";
+		or $self->_handle_error("Couldn't close file '$filename' opened for reading: $!");
 	return $buf;
 }
 
 sub write_fh {
-	my ($write_fh, $filename, $data) = @_;
+	my ($self, $write_fh, $filename, $data) = @_;
 
 	# Fast spew, adapted from File::Slurp::write, with unnecessary options removed
 	# via CHI::Driver::File (from CHI-0.33)
@@ -278,7 +298,20 @@ sub write_fh {
 	}
 
 	close $write_fh
-		or die "Couldn't close file '$filename' opened for writing: $!";
+		or $self->_handle_error("Couldn't close file '$filename' opened for writing: $!");
+}
+
+sub ensure_path {
+	my $self = shift;
+	my $dir = shift || return;
+
+	if (!-d $dir) {
+		# mkpath will croak()/die() if there is an error
+		eval {
+			mkpath($dir, 0, 0777);
+			1;
+		} or $self->_handle_error($@);
+	}
 }
 
 # ----------------------------------------------------------------------
@@ -291,12 +324,27 @@ sub _tempfile_to_path {
 	my ($self, $file, $dir) = @_;
 
 	# tempfile will croak() if there is an error
-	return tempfile("${file}_XXXXX",
-		#DIR => $dir,
-		'UNLINK' => 0, # ensure that we don't unlink on close; file is renamed
-		'SUFFIX' => '.tmp');
+	my ($temp_fh, $tempname);
+	eval {
+		($temp_fh, $tempname) = tempfile("${file}_XXXXX",
+			#DIR => $dir,
+			'UNLINK' => 0, # ensure that we don't unlink on close; file is renamed
+			'SUFFIX' => '.tmp');
+	} or $self->_handle_error($@);
+	return ($temp_fh, $tempname);
 }
 
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
 
 # ----------------------------------------------------------------------
 # worker methods
@@ -307,7 +355,7 @@ sub fetch {
 	my $file = $self->path_to_key($key);
 	return unless (defined $file && -f $file);
 
-	return read_file($file);
+	return $self->read_file($file);
 }
 
 sub store {
@@ -318,20 +366,17 @@ sub store {
 	return unless (defined $file && defined $dir);
 
 	# ensure that directory leading to cache file exists
-	if (!-d $dir) {
-		# mkpath will croak()/die() if there is an error
-		mkpath($dir, 0, 0777);
-	}
+	$self->ensure_path($dir);
 
 	# generate a temporary file
 	my ($temp_fh, $tempname) = $self->_tempfile_to_path($file, $dir);
 	chmod 0666, $tempname
 		or warn "Couldn't change permissions to 0666 / -rw-rw-rw- for '$tempname': $!";
 
-	write_fh($temp_fh, $tempname, $data);
+	$self->write_fh($temp_fh, $tempname, $data);
 
 	rename($tempname, $file)
-		or die "Couldn't rename temporary file '$tempname' to '$file': $!";
+		or $self->_handle_error("Couldn't rename temporary file '$tempname' to '$file': $!");
 }
 
 # get size of an element associated with the $key (not the size of whole cache)
@@ -362,7 +407,7 @@ sub remove {
 		or return;
 	return unless -f $file;
 	unlink($file)
-		or die "Couldn't remove file '$file': $!";
+		or $self->_handle_error("Couldn't remove file '$file': $!");
 }
 
 # $cache->is_valid($key[, $expires_in])
@@ -379,7 +424,7 @@ sub is_valid {
 	return 0 unless -f $path;
 	# get its modification time
 	my $mtime = (stat(_))[9] # _ to reuse stat structure used in -f test
-		or die "Couldn't stat file '$path': $!";
+		or $self->_handle_error("Couldn't stat file '$path': $!");
 	# cache entry is invalid if it is size 0 (in bytes)
 	return 0 unless ((stat(_))[7] > 0);
 
@@ -468,10 +513,7 @@ sub set_coderef_fh {
 	return unless (defined $path && defined $dir);
 
 	# ensure that directory leading to cache file exists
-	if (!-d $dir) {
-		# mkpath will croak()/die() if there is an error
-		mkpath($dir, 0, 0777);
-	}
+	$self->ensure_path($dir);
 
 	# generate a temporary file
 	my ($fh, $tempfile) = $self->_tempfile_to_path($path, $dir);
@@ -481,7 +523,7 @@ sub set_coderef_fh {
 
 	close $fh;
 	rename($tempfile, $path)
-		or die "Couldn't rename temporary file '$tempfile' to '$path': $!";
+		or $self->_handle_error("Couldn't rename temporary file '$tempfile' to '$path': $!");
 
 	open $fh, '<', $path or return;
 	return ($fh, $path);
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 480cfbc..28a5c5e 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -9,6 +9,7 @@ use Fcntl qw(:DEFAULT);
 use IO::Handle;
 use IO::Select;
 use IO::Pipe;
+use File::Basename;
 
 use Test::More;
 
@@ -475,6 +476,49 @@ subtest 'generating progress info' => sub {
 $cache->set_expires_in(-1);
 
 
+# ----------------------------------------------------------------------
+# ERROR HANDLING
+
+# Test 'on_error' handler
+#
+sub test_handler {
+	die "test_handler\n"; # newline needed
+}
+SKIP: {
+	# prepare error condition
+	my $is_prepared = 1;
+	$is_prepared &&= $cache->set($key, $value);
+	$is_prepared &&= chmod 0555, dirname($cache->path_to_key($key));
+
+	my $ntests = 1; # in subtest
+	skip "could't prepare error condition for 'on_error' tests", $ntests
+		unless $is_prepared;
+	skip "cannot test reliably 'on_error' as root (id=$>)", $ntests
+		unless $> != 0;
+
+	subtest 'error handler' => sub {
+		my ($result, $error);
+
+		# check that error handler works
+		$cache->set_on_error(\&test_handler);
+		$result = eval {
+			$cache->remove($key);
+		} or $error = $@;
+		ok(!defined $result,         'on_error: died on error (via handler)');
+		diag("result is $result") if defined $result;
+		is($error, "test_handler\n", 'on_error: test_handler was used');
+
+		# check that "ignore" works
+		$cache->set_on_error('ignore');
+		$result = eval {
+			$cache->remove($key);
+		} or $error = $@;
+		ok(defined $result,          'on_error: error ignored if requested');
+	};
+}
+chmod 0777, dirname($cache->path_to_key($key));
+
+
 done_testing();
 
 
-- 
1.7.3
