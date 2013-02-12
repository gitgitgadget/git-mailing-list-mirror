From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 02/12] commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
Date: Tue, 12 Feb 2013 02:17:29 -0800
Message-ID: <1360664260-11803-3-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cwe-00020V-39
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529Ab3BLKSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:09 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33009 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKSI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:08 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so8547pab.18
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HZrRBQkZph7v+Q6t6K0BXHJfVavM+da75MEKkTPD0uE=;
        b=I3E2INnAgh5YKWI25BW44ikC7BTjCU/mxvdqBYwJjP6IlTE62C8Mt+j4HNzffwCv4D
         Mep2ZB6yEuiymSdJgTKG0DWzLnZuIX4S5JmNziiHYseAaU+/4j8BsdN+ao180/Y99WVb
         zkEv1sxups+wlMLMr2xJX/sU88YmBmi4FVub1okMelFMQoGh044k0PhVSFchKW/IMw3z
         gwQ0u5CEmmDuz872TSeNzMGb4JVTBgkW33UGHKTIiT7O99t6d9X/kzG5029wvmQFe45p
         NlXpDyXZ/WK8XxI54ljh+q1g3JWKhXxNtk0Zbm6C5mn0GMfk9RUuuG+fEZga/GPPphWO
         EbAA==
X-Received: by 10.66.146.72 with SMTP id ta8mr7904108pab.24.1360664287457;
        Tue, 12 Feb 2013 02:18:07 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216131>

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
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sequencer.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index dbeff01..aa2cb8e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1026,7 +1026,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
 	char ch, prev;
 	int i, j, k;
 	int len = sb->len - ignore_footer;
-	int first = 1;
 	const char *buf = sb->buf;
 
 	prev = '\0';
@@ -1046,11 +1045,6 @@ static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
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
1.8.1.3.579.gd9af3b6
