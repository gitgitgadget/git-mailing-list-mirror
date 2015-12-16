From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/17] strbuf: make strbuf_getline_crlf() global
Date: Wed, 16 Dec 2015 14:03:02 -0800
Message-ID: <1450303398-25900-2-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAR-0000Zx-Jp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbbLPWDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755465AbbLPWDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8680B325B0;
	Wed, 16 Dec 2015 17:03:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CdxT
	ozKc0TTulOCdfXH7TsoEj4k=; b=CMEzUPLL1uQaajRE/g9+rTwXiDQow9MLZUtx
	GzCEcC+W0yP3bVN3+UkkWWs74JZPknuDZmqPBM8aQuzje/Rh3kzon9Q40J1gD8SA
	qq9pS51MIBhJyf9y/C/xw+HuN3h7zwKVI2295ELJsvjXsgrGaq/u4ByHxK0CQRGv
	qifgcho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wmRfIZ
	PqvSZR7x7IlG3Autl2NKnoXyx1soOZWfxHKpQXra/WFlc9NPFzD0e3jDsyvLy4RI
	dWSkjpextCvQ14UfQbn29GaDsxXEjbYhjH/cFYPm443M6Szn3/AXffbzr8aBIENy
	dbeMTRVPgNB9bcsUstLLdCxO3txzXQurbnbes=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EB52325AF;
	Wed, 16 Dec 2015 17:03:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 03729325AE;
	Wed, 16 Dec 2015 17:03:20 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D1DA11D0-A440-11E5-8153-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282597>

Often we read "text" files that are supplied by the end user
(e.g. commit log message that was edited with $GIT_EDITOR upon
'git commit -e'), and in some environments lines in a text file
are terminated with CRLF.  Existing strbuf_getline() knows to read
a single line and then strip the terminating byte from the result,
but it is handy to have a version that is more tailored for a "text"
input that takes both '\n' and '\r\n' as line terminator (aka
<newline> in POSIX lingo) and returns the body of the line after
stripping <newline>.

Recently reimplemented "git am" uses such a function implemented
privately; move it to strbuf.[ch] and make it available for others.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 15 ---------------
 strbuf.c     | 16 ++++++++++++++--
 strbuf.h     |  7 +++++++
 3 files changed, 21 insertions(+), 17 deletions(-)

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
index d76f0ae..7ad5ea4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -505,8 +505,20 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 {
 	if (strbuf_getwholeline(sb, fp, term))
 		return EOF;
-	if (sb->buf[sb->len-1] == term)
-		strbuf_setlen(sb, sb->len-1);
+	if (sb->buf[sb->len - 1] == term)
+		strbuf_setlen(sb, sb->len - 1);
+	return 0;
+}
+
+int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
+{
+	if (strbuf_getwholeline(sb, fp, '\n'))
+		return EOF;
+	if (sb->buf[sb->len - 1] == '\n') {
+		strbuf_setlen(sb, sb->len - 1);
+		if (sb->len && sb->buf[sb->len - 1] == '\r')
+			strbuf_setlen(sb, sb->len - 1);
+	}
 	return 0;
 }
 
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
2.7.0-rc1-83-ga8b6b9e
