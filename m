From: David Barr <david.barr@cordelta.com>
Subject: [PATCH] vcs-svn: Avoid %z in format string
Date: Sat,  4 Sep 2010 21:58:59 +1000
Message-ID: <1283601539-4477-1-git-send-email-david.barr@cordelta.com>
References: <1283586214-31204-2-git-send-email-artagnon@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 14:09:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrrYU-0003iG-39
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 14:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab0IDMJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 08:09:05 -0400
Received: from fallbackmx10.syd.optusnet.com.au ([211.29.132.251]:57838 "EHLO
	fallbackmx10.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752494Ab0IDMJE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 08:09:04 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Sep 2010 08:09:03 EDT
Received: from mail01.syd.optusnet.com.au (mail01.syd.optusnet.com.au [211.29.132.182])
	by fallbackmx10.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o84C10tj008618
	for <git@vger.kernel.org>; Sat, 4 Sep 2010 22:01:00 +1000
Received: from localhost.localdomain (d110-33-90-9.mit3.act.optusnet.com.au [110.33.90.9])
	by mail01.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o84Bxbqg012865;
	Sat, 4 Sep 2010 21:59:38 +1000
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1283586214-31204-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155320>

In the spirit of v1.6.4-rc0~124 (MinGW: Fix compiler warning in
merge-recursive, 2009-05-23), use a 64-bit integer instead.
---
 vcs-svn/svndiff.c |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 901fc1a..12b7459 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -57,7 +57,7 @@ size_t read_one_instruction(struct svndiff_instruction *op)
 	   bits; the remaining 6 bits may contain the length */
 	action = (c >> 6) & 3;
 	if (action >= 3)
-		die("Invalid instruction %d", action);
+		die("Invalid instruction %"PRIu64, (uint64_t) action);
 
 	op->action_code = (enum svndiff_action)(action);
 
@@ -93,39 +93,44 @@ size_t read_instructions(struct svndiff_window *window, size_t *ninst)
 		bsize += read_one_instruction(op);
 
 		if (DEBUG)
-			fprintf(stderr, "Instruction: %d %d %d (%d)\n",
-				op->action_code, op->length, op->offset, bsize);
+			fprintf(stderr,
+				"Instruction: %"PRIu64" %"PRIu64" %"PRIu64" (%"PRIu64")\n",
+				(uint64_t) op->action_code,
+				(uint64_t) op->length,
+				(uint64_t) op->offset,
+				(uint64_t) bsize);
 
 		if (op == NULL)
 			die("Invalid diff stream: "
-			    "instruction %d cannot be decoded", *ninst);
+				"instruction %"PRIu64" cannot be decoded", (uint64_t) *ninst);
 		else if (op->length == 0)
 			die("Invalid diff stream: "
-			    "instruction %d has length zero", *ninst);
+				"instruction %"PRIu64" has length zero", (uint64_t) *ninst);
 		else if (op->length > window->tview_len - tpos)
 			die("Invalid diff stream: "
-			    "instruction %d overflows the target view", *ninst);
+				"instruction %"PRIu64" overflows the target view",
+			(uint64_t) *ninst);
 
 		switch (op->action_code)
 		{
 		case copyfrom_source:
 			if (op->length > window->sview_len - op->offset ||
-			    op->offset > window->sview_len)
+				op->offset > window->sview_len)
 				die("Invalid diff stream: "
-				    "[src] instruction %d overflows "
-				    " the source view", *ninst);
+					"[src] instruction %"PRIu64" overflows "
+					" the source view", (uint64_t) *ninst);
 			break;
 		case copyfrom_target:
 			if (op->offset >= tpos)
 				die("Invalid diff stream: "
-				    "[tgt] instruction %d starts "
-				    "beyond the target view position", *ninst);
+					"[tgt] instruction %"PRIu64" starts "
+					"beyond the target view position", (uint64_t) *ninst);
 			break;
 		case copyfrom_new:
 			if (op->length > window->newdata_len - npos)
 				die("Invalid diff stream: "
-				    "[new] instruction %d overflows "
-				    "the new data section", *ninst);
+					"[new] instruction %"PRIu64" overflows "
+					"the new data section", (uint64_t) *ninst);
 			npos += op->length;
 			break;
 		}
@@ -163,9 +168,13 @@ size_t read_window_header(struct svndiff_window *window)
 		die("Svndiff contains corrupt window header");
 
 	if (DEBUG)
-		fprintf(stderr, "Window header: %d %d %d %d %d\n",
-			window->sview_offset, window->sview_len,
-			window->tview_len, window->ins_len, window->newdata_len);
+		fprintf(stderr,
+			"Window header: %"PRIu64" %"PRIu64" %"PRIu64" %"PRIu64" %"PRIu64"\n",
+			(uint64_t) window->sview_offset,
+			(uint64_t) window->sview_len,
+			(uint64_t) window->tview_len,
+			(uint64_t) window->ins_len,
+			(uint64_t) window->newdata_len);
 	return bsize;
 }
 
-- 
1.7.2.2
