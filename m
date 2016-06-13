From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 05/40] builtin/apply: make parse_chunk() return a negative integer on error
Date: Mon, 13 Jun 2016 18:09:07 +0200
Message-ID: <20160613160942.1806-6-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURN-0003VW-Av
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424819AbcFMQKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33269 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424773AbcFMQKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so16041492wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2yDf9N4MFXAjDxX7Da/fC1k7eSF5wTO02Iqp/COnqw=;
        b=VY0aabvAvJ522j1FOCcSkqAsOAOHeLSfJPIQrsdBajrmOXXGM9ec9Rmf6xz7Mm1vX8
         859Jd8qEgq6n+z4H48NvPs/UexueZaIY7nwPID0T2mzBccrgAbUA1Ap3kJwdm9aimKHy
         XWI0xSXLIqKyNwrHHbyYB9xdgPo5UpLN1sI9Lioteff5xFXUzjDrvuJ0f/G1satyafC7
         zbwuW1Akod2ICK1VWuuz1vjm7JI5fCqtQNh/O8SsoMWanSLTK6+wvlJFEuCkBQ4WRTdn
         LTatsr98Fw0GTzAO7T/NJxj1k7WKpmKf6XX0TrSBySJfOF7VRPI3mQMraZ/bLJQHoxGQ
         3ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2yDf9N4MFXAjDxX7Da/fC1k7eSF5wTO02Iqp/COnqw=;
        b=ih/T2s9u+I9QAujdJuS6kcy7FXvsDah+bBSoE02uEPKhO268NaX61IDT4LMPB/X0d/
         uaCiMijElDRNSgyVAlPXTYg8rUBcAcQw6BJGNkDFna6gCEw16RjMWvoTtmUGSdD32Mn/
         l/RWulM9M9zjKXMXTBx2P03wPabN6R7XkSwx2EGFK/tflSyhxNUmKbVtzfDHHfkvqpn7
         TsOXsVhdGNJDBPWqxYoqIX0sn7Qk3WazmQeD5gYQHTu0RMDbcyTdwxblTh7rBkH6IxMB
         FqwKtKFsVsoGNVBN5ibahc/GCe0WkHmdk0eNMfgHwQyGjjsk7Dr7mO3Fh1M5OVmCWmOd
         j/Ig==
X-Gm-Message-State: ALyK8tJ9KuzzAFsAhU67wMFEE5HknNISdzOsZpAnTcaRNkzGmy0Zm0A+bjq2llhs3AxNUg==
X-Received: by 10.28.68.67 with SMTP id r64mr1873846wma.57.1465834203996;
        Mon, 13 Jun 2016 09:10:03 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297194>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing or exit()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_chunk() should return -1 instead of calling
die() or exit().

As parse_chunk() is called only by apply_patch() which already
returns -1 when an error happened, let's make apply_patch() return -1
when parse_chunk() returns -1.

If find_header() returns -2 because no patch header has been found, it
is ok for parse_chunk() to also return -2. If find_header() returns -1
because an error happened, it is ok for parse_chunk() to do the same.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 630c01c..a160338 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1991,22 +1991,22 @@ static int use_patch(struct apply_state *state, struct patch *p)
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
 
@@ -2067,7 +2067,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state->linenr);
+			return error(_("patch with only garbage at line %d"), state->linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4449,6 +4449,10 @@ static int apply_patch(struct apply_state *state,
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
+			if (nr == -1) {
+				res = -1;
+				goto end;
+			}
 			break;
 		}
 		if (state->apply_in_reverse)
-- 
2.9.0.rc2.411.g3e2ca28
