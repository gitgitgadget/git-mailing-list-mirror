From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/3] shortlog: handle multi-line subjects like log --pretty=oneline
 et. al. do
Date: Tue, 06 Jan 2009 21:41:06 +0100
Message-ID: <4963C1E2.8070906@lsrfire.ath.cx>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <200812280024.59096.markus.heidelberg@web.de> <4956C47B.4020602@lsrfire.ath.cx> <49594C16.2010406@lsrfire.ath.cx> <7vocynz8y6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIlA-0002zP-Ns
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZAFUlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbZAFUlO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:41:14 -0500
Received: from india601.server4you.de ([85.25.151.105]:41411 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbZAFUlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:41:13 -0500
Received: from [10.0.1.101] (p57B7BA44.dip.t-dialin.net [87.183.186.68])
	by india601.server4you.de (Postfix) with ESMTPSA id 8A1A52F8009;
	Tue,  6 Jan 2009 21:41:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vocynz8y6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104725>

The commit message parser of git shortlog used to treat only the first
non-empty line of the commit message as the subject.  Other log commands
(e.g. --pretty=oneline) show the whole first paragraph instead (unwrapped
into a single line).

For consistency, this patch borrows format_subject() from pretty.c to
make shortlog do the same.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-shortlog.c |    9 ++++++---
 pretty.c           |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index d03f14f..e492906 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -29,6 +29,9 @@ static int compare_by_number(const void *a1, const void *a2)
 		return -1;
 }
 
+const char *format_subject(struct strbuf *sb, const char *msg,
+			   const char *line_separator);
+
 static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
@@ -41,6 +44,7 @@ static void insert_one_record(struct shortlog *log,
 	size_t len;
 	const char *eol;
 	const char *boemail, *eoemail;
+	struct strbuf subject = STRBUF_INIT;
 
 	boemail = strchr(author, '<');
 	if (!boemail)
@@ -89,9 +93,8 @@ static void insert_one_record(struct shortlog *log,
 	while (*oneline && isspace(*oneline) && *oneline != '\n')
 		oneline++;
 	len = eol - oneline;
-	while (len && isspace(oneline[len-1]))
-		len--;
-	buffer = xmemdupz(oneline, len);
+	format_subject(&subject, oneline, " ");
+	buffer = strbuf_detach(&subject, NULL);
 
 	if (dot3) {
 		int dot3len = strlen(dot3);
diff --git a/pretty.c b/pretty.c
index 343dca5..421d9c5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -486,8 +486,8 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
-static const char *format_subject(struct strbuf *sb, const char *msg,
-				  const char *line_separator)
+const char *format_subject(struct strbuf *sb, const char *msg,
+			   const char *line_separator)
 {
 	int first = 1;
 
-- 
1.6.1
