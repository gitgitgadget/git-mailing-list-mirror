From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/21] strbuf: give strbuf_getline() to the "most text friendly" variant
Date: Thu, 14 Jan 2016 15:58:24 -0800
Message-ID: <1452815916-6447-10-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnD-0003Jp-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbcANX67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755730AbcANX6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FD993CD79;
	Thu, 14 Jan 2016 18:58:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LPwj
	v++cWM1U6obxvJvL8GS2b8g=; b=tIpZXV8emKPCfAiXw6rLgMz1r2ziua/KaLLZ
	HPgaLGjJ2OiZbML70Z5VJoFbBbUFrHUEr7nyPEsf+jiOn8IFgmvG7Vw3O+Pc2LaU
	59nBIrQpobDXQGV6vUNoVAEPJe5i2zwsWU7u6ABvdHX+hbhyaoCNAk5ik80Kewcd
	tGaIL/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	gwpgbNxlpZsPvvNqDYQiHqcplkUUVDzAv8BypCsXMBJACUEQqYtfTwRcOSKppjWq
	iybyADmFUtRD7aq5JiTg3m5jCRRoUwBTjLZKHDpJHimz5J0YQnbHQg4eSD9wqD9S
	OK+TYvHQX2mV6EOxZQLBGVv/307Ad44/eH5XzI2ch6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 365763CD78;
	Thu, 14 Jan 2016 18:58:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8949E3CD77;
	Thu, 14 Jan 2016 18:58:52 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C35B8710-BB1A-11E5-8652-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284110>

Now there is no direct caller to strbuf_getline(), we can demote it
to file-scope static private to strbuf.c implementation and rename
it to strbuf_getdelim().  Rename strbuf_getline_crlf(), which is
designed to be the most "text friendly" variant, and allow it to
take over this simplest name, strbuf_getline(), so we can add more
uses of it without having to type _crlf over and over again in the
coming steps.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c       |  8 ++++----
 strbuf.c           |  8 ++++----
 strbuf.h           | 25 ++++++++++++++-----------
 transport-helper.c |  3 ++-
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9063a4a..7b8351d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -613,7 +613,7 @@ static int is_mail(FILE *fp)
 	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
 		die("invalid pattern: %s", header_regex);
 
-	while (!strbuf_getline_crlf(&sb, fp)) {
+	while (!strbuf_getline(&sb, fp)) {
 		if (!sb.len)
 			break; /* End of header */
 
@@ -660,7 +660,7 @@ static int detect_patch_format(const char **paths)
 
 	fp = xfopen(*paths, "r");
 
-	while (!strbuf_getline_crlf(&l1, fp)) {
+	while (!strbuf_getline(&l1, fp)) {
 		if (l1.len)
 			break;
 	}
@@ -681,9 +681,9 @@ static int detect_patch_format(const char **paths)
 	}
 
 	strbuf_reset(&l2);
-	strbuf_getline_crlf(&l2, fp);
+	strbuf_getline(&l2, fp);
 	strbuf_reset(&l3);
-	strbuf_getline_crlf(&l3, fp);
+	strbuf_getline(&l3, fp);
 
 	/*
 	 * If the second line is empty and the third is a From, Author or Date
diff --git a/strbuf.c b/strbuf.c
index 2ff898c..47ac045 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -501,7 +501,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 }
 #endif
 
-int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
+static int strbuf_getdelim(struct strbuf *sb, FILE *fp, int term)
 {
 	if (strbuf_getwholeline(sb, fp, term))
 		return EOF;
@@ -510,7 +510,7 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 	return 0;
 }
 
-int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
+int strbuf_getline(struct strbuf *sb, FILE *fp)
 {
 	if (strbuf_getwholeline(sb, fp, '\n'))
 		return EOF;
@@ -524,12 +524,12 @@ int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
 
 int strbuf_getline_lf(struct strbuf *sb, FILE *fp)
 {
-	return strbuf_getline(sb, fp, '\n');
+	return strbuf_getdelim(sb, fp, '\n');
 }
 
 int strbuf_getline_nul(struct strbuf *sb, FILE *fp)
 {
-	return strbuf_getline(sb, fp, '\0');
+	return strbuf_getdelim(sb, fp, '\0');
 }
 
 int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
diff --git a/strbuf.h b/strbuf.h
index 5501743..220c541 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -354,8 +354,8 @@ extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm
  *
  * NOTE: The buffer is rewound if the read fails. If -1 is returned,
  * `errno` must be consulted, like you would do for `read(3)`.
- * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
- * same behaviour as well.
+ * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline_*()`
+ * family of functions have the same behaviour as well.
  */
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 
@@ -380,26 +380,29 @@ extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents
- * of the strbuf. The second argument specifies the line
- * terminator character, typically `'\n'`.
+ * of the strbuf.  There are three public functions with this
+ * function signature, with different line termination convention.
  * Reading stops after the terminator or at EOF.  The terminator
  * is removed from the buffer before returning.  Returns 0 unless
  * there was nothing left before EOF, in which case it returns `EOF`.
  */
-extern int strbuf_getline(struct strbuf *, FILE *, int);
-
 
 typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
 
+/* Uses LF as the line terminator */
 extern int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
+
+/* Uses NUL as the line terminator */
 extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
 
-/*
- * Similar to strbuf_getline(), but uses '\n' as the terminator,
- * and additionally treats a '\r' that comes immediately before '\n'
- * as part of the terminator.
+/**
+ * Similar to strbuf_getline_lf(), but additionally treats
+ * a '\r' that comes immediately before '\n' as part of the
+ * terminator.  This is the most friendly version to be used
+ * to read "text" files that can come from platforms whose
+ * native text format is CRLF terminated.
  */
-extern int strbuf_getline_crlf(struct strbuf *, FILE *);
+extern int strbuf_getline(struct strbuf *, FILE *);
 
 
 /**
diff --git a/transport-helper.c b/transport-helper.c
index 163e4b1..e45d88f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -137,7 +137,8 @@ static struct child_process *get_helper(struct transport *transport)
 	data->no_disconnect_req = 0;
 
 	/*
-	 * Open the output as FILE* so strbuf_getline() can be used.
+	 * Open the output as FILE* so strbuf_getline_*() family of
+	 * functions can be used.
 	 * Do this with duped fd because fclose() will close the fd,
 	 * and stuff like taking over will require the fd to remain.
 	 */
-- 
2.7.0-250-ge1b5ba3
