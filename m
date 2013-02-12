From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid adding a duplicate newline
Date: Tue, 12 Feb 2013 02:33:42 -0800
Message-ID: <1360665222-3166-1-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:34:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5DC1-0003zx-43
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399Ab3BLKeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:34:05 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:39183 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab3BLKeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:34:04 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so3101993dad.38
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bAgxodrQ570wCm3ud/ty9AKoKb8nENCWTohJ8LYHlP8=;
        b=BiJVatICiTOVUZYrgiTLfuMR5lNNA42lXnwvx9YbRMRe/xBJQK0Qj+cvi2Px3goqc1
         HuRqB52qE8aMykbQfPyXehsaHP+xyofa4I5h1TYtM8nKIt7Y3mgdwtTAkpoDkYYvSyuj
         64hlapCcHv7rXSMDBFpmc7XXjc1B2NTcf7gSaxZTYAZQvhwPg4e41YeR8F58goh6UtGW
         0J9Q9s1WohxhD+5YCjBX+HKCkx2MCgWwy00lJ9h15RL7q9fRMIBVjKpf9B6KekxC/4LV
         qltuV+q2hRuLuGmV2zAT19A/f1qkOVJZaOE3OHcKLvq/ao2vHN5+2n80PiVLQUdSXCNL
         uovA==
X-Received: by 10.66.88.133 with SMTP id bg5mr30187802pab.21.1360665242984;
        Tue, 12 Feb 2013 02:34:02 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id y9sm73947620paw.1.2013.02.12.02.34.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:34:01 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216145>

Teach append_signoff to detect whether a blank line exists at the position
that the signed-off-by line will be added, and refrain from adding an
additional one if one already exists.  Or, add an additional line if one
is needed to make sure the new footer is separated from the message body
by a blank line.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---


A slight tweak.  And I promise, no more are coming.

-Brandon


 sequencer.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3364faa..084573b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1127,8 +1127,19 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	else
 		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
 
-	if (!has_footer)
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+	if (!has_footer) {
+		const char *append_newlines = NULL;
+		size_t len = msgbuf->len - ignore_footer;
+
+		if (len && msgbuf->buf[len - 1] != '\n')
+			append_newlines = "\n\n";
+		else if (len > 1 && msgbuf->buf[len - 2] != '\n')
+			append_newlines = "\n";
+
+		if (append_newlines)
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				append_newlines, strlen(append_newlines));
+	}
 
 	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-- 
1.8.1.1.252.gdb33759
