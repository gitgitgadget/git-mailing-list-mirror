From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 8/9] gitweb/lib - Cache captured output (using
	compute_fh)
Date: Thu, 23 Dec 2010 00:57:58 +0100
Message-ID: <20101222235757.7998.65738.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:58:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYZv-0008Og-FC
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab0LVX6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:58:35 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39560 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0LVX6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:58:34 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so6639663fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=HHzi0ySJG/5Vfx8BiF8km0h7eMQ3aKdPA1BKSdLeP5g=;
        b=eZ59qsRmXSiB5h7AlnPcthz6zT1y6rpBvE17NUx3MLwHM4DKStW69AUivoWpWVczjW
         vfl2mZV1DCC6JOIhs8SvwaOGIbGzLldUEUn1HN0QKshtNJKADkDylZgsdP1tBzuXLXfI
         lvNw6cOBKrY7Ra6Sgur+ZDxAjbWGbySngqmpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=xGdhGK2Cvogu5noqC53Pb7cun8/ov4tKej+nc5/kh07UgVZ0PYhHcBkZ3tGCqm+Xdt
         AdxuK1u+rkEtU3r1oerlJ6onMj67CrK3fDeENgM+XDK798fEdndgfewiekXuYUurBP4U
         41puGs1qEcVcQ9CwtFZYzrKQ+w/JcKCg2RKog=
Received: by 10.223.110.77 with SMTP id m13mr521843fap.86.1293062314066;
        Wed, 22 Dec 2010 15:58:34 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id n15sm1853864fam.36.2010.12.22.15.58.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:58:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNvwhF008199;
	Thu, 23 Dec 2010 00:58:08 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164109>



Add GitwebCache::CacheOutput package, which introduces cache_output
subroutine.  If data for given key is present in cache, then
cache_output gets data from cache and prints it.  If data is not present
in cache, then cache_output runs provided subroutine (code reference),
captures its output, saves this output in cache, and prints it.

It requires that provided $cache supports ->capture_fh method, like
GitwebCache::FileCacheWithLocking introduced in earlier commit, and that
provided $capture supports capturing to file or filehandle via
->capture($code, $file) method, like GitwebCache::Capture::ToFile
introduced in some earlier commit.

Exceptions in $code should be thrown using 'die' (Perl exception
mechanism); one can choose whether error output (output printed when
exception is raised, before raising it) should be saved to cache or not.
By default error output is not cached.

Gitweb would use cache_output to get page from cache, or to generate
page and save it to cache.  The die_error subroutine throws exception,
which will be caught and by default rethrown; error pages would not be
cached.

It is assumed that data is saved to cache _converted_, and should
therefore be read from cache and printed to STDOUT in ':raw' (binary)
mode.


Add t9512/test_cache_output.pl test, run as external test in
t9512-gitweb-cache.  It checks that cache_output behaves correctly,
namely that it saves and restores action output in cache, and that it
prints generated output or cached output, depending on whether there
exist data in cache.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/lib/GitwebCache/CacheOutput.pm    |   84 ++++++++++++++++
 t/t9512-gitweb-cache-output-interface.sh |   34 ++++++
 t/t9512/test_cache_output.pl             |  162 ++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100755 t/t9512-gitweb-cache-output-interface.sh
 create mode 100755 t/t9512/test_cache_output.pl


diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
new file mode 100644
index 0000000..4a75a7f
--- /dev/null
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -0,0 +1,84 @@
+# gitweb - simple web interface to track changes in git repositories
+#
+# (C) 2010, Jakub Narebski <jnareb@gmail.com>
+# (C) 2006, John 'Warthog9' Hawley <warthog19@eaglescrag.net>
+#
+# This program is licensed under the GPLv2
+
+#
+# Capturing and caching (gitweb) output
+#
+
+# Capture output, save it in cache and print it, or retrieve it from
+# cache and print it.
+
+package GitwebCache::CacheOutput;
+
+use strict;
+use warnings;
+
+use File::Copy qw();
+use Symbol qw(qualify_to_ref);
+
+use Exporter qw(import);
+our @EXPORT      = qw(cache_output);
+our %EXPORT_TAGS = (all => [ @EXPORT ]);
+
+# cache_output($cache, $capture, $key, $action_code, [ option => value ]);
+#
+# Attempts to get $key from $cache; if successful, prints the value.
+# Otherwise, calls $action_code, capture its output using $capture,
+# and use the captured output as the new value for $key in $cache,
+# then print captured output.
+#
+# It is assumed that captured data is already converted and it is
+# in ':raw' format (and thus restored in ':raw' from cache)
+#
+# Supported options:
+# * -cache_errors => 0|1  - whether error output should be cached
+sub cache_output {
+	my ($cache, $capture, $key, $code, %opts) = @_;
+
+	my ($fh, $filename);
+	my ($capture_fh, $capture_filename);
+	eval { # this `eval` is to catch rethrown error, so we can print captured output
+		($fh, $filename) = $cache->compute_fh($key, sub {
+			($capture_fh, $capture_filename) = @_;
+
+			# this `eval` is to be able to cache error output (up till 'die')
+			eval { $capture->capture($code, $capture_fh); };
+
+			# note that $cache can catch this error itself (like e.g. CHI);
+			# use "die"-ing error handler to rethrow this exception to outside
+			die $@ if ($@ && ! $opts{'-cache_errors'});
+		});
+	};
+	my $error = $@;
+
+	# if an exception was rethrown, and not caught by caching engine (by $cache)
+	# then ->compute_fh will not set $fh nor $filename; use those used for capture
+	if (!defined $fh) {
+		$filename ||= $capture_filename;
+	}
+
+	if (defined $fh || defined $filename) {
+		# set binmode only if $fh is defined (is a filehandle)
+		# File::Copy::copy opens files given by filename in binary mode
+		binmode $fh,    ':raw' if (defined $h);
+		binmode STDOUT, ':raw';
+		File::Copy::copy($fh || $filename, \*STDOUT);
+	}
+
+	# rethrow error if captured in outer `eval` (i.e. no -cache_errors),
+	# removing temporary file (exception thrown out of cache)
+	if ($error) {
+		unlink $capture_filename
+			if (defined $capture_filename && -e $capture_filename);
+		die $error;
+	}
+	return;
+}
+
+1;
+__END__
+# end of package GitwebCache::CacheOutput
diff --git a/t/t9512-gitweb-cache-output-interface.sh b/t/t9512-gitweb-cache-output-interface.sh
new file mode 100755
index 0000000..fb9525a
--- /dev/null
+++ b/t/t9512-gitweb-cache-output-interface.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jakub Narebski
+#
+
+test_description='gitweb cache
+
+This test checks GitwebCache::CacheOutput Perl module that is
+responsible for capturing and caching gitweb output.'
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
+	'GitwebCache::CacheOutput Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9512/test_cache_output.pl
+
+test_done
diff --git a/t/t9512/test_cache_output.pl b/t/t9512/test_cache_output.pl
new file mode 100755
index 0000000..758848c
--- /dev/null
+++ b/t/t9512/test_cache_output.pl
@@ -0,0 +1,162 @@
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
+# ....................................................................
+
+# prototypes must be known at compile time, otherwise they do not work
+BEGIN { use_ok('GitwebCache::CacheOutput'); }
+
+require_ok('GitwebCache::FileCacheWithLocking');
+require_ok('GitwebCache::Capture::ToFile');
+
+note("Using lib '$INC[0]'");
+note("Testing '$INC{'GitwebCache/CacheOutput.pm'}'");
+note("Testing '$INC{'GitwebCache/FileCacheWithLocking.pm'}'");
+note("Testing '$INC{'GitwebCache/Capture/ToFile.pm'}'");
+
+
+# Test setting up $cache and $capture
+my ($cache, $capture);
+subtest 'setup' => sub {
+	$cache   = new_ok('GitwebCache::FileCacheWithLocking' => [], 'The $cache  ');
+	$capture = new_ok('GitwebCache::Capture::ToFile'      => [], 'The $capture');
+
+	done_testing();
+};
+
+# ......................................................................
+
+# Prepare for testing cache_output
+my $key = 'Key';
+my $action_output = <<'EOF';
+# This is data to be cached and shown
+EOF
+my $cached_output = <<"EOF";
+$action_output# (version recovered from cache)
+EOF
+my $call_count = 0;
+sub action {
+	$call_count++;
+	print $action_output;
+}
+
+my $die_output = <<"EOF";
+$action_output# (died)
+EOF
+sub die_action {
+	print $die_output;
+	die "die_action\n";
+}
+
+# Catch output printed by cache_output
+sub capture_output_of_cache_output {
+	my ($code, @args) = @_;
+
+	GitwebCache::Capture::ToFile->new()->capture(sub {
+		cache_output($cache, $capture, $key, $code, @args);
+	}, 'actual');
+
+	return get_actual();
+}
+
+sub get_actual {
+	open my $fh, '<', 'actual' or return;
+	local $/ = undef;
+	my $result = <$fh>;
+	close $fh;
+	return $result;
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
+
+# ......................................................................
+
+# clean state
+$cache->set_expires_in(-1);
+$cache->remove($key);
+my $test_data;
+
+# first time (if there is no cache) generates cache entry
+subtest '1st time (generate data)' => sub {
+	$call_count = 0;
+	$test_data = capture_output_of_cache_output(\&action);
+	is($test_data,                 $action_output, 'action() output is printed');
+	is(cache_get_fh($cache, $key), $action_output, 'action() output is saved in cache');
+	cmp_ok($call_count, '==', 1, 'action() was called to generate data');
+
+	done_testing();
+};
+
+# second time (if cache is set/valid) reads from cache
+subtest '2nd time (retreve from cache)' => sub {
+	cache_set_fh($cache, $key, $cached_output);
+	$call_count = 0;
+	$test_data = capture_output_of_cache_output(\&action);
+	is(cache_get_fh($cache, $key), $cached_output, 'correct value is prepared in cache');
+	is($test_data,                 $cached_output, 'output is printed from cache');
+	cmp_ok($call_count, '==', 0, 'action() was not called');
+
+	done_testing();
+};
+
+# caching output and error handling
+subtest 'errors (exceptions) are not cached by default' => sub {
+	$cache->remove($key);
+	ok(!defined cache_get_fh($cache, $key), 'cache is prepared correctly (no data in cache)');
+	eval {
+		$test_data = capture_output_of_cache_output(\&die_action);
+	};
+	my $error = $@;
+	$test_data = get_actual();
+	is($test_data, $die_output,             'output of an error is printed');
+	ok(!defined cache_get_fh($cache, $key), 'output is not captured and not cached');
+	like($error, qr/^die_action\n/m,        'exception made it to outside, correctly');
+
+	done_testing();
+};
+
+subtest 'errors are cached with -cache_errors => 1' => sub {
+	$cache->remove($key);
+	ok(!defined cache_get_fh($cache, $key), 'cache is prepared correctly (no data in cache)');
+	eval {
+		$test_data = capture_output_of_cache_output(\&die_action, -cache_errors => 1);
+	};
+	my $error = $@;
+	$test_data = get_actual();
+	is($test_data,                 $die_output, 'output of an error is printed');
+	is(cache_get_fh($cache, $key), $die_output, 'output is captured and cached');
+	ok(! $error, 'exception didn\'t made it to outside');
+	diag($error) if $error;
+
+	done_testing();
+};
+
+
+done_testing();
+__END__
