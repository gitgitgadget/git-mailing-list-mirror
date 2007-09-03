From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] Export format_commit_message()
Date: Mon, 03 Sep 2007 20:06:36 +0200
Message-ID: <46DC4D2C.8070109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISGK3-0008RD-WB
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 20:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbXICSGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbXICSGr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 14:06:47 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54591
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087AbXICSGq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 14:06:46 -0400
Received: from [10.0.1.201] (p508EFD82.dip.t-dialin.net [80.142.253.130])
	by neapel230.server4you.de (Postfix) with ESMTP id D70B2873B5;
	Mon,  3 Sep 2007 20:06:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57497>

Drop the parameter "msg" of format_commit_message() (as it can be
inferred from the parameter "commit"), add a parameter "template"
in order to avoid accessing the static variable user_format
directly and export the result.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c |    9 +++++----
 commit.h |    1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index dc5a064..651e904 100644
--- a/commit.c
+++ b/commit.c
@@ -787,8 +787,8 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
 }
 
-static long format_commit_message(const struct commit *commit,
-		const char *msg, char **buf_p, unsigned long *space_p)
+long format_commit_message(const struct commit *commit, const void *template,
+                           char **buf_p, unsigned long *space_p)
 {
 	struct interp table[] = {
 		{ "%H" },	/* commit hash */
@@ -843,6 +843,7 @@ static long format_commit_message(const struct commit *commit,
 	char parents[1024];
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
+	const char *msg = commit->buffer;
 
 	if (ILEFT_RIGHT + 1 != ARRAY_SIZE(table))
 		die("invalid interp table!");
@@ -924,7 +925,7 @@ static long format_commit_message(const struct commit *commit,
 		char *buf = *buf_p;
 		unsigned long space = *space_p;
 
-		space = interpolate(buf, space, user_format,
+		space = interpolate(buf, space, template,
 				    table, ARRAY_SIZE(table));
 		if (!space)
 			break;
@@ -1165,7 +1166,7 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt,
 	char *buf;
 
 	if (fmt == CMIT_FMT_USERFORMAT)
-		return format_commit_message(commit, msg, buf_p, space_p);
+		return format_commit_message(commit, user_format, buf_p, space_p);
 
 	encoding = (git_log_output_encoding
 		    ? git_log_output_encoding
diff --git a/commit.h b/commit.h
index 467872e..a8d7661 100644
--- a/commit.h
+++ b/commit.h
@@ -61,6 +61,7 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
+extern long format_commit_message(const struct commit *commit, const void *template, char **buf_p, unsigned long *space_p);
 extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char **buf_p, unsigned long *space_p, int abbrev, const char *subject, const char *after_subject, enum date_mode dmode);
 
 /** Removes the first commit from a list sorted by date, and adds all
-- 
1.5.3
