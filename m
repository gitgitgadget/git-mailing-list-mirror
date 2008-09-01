From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/1] fast-import: show a warning for non-existent files.
Date: Mon,  1 Sep 2008 16:20:14 +0300
Message-ID: <1220275214-6178-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 15:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka9Lw-0003vL-9H
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 15:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYIANUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbYIANUt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 09:20:49 -0400
Received: from smtp.nokia.com ([192.100.122.233]:48630 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbYIANUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 09:20:48 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m81DKUHW001869;
	Mon, 1 Sep 2008 16:20:44 +0300
Received: from vaebh102.NOE.Nokia.com ([10.160.244.23]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 16:20:31 +0300
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by vaebh102.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 16:20:26 +0300
Received: from mgw-int02.ntc.nokia.com ([172.21.143.97]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 16:20:16 +0300
Received: from annwn.felipec.org (esdhcp04373.research.nokia.com [172.21.43.73])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m81DKET9012901;
	Mon, 1 Sep 2008 16:20:14 +0300
Received: by annwn.felipec.org (Postfix, from userid 500)
	id 48CF84C027; Mon,  1 Sep 2008 16:20:14 +0300 (EEST)
X-Mailer: git-send-email 1.6.0.1
X-OriginalArrivalTime: 01 Sep 2008 13:20:16.0330 (UTC) FILETIME=[793842A0:01C90C35]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94585>

This is useful in certain SCMs like monotone, where each 'merge revision' has
the changes of all the micro-branches merged. So it appears as duplicated commands.

The delete command was ignoring the issue completely. The rename/copy commands
where throwing a fatal exception.
---
 fast-import.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7089e6f..3dd2ab6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1945,6 +1945,7 @@ static void file_change_d(struct branch *b)
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
+	struct tree_entry leaf;
 
 	strbuf_reset(&uq);
 	if (!unquote_c_style(&uq, p, &endp)) {
@@ -1952,7 +1953,13 @@ static void file_change_d(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_remove(&b->branch_tree, p, NULL);
+	memset(&leaf, 0, sizeof(leaf));
+	tree_content_remove(&b->branch_tree, p, &leaf);
+	if (!leaf.versions[1].mode)
+	{
+		warning("Path %s not in branch", p);
+		return;
+	}
 }
 
 static void file_change_cr(struct branch *b, int rename)
@@ -1994,7 +2001,10 @@ static void file_change_cr(struct branch *b, int rename)
 	else
 		tree_content_get(&b->branch_tree, s, &leaf);
 	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", s);
+	{
+		warning("Path %s not in branch", s);
+		return;
+	}
 	tree_content_set(&b->branch_tree, d,
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
-- 
1.6.0.1
