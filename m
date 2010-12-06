From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11/24] gitweb/lib - capture output directly to cache entry file
Date: Tue,  7 Dec 2010 00:10:56 +0100
Message-ID: <1291677069-6559-12-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEP-0008RS-W1
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0LFXMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:16 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab0LFXMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:09 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7MOv4ecdgU1/+cJjL1KpebuuFbefOJBATNN0LdnJKlU=;
        b=KYrpWBtdrv4wqseqWxQiAw2TZnxBi+br0E+MD1l0KANoRJ6/QjPNtPaz0Xir5+W195
         AKqqr9gCE4pP8YuU6O4oX0G0l+f1XhGAjrNktEzE5xPRBD14/JB04W6ZIh41D8A+HU2v
         UeR2dL2rzDXw4xruKS+FHAGAbWZXuMKf1L3uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nl70sB3tbGhHk816LSOZ62lM9yjyrAUgVFNRnk25QXyG0mwdOz4eve7ucwrr6YMcgb
         6omJL48uLUPgXdVjc55/bfp0W8ph8KnwBMEfp2sEHPMGWV+M/tNWrtrNApg8BMgfpE52
         r0gfIVCqYADeVwrAOj6TTtfT/WOxMJ1w2HxbE=
Received: by 10.213.29.12 with SMTP id o12mr6701202ebc.41.1291677128755;
        Mon, 06 Dec 2010 15:12:08 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:08 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163037>

This commit makes it possible to capture output redirecting STDOUT to
cache entry file; this way we don't need to store whole output in
memory in order to cache it.

The ->capture() method in GitwebCache::Capture::Simple is extended so
it signature is now ->capture($code[, $to]).  This means that it
accepts optional $to parameter, which specifies either filehandle open
for writing, or a file name, which would be used to capture output
instead of in-memory file.  The ->capture_start() and ->capture_stop()
methods that are used by ->capture() also got updated.

GitwebCache::SimpleFileCache acquired new ->compute_fh($key, $code_fh)
method.  Instead of passing and returning data like ->compute(), it
passes and returns filehandles and filenames.  While $code parameter
in ->compute($key, $code) call is expected to generate and return data
to be cached, the $code_fh parameter in ->compute_fh($key, $code_fh)
call is expected to print generated data to filehandle provided as its
parameter.  Instead of returning data (either from cache or generated)
like ->compute(), the new ->compute_fh() method returns filehandle and
filename to read data from.

The cache_output subroutine in GitwebCache::CacheOutput now uses
->compute_fh method if cache supports it.  The contents of file that
is returned by ->compute_fh is dumped to STDOUT using File::Copy::copy.

Note that ->compute_fh interface is non-standard, and is not supported
by any caching module known to author.  Closest to it is ->handle($key)
method in the Cache[1] interface (proxied to ->entry($key)->handle()).

[1]: http://p3rl.org/Cache


Added tests for capturing to file in t9503, and of ->compute_fh method
in t9504.

Inspired-by-idea-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was inspired of behavior of cache and capturing output in
"Gitweb caching v7" series (or at least my v7.4 minimal rewrite).  It
was not present in previous version of this series... this means that
it might be less well thought out.


The major difference from the way it is done in "Gitweb caching v7" by
J.H. is that it tries to keep those three areas: caching, capturing
and integration with gitweb (caching captured output) separate.  As it
was said earlier, it allows to "unit test" those modules/packages
separately.  I think it also makes this solution easier to maintain.

As to why I didn't follow Cache interface, i.e. ->entry($key)->handle():
it would require to create at least two additional classes, a class for
cache entry to avoid race condition between checking availability and
getting ->handle(), and a IO::Handle / IO::File derivative which allows to
specify code ran when closing file - for locking, and for atomic write
(unlock and rename file to final destination).  That's why I went with
->compute_fh interface.

Note that dumping generated output or output from cache to STDOUT is done
using File::Copy: this too was inspired by code in "Gitweb caching v7" by
J.H.  (File::Copy was first released with perl 5.002, and we require for
gitweb at least 5.008).

 gitweb/lib/GitwebCache/CacheOutput.pm     |   17 ++++++++
 gitweb/lib/GitwebCache/Capture/Simple.pm  |   28 ++++++++++---
 gitweb/lib/GitwebCache/SimpleFileCache.pm |   59 +++++++++++++++++++++++++++++
 t/t9503/test_cache_interface.pl           |   32 +++++++++++++++
 t/t9504/test_capture_interface.pl         |   17 ++++++++
 5 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index 4a96ac9..7aeb895 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -17,6 +17,8 @@ package GitwebCache::CacheOutput;
 use strict;
 use warnings;
 
+use File::Copy;
+
 use Exporter qw(import);
 our @EXPORT      = qw(cache_output capture_stop);
 our %EXPORT_TAGS = (all => [ @EXPORT ]);
@@ -38,6 +40,21 @@ sub cache_output {
 
 	$capture = setup_capture($capture);
 
+	if ($cache->can('compute_fh')) {
+		my ($fh, $filename) = $cache->compute_fh($key, sub {
+			my $fh = shift;
+			$capture->capture($code, $fh);
+		});
+
+		if (defined $fh) {
+			binmode $fh, ':raw';
+			binmode STDOUT, ':raw';
+			copy($fh, \*STDOUT);
+		}
+
+		return;
+	}
+
 	my $data;
 	if ($cache->can('compute')) {
 		$data = cache_output_compute($cache, $capture, $key, $code);
diff --git a/gitweb/lib/GitwebCache/Capture/Simple.pm b/gitweb/lib/GitwebCache/Capture/Simple.pm
index 3585e58..74dd240 100644
--- a/gitweb/lib/GitwebCache/Capture/Simple.pm
+++ b/gitweb/lib/GitwebCache/Capture/Simple.pm
@@ -18,6 +18,7 @@ use strict;
 use warnings;
 
 use PerlIO;
+use Symbol qw(qualify_to_ref);
 
 # Constructor
 sub new {
@@ -32,7 +33,7 @@ sub new {
 sub capture {
 	my ($self, $code) = @_;
 
-	$self->capture_start();
+	$self->capture_start(@_[2..$#_]); # pass rest of params
 	$code->();
 	return $self->capture_stop();
 }
@@ -42,6 +43,7 @@ sub capture {
 # Start capturing data (STDOUT)
 sub capture_start {
 	my $self = shift;
+	my $to = shift;
 
 	# save copy of real STDOUT via duplicating it
 	my @layers = PerlIO::get_layers(\*STDOUT);
@@ -51,11 +53,23 @@ sub capture_start {
 	# close STDOUT, so that it isn't used anymode (to have it fd0)
 	close STDOUT;
 
-	# reopen STDOUT as in-memory file
-	$self->{'data'} = '';
-	unless (open STDOUT, '>', \$self->{'data'}) {
-		open STDOUT, '>&', fileno($self->{'orig_stdout'});
-		die "Couldn't reopen STDOUT as in-memory file for capture: $!";
+	if (defined $to) {
+		$self->{'to'} = $to;
+		if (defined fileno(qualify_to_ref($to))) {
+			# if $to is filehandle, redirect
+			open STDOUT, '>&', fileno($to);
+		} elsif (! ref($to)) {
+			# if $to is name of file, open it
+			open STDOUT, '>', $to;
+		}
+
+	} else {
+		# reopen STDOUT as in-memory file
+		$self->{'data'} = '';
+		unless (open STDOUT, '>', \$self->{'data'}) {
+			open STDOUT, '>&', fileno($self->{'orig_stdout'});
+			die "Couldn't reopen STDOUT as in-memory file for capture: $!";
+		}
 	}
 	_relayer(\*STDOUT, \@layers);
 
@@ -76,7 +90,7 @@ sub capture_stop {
 	open STDOUT, '>&', fileno($self->{'orig_stdout'});
 	_relayer(\*STDOUT, \@layers);
 
-	return $self->{'data'};
+	return exists $self->{'to'} ? $self->{'to'} : $self->{'data'};
 }
 
 # taken from Capture::Tiny by David Golden, Apache License 2.0
diff --git a/gitweb/lib/GitwebCache/SimpleFileCache.pm b/gitweb/lib/GitwebCache/SimpleFileCache.pm
index 581a574..12af44f 100644
--- a/gitweb/lib/GitwebCache/SimpleFileCache.pm
+++ b/gitweb/lib/GitwebCache/SimpleFileCache.pm
@@ -438,6 +438,65 @@ sub compute {
 	return $data;
 }
 
+# ......................................................................
+# nonstandard interface methods
+
+sub get_fh {
+	my ($self, $key) = @_;
+
+	my $path = $self->path_to_key($key);
+	return unless (defined $path);
+
+	return unless ($self->is_valid($key));
+
+	open my $fh, '<', $path or return;
+	return ($fh, $path);
+}
+
+sub set_coderef_fh {
+	my ($self, $key, $code) = @_;
+
+	my $path = $self->path_to_key($key, \my $dir);
+	return unless (defined $path && defined $dir);
+
+	# ensure that directory leading to cache file exists
+	if (!-d $dir) {
+		# mkpath will croak()/die() if there is an error
+		mkpath($dir, 0, 0777);
+	}
+
+	# generate a temporary file
+	my ($fh, $tempfile) = _tempfile_to_path($path, $dir);
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
+# ($fh, $filename) = $cache->compute_fh($key, $code);
+#
+# Combines the get and set operations in a single call.  Attempts to
+# get $key; if successful, returns the filehandle it can be read from.
+# Otherwise, calls $code passing filehandle to write to as a
+# parameter; contents of this file is then used as the new value for
+# $key; returns filehandle from which one can read newly generated data.
+sub compute_fh {
+	my ($self, $key, $code) = @_;
+
+	my ($fh, $filename) = $self->get_fh($key);
+	if (!defined $fh) {
+		($fh, $filename) = $self->set_coderef_fh($key, $code);
+	}
+
+	return ($fh, $filename);
+}
+
 1;
 __END__
 # end of package GitwebCache::SimpleFileCache;
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 9513043..0b4b09f 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -82,6 +82,38 @@ subtest 'CHI interface' => sub {
 	done_testing();
 };
 
+# Test the getting and setting of a cached value
+# (compute_fh interface)
+#
+$call_count = 0;
+sub write_value {
+	my $fh = shift;
+	$call_count++;
+	print {$fh} $value;
+}
+sub compute_fh_output {
+	my ($cache, $key, $code_fh) = @_;
+
+	my ($fh, $filename) = $cache->compute_fh($key, $code_fh);
+
+	local $/ = undef;
+	return <$fh>;
+}
+subtest 'compute_fh interface' => sub {
+	can_ok($cache, qw(compute_fh));
+
+	$cache->remove($key);
+	is(compute_fh_output($cache, $key, \&write_value), $value,
+	   "compute_fh 1st time (set) returns '$value'");
+	is(compute_fh_output($cache, $key, \&write_value), $value,
+	   "compute_fh 2nd time (get) returns '$value'");
+	is(compute_fh_output($cache, $key, \&write_value), $value,
+	   "compute_fh 3rd time (get) returns '$value'");
+	cmp_ok($call_count, '==', 1, 'write_value() is called once from compute_fh');
+
+	done_testing();
+};
+
 # Test cache expiration
 #
 subtest 'cache expiration' => sub {
diff --git a/t/t9504/test_capture_interface.pl b/t/t9504/test_capture_interface.pl
index 47ab804..26c9303 100755
--- a/t/t9504/test_capture_interface.pl
+++ b/t/t9504/test_capture_interface.pl
@@ -6,6 +6,7 @@ use strict;
 use utf8;
 
 use Test::More;
+use File::Compare;
 
 # test source version
 use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
@@ -84,6 +85,22 @@ SKIP: {
 	is($captured, '', "doesn't print while capturing");
 }
 
+# Test capturing to file
+#
+my $test_data = 'Capture this';
+open my $fh, '>', 'expected' or die "Couldn't open file for writing: $!";
+print {$fh} $test_data;
+close $fh;
+
+$capture->capture(sub { print $test_data; }, 'actual');
+cmp_ok(compare('expected', 'actual'), '==', 0, 'capturing to file via filename');
+
+open my $fh, '>', 'actual' or die "Couldn't open file for writing: $!";
+$capture->capture(sub { print $test_data; }, $fh);
+close $fh;
+cmp_ok(compare('expected', 'actual'), '==', 0, 'capturing to file via filehandle');
+
+
 done_testing();
 
 # Local Variables:
-- 
1.7.3
