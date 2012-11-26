From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 01/11] sequencer.c: remove broken support for rfc2822 continuation in footer
Date: Sun, 25 Nov 2012 17:45:49 -0800
Message-ID: <1353894359-6733-2-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnmk-00074p-W5
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab2KZBqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:46:36 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56814 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab2KZBqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:46:36 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4643368pad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M40QsJPr8D9x4dzAN1julmZ2iCbU3cMetCGHcH/TisY=;
        b=Pbi6IHN7sDl9nZWqHnnSftPrbeEkRFPQ7bRsbrwJD7bqKR0NV3xGcsCF73/361cZ/D
         /D9Ye1m1jypG2UPQssDkWrO0ud5ot08S8ju/Tf3hEWG3b6dqaBPWJ/JQxkz3B+uy+uOV
         R/maETtNGR6DE38Lodw+ye4vIwfBLtUa0dzbKkZ80wRYfcdhpVzVPVlBCWEdm5PtC7Wc
         l2SwIsYii1rwrLW+8UX4iyXplZYPQiWFOEAjBMvbYqzqxLztf6we7VxHAC4gxfW5hy0d
         GVYott1/okWc25jTMDI2V5tMm2D4c4cDWe8FgbEygGRerVJ2RgW+3abxAF5pwEOi+2s7
         tHCw==
Received: by 10.68.197.197 with SMTP id iw5mr32885286pbc.22.1353894395599;
        Sun, 25 Nov 2012 17:46:35 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.46.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:46:34 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210391>

Commit c1e01b0c generalized the detection of the last paragraph
signed-off-by footer and used rfc2822 as a guideline.  Support for rfc2822
style continuation lines was also implemented, but not correctly, so it has
never detected a line beginning with space or tab as a continuation of the
previous line.

Since a commit message is not governed by the line length limits imposed
by rfc2822 for email messages, and it does not seem like this functionality
would produce "better" commit messages anyway, let's remove this broken
functionality.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2260490..656df6b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1023,7 +1023,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 	int hit = 0;
 	int i, j, k;
 	int len = sb->len - ignore_footer;
-	int first = 1;
 	const char *buf = sb->buf;
 
 	for (i = len - 1; i > 0; i--) {
@@ -1040,11 +1039,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 			; /* do nothing */
 		k++;
 
-		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
-			continue;
-
-		first = 0;
-
 		for (j = 0; i + j < len; j++) {
 			ch = buf[i + j];
 			if (ch == ':')
-- 
1.8.0.284.g959048a
