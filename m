From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 54/83] builtin/apply: make parse_chunk() return a negative integer on error
Date: Sun, 24 Apr 2016 15:33:54 +0200
Message-ID: <1461504863-15946-55-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEC-0000bM-BS
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbcDXNgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:04 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37856 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbcDXNgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:03 -0400
Received: by mail-wm0-f53.google.com with SMTP id n3so90220227wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJjJiGcbIZi6jfjTK3cXvJJR/7/WHQ1EpJ+gEnexT00=;
        b=hAEEptajsr2ESubev3636RTomncACbp+kGY/1uoePNv5dYob9IVo89agQpFoCH1b+/
         vYe687F9kMCAC2dTeKSVVWGh55QOmeaByRPYfI2WUhigf61du0lMst4RauAJJX5jnW1t
         0ZsR7ZR/mZpES96qaMUSQTqNnpt+GnVz1tRdc/jjxtwf36DLUx4Hx53RUtruj+Fmaf63
         BbzbYY+RKkBGFI5oxMoZrBC0k9oeDDXxyZn2sDa9MwTJ6xf1SQ5IO5vFt0es3hoT+w7v
         MzVCB+f+UISCU8SRFGBO5z2b6W9KaHP7AghH6j2jEossrIuWwvBXLbET8paNXsAGImZf
         Io8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJjJiGcbIZi6jfjTK3cXvJJR/7/WHQ1EpJ+gEnexT00=;
        b=S4v22dCpvnZoe9/7q9axqYBzz5i2ZdDLEse+826v8xOJGGAfuK2OE00e4Wu9cihYK4
         W/4SHZPTFlzzZ1l/QPcUi21kzb/L7YvdiKcqkFY66Onb6t7FkjWTEqaFdPBUM25XEkb+
         5LdiCmG6n784K4UdH32bPTdBZyoj7gybkwdqFCpMSBd0qqRBLrqAVZzEeYOffS2TacG0
         hD+x0uc3A8RKvcV9OOQDfcAY1DT1p/gw9E1M/7xeD9zcwebq6dKnOptOaZeJoSwJXJY4
         FwNWvGf9Ro9HcrxDUYphVMPJMYRfM1DOr1lb8Z8/k+4w5W54b3ZnU8HLDQDohLOaODdQ
         8iRQ==
X-Gm-Message-State: AOPr4FUW5IRTGfQtIT3MEkPHWBxlvaL5nBMunck1+AACvMB6DJv8aFtkyNnbEWnmwJ/1eg==
X-Received: by 10.28.88.138 with SMTP id m132mr7068742wmb.7.1461504961771;
        Sun, 24 Apr 2016 06:36:01 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292373>

This negative number can be -2 if no patch header has been found,
otherwise it is -1.

As parse_chunk() is called only by apply_patch() which already
returns -1 when an error happened, let's make it return -1 when
parse_chunk() returns -1.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 825ffe9..e1d6c8b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2110,22 +2110,22 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	return !state->has_include;
 }
 
-
 /*
  * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
- * Return the number of bytes consumed, so that the caller can call us
- * again for the next patch.
+ *
+ * Returns:
+ *   -1 on error,
+ *   -2 if no header was found,
+ *   the number of bytes consumed otherwise,
+ *     so that the caller can call us again for the next patch.
  */
 static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
-	if (offset == -1)
-		exit(1);
-
 	if (offset < 0)
 		return offset;
 
@@ -2185,8 +2185,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * empty to us here.
 		 */
 		if ((state->apply || state->check) &&
-		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state->linenr);
+		    (!patch->is_binary && !metadata_changes(patch))) {
+			return error(_("patch with only garbage at line %d"), state->linenr);
+		}
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4566,6 +4567,8 @@ static int apply_patch(struct apply_state *state,
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
+			if (nr == -1)
+				return -1;
 			break;
 		}
 		if (state->apply_in_reverse)
-- 
2.8.1.300.g5fed0c0
