From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/15] pretty: introduce get_pretty_userformat
Date: Tue,  4 Jun 2013 18:05:36 +0530
Message-ID: <1370349337-20938-15-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRi-00078F-Ct
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab3FDMee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54150 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3FDMeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so310700pab.34
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aL9jwOKoFdPPoRez9qXmK+WosUbTNXFCZXW+wMfzHa4=;
        b=D7JknXsdLv0bKOvcAw5XsJgvBWUtpUOeCs9ZaRmWISVBNQd2qh1uah7y2/6JqELB4o
         0OdDuzspBtLAu41SOnjK9MR196IYRXPtKZreDotfchINZ8wwB9Y03X1xjCIYG6gj+GXw
         BmGtbKGsWoqe+Te8kaNukVB7CPfQHbJGFdOQ5kR3svgV3+oRgpl8t32BnoM7Rzj3iy2I
         JIIt5ORVrS6r8og9Bh4PpU2vwRLFT0o8ClplH1uQF+7I0qCVSmJdICOTIW4BwoPJ6ti3
         9otbgRwPV1AfzQr3Io8a5UcqJP2z06ArhWM4wuDbRo/qnb3jDBGKQjaWquD/GxiVqmnM
         2q9Q==
X-Received: by 10.66.251.101 with SMTP id zj5mr28563307pac.122.1370349270470;
        Tue, 04 Jun 2013 05:34:30 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226354>

This helper function is intended to be used by callers implementing
--pretty themselves; it parses pretty.* configuration variables
recursively and hands the user-defined format back to the caller.  No
builtins are supported, as CMT_FMT_* are really only useful when
displaying commits.  Callers might like to define their own builtins in
the future.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 commit.h |  1 +
 pretty.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/commit.h b/commit.h
index 04bd935..48424c9 100644
--- a/commit.h
+++ b/commit.h
@@ -113,6 +113,7 @@ extern char *logmsg_reencode(const struct commit *commit,
 			     const char *output_encoding);
 extern void logmsg_free(char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern const char *get_pretty_userformat(const char *arg);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
diff --git a/pretty.c b/pretty.c
index 28c0a72..70e4e44 100644
--- a/pretty.c
+++ b/pretty.c
@@ -174,6 +174,31 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 }
 
 /*
+ * Function to parse --pretty string, lookup pretty.* configuration
+ * variables and return the format string, assuming no builtin
+ * formats.  Not limited to commits, unlike get_commit_format().
+ */
+const char *get_pretty_userformat(const char *arg)
+{
+	struct cmt_fmt_map *commit_format;
+
+	if (!arg || !*arg)
+		return NULL;
+
+	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:"))
+		return xstrdup(strchr(arg, ':' + 1));
+
+	if (strchr(arg, '%'))
+		return xstrdup(arg);
+
+	commit_format = find_commit_format(arg);
+	if (!commit_format || commit_format->format != CMIT_FMT_USERFORMAT)
+		die("invalid --pretty format: %s", arg);
+
+	return xstrdup(commit_format->user_format);
+}
+
+/*
  * Generic support for pretty-printing the header
  */
 static int get_one_line(const char *msg)
-- 
1.8.3.GIT
