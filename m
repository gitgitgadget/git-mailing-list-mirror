From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 10/18] gitweb/lib - Cache captured output (using get/set)
Date: Mon, 14 Jun 2010 18:08:23 +0200
Message-ID: <1276531710-22945-12-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEv-0002Dq-VN
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab0FNQJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab0FNQIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:55 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649718fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=A5gZ7BgmsPA79UWKxhbVFBMadw8a/AttgCI+31jpzbM=;
        b=FwjJiZOmwjWgj3vkGOqmS6ypFLg2q7u654vJSvyGTYqDA4kpC4kQ1n8fvR1Yx5zc6Q
         PffI+MFw0But2LeSn88ytfufkgVrtGSk2v1LfglGGj1nKfYtygkSISZfNkmeyhD1WcYr
         OEqBwrc+DNO0rQS9wBo547axdJV26c0b3nIxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t231mf2pshWuPxnknhOyw1IfmC/ZSfBL7cZmV17Haz2+3dbC9cSyfVDgLGCE6iLAyg
         A5cP217z25orT0ToAf6TKXQAGLpGJ5o6YebPg5h1EUuAuYuoJoi1EaLQoF11mdZoDQQV
         +Fo9viM6Ifa0Im9wfwBflrZwokD6Sf9oTmEK0=
Received: by 10.223.5.81 with SMTP id 17mr72600fau.42.1276531734955;
        Mon, 14 Jun 2010 09:08:54 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149116>

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


Add t9503/test_cache_output.pl test, run as external test in
t9503-gitweb-caching.  It checks that cache_output behaves correctly,
namely that it saves and restores action output in cache, and that it
prints generated output or cached output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/lib/GitwebCache/CacheOutput.pm |   62 +++++++++++++++++++++++++++++++
 t/t9503-gitweb-caching.sh             |    3 +
 t/t9503/test_cache_output.pl          |   66 +++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/lib/GitwebCache/CacheOutput.pm
 create mode 100755 t/t9503/test_cache_output.pl

diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
new file mode 100644
index 0000000..8195f0b
--- /dev/null
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -0,0 +1,62 @@
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
+use GitwebCache::SimpleFileCache;
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
+		# select() instead of STDOUT is here for t9503 test:
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
diff --git a/t/t9503-gitweb-caching.sh b/t/t9503-gitweb-caching.sh
index 73b3f5a..0afcc0c 100755
--- a/t/t9503-gitweb-caching.sh
+++ b/t/t9503-gitweb-caching.sh
@@ -32,4 +32,7 @@ test_external 'GitwebCache::SimpleFileCache Perl API (in gitweb/cache.pm)' \
 test_external 'GitwebCache::Capture Perl API (in gitweb/cache.pm)' \
 	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_capture_interface.pl
 
+test_external 'GitwebCache::CacheOutput Perl API (in gitweb/cache.pm)' \
+	"$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_output.pl
+
 test_done
diff --git a/t/t9503/test_cache_output.pl b/t/t9503/test_cache_output.pl
new file mode 100755
index 0000000..96eedb5
--- /dev/null
+++ b/t/t9503/test_cache_output.pl
@@ -0,0 +1,66 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More;
+
+# test source version
+use lib "$ENV{TEST_DIRECTORY}/../gitweb/lib";
+
+# ....................................................................
+
+# prototypes must be known at compile time, otherwise they do not work
+BEGIN { use_ok('GitwebCache::CacheOutput'); }
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
1.7.0.1
