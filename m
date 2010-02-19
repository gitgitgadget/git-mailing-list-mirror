From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/4] utf8.c: remove print_wrapped_text()
Date: Fri, 19 Feb 2010 23:15:01 +0100
Message-ID: <4B7F0D65.1040602@lsrfire.ath.cx>
References: <4B7F0D08.6040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:15:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nib7v-0006Gn-0D
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab0BSWPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 17:15:04 -0500
Received: from india601.server4you.de ([85.25.151.105]:43431 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab0BSWPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 17:15:03 -0500
Received: from [10.0.1.100] (p57B7E04C.dip.t-dialin.net [87.183.224.76])
	by india601.server4you.de (Postfix) with ESMTPSA id 4C7F52F806C;
	Fri, 19 Feb 2010 23:15:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B7F0D08.6040608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140487>

print_wrapped_text() is the only function that calls
strbuf_add_wrapped_text() without a strbuf, which then writes its
results to stdout.  At its only callside, supply a strbuf, call
strbuf_add_wrapped_text() directly and remove the wrapper function.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-shortlog.c |   17 ++++++++++++++---
 utf8.c             |    5 -----
 utf8.h             |    1 -
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b3b055f..ecd2d45 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -304,9 +304,19 @@ parse_done:
 	return 0;
 }
 
+static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
+				     const struct shortlog *log)
+{
+	int col = strbuf_add_wrapped_text(sb, s, log->in1, log->in2, log->wrap);
+	if (col != log->wrap)
+		strbuf_addch(sb, '\n');
+}
+
 void shortlog_output(struct shortlog *log)
 {
 	int i, j;
+	struct strbuf sb = STRBUF_INIT;
+
 	if (log->sort_by_number)
 		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
 			compare_by_number);
@@ -321,9 +331,9 @@ void shortlog_output(struct shortlog *log)
 				const char *msg = onelines->items[j].string;
 
 				if (log->wrap_lines) {
-					int col = print_wrapped_text(msg, log->in1, log->in2, log->wrap);
-					if (col != log->wrap)
-						putchar('\n');
+					strbuf_reset(&sb);
+					add_wrapped_shortlog_msg(&sb, msg, log);
+					fwrite(sb.buf, sb.len, 1, stdout);
 				}
 				else
 					printf("      %s\n", msg);
@@ -337,6 +347,7 @@ void shortlog_output(struct shortlog *log)
 		log->list.items[i].util = NULL;
 	}
 
+	strbuf_release(&sb);
 	log->list.strdup_strings = 1;
 	string_list_clear(&log->list, 1);
 	clear_mailmap(&log->mailmap);
diff --git a/utf8.c b/utf8.c
index ab326ac..831cad6 100644
--- a/utf8.c
+++ b/utf8.c
@@ -405,11 +405,6 @@ new_line:
 	}
 }
 
-int print_wrapped_text(const char *text, int indent, int indent2, int width)
-{
-	return strbuf_add_wrapped_text(NULL, text, indent, indent2, width);
-}
-
 int is_encoding_utf8(const char *name)
 {
 	if (!name)
diff --git a/utf8.h b/utf8.h
index c9738d8..ebc4d2f 100644
--- a/utf8.h
+++ b/utf8.h
@@ -8,7 +8,6 @@ int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 
-int print_wrapped_text(const char *text, int indent, int indent2, int len);
 int strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 
-- 
1.7.0
