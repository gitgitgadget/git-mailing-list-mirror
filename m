From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.2 4/4] gitweb: Minimal testing of gitweb caching
Date: Sat, 13 Nov 2010 01:01:50 +0100
Message-ID: <201011130101.51116.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <1288607092-31458-1-git-send-email-jnareb@gmail.com> <201011130035.50229.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 01:02:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH3ZK-0004jh-Da
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 01:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232Ab0KMACF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 19:02:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60378 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218Ab0KMACC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 19:02:02 -0500
Received: by fxm6 with SMTP id 6so602578fxm.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 16:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZdxI0/6z9yRU4N9LU0AlmqBq++jeEjtjPf1U8ZZAxKU=;
        b=HC+t4gWX6Pyw0eD9LptXlE18n7aCIaq47PP48Zen4oNgL6bgxAuDabmzh4Y+ticeeF
         FH0bBCO0Uon9eDA1efMXRV9agbyd1LwC40zkA3wNWB+l1mg6agiSEO5GAto544R11CzE
         iGJQb7HbBEJ4A6UX70YZ4dFmzUa3KsD44ssQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=t/79kqK+XEf1SL3ebzwgu5v2fkIbXp1cCJ/dsV3QCqbtdLTkDPGvb8iiKBMLhQECwX
         5V2160WhqE6ztIGvQmqkpAkQGeIKIPqiWd7mEDHBSSOv/a97M9R7giYuq45gecj1JnjJ
         AjNTR2Cp7ew51E//fckor2ZbOmYgXAH4+zsVE=
Received: by 10.223.111.134 with SMTP id s6mr2098884fap.21.1289606520988;
        Fri, 12 Nov 2010 16:02:00 -0800 (PST)
Received: from [192.168.1.13] (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id y19sm204796fau.41.2010.11.12.16.01.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 16:01:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011130035.50229.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161372>

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
As I wrote in the cover letter, because of cacheWaitForUpdate() generating
extra output some of those newly introduced tests fail, some
intermittently.

John, could you take a look at it and check if the problem is: in tests,
in my simplification, or in caching code...

 t/gitweb-lib.sh                           |   15 +++++++++++++
 t/t9500-gitweb-standalone-no-errors.sh    |   20 +++++++++++++++++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +++++++++++
 t/t9502-gitweb-standalone-parse-output.sh |   33 +++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b9bb95f..16ce811 100644
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
1.7.3
