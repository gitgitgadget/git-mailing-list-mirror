From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 41/45] builtin-am: support and auto-detect mercurial patches
Date: Mon, 20 Jul 2015 00:10:33 +0800
Message-ID: <1437322237-29863-42-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCo-0006qN-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbbGSQMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34883 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbGSQMc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:32 -0400
Received: by pabkd10 with SMTP id kd10so17171091pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqxSWpEk2Xmu/jMQzRgYkDjZmKrZxrQ4t6tlKzZHlSQ=;
        b=LaFrYD+tIGfs7QjeKZmvHF8UkDPLqjKt7GVbHfYYQR3elh+m0IaIlnEvjdMmMZLxdc
         NwZ+dNAu/2HJ6c+7Ns/rNyzGDbjWL1MUcI3JgxqH/oA73NAwrqkAtyTumFXZrf2LEYxs
         aS1YyT2w4cQq0DtLhYGoqyGc4SJGWRIn67psABhmCjAf/RcbmUo4N37gDYy+z3a5VlUO
         qQssEoJBc5mdrl3bLjuauMs+5//7/DNOSXFWAaU1HhFB0tgDHDo3VnNSUw8kC1yTYW8Y
         6Fj0nJ4F0jpgA4Q6PBc2/9kc/ZgIddD4R4l7bVtUIUNc5OlxgksYzMPix1vBHpSKuQzl
         LuiA==
X-Received: by 10.68.78.36 with SMTP id y4mr49251498pbw.106.1437322352557;
        Sun, 19 Jul 2015 09:12:32 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274261>

Since 0cfd112 (am: preliminary support for hg patches, 2011-08-29),
git-am.sh could convert mercurial patches to an RFC2822 mail patch
suitable for parsing with git-mailinfo, and queue them in the state
directory for application.

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh was able to auto-detect mercurial
patches by checking if the file begins with the line:

	# HG changeset patch

Re-implement the above in builtin/am.c.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 01f8a53..8fe616e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -81,7 +81,8 @@ enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
 	PATCH_FORMAT_MBOX,
 	PATCH_FORMAT_STGIT,
-	PATCH_FORMAT_STGIT_SERIES
+	PATCH_FORMAT_STGIT_SERIES,
+	PATCH_FORMAT_HG
 };
 
 enum keep_type {
@@ -658,6 +659,11 @@ static int detect_patch_format(const char **paths)
 		goto done;
 	}
 
+	if (!strcmp(l1.buf, "# HG changeset patch")) {
+		ret = PATCH_FORMAT_HG;
+		goto done;
+	}
+
 	strbuf_reset(&l2);
 	strbuf_getline_crlf(&l2, fp);
 	strbuf_reset(&l3);
@@ -856,6 +862,68 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 }
 
 /**
+ * A split_patches_conv() callback that converts a mercurial patch to a RFC2822
+ * message suitable for parsing with git-mailinfo.
+ */
+static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	while (!strbuf_getline(&sb, in, '\n')) {
+		const char *str;
+
+		if (skip_prefix(sb.buf, "# User ", &str))
+			fprintf(out, "From: %s\n", str);
+		else if (skip_prefix(sb.buf, "# Date ", &str)) {
+			unsigned long timestamp;
+			long tz, tz2;
+			char *end;
+
+			errno = 0;
+			timestamp = strtoul(str, &end, 10);
+			if (errno)
+				return error(_("invalid timestamp"));
+
+			if (!skip_prefix(end, " ", &str))
+				return error(_("invalid Date line"));
+
+			errno = 0;
+			tz = strtol(str, &end, 10);
+			if (errno)
+				return error(_("invalid timezone offset"));
+
+			if (*end)
+				return error(_("invalid Date line"));
+
+			/*
+			 * mercurial's timezone is in seconds west of UTC,
+			 * however git's timezone is in hours + minutes east of
+			 * UTC. Convert it.
+			 */
+			tz2 = labs(tz) / 3600 * 100 + labs(tz) % 3600 / 60;
+			if (tz > 0)
+				tz2 = -tz2;
+
+			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_RFC2822));
+		} else if (starts_with(sb.buf, "# ")) {
+			continue;
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
@@ -887,6 +955,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT_SERIES:
 		return split_mail_stgit_series(state, paths, keep_cr);
+	case PATCH_FORMAT_HG:
+		return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1938,6 +2008,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_STGIT;
 	else if (!strcmp(arg, "stgit-series"))
 		*opt_value = PATCH_FORMAT_STGIT_SERIES;
+	else if (!strcmp(arg, "hg"))
+		*opt_value = PATCH_FORMAT_HG;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc2.110.gb39b692
