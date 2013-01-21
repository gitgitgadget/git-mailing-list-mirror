From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 07/10] sequencer.c: teach append_signoff to avoid adding a duplicate newline
Date: Mon, 21 Jan 2013 00:40:24 -0800
Message-ID: <1358757627-16682-8-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwU-0002yZ-WF
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab3AUIk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:58 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:65175 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3AUIk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:57 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so2623341dal.29
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9xVOaxUKp/9DKWTUB09pScH0dzibS4/rFzLHKCEu5bo=;
        b=mkhKEpvBU54XesluqzFQCdcORGlkuMa+fXtpFaxXnbncYnFxINlaKoMFjMM5HL1XvO
         WrsvLnKtuxIE7vFFesrh4jDZ9uGPFiB2XHLxeEOpbWc/OGiH5pYbfgsazkkftHfAoXcB
         Y4R2lg3np76PpGeaflO4O3qAcfoiSZDZcl6El5OOEo0SGKh3qI3oOEG5pOdaC9d8321E
         mWolFYy2LRA6xIaxpy6QRSUh/16f7OGnFDFrVh2MQMimNJwuOYU0LSZtIjVqyNLw1Nem
         2OpqJTwA+/dg+f0f0fClBbE8pnkJY07xvyfP1BZK7AarneCVxL45Ewxjvvkc5uzl5jqK
         qnAg==
X-Received: by 10.68.203.198 with SMTP id ks6mr27682305pbc.35.1358757656784;
        Mon, 21 Jan 2013 00:40:56 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.55
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:56 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214101>

Teach append_signoff to detect whether a blank line exists at the position
that the signed-off-by line will be added, and avoid adding an additional
one if one already exists.  This is necessary to allow format-patch to add a
s-o-b to a patch with no commit message without adding an extra newline.  A
following patch will make format-patch use this function rather than the
append_signoff implementation inside log-tree.c.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d4a2ece..d51e6f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1114,11 +1114,15 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
 
-	if (i)
-		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
-
-	if (!has_footer)
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+	if (msgbuf->buf[i] != '\n') {
+		if (i)
+			has_footer = has_conforming_footer(msgbuf, &sob,
+					ignore_footer);
+
+		if (!has_footer)
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+					"\n", 1);
+	}
 
 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-- 
1.8.1.1.252.gdb33759
