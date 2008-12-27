From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] pretty: factor out format_subject()
Date: Sat, 27 Dec 2008 01:39:35 +0100
Message-ID: <1230338375.8363.91.camel@ubuntu.ubuntu-domain>
References: <1230337969.8363.84.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGNEh-0004t9-M7
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYL0Aji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbYL0Aji
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:39:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:47592 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbYL0Ajh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 19:39:37 -0500
Received: from [10.0.1.101] (p57B7F73B.dip.t-dialin.net [87.183.247.59])
	by india601.server4you.de (Postfix) with ESMTPSA id EF0E82F8003;
	Sat, 27 Dec 2008 01:39:35 +0100 (CET)
In-Reply-To: <1230337969.8363.84.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103973>

The next patch will use it.

In the version that was factored out, we can't rely on the len of the
struct strbuf to find out if a line separator needs to be added, as
it might already contain something.  Add a guard variable ("first")
instead.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/pretty.c b/pretty.c
index c43497b..632abc5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -495,6 +495,28 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
+static const char *format_subject(struct strbuf *sb, const char *msg,
+				  const char *line_separator)
+{
+	int first = 1;
+
+	for (;;) {
+		const char *line = msg;
+		int linelen = get_one_line(line);
+
+		msg += linelen;
+		if (!linelen || is_empty_line(line, &linelen))
+			break;
+
+		strbuf_grow(sb, linelen + 2);
+		if (!first)
+			strbuf_addstr(sb, line_separator);
+		strbuf_add(sb, line, linelen);
+		first = 0;
+	}
+	return msg;
+}
+
 static void format_decoration(struct strbuf *sb, const struct commit *commit)
 {
 	struct name_decoration *d;
@@ -718,27 +740,11 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *encoding,
 		   int need_8bit_cte)
 {
+	const char *line_separator = (fmt == CMIT_FMT_EMAIL) ? "\n " : " ";
 	struct strbuf title;
 
 	strbuf_init(&title, 80);
-
-	for (;;) {
-		const char *line = *msg_p;
-		int linelen = get_one_line(line);
-
-		*msg_p += linelen;
-		if (!linelen || is_empty_line(line, &linelen))
-			break;
-
-		strbuf_grow(&title, linelen + 2);
-		if (title.len) {
-			if (fmt == CMIT_FMT_EMAIL) {
-				strbuf_addch(&title, '\n');
-			}
-			strbuf_addch(&title, ' ');
-		}
-		strbuf_add(&title, line, linelen);
-	}
+	*msg_p = format_subject(&title, *msg_p, line_separator);
 
 	strbuf_grow(sb, title.len + 1024);
 	if (subject) {
-- 
1.6.1
