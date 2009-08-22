From: Mark A Rada <marada@uwaterloo.ca>
Subject: [RFC] gitweb.perl t9500 t9501
Date: Sat, 22 Aug 2009 18:42:56 -0400
Message-ID: <4C812C4E-815B-478D-AEB1-3F1DEC5D3641@mailservices.uwaterloo.ca>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org> <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca> <200908212006.16333.jnareb@gmail.com> <7vfxbldj31.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 00:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MezIo-0007qV-Jz
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 00:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbZHVWnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 18:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933023AbZHVWnE
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 18:43:04 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:53989 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932901AbZHVWnC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 18:43:02 -0400
Received: from [192.168.1.105] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7MMgudt012437
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 22 Aug 2009 18:42:59 -0400
In-Reply-To: <7vfxbldj31.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
X-UUID: 315fde44-7f59-4262-9e0c-74712b8569de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126825>

Ok, I have a few questions, please:


> Word-wrapped.

I have not been telling git-format-patch to use a specific width for  
the diffstat, is the
standard width supposed to be 70? Also, you will note a line in the  
patch below
that will definitely be broken, it looks like

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb- 
standalone-no-errors.sh

I don't see an option for git-format-patch to get around that in the  
man page,
how would I fix that?


> I do not mind keeping these two lines as belt-and-suspender, though.

That is a vivid analogy...I will have to remember that one for later.

I tried switching the order of the last two checks, and I think it  
makes that unused
check more useful, it can inform clients they are trying something  
that has been
explicitly disabled as opposed to just notifying them the format is  
unsupported.

Do you think making the change is worthwhile? (new commit? rewinding?)
(The patch at the bottom currently assumes you have switched them  
already.)

another snippet:
@@ -5175,10 +5175,10 @@ sub git_snapshot {
                 die_error(400, "Invalid snapshot format parameter");
         } elsif (!exists($known_snapshot_formats{$format})) {
                 die_error(400, "Unknown snapshot format");
-       } elsif (!grep($_ eq $format, @snapshot_fmts)) {
-               die_error(403, "Unsupported snapshot format");
         } elsif ($known_snapshot_formats{$format}{'disabled'}) {
                 die_error(403, "Snapshot format not allowed");
+       } elsif (!grep($_ eq $format, @snapshot_fmts)) {
+               die_error(403, "Unsupported snapshot format");
         }

         if (!defined $hash) {


>> A trick: use '\EOF' and you don't need to escape $ against variable
>> expansion by shell.
> It is not a "trick" but is a basic courtesy for reviewers.  Even if  
> you do
> not have any $ to worry about, _unless_ you actively know you would  
> want
> variable substitution to happen, it is easier for readers if you  
> signal
> the fact that the here-doc is verbatim by quoting the \EOF marker  
> upfront.

Thanks for the protip, I've taken the liberty of making use of it for  
gitweb-lib.sh,
I hope you don't mind, Jakub.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


---
  t/gitweb-lib.sh                          |   74 +++++++++++++++++++
  t/t9500-gitweb-standalone-no-errors.sh   |   68 +-----------------
  t/t9501-gitweb-standalone-http-status.sh |   78 ++++++++++++++++++++
  3 files changed, 153 insertions(+), 67 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
new file mode 100644
index 0000000..4f4115f
--- /dev/null
+++ b/t/gitweb-lib.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Jakub Narebski
+#
+
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
+perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1  
|| {
+    say 'skipping gitweb tests, perl version is too old'
+    test_done
+}
+
+gitweb_init
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb- 
standalone-no-errors.sh
index 6275181..32e47d3 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -9,73 +9,7 @@ This test runs gitweb (git web interface) as CGI  
script from
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
-perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1  
|| {
-    say 'skipping gitweb tests, perl version is too old'
-    test_done
-}
-
-gitweb_init
+. ./gitweb-lib.sh

  #  
----------------------------------------------------------------------
  # no commits (empty, just initialized repository)
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb- 
standalone-http-status.sh
new file mode 100644
index 0000000..be042f0
--- /dev/null
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Mark Rada
+#
+
+
+test_description='gitweb as standalone script (http status tests).
+
+This test runs gitweb (git web interface) as CGI script from the
+commandline, and checks that it returns the appropriate http status
+code and message.'
+
+. ./gitweb-lib.sh
+
+#  
----------------------------------------------------------------------
+# snapshot settings
+
+test_commit \
+	'GITWEB' \
+	'I CAN HAS SNAPSHOT?'
+
+cat >>gitweb_config.perl <<\EOF
+$feature{'snapshot'}{'override'} = 0;
+EOF
+
+test_expect_success \
+	'snapshots: tgz only default format enabled' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
+	grep "403 - Unsupported snapshot format" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
+	grep "403 - Snapshot format not allowed" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+	grep "403 - Unsupported snapshot format" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<\EOF
+$feature{'snapshot'}{'default'} = ['tgz','tbz2','txz','zip'];
+EOF
+
+test_expect_success \
+	'snapshots: all enabled in default, use default disabled value' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
+	grep "Status: 200 OK" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
+	grep "403 - Snapshot format not allowed" gitweb.output &&
+	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<\EOF
+$known_snapshot_formats{'zip'}{'disabled'} = 1;
+EOF
+
+test_expect_success \
+	'snapshots: zip explicitly disabled' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+	grep "403 - Snapshot format not allowed" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<\EOF
+$known_snapshot_formats{'tgz'}{'disabled'} = 0;
+EOF
+
+test_expect_success \
+	'snapshots: tgz explicitly enabled' \
+	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+	grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+test_done
-- 
1.6.4
