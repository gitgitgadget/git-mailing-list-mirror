From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/4] git-p4: test for absolute PWD problem
Date: Fri,  9 Dec 2011 18:48:17 -0500
Message-ID: <1323474497-14339-5-git-send-email-pw@padd.com>
References: <1323474497-14339-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:49:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZACM-0007FQ-JE
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab1LIXtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:49:42 -0500
Received: from honk.padd.com ([74.3.171.149]:44005 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755108Ab1LIXtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:49:42 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id ACBC7EE;
	Fri,  9 Dec 2011 15:49:41 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3F6EA313BB; Fri,  9 Dec 2011 18:49:38 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.4.gc2b11.dirty
In-Reply-To: <1323474497-14339-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186709>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9808-chdir.sh |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100755 t/t9808-chdir.sh

diff --git a/t/t9808-chdir.sh b/t/t9808-chdir.sh
new file mode 100755
index 0000000..e6fd681
--- /dev/null
+++ b/t/t9808-chdir.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='git-p4 relative chdir'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1"
+	)
+'
+
+# P4 reads from P4CONFIG file to find its server params, if the
+# environment variable is set
+test_expect_success 'P4CONFIG and absolute dir clone' '
+	printf "P4PORT=$P4PORT\nP4CLIENT=$P4CLIENT\n" >p4config &&
+	test_when_finished "rm \"$TRASH_DIRECTORY/p4config\"" &&
+	test_when_finished cleanup_git &&
+	(
+                P4CONFIG=p4config && export P4CONFIG &&
+		unset P4PORT P4CLIENT &&
+		"$GITP4" clone --verbose --dest="$git" //depot
+	)
+'
+
+# same thing, but with relative directory name, note missing $ on --dest
+test_expect_success 'P4CONFIG and relative dir clone' '
+	printf "P4PORT=$P4PORT\nP4CLIENT=$P4CLIENT\n" >p4config &&
+	test_when_finished "rm \"$TRASH_DIRECTORY/p4config\"" &&
+	test_when_finished cleanup_git &&
+	(
+                P4CONFIG=p4config && export P4CONFIG &&
+		unset P4PORT P4CLIENT &&
+		"$GITP4" clone --verbose --dest="git" //depot
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.rc4.42.g8317d
