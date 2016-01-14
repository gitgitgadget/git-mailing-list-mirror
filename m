From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 2/9] strbuf: make strbuf_getline_crlf() global
Date: Wed, 13 Jan 2016 19:03:02 -0800
Message-ID: <1452740590-16827-3-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYC3-0007Uv-LU
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcANDDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182AbcANDDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 699DA3C426;
	Wed, 13 Jan 2016 22:03:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RCgw
	4l9yZY5Xetyj96DlasGOoUg=; b=VIxFkN97y+GcSUZXR3WD3LBwPpRs6fta/LW0
	b/4z7jHBovhKxjJSeyWEUqM1WawRw0Hi1s76obdonfEZgtAMCwFUFF+yXEiQSo7t
	mNfxqoNbpOKw1iU/S8KJPwtIRwN/Rdd6f5ieiAtoy2wxBvMyeWbJxZNqafC1QlaR
	zBloLYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	npFS7NX8EMzn8S6vbAjQjpVNVVFOLtVRVE2+7Y8mj5qxwLy8nUfyzYoRkDs31l2O
	QMgC5kddHPqsW3GFX5fDgxzHYvQ+wPhIrQYWjQcRcf3NUE2U01PfTrYNkuskbe8v
	OJJTy8xWhZd+vPdDRUTg3cBDdJA4Y/IkFED4xtuLa8s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6233A3C425;
	Wed, 13 Jan 2016 22:03:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB9A63C424;
	Wed, 13 Jan 2016 22:03:14 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5A9C4872-BA6B-11E5-B52E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284002>

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
index 4e396c8..94a533a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -45,21 +45,6 @@ static int is_empty_file(const char *filename)
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
2.7.0-242-gdd583c7
