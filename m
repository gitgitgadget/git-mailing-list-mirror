From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/5] pretty-print: further abstract out pp_handle_indent()
Date: Wed, 23 Mar 2016 16:23:44 -0700
Message-ID: <1458775426-2215-4-git-send-email-gitster@pobox.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 00:24:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ais89-00083p-HT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbcCWXXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:23:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753186AbcCWXXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 19:23:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9666850C19;
	Wed, 23 Mar 2016 19:23:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pbmU
	dTn6O2/Qgsm8PzD9c6a7Og0=; b=M7XQf8w5Xxk7YLdBn3JoQ90CyplnTxRUP3WS
	syrM6RKrmCQLp881FxbUL5vCMHraalcMV5s5HMcbgJf0xxJdBtWsZc5UuFWEsvNf
	st8G9QewvXmjq5Qw8EXrV+5rkaKMBHVV/dKNSE1eOAri3VoAxg7vXkfJIN/tKdnf
	1ayFCeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	G3hPqxcR6zMoLzrWtl4kw3fjG27oHdnqY1H2Bq3trmNhw4TJN5I0rwnuLfxLUuu0
	Djmhcb79l5Q09eJUYgU83Yb1tgsccEq/ChpGvRdbG8/Ev8guEGmnW0T4aHngnzcL
	DbEshiofGhuDUCSGi+2/x/gCIcGlUM4pALXMGKLBBPg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E72150C18;
	Wed, 23 Mar 2016 19:23:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F282450C15;
	Wed, 23 Mar 2016 19:23:52 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-rc4-198-g3f6b64c
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4E6B5F7E-F14E-11E5-A698-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289697>

Separate the call to add 4-space indent, and a new helper to add a
line after de-tabifying.

The new helper function strbuf_add_tabexpand() could later be moved
to strbuf.[ch] if other callers need to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6d657fc..717ceed 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1643,18 +1643,12 @@ static int pp_utf8_width(const char *start, const char *end)
 	return width;
 }
 
-/*
- * pp_handle_indent() prints out the intendation, and
- * the whole line (without the final newline), after
- * de-tabifying.
- */
-static void pp_handle_indent(struct strbuf *sb, int indent,
-			     const char *line, int linelen)
+
+static void strbuf_add_tabexpand(struct strbuf *sb,
+				 const char *line, int linelen)
 {
 	const char *tab;
 
-	strbuf_addchars(sb, ' ', indent);
-
 	while ((tab = memchr(line, '\t', linelen)) != NULL) {
 		int width = pp_utf8_width(line, tab);
 
@@ -1686,6 +1680,18 @@ static void pp_handle_indent(struct strbuf *sb, int indent,
 	strbuf_add(sb, line, linelen);
 }
 
+/*
+ * pp_handle_indent() prints out the intendation, and
+ * the whole line (without the final newline), after
+ * de-tabifying.
+ */
+static void pp_handle_indent(struct strbuf *sb, int indent,
+			     const char *line, int linelen)
+{
+	strbuf_addchars(sb, ' ', indent);
+	strbuf_add_tabexpand(sb, line, linelen);
+}
+
 void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
-- 
2.8.0-rc4-198-g3f6b64c
