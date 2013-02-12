From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 01/12] sequencer.c: rework search for start of footer to improve clarity
Date: Tue, 12 Feb 2013 02:17:28 -0800
Message-ID: <1360664260-11803-2-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5CwY-0001xJ-7W
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405Ab3BLKSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:05 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41832 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144Ab3BLKSE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:04 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so9181pad.10
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=aSivzG110os4tqntqfkGK9KyackoC+GHmsMOclDjXMU=;
        b=rq1y170kw1v3MgLJMJb9o+GVnSNCN1eJC/MyycEZMgK16A2T4TKqjieWxCcGt1K3TB
         zNZ51zofadgGiRzXMtWMnHFuOb9UWz0yj5isb3iecwdrK2JBkdiz0wh4+keVCS5WAuiK
         SmWJXVy/nE+JQqRpFC+Io8ThgpGiuABvTCVL3ajTgSDz6WJ1YvwEl12Q2G+frGk2mO3B
         oxLsRxvzVaVOFoJTHSzKKl0wXXbF9Pp7xfxiqalejJabrMFxiJN9YZGq/vffGuHrfMPc
         Zp+y6bqTcnNbo0IdGctTVGXE7o1XNfqHLN0x2agZxP7K/E6IKm8r4NNvcrbP83NlRUaC
         ZmLA==
X-Received: by 10.66.88.198 with SMTP id bi6mr50783497pab.54.1360664283959;
        Tue, 12 Feb 2013 02:18:03 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.01
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:02 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216130>

From: Jonathan Nieder <jrnieder@gmail.com>

This code sequence is somewhat difficult to read.  Let's rewrite it and add
some comments to improve clarity.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index aef5e8a..dbeff01 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1023,19 +1023,21 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 
 static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 {
-	int ch;
-	int hit = 0;
+	char ch, prev;
 	int i, j, k;
 	int len = sb->len - ignore_footer;
 	int first = 1;
 	const char *buf = sb->buf;
 
+	prev = '\0';
 	for (i = len - 1; i > 0; i--) {
-		if (hit && buf[i] == '\n')
+		ch = buf[i];
+		if (prev == '\n' && ch == '\n') /* paragraph break */
 			break;
-		hit = (buf[i] == '\n');
+		prev = ch;
 	}
 
+	/* advance to start of last paragraph */
 	while (i < len - 1 && buf[i] == '\n')
 		i++;
 
-- 
1.8.1.3.579.gd9af3b6
