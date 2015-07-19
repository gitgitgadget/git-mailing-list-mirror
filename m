From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 40/45] builtin-am: support and auto-detect StGit series files
Date: Mon, 20 Jul 2015 00:10:32 +0800
Message-ID: <1437322237-29863-41-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrD7-0006yY-7H
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbbGSQM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36067 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbbGSQMa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:30 -0400
Received: by pachj5 with SMTP id hj5so89290469pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wko8Gs1t3J63A+2rak1OxkvGfioYKQz14Rwz8VeGrK4=;
        b=gNhBsi9c/I3SRrjKFZJFGPMSNQdSai+lpCYMzpAyuaO75TQr9jAe2J/u46dpIs5iKS
         dYr7klHwHk4g6Ddpob7Gt9wGlOj2u+RN7u2fwuwVcnr8M1hsxEB8pbEQ9rU69L5jhfj7
         NBv1ApahHA66+9V0Ama1ucAnXg7GpPDutZT51rzP1TwSd4wbNyKVU6VV9kNT/QHX0Dl/
         e+g82KJ6gs40ZEvg83mKcNlOL0BuqH10fSnI5ZarryWTjxInKHHCYeRfd6LZblHaUO7/
         W/hMnu2u/k5+3bb4CHCPTBubUAZek493KD5BIK9tQ0W6o5yhjOQ2P4zjHo/kJSH4QEMz
         +37Q==
X-Received: by 10.66.147.4 with SMTP id tg4mr50362933pab.69.1437322350456;
        Sun, 19 Jul 2015 09:12:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274265>

Since c574e68 (git-am foreign patch support: StGIT support, 2009-05-27),
git-am.sh is able to read a single StGit series file and, for each StGit
patch listed in the file, convert the StGit patch into a RFC2822 mail
patch suitable for parsing with git-mailinfo, and queue them in the
state directory for applying.

Since 15ced75 (git-am foreign patch support: autodetect some patch
formats, 2009-05-27), git-am.sh is able to auto-detect StGit series
files by checking to see if the file starts with the string:

	# This series applies on GIT commit

Re-implement the above in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 101bca3..01f8a53 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -80,7 +80,8 @@ static int str_isspace(const char *str)
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
 	PATCH_FORMAT_MBOX,
-	PATCH_FORMAT_STGIT
+	PATCH_FORMAT_STGIT,
+	PATCH_FORMAT_STGIT_SERIES
 };
 
 enum keep_type {
@@ -652,6 +653,11 @@ static int detect_patch_format(const char **paths)
 		goto done;
 	}
 
+	if (starts_with(l1.buf, "# This series applies on GIT commit")) {
+		ret = PATCH_FORMAT_STGIT_SERIES;
+		goto done;
+	}
+
 	strbuf_reset(&l2);
 	strbuf_getline_crlf(&l2, fp);
 	strbuf_reset(&l3);
@@ -803,6 +809,53 @@ static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 }
 
 /**
+ * This function only supports a single StGit series file in `paths`.
+ *
+ * Given an StGit series file, converts the StGit patches in the series into
+ * RFC2822 messages suitable for parsing with git-mailinfo, and queues them in
+ * the state directory.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int split_mail_stgit_series(struct am_state *state, const char **paths,
+					int keep_cr)
+{
+	const char *series_dir;
+	char *series_dir_buf;
+	FILE *fp;
+	struct argv_array patches = ARGV_ARRAY_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
+
+	if (!paths[0] || paths[1])
+		return error(_("Only one StGIT patch series can be applied at once"));
+
+	series_dir_buf = xstrdup(*paths);
+	series_dir = dirname(series_dir_buf);
+
+	fp = fopen(*paths, "r");
+	if (!fp)
+		return error(_("could not open '%s' for reading: %s"), *paths,
+				strerror(errno));
+
+	while (!strbuf_getline(&sb, fp, '\n')) {
+		if (*sb.buf == '#')
+			continue; /* skip comment lines */
+
+		argv_array_push(&patches, mkpath("%s/%s", series_dir, sb.buf));
+	}
+
+	fclose(fp);
+	strbuf_release(&sb);
+	free(series_dir_buf);
+
+	ret = split_mail_conv(stgit_patch_to_mail, state, patches.argv, keep_cr);
+
+	argv_array_clear(&patches);
+	return ret;
+}
+
+/**
  * Splits a list of files/directories into individual email patches. Each path
  * in `paths` must be a file/directory that is formatted according to
  * `patch_format`.
@@ -832,6 +885,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 		return split_mail_mbox(state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT:
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
+	case PATCH_FORMAT_STGIT_SERIES:
+		return split_mail_stgit_series(state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1881,6 +1936,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_MBOX;
 	else if (!strcmp(arg, "stgit"))
 		*opt_value = PATCH_FORMAT_STGIT;
+	else if (!strcmp(arg, "stgit-series"))
+		*opt_value = PATCH_FORMAT_STGIT_SERIES;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc2.110.gb39b692
