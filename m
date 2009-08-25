From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH v2 3/3] gitweb: add t9501 tests for checking HTTP status codes
Date: Tue, 25 Aug 2009 01:03:48 -0400
Message-ID: <4A9370B4.9000009@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfoCQ-0007nM-2v
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbZHYFDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 01:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbZHYFDu
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:03:50 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:33626 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754011AbZHYFDu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 01:03:50 -0400
Received: from karakura.local (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7P53nXC018583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Aug 2009 01:03:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: 83fe5e3d-f2fe-4809-b363-0d62606ee300
X-Miltered: at mailchk-m05 with ID 4A9370B5.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Tue, 25 Aug 2009 01:03:50 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127003>

Commit message changed as suggested by Jakub.

Also added a test_description, and removed a bit of whitespace
that I hadn't noticed before.

-- 
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--->8---
This commit adds a new test file, t9501, that is used for gitweb
test cases that check HTTP status codes and messages.

Currently, the only tests are for the snapshot feature.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 t/t9501-gitweb-standalone-http-status.sh |   78 ++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 t/t9501-gitweb-standalone-http-status.sh

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
new file mode 100644
index 0000000..d0ff21d
--- /dev/null
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Mark Rada
+#
+
+test_description='gitweb as standalone script (http status tests).
+
+This test runs gitweb (git web interface) as a CGI script from the
+commandline, and checks that it returns the expected HTTP status
+code and message.'
+
+
+. ./gitweb-lib.sh
+
+# ----------------------------------------------------------------------
+# snapshot settings
+
+test_commit \
+	'SnapshotTests' \
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
