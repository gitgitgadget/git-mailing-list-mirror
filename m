From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 40/44] builtin-am: support and auto-detect mercurial patches
Date: Sun, 28 Jun 2015 22:06:02 +0800
Message-ID: <1435500366-31700-41-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DH6-0003HM-8k
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbbF1OJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:33 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34685 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbF1OJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:09:30 -0400
Received: by pdbep18 with SMTP id ep18so79695344pdb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YsQNQ7hElwv1zXviR7sEkl/uc8K12HBlVMRvMDVq1+A=;
        b=RKKYBZ365rhlxNKgS3GmSwwMcR0iCSpXFhqutmDeYZlMpyChs7AewM3prM5Dwi2S6R
         G89mPq1DTrpqO02G93aMb2LR3OKEx+OteQZSXwfvyWAUtssTvPxbEfDHcnFN9G0IKE9h
         xDYt2eXcDqJDC/Yz6KUw7+AXUq7Ku2xBQPaaOOO/lPXUTZgL1BL3QMWGIOHBl58mI/kS
         /KzE33l4TgukXpryIixy7U8TmvMh5dDduC+x2eSLdkvjE8Ih0e/Atwg3nhRN0Gvxx9NA
         1g81AhLJ0Vk9zgBq0VnKXVhHe7QyfRTaX8fW6pOA15bR4vWGjy3yD3VBX672tVeVfNzD
         9WhA==
X-Received: by 10.67.4.201 with SMTP id cg9mr22568732pad.53.1435500570337;
        Sun, 28 Jun 2015 07:09:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272916>

Since 0cfd112 (am: preliminary support for hg patches, 2011-08-29),
git-am.sh could convert mercurial patches to an RFC2822 mail patch
suitable for parsing with git-mailinfo, and queue them in the state
directory for application.

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh was able to auto-detect mercurial
patches by checking if the file begins with the line:

	# HG changeset patch

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1576bd4..5c86e6f 100644
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
@@ -697,6 +698,11 @@ static int detect_patch_format(const char **paths)
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
@@ -895,6 +901,67 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
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
+			long tz;
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
+			tz = tz / (60 * 60) * 100 + tz % (60 * 60);
+			tz = -tz;
+
+			fprintf(out, "Date: %s\n", show_date(timestamp, tz, DATE_RFC2822));
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
@@ -926,6 +993,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT_SERIES:
 		return split_mail_stgit_series(state, paths, keep_cr);
+	case PATCH_FORMAT_HG:
+		return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1960,6 +2029,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_STGIT;
 	else if (!strcmp(arg, "stgit-series"))
 		*opt_value = PATCH_FORMAT_STGIT_SERIES;
+	else if (!strcmp(arg, "hg"))
+		*opt_value = PATCH_FORMAT_HG;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc0.76.gb2c6e93
