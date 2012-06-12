From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] gitweb: Skip 'modification times' tests when no date parser
 available
Date: Tue, 12 Jun 2012 19:09:38 +0100
Message-ID: <4FD785E2.3020207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVYz-0002xp-Se
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab2FLSL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 14:11:27 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:38292 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753908Ab2FLSL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 14:11:26 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SeVYq-0002zQ-kC; Tue, 12 Jun 2012 18:11:25 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199825>


The If-Modified-Since support in Gitweb is conditional on the
availability of a date parser from either the HTTP::Date or
Time::ParseDate modules. If a suitable parser is not available,
then the corresponding 'modification times' tests should be skipped.

Introduce the DATE_PARSER test prerequisite and use it to skip
all of the dependent tests.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9501-gitweb-standalone-http-status.sh |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index fa2f65f..ef86948 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -12,6 +12,13 @@ code and message.'
 
 . ./gitweb-lib.sh
 
+#
+# Gitweb only provides the functionality tested by the 'modification times'
+# tests if it can access a date parser from one of these modules:
+#
+perl -MHTTP::Date -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
+perl -MTime::ParseDate -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
+
 # ----------------------------------------------------------------------
 # snapshot settings
 
@@ -115,14 +122,14 @@ test_debug 'cat gitweb.output'
 # ----------------------------------------------------------------------
 # modification times (Last-Modified and If-Modified-Since)
 
-test_expect_success 'modification: feed last-modified' '
+test_expect_success DATE_PARSER 'modification: feed last-modified' '
 	gitweb_run "p=.git;a=atom;h=master" &&
 	grep "Status: 200 OK" gitweb.headers &&
 	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
-test_expect_success 'modification: feed if-modified-since (modified)' '
+test_expect_success DATE_PARSER 'modification: feed if-modified-since (modified)' '
 	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=atom;h=master" &&
@@ -130,7 +137,7 @@ test_expect_success 'modification: feed if-modified-since (modified)' '
 '
 test_debug 'cat gitweb.headers'
 
-test_expect_success 'modification: feed if-modified-since (unmodified)' '
+test_expect_success DATE_PARSER 'modification: feed if-modified-since (unmodified)' '
 	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=atom;h=master" &&
@@ -138,14 +145,14 @@ test_expect_success 'modification: feed if-modified-since (unmodified)' '
 '
 test_debug 'cat gitweb.headers'
 
-test_expect_success 'modification: snapshot last-modified' '
+test_expect_success DATE_PARSER 'modification: snapshot last-modified' '
 	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
 	grep "Status: 200 OK" gitweb.headers &&
 	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
-test_expect_success 'modification: snapshot if-modified-since (modified)' '
+test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (modified)' '
 	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
@@ -153,7 +160,7 @@ test_expect_success 'modification: snapshot if-modified-since (modified)' '
 '
 test_debug 'cat gitweb.headers'
 
-test_expect_success 'modification: snapshot if-modified-since (unmodified)' '
+test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (unmodified)' '
 	export HTTP_IF_MODIFIED_SINCE="Thu, 7 Apr 2005 22:14:13 +0000" &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
@@ -161,7 +168,7 @@ test_expect_success 'modification: snapshot if-modified-since (unmodified)' '
 '
 test_debug 'cat gitweb.headers'
 
-test_expect_success 'modification: tree snapshot' '
+test_expect_success DATE_PARSER 'modification: tree snapshot' '
 	ID=`git rev-parse --verify HEAD^{tree}` &&
 	export HTTP_IF_MODIFIED_SINCE="Wed, 6 Apr 2005 22:14:13 +0000" &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
-- 
1.7.10
