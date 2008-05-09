From: drafnel@gmail.com
Subject: [PATCH 1/2] ident.c: New function valid_ident for checking ident string formatting
Date: Fri,  9 May 2008 00:03:35 -0500
Message-ID: <56662.1210309343088.JavaMail.teamon@b304.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 07:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuL1H-0006Bh-6c
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 07:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYEIFSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 01:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYEIFSx
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 01:18:53 -0400
Received: from mailproxy04.teamon.com ([64.14.130.33]:30636 "EHLO
	b304.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751986AbYEIFSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 01:18:51 -0400
X-Greylist: delayed 985 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2008 01:18:51 EDT
Received: from b304.teamon.com (localhost [127.0.0.1])
	by b304.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4952Ns03469;
	Fri, 9 May 2008 05:02:23 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81599>

From: Brandon Casey <drafnel@gmail.com>

This function provides a centralized method for checking ident
strings which can be shared by the functions creating or parsing
author, committer, or tagger fields.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 cache.h |    1 +
 ident.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index d5d5dad..92f21e1 100644
--- a/cache.h
+++ b/cache.h
@@ -580,6 +580,7 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern int valid_ident(const char *buf, size_t size, int flag);
 
 struct checkout {
 	const char *base_dir;
diff --git a/ident.c b/ident.c
index ed44a53..1dc9b22 100644
--- a/ident.c
+++ b/ident.c
@@ -167,6 +167,75 @@ static int copy(char *buf, size_t size, int offset, const char *src)
 	return offset;
 }
 
+int valid_ident(const char *buf, size_t size, int flag)
+{
+        const char *s, *lb, *rb;
+	int name_addr_only = (flag & IDENT_NO_DATE);
+
+        /* check for leading crud */
+	if (crud(*buf))
+		return 0;
+
+	/* Find start of email and check for disallowed chars in name */
+	if (!(lb = strstr(buf, " <")) || strpbrk(buf, "<>\n") < lb)
+		return 0;
+
+	/* Check for empty name and trailing crud in name */
+	if (lb == buf || crud(lb[-1]))
+		return 0;
+
+	/* Find end of email and check for disallowed chars in email */
+	if (!(rb = strchr(lb+2, '>')) || strpbrk(lb+2, "><\n ") < rb)
+		return 0;
+
+	/* Check for leading or trailing crud in email */
+	if (rb > lb+2 && (crud(lb[2]) || crud(rb[-1])))
+		return 0;
+
+	s = rb+1;
+	if (!name_addr_only) {
+		char tz[5];
+		size_t len;
+
+		/* a space separates email from timestamp */
+		if (*s != ' ')
+			return 0;
+		s++;
+
+		/*
+		 * timestamp, 1 or more digits followed by space.
+		 * fast-import at least assumes the timestamp and
+		 * timezone fields will be 23 bytes or less. That
+		 * leaves 17 bytes for the timestamp.
+		 */
+		if (!(len = strspn(s, "0123456789")) || len > 17)
+			return 0;
+		s += len;
+
+		/* a space separates timestamp from timezone */
+		if (*s != ' ')
+			return 0;
+		s++;
+
+		/*
+                 * timezone, 5 digits [+-]hhmm, max. 1400
+                 * A buffer is used here to hold the timezone characters
+                 * since our string may not be nul terminated immediately
+                 * after the timezone field. Though it must adhere to the
+                 * size parameter supplied by the caller.
+                 */
+		if (!((s[0] == '+' || s[0] == '-') &&
+		      strlcpy(tz, s+1, 5) >= 4 &&
+		      strspn(tz, "0123456789") == 4 &&
+		      atoi(tz) <= 1400))
+			return 0;
+
+		s += 5;
+	}
+
+	return (s - buf == size);
+}
+
 static const char au_env[] = "GIT_AUTHOR_NAME";
 static const char co_env[] = "GIT_COMMITTER_NAME";
 static const char *env_hint =
-- 
1.5.5.67.g9a49
