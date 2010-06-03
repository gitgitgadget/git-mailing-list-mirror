From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/4] diff: make treatment of missing EOL at EOF configurable
Date: Thu,  3 Jun 2010 16:35:21 +0200
Message-ID: <77f4ffc1e89c4a5e34c74882dcf4761b486f5b48.1275575236.git.git@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 16:36:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBXN-0005fL-GX
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab0FCOfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:35:52 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40710 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755397Ab0FCOft (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 10:35:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8BA8EF8EC3
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 10:35:48 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 10:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=THsgSNNMwT3MTaOyrGaSDZCd3s8=; b=i86gvOEYYkE87N0j13a6uSMhTOX8DgbBnJdxCU2rDjxEA2M0T5cGGPuFfQvODELVBgLgNTJVDXlgSdoFGuwI+yZd5SdEnTxfgSkZt1ulB98h+1WQCEAc0hM0VmXbeSFxiujiGrgSfIBnPlxLSUvMzrS4Fqznuyzzyzpx9gc5WDI=
X-Sasl-enc: VPSoidTNmd5iOF4yajWvxDXEOXN51o2PpahOgDLBVrR9 1275575748
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F25BF50EBF;
	Thu,  3 Jun 2010 10:35:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.351.ge2633e
In-Reply-To: <cover.1275575236.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148325>

Make this one of the WS_* flags so that we can later turn the warning
for missing EOL at EOF on and off as per config or blob type.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 cache.h |    3 ++-
 diff.c  |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index c966023..dc72b8f 100644
--- a/cache.h
+++ b/cache.h
@@ -1048,8 +1048,9 @@ void shift_tree_by(const unsigned char *, const unsigned char *, unsigned char *
 #define WS_CR_AT_EOL           010
 #define WS_BLANK_AT_EOF        020
 #define WS_TAB_IN_INDENT       040
+#define WS_NO_EOL_AT_EOF      0100
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
-#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
+#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|WS_NO_EOL_AT_EOF)
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/diff.c b/diff.c
index ff44bcc..7950df6 100644
--- a/diff.c
+++ b/diff.c
@@ -455,7 +455,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
+	if (!endp && (ecb->ws_rule & WS_NO_EOL_AT_EOF)) {
 		const char *plain = diff_get_color(ecb->color_diff,
 						   DIFF_PLAIN);
 		emit_line_0(ecb->file, plain, reset, '\\',
@@ -918,7 +918,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
 	}
 	if (line[len-1] != '\n')
-		fputs("\n\\ No newline at end of file\n", ecbdata->file);
+		fputs((ecbdata->ws_rule & WS_NO_EOL_AT_EOF)
+			? "\n\\ No newline at end of file\n" : "\n", ecbdata->file);
 }
 
 static char *pprint_rename(const char *a, const char *b)
-- 
1.7.1.351.ge2633e
