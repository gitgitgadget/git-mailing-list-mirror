From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 40/44] builtin-am: support and auto-detect mercurial patches
Date: Tue,  7 Jul 2015 22:20:58 +0800
Message-ID: <1436278862-2638-41-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:24:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTn9-0005aa-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469AbbGGOYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:24:04 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33246 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbbGGOXK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:23:10 -0400
Received: by pdbdz6 with SMTP id dz6so31998451pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROvFrEpLxiJiV/SJSqmyBFI9C0B78uSPa41swv0ldpY=;
        b=pEW9NhThHhj5wxbOCoTygX2BL2Je4iGFL377A/cqwXNWTNWy5oAykJfiorTIQBntkA
         I1LX+6aC55LT+4Tk+5muJpGdzTU0HgPqlQknFbGam9y/0xn9DNKI82gTRaTc/+8pqyZO
         kw97dNyyCRCP5oMm5WopycGo8EuoB6AEeckw45dl7JKEUWty5rFjLuuRqSfv3oM3oY5p
         goe10H3v0XfE45m97c8/O846IUUe0ORaQTLKRD8wD4F/xodg0p7c545vlClKViGqyxqE
         896SACIaiIJiQGRTf3/JlMSwGEOghj8uIGJsndQjZvvMNcfBJocuayufzaz2mWyzXRwW
         uhqw==
X-Received: by 10.66.66.130 with SMTP id f2mr9729937pat.120.1436278989145;
        Tue, 07 Jul 2015 07:23:09 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.23.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:23:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273557>

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

Notes:
    v5
    
    * v4 had a math fail in the timestamp conversion. Fixed the math.
    
    * In C89, it is implementation defined whether integer division rounds
      towards 0 or towards negative infinity. To be safe, we do the
      timestamp conversion with positive integers only, and then negate the
      result appropriately.

 builtin/am.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7a56005..55962c6 100644
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
@@ -692,6 +693,11 @@ static int detect_patch_format(const char **paths)
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
@@ -890,6 +896,68 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
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
@@ -921,6 +989,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT_SERIES:
 		return split_mail_stgit_series(state, paths, keep_cr);
+	case PATCH_FORMAT_HG:
+		return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1955,6 +2025,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_STGIT;
 	else if (!strcmp(arg, "stgit-series"))
 		*opt_value = PATCH_FORMAT_STGIT_SERIES;
+	else if (!strcmp(arg, "hg"))
+		*opt_value = PATCH_FORMAT_HG;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc1.76.gf60a929
