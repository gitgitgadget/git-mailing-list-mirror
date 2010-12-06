From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 07/24] gitweb/lib - Cache captured output (using get/set)
Date: Tue,  7 Dec 2010 00:10:52 +0100
Message-ID: <1291677069-6559-8-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkE1-0008Ec-JP
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab0LFXMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:01 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0LFXMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:00 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=f2whyMmM9g9EZwTbO63Cdc0nMj1BVpaTBktTm7+7I3E=;
        b=vV2lcVHvm3HwW3zshPf1LT9ShI81EwF8w5k3u4pZRgHl5GrJizg60g9iFGs0nouE5p
         jsmN8WDCmoowKBgMwBaAL0nuTlX8vj7UaTic6jv7TvJgjb9U+SvJoeI8lHOd1Ku3U49m
         TAnL1cn4/2KuFBe4JcqF9dKua5wxGmw53LLFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XUNncrnx/+ngKBkybkRQyx+OfLXVAS+V3ZDVnbGNhl3YyJEmN/riG4mHI4LRiP+dtQ
         YNAyrTi7GBiSeo7l6k8Ma6Zv3NOmAJ3dYj+tHb+9gj8hWqaUcih7lqBVoYOL6U2aJ2yq
         T09OC3xsXhfDNgHx0MjSyNoFTWCeU1Hmg/Fbc=
Received: by 10.213.9.8 with SMTP id j8mr82708ebj.95.1291677119527;
        Mon, 06 Dec 2010 15:11:59 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:58 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163035>

Add GitwebCache::CacheOutput package, which contains cache_output
subroutine.  The cache_output gets data from cache and prints it, or
captures output of provided subroutine (code reference), saves it to
cache and prints it.  It currently uses Cache::Cache compatibile (get,
set) interface to cache.  The capture_stop currently simply runs
$capture->capture_stop().

Capturing output is done using GitwebCache::Capture::Simple compatibile
capture (->new(), ->capture($code)) passed as one of parameters; the
default solution is to use GitwebCache::Capture::Simple.

Gitweb would use cache_output to get page from cache, or to generate
page and save it to cache.  The capture_stop would be used in die_error
subroutine, because error pages would not be cached.

It is assumed that data is saved to cache _converted_, and should
therefore be read from cache and printed to STDOUT in ':raw' (binary)
mode.


Add t9505/test_cache_output.pl test, run as external test in
t9505-gitweb-cache.  It checks that cache_output behaves correctly,
namely that it saves and restores action output in cache, and that it
prints generated output or cached output, depending on whether there
exist data in cache.  This test requires Capture::Tiny to be installed
(because GitwebCache::Capture::Simple dosn't support recursive
capturing).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
In this version capture_stop is defined in GitwebCache::CacheOutput,
instead of being re-exported from GitwebCache::Capture (which no
longer exists).  Compared to previous version cache_output now expects
$capture (selecting capturing engine) as second argument, and 
capture_stop expect $cache and $capture, while it was paramless before.
t9505 now requires Capture::Tiny, because it needs reliable nested
capture.

capture_stop is here only in the case in the future we would accept
wider range of possible $capture values, e.g. \&Capture::Tiny::capture
(reference to capturing subroutine).


cache_output($cache, $capture, $key, $code) is roughly equivalent to
cache_fetch($action) from cache.pm file in "Gitweb caching v7" series
by J.H.... but nothing in GitwebCache::CacheOutput is gitweb specific.
This module is simply about caching captured output, using given caching
engine, given capturing engine, given key to cache entry, and given 
coderef output of which is to be captured and cached, and then printing
generated data or data from cache.

Similarly to J.H. patch, and differently from CGI::Cache or
Plack::Middleware::Cache accessing cache is/would be quite explicit.

 gitweb/lib/GitwebCache/CacheOutput.pm              |   90 ++++++++++++++++++++
 ...-caching-interface.sh => t9505-gitweb-cache.sh} |   15 ++-
 t/t9505/test_cache_output.pl                       |   86 +++++++++++++++++++
 3 files changed, 186 insertions(+), 5 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 copy t/{t9503-gitweb-caching-interface.sh => t9505-gitweb-cache.sh} (58%)
 create mode 100755 t/t9505/test_cache_output.pl

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
new file mode 100644
index 0000000..458e314
--- /dev/null
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -0,0 +1,90 @@
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
+use Exporter qw(import);
+our @EXPORT      = qw(cache_output capture_stop);
+our %EXPORT_TAGS = (all => [ @EXPORT ]);
+
+# cache_output($cache, $capture, $key, $action_code);
+#
+# Attempts to get $key from $cache; if successful, prints the value.
+# Otherwise, calls $action_code, capture its output using $capture,
+# and use the captured output as the new value for $key in $cache,
+# then print captured output.
+#
+# It is assumed that captured data is already converted and it is
+# in ':raw' format (and thus restored in ':raw' from cache)
+
+# default capture class (engine), if none provided
+our $DEFAULT_CAPTURE_CLASS = 'GitwebCache::Capture::Simple';
+sub cache_output {
+	my ($cache, $capture, $key, $code) = @_;
+
+	$capture = setup_capture($capture);
+
+	# check if data is in the cache
+	my $data = $cache->get($key);
+
+	# capture and cache output, if there was nothing in the cache
+	if (!defined $data) {
+		$data = $capture->capture($code);
+		$cache->set($key, $data) if defined $data;
+	}
+
+	# print cached data
+	if (defined $data) {
+		binmode STDOUT, ':raw';
+		print $data;
+	}
+
+	return $data;
+}
+
+# capture_stop($cache, $capture);
+#
+# Stops capturing output; to be used in die_error, so that error pages
+# are not cached (not captured and cached).
+sub capture_stop {
+	my ($cache, $capture) = @_;
+
+	if (defined $capture) {
+		return $capture->capture_stop();
+	}
+	return;
+}
+
+# ......................................................................
+# helper subroutines
+
+# setup capture engine
+sub setup_capture {
+	my $capture = shift;
+
+	$capture ||= $DEFAULT_CAPTURE_CLASS;
+	if (!ref($capture)) {
+		eval "require $capture;" or die $@;
+		$capture = $capture->new();
+	}
+
+	return $capture;
+}
+
+1;
+__END__
+# end of package GitwebCache::CacheOutput
diff --git a/t/t9503-gitweb-caching-interface.sh b/t/t9505-gitweb-cache.sh
similarity index 58%
copy from t/t9503-gitweb-caching-interface.sh
copy to t/t9505-gitweb-cache.sh
index 819da1d..181577f 100755
--- a/t/t9503-gitweb-caching-interface.sh
+++ b/t/t9505-gitweb-cache.sh
@@ -3,10 +3,10 @@
 # Copyright (c) 2010 Jakub Narebski
 #
 
-test_description='gitweb caching interface
+test_description='gitweb cache
 
-This test checks caching interface used in gitweb caching, and caching
-infrastructure (GitwebCache::* modules).'
+This test checks GitwebCache::CacheOutput Perl module that is
+responsible for capturing and caching gitweb output.'
 
 # for now we are running only cache interface tests
 . ./test-lib.sh
@@ -22,13 +22,18 @@ fi
 	test_done
 }
 
+"$PERL_PATH" -MCapture::Tiny -e 0 >/dev/null 2>&1 || {
+	skip_all='perl module Capture::Tiny unavailable, skipping test'
+	test_done
+}
+
 # ----------------------------------------------------------------------
 
 # The external test will outputs its own plan
 test_external_has_tap=1
 
 test_external \
-	'GitwebCache::* Perl API (in gitweb/lib/)' \
-	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
+	'GitwebCache::CacheOutput Perl API (in gitweb/lib/)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9505/test_cache_output.pl
 
 test_done
diff --git a/t/t9505/test_cache_output.pl b/t/t9505/test_cache_output.pl
new file mode 100755
index 0000000..167bb36
--- /dev/null
+++ b/t/t9505/test_cache_output.pl
@@ -0,0 +1,86 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More;
+use Capture::Tiny qw(capture);
+
+# test source version
+use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
+
+# ....................................................................
+
+# prototypes must be known at compile time, otherwise they do not work
+BEGIN { use_ok('GitwebCache::CacheOutput'); }
+
+require_ok('GitwebCache::SimpleFileCache');
+require_ok('GitwebCache::Capture::Simple');
+
+diag("Using lib '$INC[0]'");
+diag("Testing '$INC{'GitwebCache/CacheOutput.pm'}'");
+diag("Testing '$INC{'GitwebCache/SimpleFileCache.pm'}'");
+diag("Testing '$INC{'GitwebCache/Capture/Simple.pm'}'");
+
+
+# Test setting up $cache and $capture
+my $cache   = new_ok('GitwebCache::SimpleFileCache' => [], 'The $cache  ');
+my $capture = new_ok('GitwebCache::Capture::Simple' => [], 'The $capture');
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
+my $no_capture_output = <<"EOF";
+$action_output# (no capture)
+EOF
+sub no_capture {
+	capture_stop($cache, $capture);
+	print $no_capture_output;
+}
+
+# Catch output printed by cache_fetch
+# (only for 'print <sth>' and 'printf <sth>')
+sub capture_output_of_cache_output {
+	my $code = shift;
+
+	my ($stdout, $stderr) = capture {
+		cache_output($cache, $capture, $key, $code);
+	};
+	print STDERR $stderr;
+	return $stdout;
+}
+
+# clean state
+$cache->set_expires_in(-1);
+$cache->remove($key);
+my $test_data;
+
+# first time (if there is no cache) generates cache entry
+$test_data = capture_output_of_cache_output(\&action);
+is($test_data, $action_output,        'action output is printed (generated)');
+is($cache->get($key), $action_output, 'action output is saved in cache (generated)');
+
+# second time (if cache is set/valid) reads from cache
+$cache->set($key, $cached_output);
+$test_data = capture_output_of_cache_output(\&action);
+is($test_data, $cached_output,        'action output is printed (from cache)');
+
+# test using capture_stop
+$cache->remove($key);
+$test_data = capture_output_of_cache_output(\&no_capture);
+is($test_data, $no_capture_output,    'no_capture output is printed (generated)');
+ok(! $cache->get($key),               'no_capture output is not captured and not cached');
+
+done_testing();
-- 
1.7.3
