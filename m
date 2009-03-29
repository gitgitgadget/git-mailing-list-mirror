From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] quote: implement "sq_dequote_many" to unwrap many args
 in one string
Date: Sun, 29 Mar 2009 11:44:44 +0200
Message-ID: <20090329114444.5579813c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnrbo-00046d-2S
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZC2Jpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbZC2Jpt
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:45:49 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:58953 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbZC2Jps (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:45:48 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id A640E4B0090;
	Sun, 29 Mar 2009 11:45:39 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 94CC04B0168;
	Sun, 29 Mar 2009 11:45:36 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115005>

The new "sq_dequote_many" function is implemented by changing the
code of "sq_dequote" and "sq_dequote" is now a thin wrapper around
"sq_dequote_many".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 quote.c |   18 ++++++++++++++++--
 quote.h |    8 ++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/quote.c b/quote.c
index 6a52085..8cf0ef4 100644
--- a/quote.c
+++ b/quote.c
@@ -72,7 +72,7 @@ void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 	}
 }
 
-char *sq_dequote(char *arg)
+char *sq_dequote_many(char *arg, char **next)
 {
 	char *dst = arg;
 	char *src = arg;
@@ -92,6 +92,8 @@ char *sq_dequote(char *arg)
 		switch (*++src) {
 		case '\0':
 			*dst = 0;
+			if (next)
+				*next = 0;
 			return arg;
 		case '\\':
 			c = *++src;
@@ -101,11 +103,23 @@ char *sq_dequote(char *arg)
 			}
 		/* Fallthrough */
 		default:
-			return NULL;
+			if (!next || !isspace(*src))
+				return NULL;
+			do {
+				c = *++src;
+			} while (isspace(c));
+			*dst = 0;
+			*next = src;
+			return arg;
 		}
 	}
 }
 
+char *sq_dequote(char *arg)
+{
+	return sq_dequote_many(arg, NULL);
+}
+
 /* 1 means: quote as octal
  * 0 means: quote as octal if (quote_path_fully)
  * -1 means: never quote
diff --git a/quote.h b/quote.h
index c5eea6f..c2f98e7 100644
--- a/quote.h
+++ b/quote.h
@@ -39,6 +39,14 @@ extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
  */
 extern char *sq_dequote(char *);
 
+/*
+ * Same as the above, but can unwraps many arguments in the same string
+ * separated by space. "next" is changed to point to the next argument
+ * that should be passed as first parameter. When there are no more
+ * arguments to be dequoted, then "next" is changed to point to NULL.
+ */
+extern char *sq_dequote_many(char *arg, char **next);
+
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
 extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
-- 
1.6.2.1.404.gb0085.dirty
