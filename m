From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v3 3/5] pretty: make it easier to add new formats
Date: Fri, 30 Apr 2010 20:35:26 +0100
Message-ID: <1272656128-2002-4-git-send-email-wmpalmer@gmail.com>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:38:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w2v-0008Of-UM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab0D3Tgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:36:36 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56379 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933085Ab0D3Tfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:35:42 -0400
Received: by wwb34 with SMTP id 34so446931wwb.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bK3ejo4QB2O7OxwX2Y7dvYfGo7jlQ++aB9OlWM77qf8=;
        b=M+oSn9uX/F1zwxEHy2f4Uwq5qYeiy4yHrkjPbYwtPH0nI92tKYnpj7noaHTU1yukpQ
         3+vxSMuJyCGdhk/YGz1WZ1NRH3W94lC6DlIML12dvBq3TFBnrHiESTQDr9QRKKJyOPgH
         I+irHoeS1UvEaIWaz+nWuwa5SG4yKeQX8cBto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DFNtMqbwFw2j7Io7dsRA6AFHiUcfre4E/tRA2+yb38uBfk3/tdodErP18oxQFGLjQF
         kdwPRvKHX7p6jGiL/3UbNLrJaLa3fdlZLo3brmfpV3YYhu1w3J1Xbvlqcd+JFOW4p/LU
         xyKSe5jsxmCaO2PKkfzf5YCb7h6LmTYWo8Pfo=
Received: by 10.216.163.7 with SMTP id z7mr1964656wek.123.1272656141305;
        Fri, 30 Apr 2010 12:35:41 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm17896470wbs.4.2010.04.30.12.35.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 12:35:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146053>

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
index 60ed9f6..55d5721 100644
--- a/pretty.c
+++ b/pretty.c
@@ -11,6 +11,13 @@
 #include "reflog-walk.h"
 
 static char *user_format;
+static struct cmt_fmt_map {
+	const char *name;
+	enum cmit_fmt format;
+	int is_tformat;
+} *commit_formats = NULL;
+static size_t commit_formats_len = 0;
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
+		if( prefixcmp(commit_formats[i].name, sought) )
+			continue;
+
+		match_len = strlen(commit_formats[i].name);
+		if( found == NULL || found_match_len > match_len ){
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
+	if( !commit_format )
+		die("invalid --pretty format: %s", arg);
+
+	rev->commit_format = commit_format->format;
+	rev->use_terminator = commit_format->is_tformat;
 }
 
 /*
-- 
1.7.1.rc1.13.gbb0a0a.dirty
