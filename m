From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] shortlog: refactor insert_one_record()
Date: Wed, 15 Jul 2009 13:16:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907151316130.4410@intel-tinevez-2-302>
References: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain> <7v8wiqfj60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 13:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR2Tk-0007jY-90
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 13:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZGOLQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 07:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZGOLQ3
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 07:16:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:41289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754145AbZGOLQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 07:16:28 -0400
Received: (qmail invoked by alias); 15 Jul 2009 11:16:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 15 Jul 2009 13:16:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oYacXcWOoJcwLG9xMtUIMzxc21ZspfQgQ16cG2y
	0seGO10wG1Gf5k
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v8wiqfj60.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123297>


This just splits insert_one_record() into one part which assumes that
the key is an email ident of the form "A U Thor <author@example.com>"
(that needs to respect .mailmap) and a second part which does not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-shortlog.c |   81 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 6a3812e..a684422 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -32,19 +32,57 @@ static int compare_by_number(const void *a1, const void *a2)
 const char *format_subject(struct strbuf *sb, const char *msg,
 			   const char *line_separator);
 
-static void insert_one_record(struct shortlog *log,
-			      const char *author,
-			      const char *oneline)
+static void insert_one_record1(struct shortlog *log,
+		const char *name, const char *oneline)
 {
 	const char *dot3 = log->common_repo_prefix;
 	char *buffer, *p;
 	struct string_list_item *item;
+	const char *eol;
+	struct strbuf subject = STRBUF_INIT;
+
+	item = string_list_insert(name, &log->list);
+	if (item->util == NULL)
+		item->util = xcalloc(1, sizeof(struct string_list));
+
+	/* Skip any leading whitespace, including any blank lines. */
+	while (*oneline && isspace(*oneline))
+		oneline++;
+	eol = strchr(oneline, '\n');
+	if (!eol)
+		eol = oneline + strlen(oneline);
+	if (!prefixcmp(oneline, "[PATCH")) {
+		char *eob = strchr(oneline, ']');
+		if (eob && (!eol || eob < eol))
+			oneline = eob + 1;
+	}
+	while (*oneline && isspace(*oneline) && *oneline != '\n')
+		oneline++;
+	format_subject(&subject, oneline, " ");
+	buffer = strbuf_detach(&subject, NULL);
+
+	if (dot3) {
+		int dot3len = strlen(dot3);
+		if (dot3len > 5) {
+			while ((p = strstr(buffer, dot3)) != NULL) {
+				int taillen = strlen(p) - dot3len;
+				memcpy(p, "/.../", 5);
+				memmove(p + 5, p + dot3len, taillen + 1);
+			}
+		}
+	}
+
+	string_list_append(buffer, item->util);
+}
+
+static void insert_one_record(struct shortlog *log,
+			      const char *author,
+			      const char *oneline)
+{
 	char namebuf[1024];
 	char emailbuf[1024];
 	size_t len;
-	const char *eol;
 	const char *boemail, *eoemail;
-	struct strbuf subject = STRBUF_INIT;
 
 	boemail = strchr(author, '<');
 	if (!boemail)
@@ -84,38 +122,7 @@ static void insert_one_record(struct shortlog *log,
 		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
 	}
 
-	item = string_list_insert(namebuf, &log->list);
-	if (item->util == NULL)
-		item->util = xcalloc(1, sizeof(struct string_list));
-
-	/* Skip any leading whitespace, including any blank lines. */
-	while (*oneline && isspace(*oneline))
-		oneline++;
-	eol = strchr(oneline, '\n');
-	if (!eol)
-		eol = oneline + strlen(oneline);
-	if (!prefixcmp(oneline, "[PATCH")) {
-		char *eob = strchr(oneline, ']');
-		if (eob && (!eol || eob < eol))
-			oneline = eob + 1;
-	}
-	while (*oneline && isspace(*oneline) && *oneline != '\n')
-		oneline++;
-	format_subject(&subject, oneline, " ");
-	buffer = strbuf_detach(&subject, NULL);
-
-	if (dot3) {
-		int dot3len = strlen(dot3);
-		if (dot3len > 5) {
-			while ((p = strstr(buffer, dot3)) != NULL) {
-				int taillen = strlen(p) - dot3len;
-				memcpy(p, "/.../", 5);
-				memmove(p + 5, p + dot3len, taillen + 1);
-			}
-		}
-	}
-
-	string_list_append(buffer, item->util);
+	insert_one_record1(log, namebuf, oneline);
 }
 
 static void read_from_stdin(struct shortlog *log)
-- 
1.6.3.284.g6fecc
