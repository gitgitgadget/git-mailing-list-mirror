From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 5/8] am: detect mbox patches
Date: Wed, 27 May 2015 21:33:35 +0800
Message-ID: <1432733618-25629-6-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:34:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbTr-0006FL-7K
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbbE0Nei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:38 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34986 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbE0Neh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:37 -0400
Received: by pdea3 with SMTP id a3so15337181pde.2
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6V4B6ZVL3ubpPdeofFaPdP46ZJsdYceDcjqOscyu2c=;
        b=FJoyNt/0sPULpXNTEsxUZyGaqFcSNxDIn5UvMhTPs9/VSyGCsMboHn0kHmBJqmTpPs
         6yPutfqFDk5YCH/KdXRs+LJ94q0G9OFQ2iAd94YZkDnBy+dValXioVIwAwduRGlrP6WP
         6p33bTLZHqcaIDNkuEAMbi2IhP1wFmKjGMED5/PHdzmyZAABDr+hzGvjFhzlmgISKYsj
         lK9C2AZ8swAE9sJPH7DT+pfwQydixxG7vwRzuUKXN9u3r+R6WlmCbWt9PnMradhdOQlC
         pn+zk/7G2zTKZxTw7WXxdMcf1KnPKi4IS0UUvLVgNYfhGvbmoGvX2tfviXQ4434PiNYA
         6Umg==
X-Received: by 10.70.62.6 with SMTP id u6mr30436279pdr.142.1432733677140;
        Wed, 27 May 2015 06:34:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270051>

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh is able to autodetect mbox, stgit and
mercurial patches through heuristics.

Re-implement support for autodetecting mbox/maildir files.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 9c7b058..d589ec5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -108,6 +108,97 @@ static void am_destroy(const struct am_state *state)
 	strbuf_release(&sb);
 }
 
+/*
+ * Returns 1 if the file looks like a piece of email a-la RFC2822, 0 otherwise.
+ * We check this by grabbing all the non-indented lines and seeing if they look
+ * like they begin with valid header field names.
+ */
+static int is_email(const char *filename)
+{
+	struct strbuf sb = STRBUF_INIT;
+	FILE *fp = xfopen(filename, "r");
+	int ret = 1;
+
+	while (!strbuf_getline(&sb, fp, '\n')) {
+		const char *x;
+
+		strbuf_rtrim(&sb);
+
+		if (!sb.len)
+			break; /* End of header */
+
+		/* Ignore indented folded lines */
+		if (*sb.buf == '\t' || *sb.buf == ' ')
+			continue;
+
+		/* It's a header if it matches the regexp "^[!-9;-~]+:" */
+		for (x = sb.buf; *x; x++) {
+			if (('!' <= *x && *x <= '9') || (';' <= *x && *x <= '~'))
+				continue;
+			if (*x == ':' && x != sb.buf)
+				break;
+			ret = 0;
+			goto fail;
+		}
+	}
+
+fail:
+	fclose(fp);
+	strbuf_release(&sb);
+	return ret;
+}
+
+/**
+ * Attempts to detect the patch_format of the patches contained in `paths`,
+ * returning the PATCH_FORMAT_* enum value. Returns PATCH_FORMAT_UNKNOWN if
+ * detection fails.
+ */
+static int detect_patch_format(struct string_list *paths)
+{
+	enum patch_format ret = PATCH_FORMAT_UNKNOWN;
+	struct strbuf l1 = STRBUF_INIT;
+	struct strbuf l2 = STRBUF_INIT;
+	struct strbuf l3 = STRBUF_INIT;
+	FILE *fp;
+
+	/*
+	 * We default to mbox format if input is from stdin and for directories
+	 */
+	if (!paths->nr || !strcmp(paths->items->string, "-") ||
+	    is_directory(paths->items->string)) {
+		strbuf_release(&l1);
+		strbuf_release(&l2);
+		strbuf_release(&l3);
+		return PATCH_FORMAT_MBOX;
+	}
+
+	/*
+	 * Otherwise, check the first few 3 lines of the first patch, starting
+	 * from the first non-blank line, to try to detect its format.
+	 */
+	fp = xfopen(paths->items->string, "r");
+	while (!strbuf_getline(&l1, fp, '\n')) {
+		strbuf_trim(&l1);
+		if (l1.len)
+			break;
+	}
+	strbuf_getline(&l2, fp, '\n');
+	strbuf_trim(&l2);
+	strbuf_getline(&l3, fp, '\n');
+	strbuf_trim(&l3);
+	fclose(fp);
+
+	if (starts_with(l1.buf, "From ") || starts_with(l1.buf, "From: "))
+		ret = PATCH_FORMAT_MBOX;
+	else if (l1.len && l2.len && l3.len && is_email(paths->items->string))
+		ret = PATCH_FORMAT_MBOX;
+
+	strbuf_release(&l1);
+	strbuf_release(&l2);
+	strbuf_release(&l3);
+	return ret;
+}
+
 /**
  * Splits out individual patches from `paths`, where each path is either a mbox
  * file or a Maildir. Return 0 on success, -1 on failure.
@@ -162,6 +253,14 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
 static void am_setup(struct am_state *state, enum patch_format patch_format,
 		struct string_list *paths)
 {
+	if (!patch_format)
+		patch_format = detect_patch_format(paths);
+
+	if (!patch_format) {
+		fprintf_ln(stderr, _("Patch format detection failed."));
+		exit(128);
+	}
+
 	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir.buf);
 
-- 
2.1.4
