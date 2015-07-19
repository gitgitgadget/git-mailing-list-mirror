From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 39/45] builtin-am: support and auto-detect StGit patches
Date: Mon, 20 Jul 2015 00:10:31 +0800
Message-ID: <1437322237-29863-40-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrD2-0006w2-7R
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbbGSQMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:31 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36029 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbbGSQM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:28 -0400
Received: by pdjr16 with SMTP id r16so91407816pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IzWzyEIKCHi89Tc74e4Sxrb10vLZ9c73f5Qtx+K9hTs=;
        b=ZImmsdE/c0/pYQuNqd3XhChx4arwzgjn0SlYuIMdvulP67my76cNXK1QTvENazCTKr
         gftavr60dvjKgpPJAlCHLIszmjtUCUluWk0Yi7E4JWzoYNtCZDNMQF02pQyPG7OfT3tg
         RuGnuusJq4ttN8DTs8u/be+6r2i0D4bjx0e1GQzyvbHazo1eG5lpoRsohae8XSzv2gJV
         zWtW1zMZhsLC/nSrzCPwre575RcIIFsd31xFvFBghTcNlXZZoXYmlXukD0J2PGqKuxLG
         5vviAnq8+Fq/nqo6nYLN+zoRrMmx0oDv2OpFmH/LEw+VnjI8ybQ/GPrOtDWViiotqujQ
         UgOA==
X-Received: by 10.66.164.106 with SMTP id yp10mr49697741pab.121.1437322348389;
        Sun, 19 Jul 2015 09:12:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274263>

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
 builtin/am.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 89613e0..101bca3 100644
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
@@ -612,6 +625,8 @@ static int detect_patch_format(const char **paths)
 {
 	enum patch_format ret = PATCH_FORMAT_UNKNOWN;
 	struct strbuf l1 = STRBUF_INIT;
+	struct strbuf l2 = STRBUF_INIT;
+	struct strbuf l3 = STRBUF_INIT;
 	FILE *fp;
 
 	/*
@@ -637,6 +652,23 @@ static int detect_patch_format(const char **paths)
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
@@ -677,6 +709,100 @@ static int split_mail_mbox(struct am_state *state, const char **paths, int keep_
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
@@ -704,6 +830,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 	switch (patch_format) {
 	case PATCH_FORMAT_MBOX:
 		return split_mail_mbox(state, paths, keep_cr);
+	case PATCH_FORMAT_STGIT:
+		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1751,6 +1879,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 	if (!strcmp(arg, "mbox"))
 		*opt_value = PATCH_FORMAT_MBOX;
+	else if (!strcmp(arg, "stgit"))
+		*opt_value = PATCH_FORMAT_STGIT;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc2.110.gb39b692
