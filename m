From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/5] Add more tests for format-patch
Date: Mon, 18 Feb 2008 22:56:02 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182254000.5816@iabervon.org>
References: <cover.1203392527.git.barkalow@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 04:57:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRJbR-0002Fp-SU
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 04:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYBSD4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 22:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYBSD4W
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 22:56:22 -0500
Received: from iabervon.org ([66.92.72.58]:54147 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbYBSD4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 22:56:04 -0500
Received: (qmail 22293 invoked by uid 1000); 19 Feb 2008 03:56:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 03:56:02 -0000
In-Reply-To: <cover.1203392527.git.barkalow@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74368>

Tests -o, and an excessively long subject, and --thread, with and
without --in-reply-to=

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t4014-format-patch.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0a6fe53..6e8b5f4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -88,4 +88,49 @@ test_expect_success 'replay did not screw up the log message' '
 
 '
 
+test_expect_success 'multiple files' '
+
+	rm -rf patches/ &&
+	git checkout side &&
+	git format-patch -o patches/ master &&
+	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
+'
+
+test_expect_success 'thread' '
+
+	rm -rf patches/ &&
+	git checkout side &&
+	git format-patch --thread -o patches/ master &&
+	FIRST_MID=$(grep "Message-Id:" patches/0001-* | sed "s/^[^<]*\(<[^>]*>\).*$/\1/") &&
+	for i in patches/0002-* patches/0003-*
+	do
+	  grep "References: $FIRST_MID" $i &&
+	  grep "In-Reply-To: $FIRST_MID" $i
+	done
+'
+
+test_expect_success 'thread in-reply-to' '
+
+	rm -rf patches/ &&
+	git checkout side &&
+	git format-patch --in-reply-to="<test.message>" --thread -o patches/ master &&
+	FIRST_MID="<test.message>" &&
+	for i in patches/*
+	do
+	  grep "References: $FIRST_MID" $i &&
+	  grep "In-Reply-To: $FIRST_MID" $i
+	done
+'
+
+test_expect_success 'excessive subject' '
+
+	rm -rf patches/ &&
+	git checkout side &&
+	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >>file &&
+	git update-index file &&
+	git commit -m "This is an excessively long subject line for a message due to the habit some projects have of not having a short, one-line subject at the start of the commit message, but rather sticking a whole paragraph right at the start as the only thing in the commit message. It had better not become the filename for the patch." &&
+	git format-patch -o patches/ master..side &&
+	ls patches/0004-This-is-an-excessively-long-subject-line-for-a-messa.patch
+'
+
 test_done
-- 
1.5.4.1.191.gfbf10
