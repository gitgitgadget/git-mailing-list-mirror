From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 41/45] builtin-am: support and auto-detect mercurial patches
Date: Tue,  4 Aug 2015 21:52:02 +0800
Message-ID: <1438696326-19590-42-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:58:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMcjU-0004gV-He
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbbHDNyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:54:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35530 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964965AbbHDNyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:54:47 -0400
Received: by pasy3 with SMTP id y3so9215646pas.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ppsCHMKMlzEfnx62ifJ75ed0nIBuUu/5+wy4bkH/i7s=;
        b=p90aQT5GqOlP3m1RluPj7ssO3dxMwQiMp3AgMCad3XTQv5HrCfRXZ3BP7c5MjWCI67
         e5m2HyaTuWzSv7rGjXM29H3n6mCJcJGAPeJJdTRK4V1M/7ZireedjISwal4r7ihVtoW5
         QyXRMq/4TRdsqEHdvp2soXMhFgNjv7vmbIC+T9g0RITqLDnYaYIzCs6IO0DetFEVV4aM
         csQkKb41vPA5+wLMafTGu730K/PgOZs1NZLTQolQs8xS00jB8CWuc6k7iD2SqduoCpcs
         5TQ0++F9+ziiVQOkoaSJsmI1oXOFS1iwy7Ydcjn/5g3FZeRviiUTac1ddBLCgnjaxQft
         +qjw==
X-Received: by 10.66.62.194 with SMTP id a2mr8257346pas.67.1438696486905;
        Tue, 04 Aug 2015 06:54:46 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.54.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:54:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275312>

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
    v7
    
    * Since a5481a6 (convert "enum date_mode" into a struct, 2015-06-25),
      show_date() now takes a date_mode struct. Use the DATE_MODE() macro to
      pass the equivalent date_mode struct to show_date().

 builtin/am.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3c2ec15..98c10a0 100644
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
@@ -656,6 +657,11 @@ static int detect_patch_format(const char **paths)
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
@@ -854,6 +860,68 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
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
+			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_MODE(RFC2822)));
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
@@ -885,6 +953,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT_SERIES:
 		return split_mail_stgit_series(state, paths, keep_cr);
+	case PATCH_FORMAT_HG:
+		return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1937,6 +2007,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_STGIT;
 	else if (!strcmp(arg, "stgit-series"))
 		*opt_value = PATCH_FORMAT_STGIT_SERIES;
+	else if (!strcmp(arg, "hg"))
+		*opt_value = PATCH_FORMAT_HG;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.280.gd88bd6e
