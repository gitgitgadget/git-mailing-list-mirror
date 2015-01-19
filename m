From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 11/18] fsck: Add a simple test for receive.fsck.*
Date: Mon, 19 Jan 2015 16:51:14 +0100
Organization: gmx
Message-ID: <ba5b133ec7dfad799107f041489f693022f0fcc8.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjg-0006Dy-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbASP7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:25 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751349AbbASP7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:24 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFpE6i026385;
	Mon, 19 Jan 2015 16:51:14 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFpEfR026384;
	Mon, 19 Jan 2015 16:51:14 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262618>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..d491172 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,24 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit << EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.warn = missing-email' '
+	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.warn missing-email &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missing-email" act
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
