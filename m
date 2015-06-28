From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 39/44] builtin-am: support and auto-detect StGit series files
Date: Sun, 28 Jun 2015 22:06:01 +0800
Message-ID: <1435500366-31700-40-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:09:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DGr-00036x-By
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbbF1OJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:09:18 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35336 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbbF1OIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:08:42 -0400
Received: by pactm7 with SMTP id tm7so91499500pac.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cXt1WI/RgB6Gn8Cd+bUbsM01gdOVJtUjTuKSYN8cV0s=;
        b=f+GJmPb0EZ9AzLSZdL7unUnr5K8bbCy+Nz5bUHUH4CFzP1L0blnpd1BFL7O15IDo4D
         m4kdmzIP5O17NJzsHocmWSGy0C7Ysh/xQtpxU+EuCBwH/kTYw7d59hJ/MFJx8c9HvbYF
         Sywq9ouLmzDhaLFNM9yg8gV8/Hbj315MeCm8fJeVfq32zlMddkIwyFejElVIkZ9LnYDv
         kEMArGOYD6PR5PfosMXh3UpP6kL7hcqV0HVQeFoDFvkBSerJIXJ59mtJMLiYD/e1dB7O
         OPvAdat9A6fLFAV6IjvkUBU/BRd3xhd1qBkg1/XuVK3b/y73PKoMXNcgwXuYlr5qdaUf
         Z49g==
X-Received: by 10.70.49.229 with SMTP id x5mr22146365pdn.81.1435500521886;
        Sun, 28 Jun 2015 07:08:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.08.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:08:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272913>

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
index b73498e..1576bd4 100644
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
@@ -691,6 +692,11 @@ static int detect_patch_format(const char **paths)
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
@@ -842,6 +848,53 @@ static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
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
@@ -871,6 +924,8 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 		return split_mail_mbox(state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT:
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
+	case PATCH_FORMAT_STGIT_SERIES:
+		return split_mail_stgit_series(state, paths, keep_cr);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -1903,6 +1958,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_MBOX;
 	else if (!strcmp(arg, "stgit"))
 		*opt_value = PATCH_FORMAT_STGIT;
+	else if (!strcmp(arg, "stgit-series"))
+		*opt_value = PATCH_FORMAT_STGIT_SERIES;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
-- 
2.5.0.rc0.76.gb2c6e93
