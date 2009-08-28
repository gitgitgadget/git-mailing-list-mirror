From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH v3 2/3] gitweb: split test suite into library and tests
Date: Thu, 27 Aug 2009 22:07:07 -0400
Message-ID: <4A973BCB.7000802@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 04:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgqs5-0006ii-8r
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 04:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZH1CHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 22:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZH1CHL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 22:07:11 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:33051 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751203AbZH1CHK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 22:07:10 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7S2777u022737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Aug 2009 22:07:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: c53ed288-a570-4e1f-88da-e24bae7cac6a
X-Miltered: at mailchk-m05 with ID 4A973BCB.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Thu, 27 Aug 2009 22:07:09 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127243>

I just fixed a typo in the commit message, a really obvious typo
that had to be pointed out to me...

I hope this is not too late.

-- 
Mark A Rada (ferrous26)
marada@uwaterloo.ca

--->8---
To accommodate additions to the test cases for gitweb, the preamble
from t9500 is now in its own library so that new sets of tests for
gitweb can use the same setup without copying the code.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 t/gitweb-lib.sh                        |   73 ++++++++++++++++++++++++++++++++
 t/t9500-gitweb-standalone-no-errors.sh |   67 +----------------------------
 2 files changed, 74 insertions(+), 66 deletions(-)
 create mode 100644 t/gitweb-lib.sh

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
new file mode 100644
index 0000000..8452532
--- /dev/null
+++ b/t/gitweb-lib.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Jakub Narebski
+#
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
index 6275181..2fc7fdb 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -9,73 +9,8 @@ This test runs gitweb (git web interface) as CGI script from
 commandline, and checks that it would not write any errors
 or warnings to log.'
 
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
1.6.4.1
