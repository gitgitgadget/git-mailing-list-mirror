From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/5] pretty-print: simplify the interaction between pp_handle_indent() and its caller
Date: Wed, 23 Mar 2016 16:23:43 -0700
Message-ID: <1458775426-2215-3-git-send-email-gitster@pobox.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 00:24:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ais8H-00088C-9h
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbcCWXXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:23:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751092AbcCWXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 19:23:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDABD50C14;
	Wed, 23 Mar 2016 19:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tzwG
	Us52/6whRKf//ioiTYgMxes=; b=aVpUiGMJIQprVL4dwI68CgbA7VBj5aC8fQwv
	636BJJEJNX8KJtBAMAELjCNoXATp4OoYp/Z7NjDkam3fZMPi8XGsaX2iddjE+E9Q
	YSmbLd2f3Emk9Rgc8rE7IQ5pyB+aCqoWhMsL28DGocnF4YbQ3UwEl71zU+9KG2U5
	2v8uA6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	TsgKFtJWhvyXpoDz/IpszDn9FVlZoZwSSg017m8eCvAXU6UDkDrEXd/rfcmdOq4l
	74QJ33rVxsCbHK5ahyQ5AhTkI9SCTx6Bj7CHIdbqH051RpXHFNTSdyUMDYi7IflE
	hF8Q9omU5xRZmC7BoPmVlbbnB/Rv0XF0ejr4eEnVHbk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3F0050C13;
	Wed, 23 Mar 2016 19:23:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58C0D50C12;
	Wed, 23 Mar 2016 19:23:51 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-rc4-198-g3f6b64c
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4D72C184-F14E-11E5-B2F3-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289699>

Instead	of sometimes handling the output itself and some other times
forcing the caller handle the output, make the helper function
pp_handle_indent() responsible for the output for all cases.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/pretty.c b/pretty.c
index 0b40457..6d657fc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1645,26 +1645,17 @@ static int pp_utf8_width(const char *start, const char *end)
 
 /*
  * pp_handle_indent() prints out the intendation, and
- * perhaps the whole line (without the final newline)
- *
- * Why "perhaps"? If there are tabs in the indented line
- * it will print it out in order to de-tabify the line.
- *
- * But if there are no tabs, we just fall back on the
- * normal "print the whole line".
+ * the whole line (without the final newline), after
+ * de-tabifying.
  */
-static int pp_handle_indent(struct strbuf *sb, int indent,
+static void pp_handle_indent(struct strbuf *sb, int indent,
 			     const char *line, int linelen)
 {
 	const char *tab;
 
 	strbuf_addchars(sb, ' ', indent);
 
-	tab = memchr(line, '\t', linelen);
-	if (!tab)
-		return 0;
-
-	do {
+	while ((tab = memchr(line, '\t', linelen)) != NULL) {
 		int width = pp_utf8_width(line, tab);
 
 		/*
@@ -1685,10 +1676,7 @@ static int pp_handle_indent(struct strbuf *sb, int indent,
 		/* Skip over the printed part .. */
 		linelen -= 1+tab-line;
 		line = tab + 1;
-
-		/* .. and look for the next tab */
-		tab = memchr(line, '\t', linelen);
-	} while (tab);
+	}
 
 	/*
 	 * Print out everything after the last tab without
@@ -1696,7 +1684,6 @@ static int pp_handle_indent(struct strbuf *sb, int indent,
 	 * align.
 	 */
 	strbuf_add(sb, line, linelen);
-	return 1;
 }
 
 void pp_remainder(struct pretty_print_context *pp,
@@ -1722,11 +1709,10 @@ void pp_remainder(struct pretty_print_context *pp,
 		first = 0;
 
 		strbuf_grow(sb, linelen + indent + 20);
-		if (indent) {
-			if (pp_handle_indent(sb, indent, line, linelen))
-				linelen = 0;
-		}
-		strbuf_add(sb, line, linelen);
+		if (indent)
+			pp_handle_indent(sb, indent, line, linelen);
+		else
+			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
 	}
 }
-- 
2.8.0-rc4-198-g3f6b64c
