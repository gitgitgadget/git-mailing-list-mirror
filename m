From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Thu,  3 Jun 2010 16:35:20 +0200
Message-ID: <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 16:35:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBWV-0004yS-0l
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab0FCOft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:35:49 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:35822 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767Ab0FCOfr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 10:35:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9C19CF8ED5
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 10:35:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 10:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=i2Qi17kFQ0FyodiwvOj3VHUwuXk=; b=cM60d8Th3hEiPWI56g6/MwAMmBRQnTSJdFldgdiAZwcx23G2xTTCJ1gai9ONWAnk6G0J1nSrnYq9Xl9DrbqLi0ZW05VmeP4nJE9HrkeoVklvRSBHLlSYT8fbnkmcCgrrXrDHMmEaRlMHTfcHo1rHaGfiwgPt1tUj2uOuOv+E2Zk=
X-Sasl-enc: yqplRT13kxOQPbLajQBisLSRv7vEyGUxOi64fN+3tVbM 1275575746
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 08A9850EC8;
	Thu,  3 Jun 2010 10:35:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.351.ge2633e
In-Reply-To: <cover.1275575236.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148322>

This puts the "No newline at end of file" warning for both code paths
(emit_rewrite_lines for emit_rewrite_diff and fn_out_consume for
xdi_diff_outf) into diff.c so that it is easier to adjust later on.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 diff.c         |    2 ++
 xdiff/xutils.c |    5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 4e07744..ff44bcc 100644
--- a/diff.c
+++ b/diff.c
@@ -917,6 +917,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
 	}
+	if (line[len-1] != '\n')
+		fputs("\n\\ No newline at end of file\n", ecbdata->file);
 }
 
 static char *pprint_rename(const char *a, const char *b)
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index bc12f29..feb43a9 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -51,11 +51,6 @@ int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 	mb[0].size = psize;
 	mb[1].ptr = (char *) rec;
 	mb[1].size = size;
-	if (size > 0 && rec[size - 1] != '\n') {
-		mb[2].ptr = (char *) "\n\\ No newline at end of file\n";
-		mb[2].size = strlen(mb[2].ptr);
-		i++;
-	}
 	if (ecb->outf(ecb->priv, mb, i) < 0) {
 
 		return -1;
-- 
1.7.1.351.ge2633e
