From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 4/4] gitweb: Minimal testing of gitweb caching
Date: Mon,  1 Nov 2010 11:24:52 +0100
Message-ID: <1288607092-31458-5-git-send-email-jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 11:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCrZz-0005lL-AS
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 11:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170Ab0KAKZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 06:25:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46286 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155Ab0KAKZW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 06:25:22 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so3018422eye.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uUQZejQqg/B7iZU9FuH1kP/9Ilk3BUqZYbcCjCDNOR4=;
        b=ELES/+CWMtNifB8q7XB80NRlvSuqVAEN5hRfjpdK1W5SmolP44oWqjnPP0scv/i+99
         KVZXaMTGUNeS7PJG07+nMrM5lHtYvcBDV89VfisHXiK7ha35gyurZYAgPEMjvZYCKQPX
         mgZpWNlC9ZGOZO0dtdu1e7jxjNvJ7/WE1T09E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LSI10vjR0L2hcnw3xKi2h35boFUJNwAiYrorJ4DXE+lqWMs/pUwGhXyIP8DD1dCS3m
         qPwD4o/YvTNp5fnEciKWDqwj6ZnOWEj8A3YEqUNH9GaqXkz7OwX0OkD1ejadu944xzk4
         MYCidM3QEvCa6OVIJo2fleUSMjHxfVvoyCtgo=
Received: by 10.14.45.72 with SMTP id o48mr10734269eeb.22.1288607122179;
        Mon, 01 Nov 2010 03:25:22 -0700 (PDT)
Received: from roke.localdomain (abvk31.neoplus.adsl.tpnet.pl [83.8.208.31])
        by mx.google.com with ESMTPS id x54sm4069255eeh.11.2010.11.01.03.25.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 03:25:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <201010311021.55917.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160477>

Add basic tests of caching support to t9500-gitweb-standalone-no-errors
test: set $caching_enabled to true and check for errors for first time
run (generating cache) and second time run (retrieving from cache) for a
single view - summary view for a project.  Check in the
t9502-gitweb-standalone-parse-output test that gitweb produces the same
output with and without caching, for first and second run, with binary
or text output.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
All tests, including those added here, passes.

 t/t9500-gitweb-standalone-no-errors.sh    |   19 ++++++++++++++
 t/t9502-gitweb-standalone-parse-output.sh |   39 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 4f2b9b0..0ad5fc8 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -676,4 +676,23 @@ test_expect_success HIGHLIGHT \
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# caching
+
+cat >>gitweb_config.perl <<\EOF
+$caching_enabled = 1;
+$cachedir = 'cache'; # to clear right thing
+EOF
+rm -rf cache
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
 test_done
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index dd83890..f3d0cf0 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -112,4 +112,43 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+
+# ----------------------------------------------------------------------
+# whether gitweb with caching enabled produces the same output
+
+test_expect_success 'setup for caching tests (utf8 commit, binary file)' '
+	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	cp "$TEST_DIRECTORY"/test9200a.png image.png &&
+	git add image.png &&
+	git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
+	gitweb_run "p=.git;a=patch" &&
+	mv gitweb.body no_cache.html &&
+	gitweb_run "p=.git;a=blob_plain;f=image.png" &&
+	mv gitweb.body no_cache.png
+'
+
+test_expect_success 'enable caching' '
+	cat >>gitweb_config.perl <<-\EOF &&
+	$caching_enabled = 1;
+	$cachedir = "cache"; # to clear right thing
+	EOF
+	rm -rf cache
+'
+
+for desc in 'generating cache' 'cached version'; do
+	test_expect_success "caching enabled, HTML output, $desc" '
+		gitweb_run "p=.git;a=patch" &&
+		mv gitweb.body cache.html &&
+		test_cmp no_cache.html cache.html
+	'
+done
+
+for desc in 'generating cache' 'cached version'; do
+	test_expect_success "caching enabled, binary output, $desc" '
+		gitweb_run "p=.git;a=blob_plain;f=image.png" &&
+		mv gitweb.body cache.png &&
+		cmp no_cache.png cache.png
+	'
+done
+
 test_done
-- 
1.7.3
