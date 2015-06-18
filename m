From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 06/31] am: detect mbox patches
Date: Thu, 18 Jun 2015 19:25:18 +0800
Message-ID: <1434626743-8552-7-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xxw-0004e3-KU
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbbFRL0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:32 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34825 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbbFRL02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:28 -0400
Received: by pacyx8 with SMTP id yx8so59547565pac.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u41vXu8yNkV3M3JUxi8Oaek6TUgFOilKvtxvZSW4cXI=;
        b=hOASDDz11fRv+omTUZt0oMdpH2SSBo+fwYhlu1Xkoa5M0DKFXl/Lnx5fzSXWYQiRMw
         2ftPsHO2OEphzgFuVibFPGVJWKezgPobbXVGbv+iNC7XSOyK0rmknPNzE9OpLVxZqq0t
         yn1rUMmAmW6erki4ZUxA5kxQP7zz6hnOerTt4ABVV/w4aVDh9qdVKpA2JRQJ84yrvis2
         i+oC+BEeW3AluhMewCMn1YyLDggzCH7zEMPCq6tiwtMCPqyHrXcZS7RKqyOxfEoIE8m9
         zd/AlH+nULLz0OyuGYrYzGQNnh5ogkKw9wUjYUNsGYcXb7vPkk1Y0Y5clnZz7H3j2Jaj
         /ziA==
X-Received: by 10.68.241.164 with SMTP id wj4mr19991644pbc.37.1434626787850;
        Thu, 18 Jun 2015 04:26:27 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271970>

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh is able to autodetect mbox, stgit and
mercurial patches through heuristics.

Re-implement support for autodetecting mbox/maildir files.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index e9a3687..7b97ea8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -121,6 +121,96 @@ static void am_destroy(const struct am_state *state)
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
@@ -177,6 +267,14 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
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
