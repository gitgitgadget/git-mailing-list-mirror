From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 01/11] sequencer.c: rework search for start of footer to improve clarity
Date: Sun, 27 Jan 2013 17:11:45 -0800
Message-ID: <1359335515-13818-2-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdH4-0006Mm-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039Ab3A1BMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:16 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:47847 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab3A1BMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:15 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so1198609pad.21
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pDuuaAqWJlsO+WDMI+1ZYSnFfFBHiwqsWo2SP0VHgcQ=;
        b=rCm4Rasr7cNZwQ6ZXJF5YyKbX2qEha6gfS0SM/HGy3t3G6Nd+uoadoBnGVouIGsV+F
         Lr2tt1cV6zOPAXndYzFQVUAbJLipR7g6VzKPfnAlEBipRVj/sZNg+Y05bYZsigx4hL2f
         hcE8WP0V0uEA4k8BL1hQKdpZ8Y8TgIa3m3UuPFYUWp8EZvjrFXLpeP/k+ZZWciH8gJJb
         6klESaWxfGMOdwnQegLROcMXw5elm4YzkMYGeT7TJFC9nzBPm0G6fIak7e3kHFz0GoRv
         XA6riUr93viv5WaY+qQDgjKARlqbC7KJslu9/Zifp0F2jeYIErQASFzg0Pz/L1guWkhb
         HUEA==
X-Received: by 10.68.231.41 with SMTP id td9mr33181779pbc.128.1359335535241;
        Sun, 27 Jan 2013 17:12:15 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.13
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:14 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214766>

This code sequence is somewhat difficult to read.  Let's rewrite it
using more descriptive variable names to try to make it easier to
understand.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 sequencer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index aef5e8a..cd211b2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1024,16 +1024,19 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 {
 	int ch;
-	int hit = 0;
+	int last_char_was_nl, this_char_is_nl;
 	int i, j, k;
 	int len = sb->len - ignore_footer;
 	int first = 1;
 	const char *buf = sb->buf;
 
+	/* find start of last paragraph */
+	last_char_was_nl = 0;
 	for (i = len - 1; i > 0; i--) {
-		if (hit && buf[i] == '\n')
+		this_char_is_nl = (buf[i] == '\n');
+		if (last_char_was_nl && this_char_is_nl)
 			break;
-		hit = (buf[i] == '\n');
+		last_char_was_nl = this_char_is_nl;
 	}
 
 	while (i < len - 1 && buf[i] == '\n')
-- 
1.8.1.1.450.g0327af3
