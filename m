From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 07/17] gitweb/lib - Cache captured output (using get/set)
Date: Thu,  7 Oct 2010 00:01:52 +0200
Message-ID: <1286402526-13143-8-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5m-0002Gb-0L
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759953Ab0JFWCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab0JFWCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:44 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49448bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+hZQ8x1nBKRavT+VZMJXjo284mOwGv8IXiH9S9EV9JU=;
        b=Hoj1kRHoSMGnlPIbWjmDanNENwuKTSyUQtOGKwA26AjeHTU66+wiUuPzGaFeaYr3oQ
         SAfkrFhm5cNVgzzTQLRKrf1au/YbrsAyaYNQ1iOIF1TeRxrgd3YUQs4wn1yivG/O4cFD
         nujHgWA/lDJA3+dpTjYC+zESlTH1eUw8e9L7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I28D37iFJeba27HDhaFfiCLcKzsxl7EBrVW4girj+5pkLeH60Jl1vvqy0pHxh7mpez
         Tk474GX/MUe2BrpHKdSE7oaA7J8x5TcVJ10stNPYw7IddXX34qqS/l/9M38kdiiuDv+n
         +jR0WoKWlkmAgt/DvtSGKY2mwZ+tX+RqJC0E4=
Received: by 10.204.68.144 with SMTP id v16mr10296279bki.58.1286402562247;
        Wed, 06 Oct 2010 15:02:42 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158322>

Add GitwebCache::CacheOutput package, which contains cache_output
subroutine, and (re)exports capture_stop from GitwebCache::Capture.
The cache_output gets data from cache and prints it, or captures
output of provided subroutine (code reference), saves it to cache and
prints it.  It currently uses Cache::Cache compatibile (get, set)
interface to cache.  Capturing is currently (not configurable) done
using GitwebCache::Capture::SelectFH introduced in previous commit,
but any class derived from GitwebCache::Capture (like provided example
GitwebCache::Capture::TiedCapture and GitwebCache::Capture::PerlIO)
would work.

Gitweb would use cache_output to get page from cache, or to generate
page and save it to cache.  The capture_stop would be used in
die_error subroutine, because error pages would not be cached.

It is assumed that data is saved to cache _converted_, and should
therefore be read from cache and printed to STDOUT in ':raw' (binary)
mode.


Add t9505/test_cache_output.pl test, run as external test in
t9505-gitweb-cache.sh.  It checks that cache_output behaves correctly,
namely that it saves and restores action output in cache, and that it
prints generated output or cached output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from v4:
* Similarly to other patches in this revision of gitweb caching
  series, the new test for this new module, written in Perl, is now
  invoked from a separate test script, to make it possible to run
  'prove' on git test suite.

  Also new test uses GIT_BUILD_DIR rather than TEST_DIRECTORY/.., and
  it respects GITWEBLIBDIR to make it possible to test installed
  version of this module.

* GitwebCache::CacheOutput no longer loads GitwebCache::SimpleFileCache;
  It is now assumed that cache_output() caller loads required packages
  itself, so that ->get() and ->set() methods $cache instance, passed
  as argument to cache_output(), work correctly.

  This required small change to t/t9505/test_cache_output.pl


Differences from relevant parts of J.H. patch:
* cache_fetch() subroutine, now named cache_output(), is much, much
  simpler.  Well, at this point in the patch series it lacks most of
  the features of original cache_fetch() by J.H.: it doesn't have
  adaptive cache lifetime, nor locking to prevent 'stampeding herd'
  problem, nor serving stale data when waiting for cache regeneration,
  nor background data generation, nor activity indicator... but the
  cache_output() itself doesn't change much in later commits, as those
  features are added mainly via methods and subroutines that
  cache_output() calls.

* Capturing gitweb output would be done without need to extensively
  modify gitweb to either 1) save generated output into $output
  variable, i.e. replace 'print <sth>' by '$output .= <sth>', and print
  it or save in cache after it is generated in full (original J.H. patch
  in "Gitweb caching v2"), or 2) changing all print statements to print
  to explicit filehandle, i.e. replace 'print <sth>' by 
  'print {$out} <sth>', which filehandle points to STDOUT if caching is
  disabled and to in-memory file if caching is enabled (modified
  J.H. patch in "Gitweb caching v5").

  Currently capturing output is hardcoded to GitwebCache::Capture::SelectFH,
  but changing it to other compatibile capturing engine requires (in
  current version) change only only two lines in GitwebCache::CacheOutput
  module.

* It is assumed that capture generates binary output (with I/O filters
  already applied), and that therefore we read from cache files in
  binary mode, and we print both captured output and data retrieved from
  cache in ':raw' mode (in binmode).

* The key (human-readable unique id) for a page (for given capture) is
  passed explicitely to cache_output().  The cache_output() subroutine
  no longer depends of subroutines (like href()) and variables (like
  $cation or %actions) defined in gitweb.perl.

  This allows to simply use 'require <package>' instead of 'do $package_pm'
  (which also means that it can be installed as module in PERL5LIB etc.).

* Added tests for cache_output() behavior.

 gitweb/lib/GitwebCache/CacheOutput.pm |   64 ++++++++++++++++++++++++++++++
 t/t9505-gitweb-cache.sh               |   34 ++++++++++++++++
 t/t9505/test_cache_output.pl          |   70 +++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100755 t/t9505-gitweb-cache.sh
 create mode 100755 t/t9505/test_cache_output.pl

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
new file mode 100644
index 0000000..bba73ee
--- /dev/null
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -0,0 +1,64 @@
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
+use GitwebCache::Capture::SelectFH qw(:all);
+
+use Exporter qw(import);
+our @EXPORT      = qw(cache_output capture_stop);
+our %EXPORT_TAGS = (all => [ @EXPORT ]);
+
+# cache_output($cache, $key, $action_code);
+#
+# Attempts to get $key from $cache; if successful, prints the value.
+# Otherwise, calls $action_code, capture its output and use
+# the captured output as the new value for $key in $cache,
+# then print captured output.
+#
+# It is assumed that captured data is already converted and it is
+# in ':raw' format (and thus restored in ':raw' from cache)
+our $CAPTURE_CLASS = 'GitwebCache::Capture::SelectFH';
+
+sub cache_output {
+	my ($cache, $key, $code) = @_;
+
+	my $data = $cache->get($key);
+
+	# capture and cache output, if there was nothing in the cache
+	if (!defined $data) {
+		my $capture = $CAPTURE_CLASS;
+		setup_capture($capture);
+
+		# do not use 'capture_block' prototype
+		$data = &capture_block($code);
+		$cache->set($key, $data) if defined $data;
+	}
+
+	# print cached data
+	if (defined $data) {
+		# select() instead of STDOUT is here for tests:
+		binmode select(), ':raw';
+		print $data;
+	}
+
+	return $data;
+}
+
+1;
+__END__
+# end of package GitwebCache::CacheOutput;
diff --git a/t/t9505-gitweb-cache.sh b/t/t9505-gitweb-cache.sh
new file mode 100755
index 0000000..55d3e17
--- /dev/null
+++ b/t/t9505-gitweb-cache.sh
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
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9505/test_cache_output.pl
+
+test_done
diff --git a/t/t9505/test_cache_output.pl b/t/t9505/test_cache_output.pl
new file mode 100755
index 0000000..0343591
--- /dev/null
+++ b/t/t9505/test_cache_output.pl
@@ -0,0 +1,70 @@
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
+# load GitwebCache::SimpleFileCache (gitweb.perl uses require too)
+# GitwebCache::Capture::SelectFH is loaded by GitwebCache::CacheOutput
+require_ok('GitwebCache::SimpleFileCache');
+
+# Test setting up $cache and $capture
+my $cache   = new_ok('GitwebCache::SimpleFileCache'   => [], 'The $cache  ');
+my $capture = new_ok('GitwebCache::Capture::SelectFH' => [], 'The $capture');
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
+sub action {
+	print $action_output;
+}
+
+# Catch output printed by cache_fetch
+# (only for 'print <sth>' and 'printf <sth>')
+sub capture_output_of_cache_output {
+	my $test_data = '';
+
+	open my $test_data_fh, '>', \$test_data;
+	my $oldfh = select($test_data_fh);
+
+	cache_output($cache, $key, \&action);
+
+	select($oldfh);
+	close $test_data_fh;
+
+	return $test_data;
+}
+
+# clean state
+$cache->set_expires_in(-1);
+$cache->remove($key);
+my $test_data;
+
+# first time (if there is no cache) generates cache entry
+$test_data = capture_output_of_cache_output();
+is($test_data, $action_output,        'action output is printed (generated)');
+is($cache->get($key), $action_output, 'action output is saved in cache (generated)');
+
+# second time (if cache is set/valid) reads from cache
+$cache->set($key, $cached_output);
+$test_data = capture_output_of_cache_output();
+is($test_data, $cached_output,        'action output is printed (from cache)');
+
+done_testing();
-- 
1.7.3
