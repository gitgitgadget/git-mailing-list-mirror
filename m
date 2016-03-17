From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] pretty-print: simplify the interaction between pp_handle_indent() and its caller
Date: Thu, 17 Mar 2016 16:15:30 -0700
Message-ID: <xmqqwpp0y9v1.fsf_-_@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agh8j-0001jF-N9
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935907AbcCQXPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:15:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933172AbcCQXPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:15:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2A164CC88;
	Thu, 17 Mar 2016 19:15:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eu/X4O1FkEoPqDDL7BUNbukjmPs=; b=g3j8jy
	xOK5UA7occy0VPQ86Q3pskMAWREo27L1/O45qEO51TTZuJ8hIui5BMV42hIBvTmV
	We9ICExX1hzJmuceH7JtmTETNpPLbCZsh/o0hduLAMMrGsEzpqUS6e5ETpcYBRtB
	EdPKAWegz9ssk1v2znpy7kexfPoAm05yzL9/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eApUd4A7MGOWrh3t4nUBrZlDR/NXUF8I
	jKtD4DvQ4Gf2Iisb0+DFcztsdQsEwr6E1JuE/vkpdLssgoyRsTKF0rxGqzATTBLL
	lxQFKT05OZoqvZrD8i+oxpiUgkRR+1T119igMpDjiOP/E7mlEtHkiLOvEyg9ltSa
	xSXgGZiOmuo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA7564CC87;
	Thu, 17 Mar 2016 19:15:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B7BA4CC86;
	Thu, 17 Mar 2016 19:15:31 -0400 (EDT)
In-Reply-To: <xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Thu, 17 Mar 2016 16:13:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24DF93A8-EC96-11E5-BF65-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289167>

Instead of	sometimes handling the output itself and some other
times forcing   the caller handle the output, make pp_handle_indent()
responsible to  handle the output for all cases.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This and the other two patches that follow show what I meant
   during the discussion.

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
2.8.0-rc3-175-g64dcf62
