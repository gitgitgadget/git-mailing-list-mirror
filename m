From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 06/19] am: detect mbox patches
Date: Thu, 11 Jun 2015 18:21:52 +0800
Message-ID: <1434018125-31804-7-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdB-0007iP-0V
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbbFKKWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:37 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35780 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbFKKWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:34 -0400
Received: by pdbnf5 with SMTP id nf5so1985448pdb.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rmWY8lnZMEC1xSMsyvExGt1vkB3TlViuiDUc5ACMOEU=;
        b=ZVH4VYxgHCs0oxlIPxVjJZ1s8V+rLkxnO/PpViNiwzHVf3s2wH3OXesxsvFPDuhgOp
         koxy2N6D7m3XzLHHoTT7SPRy0IsJeIQGDnxrrHHsuMj7YTfLE5fkQxaqk/s9JxyasUYS
         JLzQIB2m8OgYy6C6ijqBt8/QOhhEqhDHmp2+AWqxI4cfX5p+7nCHSJiST7CkeDLb4MqL
         jxUwp6raEJoJC+mAN0IJ1VgWY7MwKyD7sxbF5VPC8QHUCRP+CWLSE4SzWzNrJeL1wl61
         2NhK98UptY1N8eAlJXADn9TRVhVx3DcNKl72urncWzD8JQd9D87fdOnvgLFPV8oXIRsB
         Rlgg==
X-Received: by 10.70.55.165 with SMTP id t5mr13550303pdp.102.1434018153451;
        Thu, 11 Jun 2015 03:22:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271386>

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh is able to autodetect mbox, stgit and
mercurial patches through heuristics.

Re-implement support for autodetecting mbox/maildir files.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Various small code tweaks suggested by Eric.

 builtin/am.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 5198a8e..7379b97 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -120,6 +120,96 @@ static void am_destroy(const struct am_state *state)
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
+			goto done;
+		}
+	}
+
+done:
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
+		ret = PATCH_FORMAT_MBOX;
+		goto done;
+	}
+
+	/*
+	 * Otherwise, check the first 3 lines of the first patch, starting
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
+done:
+	strbuf_release(&l1);
+	strbuf_release(&l2);
+	strbuf_release(&l3);
+	return ret;
+}
+
 /**
  * Splits out individual patches from `paths`, where each path is either a mbox
  * file or a Maildir. Return 0 on success, -1 on failure.
@@ -174,6 +264,14 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
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
