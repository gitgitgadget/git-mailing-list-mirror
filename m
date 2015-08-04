From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 06/45] builtin-am: auto-detect mbox patches
Date: Tue,  4 Aug 2015 21:51:27 +0800
Message-ID: <1438696326-19590-7-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMces-0002IR-C8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934240AbbHDNxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:53:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33746 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627AbbHDNxN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:13 -0400
Received: by padck2 with SMTP id ck2so9376499pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YeOS2YdSmnvDUg+3FXKuKCtV5qf8MXVwAhIGTMX3Mb0=;
        b=jYh5F25be9jz1GgtF15o27iqgau4G287f0qWstp5Z4Ju93vkZuUsvgMtu771LdnUH1
         J4ux+gQSyZPl5tY3FyDugJ3UPF6AP4llmMn9CPRZ5t6LXM6GfbWHHdBQaxucGD4vSS/d
         WtY4qku3AkUqDGgJZjgBSlflvzSHgPdZm6FgntYq8NbiajxwYC70oyOcyYZ2LxIHGxcj
         tPvYtGGxyBGZ+OnPx3tZ0XIexWol1kvR9a3fZzBwjq4U6MCaGCHecG2C+r4BzR8iVuHl
         YfKa6Kl/f4tC0IaSCLnNWyv4JP6QFdUi2yA0ku3WPZoFFSMMwwpMGOO9mJREI32VuTPw
         Ad2A==
X-Received: by 10.66.55.66 with SMTP id q2mr8107109pap.94.1438696393175;
        Tue, 04 Aug 2015 06:53:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275279>

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
2.5.0.280.gd88bd6e
