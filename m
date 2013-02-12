From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 06/12] sequencer.c: require a conforming footer to be preceded by a blank line
Date: Tue, 12 Feb 2013 02:17:33 -0800
Message-ID: <1360664260-11803-7-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Cwo-0002O8-M5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab3BLKSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 05:18:22 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59447 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab3BLKSV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:18:21 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so7836pad.30
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=O2+VDnkGvZ9JazKa9rMpfZY/0TFBLV2c4Ghvt/QN3jw=;
        b=Digt5sdn83Ak4yI4sU5OVACawmmlAlMaIrrw0Dcm5rBROyEI+Ksn27BzJqmkH6jFYy
         VNnuKuWmA7se4at9dJ7Z3ZdybjObsuzHZdnwtyLXi3s1Jv9FWEWTLC1FxL0tRJMtf/1s
         5g/HUytPIfU2hARSVMDE1GGXLpfVc8JieB2ooe/m2pGWHd/V/+Gbv/Q2PwywoBBqau2n
         fQ+E4o7ysXaFlsDO/utHeezRHU/Q/+0/ydHCiuefNrVZ2nX3TwG2K5yoasrDXcS+p5dd
         QwT5LMr+IpkQyg2SlhrJbMSwM4H8+11oEEFh3eaHplS0bYoQA0pDYwjhvD3/QeYYjpX3
         kXYg==
X-Received: by 10.66.78.1 with SMTP id x1mr51002586paw.2.1360664300605;
        Tue, 12 Feb 2013 02:18:20 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.18.18
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:18:19 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216133>

Currently, append_signoff() performs a search for the last line of the
commit buffer by searching back from the end until it hits a newline.  If
it reaches the beginning of the buffer without finding a newline, that
means either the commit message was empty, or there was only one line in it.
In this case, append_signoff will skip the call to has_conforming_footer
since it already knows that it is necessary to append a newline before
appending the sob.

Let's perform this function inside of has_conforming_footer where it
appropriately belongs and generalize it so that we require that the
footer paragraph be an actual distinct paragraph separated by a blank
line.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 sequencer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 93495b0..178e84b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1065,6 +1065,10 @@ static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
 		prev = ch;
 	}
 
+	/* require at least one blank line */
+	if (prev != '\n' || buf[i] != '\n')
+		return 0;
+
 	/* advance to start of last paragraph */
 	while (i < len - 1 && buf[i] == '\n')
 		i++;
@@ -1093,7 +1097,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
 	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
 		; /* do nothing */
 	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
+		if (!has_conforming_footer(msgbuf, ignore_footer))
 			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
 	}
-- 
1.8.1.3.579.gd9af3b6
