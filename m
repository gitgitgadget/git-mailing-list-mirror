From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 06/44] builtin-am: auto-detect mbox patches
Date: Sun, 28 Jun 2015 22:05:28 +0800
Message-ID: <1435500366-31700-7-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DEz-0001pD-IM
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbbF1OHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:21 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36001 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbF1OHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:11 -0400
Received: by pdcu2 with SMTP id u2so101476699pdc.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fr6VwYao8lPLfBvrnspB5A/wI8VURf6lNKRHD6iac6E=;
        b=La0dta83nNNw6KdouIdbFe77jSofhjhamQUzz8mgcSu5yKX8duh/Nc+ytJMz3QKXHM
         BfBii/mpa3667kIVkHH1rAKhxY0SAHxaqWhDtcwJbbAWnk4MYIz9yXYmOOq/26e+7qRa
         jxwasmLp+bioT+W3Dn2z669jpY7a0daM2gYoCFibsv0VxQB762cIYzEpEFaZ5imHUsif
         reEize88AsN/E2ZrWhhArivkgSjhZHwUOzze+zPT62+PAnDdRqOC9S1k6DHfAAhFrXRL
         RU4i1nx9zvNvR1POBZFcorCWXHToPh+fkDEdShCucO1WKmhxjAkpqLdDa6bOg0A0eN4f
         TgJA==
X-Received: by 10.70.134.133 with SMTP id pk5mr22456692pdb.133.1435500430999;
        Sun, 28 Jun 2015 07:07:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272881>

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh is able to autodetect mbox, stgit and
mercurial patches through heuristics.

Re-implement support for autodetecting mbox/maildir files in
builtin/am.c.

RFC 2822 requires that lines are terminated by "\r\n". To support this,
implement strbuf_getline_crlf(), which will remove both '\n' and "\r\n"
from the end of the line.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v4
    
    * Using strbuf_trim() to remove the \r from CRLF lines is obviously
      wrong. Instead, implement strbuf_getline_crlf() to do it correctly for
      us.
    
    * Use a regex
    
    * Instead of re-opening the file again in is_email(), rewind the
      already-opened data stream.

 builtin/am.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 136ccc6..31d85eb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -10,6 +10,21 @@
 #include "dir.h"
 #include "run-command.h"
 
+/**
+ * Like strbuf_getline(), but treats both '\n' and "\r\n" as line terminators.
+ */
+static int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
+{
+	if (strbuf_getwholeline(sb, fp, '\n'))
+		return EOF;
+	if (sb->buf[sb->len - 1] == '\n') {
+		strbuf_setlen(sb, sb->len - 1);
+		if (sb->len > 0 && sb->buf[sb->len - 1] == '\r')
+			strbuf_setlen(sb, sb->len - 1);
+	}
+	return 0;
+}
+
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
 	PATCH_FORMAT_MBOX
@@ -131,6 +146,92 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Determines if the file looks like a piece of RFC2822 mail by grabbing all
+ * non-indented lines and checking if they look like they begin with valid
+ * header field names.
+ *
+ * Returns 1 if the file looks like a piece of mail, 0 otherwise.
+ */
+static int is_mail(FILE *fp)
+{
+	const char *header_regex = "^[!-9;-~]+:";
+	struct strbuf sb = STRBUF_INIT;
+	regex_t regex;
+	int ret = 1;
+
+	if (fseek(fp, 0L, SEEK_SET))
+		die_errno(_("fseek failed"));
+
+	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
+		die("invalid pattern: %s", header_regex);
+
+	while (!strbuf_getline_crlf(&sb, fp)) {
+		if (!sb.len)
+			break; /* End of header */
+
+		/* Ignore indented folded lines */
+		if (*sb.buf == '\t' || *sb.buf == ' ')
+			continue;
+
+		/* It's a header if it matches header_regex */
+		if (regexec(&regex, sb.buf, 0, NULL, 0)) {
+			ret = 0;
+			goto done;
+		}
+	}
+
+done:
+	regfree(&regex);
+	strbuf_release(&sb);
+	return ret;
+}
+
+/**
+ * Attempts to detect the patch_format of the patches contained in `paths`,
+ * returning the PATCH_FORMAT_* enum value. Returns PATCH_FORMAT_UNKNOWN if
+ * detection fails.
+ */
+static int detect_patch_format(const char **paths)
+{
+	enum patch_format ret = PATCH_FORMAT_UNKNOWN;
+	struct strbuf l1 = STRBUF_INIT;
+	FILE *fp;
+
+	/*
+	 * We default to mbox format if input is from stdin and for directories
+	 */
+	if (!*paths || !strcmp(*paths, "-") || is_directory(*paths))
+		return PATCH_FORMAT_MBOX;
+
+	/*
+	 * Otherwise, check the first few lines of the first patch, starting
+	 * from the first non-blank line, to try to detect its format.
+	 */
+
+	fp = xfopen(*paths, "r");
+
+	while (!strbuf_getline_crlf(&l1, fp)) {
+		if (l1.len)
+			break;
+	}
+
+	if (starts_with(l1.buf, "From ") || starts_with(l1.buf, "From: ")) {
+		ret = PATCH_FORMAT_MBOX;
+		goto done;
+	}
+
+	if (l1.len && is_mail(fp)) {
+		ret = PATCH_FORMAT_MBOX;
+		goto done;
+	}
+
+done:
+	fclose(fp);
+	strbuf_release(&l1);
+	return ret;
+}
+
+/**
  * Splits out individual email patches from `paths`, where each path is either
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
@@ -188,6 +289,14 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 static void am_setup(struct am_state *state, enum patch_format patch_format,
 			const char **paths)
 {
+	if (!patch_format)
+		patch_format = detect_patch_format(paths);
+
+	if (!patch_format) {
+		fprintf_ln(stderr, _("Patch format detection failed."));
+		exit(128);
+	}
+
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
 
-- 
2.5.0.rc0.76.gb2c6e93
