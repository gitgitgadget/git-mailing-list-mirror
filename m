From: Mark Rada <marada@uwaterloo.ca>
Subject: [RFC/PATCH 3/3] gitweb: add test cases for snapshot settings
Date: Sun, 23 Aug 2009 17:53:23 -0400
Message-ID: <4A91BA53.1040800@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfL5C-0007W3-0g
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbZHWV61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbZHWV60
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:58:26 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:46341 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750800AbZHWV60 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 17:58:26 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7NLrNZK016732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Aug 2009 17:53:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: dbe78306-8773-474c-9c39-14e3f27241c2
X-Miltered: at mailchk-m04 with ID 4A91BA53.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Sun, 23 Aug 2009 17:53:25 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126887>

This commit adds a new test file (t9501) that is used for gitweb test
cases that parse gitweb output to verify the HTTP status code or
message.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 t/t9501-gitweb-standalone-http-status.sh |   71 ++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 t/t9501-gitweb-standalone-http-status.sh

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
new file mode 100644
index 0000000..c4b0479
--- /dev/null
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Mark Rada
+#
+
+. ./gitweb-lib.sh
+
+# ----------------------------------------------------------------------
+# snapshot settings
+
+test_commit \
+	'SnapshotTest' \
+	'i can has snapshot?'
+
+cat >>gitweb_config.perl <<\EOF
+$feature{'snapshot'}{'override'} = 0;
+EOF
+
+test_expect_success \
+    'snapshots: tgz only default format enabled' \
+    'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+    grep "Status: 200 OK" gitweb.output &&
+    gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
+    grep "403 - Unsupported snapshot format" gitweb.output &&
+    gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
+    grep "403 - Snapshot format not allowed" gitweb.output &&
+    gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+    grep "403 - Unsupported snapshot format" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<\EOF
+$feature{'snapshot'}{'default'} = ['tgz','tbz2','txz','zip'];
+EOF
+
+test_expect_success \
+    'snapshots: all enabled in default, use default disabled value' \
+    'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+    grep "Status: 200 OK" gitweb.output &&
+    gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
+    grep "Status: 200 OK" gitweb.output &&
+    gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
+    grep "403 - Snapshot format not allowed" gitweb.output &&
+    gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+    grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<\EOF
+$known_snapshot_formats{'zip'}{'disabled'} = 1;
+EOF
+
+test_expect_success \
+    'snapshots: zip explicitly disabled' \
+    'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
+    grep "403 - Snapshot format not allowed" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+cat >>gitweb_config.perl <<\EOF
+$known_snapshot_formats{'tgz'}{'disabled'} = 0;
+EOF
+
+test_expect_success \
+    'snapshots: tgz explicitly enabled' \
+    'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
+    grep "Status: 200 OK" gitweb.output'
+test_debug 'cat gitweb.output'
+
+
+test_done 
-- 
1.6.4
