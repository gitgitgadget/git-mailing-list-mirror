From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/21] strbuf: make strbuf_getline_crlf() global
Date: Thu, 14 Jan 2016 15:58:17 -0800
Message-ID: <1452815916-6447-3-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrmx-00037H-EK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbcANX6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755389AbcANX6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5360D3CD5C;
	Thu, 14 Jan 2016 18:58:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7qHr
	Q0Ao9eAYi7z1EDS9lrib1Jo=; b=IVlDoG7EFWj2dK0l8yzekY35aD3snAjrPZWZ
	IElDboNpWgFSwDu+iYtA5N6XFUT6eHPBU/RoScFcJ6LNzBI/rvsGbBIbmQ+B2HFq
	8jfcQiV0TmEbvTkaIR2Kz7bPb7NS9W6my5439eWiR7QszOEBp1aiRSJ9Mfd1YggN
	uIMHOyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	UxXgij/0KJc06xbCqbnxZkOvV3suXcnxFKU9b5ytAeHGBfq1EoBEAnFfLtI7aGRE
	dTwU0pDanreNNYCG9lln/06yc7SmlLob1vREcRT/g0zIIyBaHuG8L8ig9NkzVYhb
	ocvHPQGyTXRaBCXhJYPXN6zUagsIYe9XGAQqvUj9O5A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4ACCA3CD5B;
	Thu, 14 Jan 2016 18:58:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A2F9A3CD5A;
	Thu, 14 Jan 2016 18:58:40 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BC44CE82-BB1A-11E5-9F69-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284106>

Often we read "text" files that are supplied by the end user
(e.g. commit log message that was edited with $GIT_EDITOR upon 'git
commit -e'), and in some environments lines in a text file are
terminated with CRLF.  Existing strbuf_getline() knows to read a
single line and then strip the terminating byte from the result, but
it is handy to have a version that is more tailored for a "text"
input that takes both '\n' and '\r\n' as line terminator (aka
<newline> in POSIX lingo) and returns the body of the line after
stripping <newline>.

Recently reimplemented "git am" uses such a function implemented
privately; move it to strbuf.[ch] and make it available for others.

Note that we do not blindly replace calls to strbuf_getline() that
uses LF as the line terminator with calls to strbuf_getline_crlf()
and this is very much deliberate.  Some callers may want to treat an
incoming line that ends with CR (and terminated with LF) to have a
payload that includes the final CR, and such a blind replacement
will result in misconversion when done without code audit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 15 ---------------
 strbuf.c     | 12 ++++++++++++
 strbuf.h     |  7 +++++++
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9fb42fd..d96735c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -46,21 +46,6 @@ static int is_empty_file(const char *filename)
 }
 
 /**
- * Like strbuf_getline(), but treats both '\n' and "\r\n" as line terminators.
- */
-static int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
-{
-	if (strbuf_getwholeline(sb, fp, '\n'))
-		return EOF;
-	if (sb->buf[sb->len - 1] == '\n') {
-		strbuf_setlen(sb, sb->len - 1);
-		if (sb->len > 0 && sb->buf[sb->len - 1] == '\r')
-			strbuf_setlen(sb, sb->len - 1);
-	}
-	return 0;
-}
-
-/**
  * Returns the length of the first line of msg.
  */
 static int linelen(const char *msg)
diff --git a/strbuf.c b/strbuf.c
index b165d04..7ad5ea4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -510,6 +510,18 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 	return 0;
 }
 
+int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
+{
+	if (strbuf_getwholeline(sb, fp, '\n'))
+		return EOF;
+	if (sb->buf[sb->len - 1] == '\n') {
+		strbuf_setlen(sb, sb->len - 1);
+		if (sb->len && sb->buf[sb->len - 1] == '\r')
+			strbuf_setlen(sb, sb->len - 1);
+	}
+	return 0;
+}
+
 int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
 {
 	strbuf_reset(sb);
diff --git a/strbuf.h b/strbuf.h
index 7123fca..d84c866 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -388,6 +388,13 @@ extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  */
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
+/*
+ * Similar to strbuf_getline(), but uses '\n' as the terminator,
+ * and additionally treats a '\r' that comes immediately before '\n'
+ * as part of the terminator.
+ */
+extern int strbuf_getline_crlf(struct strbuf *, FILE *);
+
 /**
  * Like `strbuf_getline`, but keeps the trailing terminator (if
  * any) in the buffer.
-- 
2.7.0-250-ge1b5ba3
