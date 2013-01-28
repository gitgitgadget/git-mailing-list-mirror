From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 02/11] commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
Date: Sun, 27 Jan 2013 17:11:46 -0800
Message-ID: <1359335515-13818-3-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdH4-0006Mm-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059Ab3A1BMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:19 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:42466 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab3A1BMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:17 -0500
Received: by mail-pa0-f41.google.com with SMTP id bj3so1198071pad.0
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=AVpyVM+ZGYq+6shElOj8klyTaGqDkgN5HkcH5GrhPA8=;
        b=KVEPmjoq3D6tA3tPP4d4LSwWqbenVYGQS5ERmFTWSM5/J7V6gpJ9XIbQblJrFBjYQ3
         Y4gFEY6MthHcnt0rcIcv0b78L3rLV+h8uDI2eMqAGlU8XO0OmdATgXlAEGkX/kI43oZQ
         d6VPugB4xsJpbgQU4vZ/AhkcKLzkV0KY5sSwObTosmGj0k74S+STA+bxb4mIqJ+KGsZs
         D1R8GDr0NQ/UoPD93S78heZLDk5KBhjLRq/t9MATVnWJDyi4FJ1Gw0wOPCDNTZUyrBts
         ZyxvPSCKINKYwyGGWn2rmki8zfVGCXOCXPTuyiOrSgRmEbYxUhyY0ipyMLuzPq5y+MHA
         /QFw==
X-Received: by 10.68.228.74 with SMTP id sg10mr18620658pbc.162.1359335537328;
        Sun, 27 Jan 2013 17:12:17 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.15
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:16 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214765>

Starting with c1e01b0c (commit: More generous accepting of RFC-2822 footer
lines, 2009-10-28), "git commit -s" carefully parses the last paragraph of
each commit message to check if it consists only of RFC2822-style headers,
in which case the signoff will be added as a new line in the same list:

   Reported-by: Reporter <reporter@example.com>
   Signed-off-by: Author <author@example.com>
   Acked-by: Lieutenant <lt@example.com>

It even included support for accepting indented continuation lines for
multiline fields.  Unfortunately the multiline field support is broken
because it checks whether buf[k] (the first character of the *next* line)
instead of buf[i] is a whitespace character.  The result is that any footer
with a continuation line is not accepted, since the last continuation line
neither starts with an RFC2822 field name nor is followed by a continuation
line.

That this has remained broken for so long is good evidence that nobody
actually needed multiline fields.  Rip out the broken continuation support.

There should be no functional change.

[Thanks to Jonathan Nieder for the excellent commit message]

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 sequencer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cd211b2..39a752b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1027,7 +1027,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 	int last_char_was_nl, this_char_is_nl;
 	int i, j, k;
 	int len = sb->len - ignore_footer;
-	int first = 1;
 	const char *buf = sb->buf;
 
 	/* find start of last paragraph */
@@ -1047,11 +1046,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
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
1.8.1.1.450.g0327af3
