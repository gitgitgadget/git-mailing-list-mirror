From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.4 4/4] gitweb: Minimal testing of gitweb caching
Date: Fri,  3 Dec 2010 20:25:35 +0100
Message-ID: <1291404335-25541-5-git-send-email-jnareb@gmail.com>
References: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 20:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObH5-0002Rm-3Q
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0LCT0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:26:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59210 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0LCT0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:26:08 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so8656191bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ua6i3K6WDMxEYiYjdqr/wjhVohwpgU98lNPKD6JpDLo=;
        b=jgD3xi9A7fwY6TRMeOjH/2Wy9l/0J9R9GN2kAuhoMihgB746amwpZBWgnPg3tX+JMK
         6doGwPnQ/8tcoA3uGVBnywpG9gQXGKQRBX+kMsff0Ao6jIem+zEeZzTLWrAQ9IArlJlQ
         yf5PYpJyX1BsUkS7bd75TNk8lznfPzoNFQJ/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h9mH7+7c0qDXnaY4mQb8QStmFXj/xjEqzPI8DDdWBlUQvi91q15yvACgMrb8Z4yS5u
         w+Xipr9k4lL3DHR/5O7OxlwIAhJD/BkD8bxSjHHGJmtxsYtuf4Qt0Z1+BYvs9bI1WiuA
         4LlWGY5E+DJLs/hPayoq9hfmvJQDMcv7dA1kA=
Received: by 10.204.73.4 with SMTP id o4mr3016823bkj.156.1291404366874;
        Fri, 03 Dec 2010 11:26:06 -0800 (PST)
Received: from localhost.localdomain (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id b17sm1064634bku.8.2010.12.03.11.26.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 11:26:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291404335-25541-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162833>

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
The minor bug in value for $xxxCacheTime value in t/gitweb-lib.sh
noticed by Junio C Hamano in
  http://thread.gmane.org/gmane.comp.version-control.git/160147/focus=161635

is fixed here, but it doesn't make gitweb pass new tests.

 t/gitweb-lib.sh                           |   15 +++++++++++++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 +++++++++++++++++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +++++++++++
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b9bb95f..2c2ac90 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -52,6 +52,21 @@ EOF
 	export SCRIPT_NAME
 }
 
+gitweb_enable_caching () {
+	test_expect_success 'enable caching' '
+		cat >>gitweb_config.perl <<-\EOF &&
+		our $caching_enabled = 1;
+		our $minCacheTime = 60*60*24*7;        # very long expiration time for tests (a week)
+		our $maxCacheTime = 60*60*24*30;       # upper bound for dynamic (adaptive) caching
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
1.7.3
