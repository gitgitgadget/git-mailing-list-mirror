From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 06/45] builtin-am: auto-detect mbox patches
Date: Mon, 20 Jul 2015 00:09:58 +0800
Message-ID: <1437322237-29863-7-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBF-00062B-Gb
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbbGSQLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:05 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36468 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbbGSQLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:03 -0400
Received: by pachj5 with SMTP id hj5so89276622pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HHqyqydwoOWJbP3XvowzXQX8v5OIbjx9x/34GbdwbeE=;
        b=kI50e+ifEeWnEk+FldM0iPa28qcsfwrCe3+ZH4Em0psK81/0nSxGYuD3f98KA4xsxN
         Xb8j4OyLlStwMHcspEFqj1u7ZTlInPSSvBo0KENnNJIvJ5AIYysFkt9UcqjZ1A93FSL6
         4944XLYM1rcIozlSgnlcszTnp4j+V/QA+Njto4RrWlyJMvVrx3x/xF7g1eFNghARTDPa
         dXq9yPzGKIz5d/EospMkM050U/BQy0pkA3dL7Nljt1yGF/L2xm/Bc3pf5eFaWRpdYkRQ
         DOlJKFpwQv4Qu5zHW3RryF03VNIagja5JHk1ISnd/GbiTf4AP8lXqBOIrNGkSbJ9G816
         /Szg==
X-Received: by 10.66.55.66 with SMTP id q2mr49603662pap.94.1437322263480;
        Sun, 19 Jul 2015 09:11:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.10.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274229>

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
 builtin/am.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 5f3c131..c12566a 100644
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
@@ -128,6 +143,92 @@ static void am_destroy(const struct am_state *state)
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
@@ -185,6 +286,14 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
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
2.5.0.rc2.110.gb39b692
