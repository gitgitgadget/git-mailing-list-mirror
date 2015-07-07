From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 38/44] builtin-am: support and auto-detect StGit patches
Date: Tue,  7 Jul 2015 22:20:56 +0800
Message-ID: <1436278862-2638-39-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:23:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTmq-0005PY-M6
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757706AbbGGOXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:23:38 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35921 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757757AbbGGOXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:23:03 -0400
Received: by pacgz10 with SMTP id gz10so40453851pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8jwb3iXUMppQQPTdllwgMLI+X7YfaJT7kVLfQJ5uBxU=;
        b=XLgNYllS4VzW4bdH6hPOz4NENiAin7Dpw2mYhSuI6TA8wmYYce1jIrrTJjwlcdyj36
         8NQt9gd27hTiozNr9MSJWD5YxiXBE4hh9asMj8AxVSt1V8Q9r+jJnOipFdzY8cfBe9R1
         mjrgU7ph6f2bJ4kU2UjqkxZHVMavgOHFcQVOivmpxaYA9vsYK6Wc6UtlwvwAoCyYo5rT
         ULIs8hD3rFJQYuJtn1srX9yJ87PlYONo2TsNzvQ/jCvIJRWrGy5nuoELd0CIcqY9ZQHE
         GTN/IZQqvalYEZ3rsHBpI0gaa/BOSI7WNeRzywq0GxLSh3yf56jbxkHMT5DC/M2SKVYg
         DhFQ==
X-Received: by 10.68.197.102 with SMTP id it6mr9544752pbc.65.1436278982401;
        Tue, 07 Jul 2015 07:23:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.22.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:23:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273551>

Since c574e68 (git-am foreign patch support: StGIT support, 2009-05-27),
git-am.sh supported converting StGit patches into RFC2822 mail patches
that can be parsed with git-mailinfo.

Implement this by introducing two functions in builtin/am.c:
stgit_patch_to_mail() and split_mail_conv().

stgit_patch_to_mail() is a callback function for split_mail_conv(), and
contains the logic for converting an StGit patch into an RFC2822 mail
patch.

split_mail_conv() implements the logic to go through each file in the
`paths` list, reading from stdin where specified, and calls the callback
function to write the converted patch to the corresponding output file
in the state directory. This interface should be generic enough to
support other foreign patch formats in the future.

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh is able to auto-detect StGit patches.
Re-implement this in builtin/am.c.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v5
    
    * Rewrite of the loop in str_isspace() to be clearer.

 builtin/am.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6b388de..0bb1875 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -65,9 +65,22 @@ static int linelen(const char *msg)
 	return strchrnul(msg, '\n') - msg;
 }
 
+/**
+ * Returns true if `str` consists of only whitespace, false otherwise.
+ */
+static int str_isspace(const char *str)
+{
+	for (; *str; str++)
+		if (!isspace(*str))
+			return 0;
+
+	return 1;
+}
+
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
-	PATCH_FORMAT_MBOX
+	PATCH_FORMAT_MBOX,
+	PATCH_FORMAT_STGIT
 };
 
 enum keep_type {
@@ -646,6 +659,8 @@ static int detect_patch_format(const char **paths)
 {
 	enum patch_format ret = PATCH_FORMAT_UNKNOWN;
 	struct strbuf l1 = STRBUF_INIT;
+	struct strbuf l2 = STRBUF_INIT;
+	struct strbuf l3 = STRBUF_INIT;
 	FILE *fp;
 
 	/*
@@ -671,6 +686,23 @@ static int detect_patch_format(const char **paths)
 		goto done;
 	}
 
+	strbuf_reset(&l2);
+	strbuf_getline_crlf(&l2, fp);
+	strbuf_reset(&l3);
+	strbuf_getline_crlf(&l3, fp);
+
+	/*
+	 * If the second line is empty and the third is a From, Author or Date
+	 * entry, this is likely an StGit patch.
+	 */
+	if (l1.len && !l2.len &&
+		(starts_with(l3.buf, "From:") ||
+		 starts_with(l3.buf, "Author:") ||
+		 starts_with(l3.buf, "Date:"))) {
+		ret = PATCH_FORMAT_STGIT;
+		goto done;
+	}
+
 	if (l1.len && is_mail(fp)) {
 		ret = PATCH_FORMAT_MBOX;
 		goto done;
@@ -711,6 +743,100 @@ static int split_mail_mbox(struct am_state *state, const char **paths, int keep_
 }
 
 /**
+ * Callback signature for split_mail_conv(). The foreign patch should be
+ * read from `in`, and the converted patch (in RFC2822 mail format) should be
+ * written to `out`. Return 0 on success, or -1 on failure.
+ */
+typedef int (*mail_conv_fn)(FILE *out, FILE *in, int keep_cr);
+
+/**
+ * Calls `fn` for each file in `paths` to convert the foreign patch to the
+ * RFC2822 mail format suitable for parsing with git-mailinfo.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
+			const char **paths, int keep_cr)
+{
+	static const char *stdin_only[] = {"-", NULL};
+	int i;
+
+	if (!*paths)
+		paths = stdin_only;
+
+	for (i = 0; *paths; paths++, i++) {
+		FILE *in, *out;
+		const char *mail;
+		int ret;
+
+		if (!strcmp(*paths, "-"))
+			in = stdin;
+		else
+			in = fopen(*paths, "r");
+
+		if (!in)
+			return error(_("could not open '%s' for reading: %s"),
+					*paths, strerror(errno));
+
+		mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
+
+		out = fopen(mail, "w");
+		if (!out)
+			return error(_("could not open '%s' for writing: %s"),
+					mail, strerror(errno));
+
+		ret = fn(out, in, keep_cr);
+
+		fclose(out);
+		fclose(in);
+
+		if (ret)
+			return error(_("could not parse patch '%s'"), *paths);
+	}
+
+	state->cur = 1;
+	state->last = i;
+	return 0;
+}
+
+/**
+ * A split_mail_conv() callback that converts an StGit patch to an RFC2822
+ * message suitable for parsing with git-mailinfo.
+ */
+static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int subject_printed = 0;
+
+	while (!strbuf_getline(&sb, in, '\n')) {
+		const char *str;
+
+		if (str_isspace(sb.buf))
+			continue;
+		else if (skip_prefix(sb.buf, "Author:", &str))
+			fprintf(out, "From:%s\n", str);
+		else if (starts_with(sb.buf, "From") || starts_with(sb.buf, "Date"))
+			fprintf(out, "%s\n", sb.buf);
+		else if (!subject_printed) {
+			fprintf(out, "Subject: %s\n", sb.buf);
+			subject_printed = 1;
+		} else {
+			fprintf(out, "\n%s\n", sb.buf);
+			break;
+		}
+	}
+
+	strbuf_reset(&sb);
+	while (strbuf_fread(&sb, 8192, in) > 0) {
+		fwrite(sb.buf, 1, sb.len, out);
+		strbuf_reset(&sb);
+	}
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+/**
  * Splits a list of files/directories into individual email patches. Each path
  * in `paths` must be a file/directory that is formatted according to
  * `patch_format`.
@@ -738,6 +864,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 	switch (patch_format) {
 	case PATCH_FORMAT_MBOX:
 		return split_mail_mbox(state, paths, keep_cr);
+	case PATCH_FORMAT_STGIT:
+		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1768,6 +1896,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 	if (!strcmp(arg, "mbox"))
 		*opt_value = PATCH_FORMAT_MBOX;
+	else if (!strcmp(arg, "stgit"))
+		*opt_value = PATCH_FORMAT_STGIT;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc1.76.gf60a929
