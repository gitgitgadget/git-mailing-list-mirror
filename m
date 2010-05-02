From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v4 1/3] pretty: make it easier to add new formats
Date: Sun,  2 May 2010 12:00:42 +0100
Message-ID: <1272798044-10487-2-git-send-email-wmpalmer@gmail.com>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 13:01:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8WvG-0002Dl-KY
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665Ab0EBLBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:01:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45933 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab0EBLBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:01:08 -0400
Received: by wye20 with SMTP id 20so1085518wye.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YYaHZS7z/ay7QaHayLzG9xJG1/IigjIuA2uNlXj13B8=;
        b=dk9kTCsHyZiSqpaU0mEEZHgSOfinjmX+bU+jNHRlankhLAq7uGhU8D06XYRN7jio0Z
         +VnRmO1NxIR4qJqh3UX4Uimh48wYFKgkjcUQKOqVT0WVIqDctLvL04ACJr8NBs9TeXjJ
         9fE3fL6PVwXil0dqkaml5c+wkCQ0HoY6qZeqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YpAX8AuTYZDRSiZ2lxfx4q+sT4zGFMTMUaPmhyLBvJqZQCuimOKowUHIPgyKUdHXoK
         6dORks4pZyzSTyhjCfNB44HNUSgMkmhGv2qJtK/328wUcnr5BU+EfxlPIoJLhx8K5mAN
         pio7Rvx/XJSMq/sj7vIK/15pQCqsT4vbovlnM=
Received: by 10.216.88.134 with SMTP id a6mr3495885wef.66.1272798065944;
        Sun, 02 May 2010 04:01:05 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id b2sm25456649wbb.14.2010.05.02.04.01.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 04:01:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146158>

As the first step towards creating aliases, we make it easier to add new
formats to the list of builtin formats. To do this, we move the
initialization of the formats array into a new function,
setup_commit_formats(), which we can easily extend later. Then, rather
than looping through only the list of known formats, we make a more
generic find_commit_format function, which will return the commit format
whose name is the shortest which is prefixed with the passed-in sought
format, the same rules which were more-or-less hard-coded in before.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 pretty.c |   81 +++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/pretty.c b/pretty.c
index 7cb3a2a..ecac8f5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -11,6 +11,13 @@
 #include "reflog-walk.h"
 
 static char *user_format;
+static struct cmt_fmt_map {
+	const char *name;
+	enum cmit_fmt format;
+	int is_tformat;
+} *commit_formats;
+static size_t commit_formats_len;
+static struct cmt_fmt_map *find_commit_format(const char *sought);
 
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
 {
@@ -21,22 +28,51 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 	rev->commit_format = CMIT_FMT_USERFORMAT;
 }
 
-void get_commit_format(const char *arg, struct rev_info *rev)
+static void setup_commit_formats(void)
 {
-	int i;
-	static struct cmt_fmt_map {
-		const char *n;
-		size_t cmp_len;
-		enum cmit_fmt v;
-	} cmt_fmts[] = {
-		{ "raw",	1,	CMIT_FMT_RAW },
-		{ "medium",	1,	CMIT_FMT_MEDIUM },
-		{ "short",	1,	CMIT_FMT_SHORT },
-		{ "email",	1,	CMIT_FMT_EMAIL },
-		{ "full",	5,	CMIT_FMT_FULL },
-		{ "fuller",	5,	CMIT_FMT_FULLER },
-		{ "oneline",	1,	CMIT_FMT_ONELINE },
+	struct cmt_fmt_map builtin_formats[] = {
+		{ "raw",	CMIT_FMT_RAW,		0 },
+		{ "medium",	CMIT_FMT_MEDIUM,	0 },
+		{ "short",	CMIT_FMT_SHORT,		0 },
+		{ "email",	CMIT_FMT_EMAIL,		0 },
+		{ "fuller",	CMIT_FMT_FULLER,	0 },
+		{ "full",	CMIT_FMT_FULL,		0 },
+		{ "oneline",	CMIT_FMT_ONELINE,	1 }
 	};
+	commit_formats_len = ARRAY_SIZE(builtin_formats);
+	commit_formats = xcalloc(commit_formats_len,
+				 sizeof(*builtin_formats));
+	memcpy(commit_formats, builtin_formats,
+	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
+}
+
+static struct cmt_fmt_map *find_commit_format(const char *sought)
+{
+	struct cmt_fmt_map *found = NULL;
+	size_t found_match_len;
+	int i;
+
+	if (!commit_formats)
+		setup_commit_formats();
+
+	for (i = 0; i < commit_formats_len; i++) {
+		size_t match_len;
+
+		if (prefixcmp(commit_formats[i].name, sought))
+			continue;
+
+		match_len = strlen(commit_formats[i].name);
+		if (found == NULL || found_match_len > match_len) {
+			found = &commit_formats[i];
+			found_match_len = match_len;
+		}
+	}
+	return found;
+}
+
+void get_commit_format(const char *arg, struct rev_info *rev)
+{
+	struct cmt_fmt_map *commit_format;
 
 	rev->use_terminator = 0;
 	if (!arg || !*arg) {
@@ -47,21 +83,18 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
 		return;
 	}
-	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
-		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
-		    !strncmp(arg, cmt_fmts[i].n, strlen(arg))) {
-			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
-				rev->use_terminator = 1;
-			rev->commit_format = cmt_fmts[i].v;
-			return;
-		}
-	}
+
 	if (strchr(arg, '%')) {
 		save_user_format(rev, arg, 1);
 		return;
 	}
 
-	die("invalid --pretty format: %s", arg);
+	commit_format = find_commit_format(arg);
+	if (!commit_format)
+		die("invalid --pretty format: %s", arg);
+
+	rev->commit_format = commit_format->format;
+	rev->use_terminator = commit_format->is_tformat;
 }
 
 /*
-- 
1.7.1.rc1.13.gbb0a0a.dirty
