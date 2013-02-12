From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 09/12] sequencer.c: teach append_signoff to avoid adding a duplicate newline
Date: Tue, 12 Feb 2013 02:17:36 -0800
Message-ID: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:19:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cx2-0002yo-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758685Ab3BLKSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:33 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54425 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:30 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so9637pab.5
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QOGiNXjnqYsHBODFTOCbB+OOycg34H/PcuSAFgyXFQM=;
        b=Br9rg0/3BgDBW/Vxg/jv3HNYzYxwb80D4mBBCYuc/ZaHYCTD3tgxROCi8AgekSD4Ge
         h3NxN5luVVV/XzACKJVhzkOy45Wvv4J/Hc3PwGW1ID8/0JUw48B0Dxo2yNshLw+PAG+h
         YrlOoNornK3iBEBmW+j0pyeit99OsxiewrgaOBgYJVQYefgKvdY/A4vSZCShHkd6wQJJ
         OqD2h5awexHyT9uRuOujZKedF+Xx2SdWOvMEyL1zFK/SbtMtveYbwt2gLeT0dRz/YfZh
         e4lYxqquN1gnHc7c14FcK5jNqrC7Qxs1JYHy9Cl28Z/ncxAd/NaO1tg445qMXxyFATIN
         orOg==
X-Received: by 10.66.73.164 with SMTP id m4mr51088504pav.12.1360664309568;
        Tue, 12 Feb 2013 02:18:29 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.27
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:28 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216138>

Teach append_signoff to detect whether a blank line exists at the position
that the signed-off-by line will be added, and refrain from adding an
additional one if one already exists.  Or, add an additional line if one
is needed to make sure the new footer is separated from the message body
by a blank line.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3364faa..3c63e3a 100644


I dropped the mention of format-patch in the commit message.  This
implementation is less about making format-patch work and more about
cleaning up a strangely formatted commit message.

-Brandon

--- a/sequencer.c
+++ b/sequencer.c
@@ -1110,6 +1110,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
 	struct strbuf sob = STRBUF_INIT;
+	const char *append_newlines = NULL;
 	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
@@ -1127,8 +1128,17 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	else
 		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
 
-	if (!has_footer)
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+	if (!has_footer) {
+		size_t len = msgbuf->len - ignore_footer;
+		if (len && msgbuf->buf[len - 1] != '\n')
+			append_newlines = "\n\n";
+		else if (len > 1 && msgbuf->buf[len - 2] != '\n')
+			append_newlines = "\n";
+	}
+
+	if (append_newlines)
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+			append_newlines, strlen(append_newlines));
 
 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-- 
1.8.1.3.579.gd9af3b6
