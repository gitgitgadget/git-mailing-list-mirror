From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH 2/3] gitweb: break test suite into library and tests
Date: Sun, 23 Aug 2009 17:52:08 -0400
Message-ID: <4A91BA08.2010003@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfL41-000723-JG
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbZHWV5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbZHWV5M
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:57:12 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:36714 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750758AbZHWV5L (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 17:57:11 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7NLq9Pj002016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Aug 2009 17:52:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: f93d53dc-6594-4bc6-a5eb-58e30a1ecc40
X-Miltered: at mailchk-m05 with ID 4A91BA09.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sun, 23 Aug 2009 17:52:11 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126886>

To accommodate additions to the tests cases for gitweb, the preamble
from t9500 is now in its library so that new sets of tests for gitweb
can use the same setup without copying the same code.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 t/gitweb-lib.sh                        |   79 ++++++++++++++++++++++++++++++++
 t/t9500-gitweb-standalone-no-errors.sh |   74 +-----------------------------
 2 files changed, 80 insertions(+), 73 deletions(-)
 create mode 100644 t/gitweb-lib.sh

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
new file mode 100644
index 0000000..3a60fa5
--- /dev/null
+++ b/t/gitweb-lib.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Jakub Narebski
+#
+
+test_description='gitweb as standalone script (basic tests).
+
+This test runs gitweb (git web interface) as CGI script from
+commandline, and checks that it would not write any errors
+or warnings to log.'
+
+gitweb_init () {
+	safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
+	cat >gitweb_config.perl <<EOF
+#!/usr/bin/perl
+
+# gitweb configuration for tests
+
+our \$version = 'current';
+our \$GIT = 'git';
+our \$projectroot = "$safe_pwd";
+our \$project_maxdepth = 8;
+our \$home_link_str = 'projects';
+our \$site_name = '[localhost]';
+our \$site_header = '';
+our \$site_footer = '';
+our \$home_text = 'indextext.html';
+our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/gitweb.css');
+our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/git-logo.png';
+our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/git-favicon.png';
+our \$projects_list = '';
+our \$export_ok = '';
+our \$strict_export = '';
+
+EOF
+
+	cat >.git/description <<EOF
+$0 test repository
+EOF
+}
+
+gitweb_run () {
+	GATEWAY_INTERFACE='CGI/1.1'
+	HTTP_ACCEPT='*/*'
+	REQUEST_METHOD='GET'
+	SCRIPT_NAME="$TEST_DIRECTORY/../gitweb/gitweb.perl"
+	QUERY_STRING=""$1""
+	PATH_INFO=""$2""
+	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
+		SCRIPT_NAME QUERY_STRING PATH_INFO
+
+	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
+	export GITWEB_CONFIG
+
+	# some of git commands write to STDERR on error, but this is not
+	# written to web server logs, so we are not interested in that:
+	# we are interested only in properly formatted errors/warnings
+	rm -f gitweb.log &&
+	perl -- "$SCRIPT_NAME" \
+		>gitweb.output 2>gitweb.log &&
+	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; fi
+
+	# gitweb.log is left for debugging
+	# gitweb.output is used to parse http output
+}
+
+. ./test-lib.sh
+
+if ! test_have_prereq PERL; then
+	say 'skipping gitweb tests, perl not available'
+	test_done
+fi
+
+perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+    say 'skipping gitweb tests, perl version is too old'
+    test_done
+}
+
+gitweb_init
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6275181..a5b5b26 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -3,79 +3,7 @@
 # Copyright (c) 2007 Jakub Narebski
 #
 
-test_description='gitweb as standalone script (basic tests).
-
-This test runs gitweb (git web interface) as CGI script from
-commandline, and checks that it would not write any errors
-or warnings to log.'
-
-gitweb_init () {
-	safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
-	cat >gitweb_config.perl <<EOF
-#!/usr/bin/perl
-
-# gitweb configuration for tests
-
-our \$version = "current";
-our \$GIT = "git";
-our \$projectroot = "$safe_pwd";
-our \$project_maxdepth = 8;
-our \$home_link_str = "projects";
-our \$site_name = "[localhost]";
-our \$site_header = "";
-our \$site_footer = "";
-our \$home_text = "indextext.html";
-our @stylesheets = ("file:///$TEST_DIRECTORY/../gitweb/gitweb.css");
-our \$logo = "file:///$TEST_DIRECTORY/../gitweb/git-logo.png";
-our \$favicon = "file:///$TEST_DIRECTORY/../gitweb/git-favicon.png";
-our \$projects_list = "";
-our \$export_ok = "";
-our \$strict_export = "";
-
-EOF
-
-	cat >.git/description <<EOF
-$0 test repository
-EOF
-}
-
-gitweb_run () {
-	GATEWAY_INTERFACE="CGI/1.1"
-	HTTP_ACCEPT="*/*"
-	REQUEST_METHOD="GET"
-	SCRIPT_NAME="$TEST_DIRECTORY/../gitweb/gitweb.perl"
-	QUERY_STRING=""$1""
-	PATH_INFO=""$2""
-	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
-		SCRIPT_NAME QUERY_STRING PATH_INFO
-
-	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
-	export GITWEB_CONFIG
-
-	# some of git commands write to STDERR on error, but this is not
-	# written to web server logs, so we are not interested in that:
-	# we are interested only in properly formatted errors/warnings
-	rm -f gitweb.log &&
-	perl -- "$SCRIPT_NAME" \
-		>/dev/null 2>gitweb.log &&
-	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
-
-	# gitweb.log is left for debugging
-}
-
-. ./test-lib.sh
-
-if ! test_have_prereq PERL; then
-	say 'skipping gitweb tests, perl not available'
-	test_done
-fi
-
-perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
-    say 'skipping gitweb tests, perl version is too old'
-    test_done
-}
-
-gitweb_init
+. ./gitweb-lib.sh
 
 # ----------------------------------------------------------------------
 # no commits (empty, just initialized repository)
-- 
1.6.4
