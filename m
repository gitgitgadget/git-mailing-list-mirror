From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 04/18] gitweb: Minimal testing of gitweb caching
Date: Thu,  9 Dec 2010 13:57:10 -0800
Message-ID: <1291931844-28454-5-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:55:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoSz-0006x0-6T
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435Ab0LIVzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:50 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51848 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0LIVzt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:49 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePo027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:48 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163334>

From: Jakub Narebski <jnareb@gmail.com>

Add basic tests of caching support to t9500-gitweb-standalone-no-errors
test: set $caching_enabled to true and check for errors for first time
run (generating cache) and second time run (retrieving from cache) for a
single view - summary view for a project.  Check also that request for
non-existent object (which results in die_error() codepath to be called)
doesn't produce errors.

Check in t9501-gitweb-standalone-http-status that request for
non-existent object produces correct output (HTTP headers and HTML
output) also when caching is enabled.

Check in the t9502-gitweb-standalone-parse-output test that gitweb
produces the same output with and without caching, for first and
second run, with binary (raw) or plain text (utf8) output.

The common routine that enables cache, gitweb_enable_caching, is
defined in t/gitweb-lib.sh

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/gitweb-lib.sh                           |   15 +++++++++++++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 +++++++++++++++++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +++++++++++
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/gitweb-lib.sh

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
old mode 100644
new mode 100755
index b9bb95f..16ce811
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -52,6 +52,21 @@ EOF
 	export SCRIPT_NAME
 }
 
+gitweb_enable_caching () {
+	test_expect_success 'enable caching' '
+		cat >>gitweb_config.perl <<-\EOF &&
+		our $caching_enabled = 1;
+		our $minCacheTime = 60*60*24*7*30;     # very long expiration time for tests (a month)
+		our $maxCacheTime = 60*60*24*7*30*365; # upper bound for dynamic (adaptive) caching
+		our $cachedir = "cache";               # for testsuite to clear the right thing
+		# required, because otherwise some tests might intermittently not pass
+		our $backgroundCache = 0; # should turn off cacheWaitForUpdate() / "Generating..."
+		#our $cacheDoFork = 0;
+		EOF
+		rm -rf cache/
+	'
+}
+
 gitweb_run () {
 	GATEWAY_INTERFACE='CGI/1.1'
 	HTTP_ACCEPT='*/*'
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 21cd286..86c1b50 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -677,4 +677,24 @@ test_expect_success HIGHLIGHT \
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# caching
+
+gitweb_enable_caching
+
+test_expect_success \
+	'caching enabled (project summary, first run, generating cache)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'caching enabled (project summary, second run, cached version)' \
+	'gitweb_run "p=.git;a=summary"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'caching enabled (non-existent commit, non-cache error page)' \
+	'gitweb_run "p=.git;a=commit;h=non-existent"'
+test_debug 'cat gitweb.log'
+
 test_done
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 2487da1..5b1df3f 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -134,5 +134,18 @@ cat >>gitweb_config.perl <<\EOF
 our $maxload = undef;
 EOF
 
+# ----------------------------------------------------------------------
+# output caching
+
+gitweb_enable_caching
+
+test_expect_success 'caching enabled (non-existent commit, 404 error)' '
+	gitweb_run "p=.git;a=commit;h=non-existent" &&
+	grep "Status: 404 Not Found" gitweb.headers &&
+	grep "404 - Unknown commit object" gitweb.body
+'
+test_debug 'echo "log"     && cat gitweb.log'
+test_debug 'echo "headers" && cat gitweb.headers'
+test_debug 'echo "body"    && cat gitweb.body'
 
 test_done
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index dd83890..bc8eb01 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -112,4 +112,37 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+
+# ----------------------------------------------------------------------
+# whether gitweb with caching enabled produces the same output
+
+test_expect_success 'setup for caching tests (utf8 patch, binary file)' '
+	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	cp "$TEST_DIRECTORY"/test9200a.png image.png &&
+	git add image.png &&
+	git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
+	gitweb_run "p=.git;a=patch" &&
+	mv gitweb.body no_cache.txt &&
+	gitweb_run "p=.git;a=blob_plain;f=image.png" &&
+	mv gitweb.body no_cache.png
+'
+
+gitweb_enable_caching
+
+for desc in 'generating cache' 'cached version'; do
+	test_expect_success "caching enabled, plain text (utf8) output, $desc" '
+		gitweb_run "p=.git;a=patch" &&
+		mv gitweb.body cache.txt &&
+		test_cmp no_cache.txt cache.txt
+	'
+done
+
+for desc in 'generating cache' 'cached version'; do
+	test_expect_success "caching enabled, binary output (raw), $desc" '
+		gitweb_run "p=.git;a=blob_plain;f=image.png" &&
+		mv gitweb.body cache.png &&
+		cmp no_cache.png cache.png
+	'
+done
+
 test_done
-- 
1.7.2.3
