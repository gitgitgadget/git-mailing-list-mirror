From: Jeff King <peff@peff.net>
Subject: [PATCH 5/4] fast-import: clarify "inline" logic in file_change_m
Date: Thu, 21 Mar 2013 11:44:39 -0400
Message-ID: <20130321154439.GA2075@sigill.intra.peff.net>
References: <20130321154402.GA25907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhg2-0008P9-HE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726Ab3CUPor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:44:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33937 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453Ab3CUPor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:44:47 -0400
Received: (qmail 24384 invoked by uid 107); 21 Mar 2013 15:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 11:46:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 11:44:39 -0400
Content-Disposition: inline
In-Reply-To: <20130321154402.GA25907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218738>

When we read a fast-import line like:

  M 100644 :1 foo.c

we point the local object_entry variable "oe" to the object
named by the mark ":1". When the input uses the "inline"
construct, however, we do not have such an object_entry.

The current code is careful not to access "oe" in the inline
case, but we can make the assumption even more obvious (and
catch violations of it) by setting oe to NULL and adding a
comment. As a bonus, this also squelches an over-zealous gcc
-Wuninitialized warning, which means we can drop the "oe =
oe" initialization hack.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index e12a8b8..a0c2c2f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2265,7 +2265,7 @@ static void file_change_m(struct branch *b)
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;
 
@@ -2292,6 +2292,7 @@ static void file_change_m(struct branch *b)
 		hashcpy(sha1, oe->idx.sha1);
 	} else if (!prefixcmp(p, "inline ")) {
 		inline_data = 1;
+		oe = NULL; /* not used with inline_data, but makes gcc happy */
 		p += strlen("inline");  /* advance to space */
 	} else {
 		if (get_sha1_hex(p, sha1))
-- 
1.8.2.rc2.8.g2161951
