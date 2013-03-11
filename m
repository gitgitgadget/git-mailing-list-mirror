From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 1/3] git p4 test: make sure P4CONFIG relative path works
Date: Mon, 11 Mar 2013 17:45:27 -0400
Message-ID: <1363038329-20185-2-git-send-email-pw@padd.com>
References: <5139883C.6080308@viscovery.net>
 <1363038329-20185-1-git-send-email-pw@padd.com>
Cc: =?UTF-8?q?Mikl=C3=B3s=20Fazekas?= <mfazekas@szemafor.com>,
	John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 22:46:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFAXy-0002su-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab3CKVpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 17:45:52 -0400
Received: from honk.padd.com ([74.3.171.149]:40827 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234Ab3CKVpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 17:45:52 -0400
Received: from arf.padd.com (unknown [50.55.138.130])
	by honk.padd.com (Postfix) with ESMTPSA id ABF003362;
	Mon, 11 Mar 2013 14:45:51 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AE2652261E; Mon, 11 Mar 2013 17:45:49 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.rc2.65.g92f3e2d
In-Reply-To: <1363038329-20185-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217914>

This adds a test for the fix in bf1d68f (git-p4: use absolute
directory for PWD env var, 2011-12-09).  It is necessary to
set PWD to an absolute path so that p4 can find files referenced
by non-absolute paths, like the value of the P4CONFIG environment
variable.

P4 does not open files directly; it builds a path by prepending
the contents of the PWD environment variable.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9808-git-p4-chdir.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index dc92e60..55c5e36 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -42,6 +42,20 @@ test_expect_success 'P4CONFIG and relative dir clone' '
 	)
 '
 
+# Common setup using .p4config to set P4CLIENT and P4PORT breaks
+# if clone destination is relative.  Make sure that chdir() expands
+# the relative path in --dest to absolute.
+test_expect_success 'p4 client root would be relative due to clone --dest' '
+	test_when_finished cleanup_git &&
+	(
+		echo P4PORT=$P4PORT >git/.p4config &&
+		P4CONFIG=.p4config &&
+		export P4CONFIG &&
+		unset P4PORT &&
+		git p4 clone --dest="git" //depot
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.2.rc2.65.g92f3e2d
