From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Add tests for extra headers in format-patch
Date: Tue, 19 Feb 2008 02:40:28 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190239380.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:41:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRN6j-0006Rf-8V
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759790AbYBSHka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759841AbYBSHk3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:40:29 -0500
Received: from iabervon.org ([66.92.72.58]:33328 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759059AbYBSHk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:40:29 -0500
Received: (qmail 16201 invoked by uid 1000); 19 Feb 2008 07:40:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:40:28 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74384>

Presently, it works with each header ending with a newline, but not
without the newlines.

Also add a test to see that multiple "To:" headers get combined.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t4014-format-patch.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ac78752..28ab7b9 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -88,6 +88,40 @@ test_expect_success 'replay did not screw up the log message' '
 
 '
 
+test_expect_success 'extra headers' '
+
+	git config format.headers "To: R. E. Cipient <rcipient@example.com>
+" &&
+	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>
+" &&
+	git format-patch --stdout master..side > patch2 &&
+	sed -e "/^$/Q" patch2 > hdrs2 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs2 &&
+	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs2
+	
+'
+
+test_expect_failure 'extra headers without newlines' '
+
+	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
+	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>" &&
+	git format-patch --stdout master..side >patch3 &&
+	sed -e "/^$/Q" patch3 > hdrs3 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs3 &&
+	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs3
+	
+'
+
+test_expect_failure 'extra headers with multiple To:s' '
+
+	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
+	git config --add format.headers "To: S. E. Cipient <scipient@example.com>" &&
+	git format-patch --stdout master..side > patch4 &&
+	sed -e "/^$/Q" patch4 > hdrs4 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>,$" hdrs4 &&
+	grep "^ *S. E. Cipient <scipient@example.com>$" hdrs4
+'
+
 test_expect_success 'multiple files' '
 
 	rm -rf patches/ &&
-- 
1.5.4.1.192.g8ea3a
