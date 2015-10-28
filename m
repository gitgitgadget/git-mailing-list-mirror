From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/17] strbuf: add strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:45 -0700
Message-ID: <1446071161-15610-2-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIF-0000nz-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbbJ1WeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:34:03 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755464AbbJ1Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D32ED26A0E;
	Wed, 28 Oct 2015 18:26:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UsjN
	abIz6NkhP/3gkXekgwGsG80=; b=cU3YmsC5RizS6ow7Kv83E7Q3JmGRz9bhwcUg
	P9O3T1rXse9IpiPtsrmZSF8r74qLLDEz04sfpEDRfemQ93zZNJOcF56hDFOCm+un
	9B36EJMJHqGoyextJVtXH325/kSW5+zCwT1bo/BxScSK20vOx+Kiy9stamupQ/IS
	yv7f5SI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IJQhFf
	af2xfZU2QCC1qpGJ76llqu3XhjB9zAzSqvaOC0urzvOvRp4gjV1ZiA8RpfYehpPQ
	xrEp8HkwsuTc7NNAzCNzxMamUkqBkGH29uCxR9OtTXYWBkzI0k5kSojeORESIwI0
	bpR7RmnfTJjx6inpv1RTfqoWTpnlxu4mNAzCE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBE2E26A0D;
	Wed, 28 Oct 2015 18:26:04 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 49D7C26A0C;
	Wed, 28 Oct 2015 18:26:04 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E0318B86-7DC2-11E5-9C70-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280412>

Often we read "text" files that are supplied by the end user
(e.g. commit log message that was edited with $GIT_EDITOR upon 'git
commit -e'), and in some environments lines in a text file are
terminated with CRLF.  Existing strbuf_getline() knows to read a
single line and then strip the terminating byte from the result, but
it is handy to have a version that is more tailored for a "text"
input that takes both '\n' and '\r\n' as line terminator (aka
<newline> in POSIX lingo) and returns the body of the line after
stripping <newline>.

Recently reimplemented "git am" already uses such a function
implemented privately; move it to strbuf.[ch] and make it available
for others.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 23 ++++-------------------
 strbuf.c     | 16 ++++++++++++++--
 strbuf.h     |  7 +++++++
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4e396c8..9376d5e 100644
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
@@ -627,7 +612,7 @@ static int is_mail(FILE *fp)
 	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
 		die("invalid pattern: %s", header_regex);
 
-	while (!strbuf_getline_crlf(&sb, fp)) {
+	while (!strbuf_gets(&sb, fp)) {
 		if (!sb.len)
 			break; /* End of header */
 
@@ -674,7 +659,7 @@ static int detect_patch_format(const char **paths)
 
 	fp = xfopen(*paths, "r");
 
-	while (!strbuf_getline_crlf(&l1, fp)) {
+	while (!strbuf_gets(&l1, fp)) {
 		if (l1.len)
 			break;
 	}
@@ -695,9 +680,9 @@ static int detect_patch_format(const char **paths)
 	}
 
 	strbuf_reset(&l2);
-	strbuf_getline_crlf(&l2, fp);
+	strbuf_gets(&l2, fp);
 	strbuf_reset(&l3);
-	strbuf_getline_crlf(&l3, fp);
+	strbuf_gets(&l3, fp);
 
 	/*
 	 * If the second line is empty and the third is a From, Author or Date
diff --git a/strbuf.c b/strbuf.c
index d76f0ae..290fc74 100644
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
+int strbuf_gets(struct strbuf *sb, FILE *fp)
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
index 7123fca..c22bae0 100644
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
+extern int strbuf_gets(struct strbuf *, FILE *);
+
 /**
  * Like `strbuf_getline`, but keeps the trailing terminator (if
  * any) in the buffer.
-- 
2.6.2-423-g5314b62
