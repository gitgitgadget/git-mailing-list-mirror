From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] --pretty=format: parse commit message only once
Date: Sat, 10 Nov 2007 12:14:20 +0100
Message-ID: <4735928C.3040009@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net> <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:15:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoIk-0006w2-7H
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXKJLOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXKJLOm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:14:42 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54495
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751306AbXKJLOl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 06:14:41 -0500
Received: from [10.0.1.201] (p57B7EF01.dip.t-dialin.net [87.183.239.1])
	by neapel230.server4you.de (Postfix) with ESMTP id CCF73873BA;
	Sat, 10 Nov 2007 12:14:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071110004635.GA14992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64329>

As Jeff King pointed out, some placeholder expansions are related to
each other: the steps to calculate one go most of the way towards
calculating the other, too.

This patch makes format_commit_message() parse the commit message
only once, remembering the position of each item.  This speeds up
handling of format strings containing multiple placeholders from the
set %s, %a*, %c*, %e, %b.

Here are the timings for the git version in next.  The first one is
to estimate the overhead of the caching, the second one is taken
from http://svn.tue.mpg.de/tentakel/trunk/tentakel/Makefile as an
example of a format string found in the wild.  The times are the
fastest of three consecutive runs in each case:

$ time git log --pretty=format:%e >/dev/null

real    0m0.381s
user    0m0.340s
sys     0m0.024s

$ time git log --pretty=format:"* %cd %cn%n%n%s%n%b" >/dev/null

real    0m0.623s
user    0m0.556s
sys     0m0.052s

And here the times with this patch:

$ time git log --pretty=format:%e >/dev/null

real    0m0.385s
user    0m0.332s
sys     0m0.040s

$ time git log --pretty=format:"* %cd %cn%n%n%s%n%b" >/dev/null

real    0m0.563s
user    0m0.504s
sys     0m0.048s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c |  124 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 82 insertions(+), 42 deletions(-)

diff --git a/pretty.c b/pretty.c
index 9fbd73f..0c2f83b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -354,14 +354,67 @@ static void format_person_part(struct strbuf *sb, char part,
 	}
 }
 
-static void format_commit_item(struct strbuf *sb, const char *placeholder,
-                               void *context)
+struct chunk {
+	size_t off;
+	size_t len;
+};
+
+struct format_commit_context {
+	const struct commit *commit;
+
+	/* These offsets are relative to the start of the commit message. */
+	int commit_header_parsed;
+	struct chunk subject;
+	struct chunk author;
+	struct chunk committer;
+	struct chunk encoding;
+	size_t body_off;
+};
+
+static void parse_commit_header(struct format_commit_context *context)
 {
-	const struct commit *commit = context;
-	struct commit_list *p;
+	const char *msg = context->commit->buffer;
 	int i;
 	enum { HEADER, SUBJECT, BODY } state;
+
+	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
+		int eol;
+		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
+			; /* do nothing */
+
+		if (state == SUBJECT) {
+			context->subject.off = i;
+			context->subject.len = eol - i;
+			i = eol;
+		}
+		if (i == eol) {
+			state++;
+			/* strip empty lines */
+			while (msg[eol + 1] == '\n')
+				eol++;
+		} else if (!prefixcmp(msg + i, "author ")) {
+			context->author.off = i + 7;
+			context->author.len = eol - i - 7;
+		} else if (!prefixcmp(msg + i, "committer ")) {
+			context->committer.off = i + 10;
+			context->committer.len = eol - i - 10;
+		} else if (!prefixcmp(msg + i, "encoding ")) {
+			context->encoding.off = i + 9;
+			context->encoding.len = eol - i - 9;
+		}
+		i = eol;
+	}
+	context->body_off = i;
+	context->commit_header_parsed = 1;
+}
+
+static void format_commit_item(struct strbuf *sb, const char *placeholder,
+                               void *context)
+{
+	struct format_commit_context *c = context;
+	const struct commit *commit = c->commit;
 	const char *msg = commit->buffer;
+	struct commit_list *p;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -429,45 +482,28 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 	}
 
 	/* For the rest we have to parse the commit header. */
-	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
-		int eol;
-		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
-			; /* do nothing */
+	if (!c->commit_header_parsed)
+		parse_commit_header(c);
 
-		if (state == SUBJECT) {
-			if (placeholder[0] == 's') {
-				strbuf_add(sb, msg + i, eol - i);
-				return;
-			}
-			i = eol;
-		}
-		if (i == eol) {
-			state++;
-			/* strip empty lines */
-			while (msg[eol + 1] == '\n')
-				eol++;
-		} else if (!prefixcmp(msg + i, "author ")) {
-			if (placeholder[0] == 'a') {
-				format_person_part(sb, placeholder[1],
-				                   msg + i + 7, eol - i - 7);
-				return;
-			}
-		} else if (!prefixcmp(msg + i, "committer ")) {
-			if (placeholder[0] == 'c') {
-				format_person_part(sb, placeholder[1],
-				                   msg + i + 10, eol - i - 10);
-				return;
-			}
-		} else if (!prefixcmp(msg + i, "encoding ")) {
-			if (placeholder[0] == 'e') {
-				strbuf_add(sb, msg + i + 9, eol - i - 9);
-				return;
-			}
-		}
-		i = eol;
+	switch (placeholder[0]) {
+	case 's':
+		strbuf_add(sb, msg + c->subject.off, c->subject.len);
+		return;
+	case 'a':
+		format_person_part(sb, placeholder[1],
+		                   msg + c->author.off, c->author.len);
+		return;
+	case 'c':
+		format_person_part(sb, placeholder[1],
+		                   msg + c->committer.off, c->committer.len);
+		return;
+	case 'e':
+		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
+		return;
+	case 'b':
+		strbuf_addstr(sb, msg + c->body_off);
+		return;
 	}
-	if (msg[i] && placeholder[0] == 'b')	/* body */
-		strbuf_addstr(sb, msg + i);
 }
 
 void format_commit_message(const struct commit *commit,
@@ -505,7 +541,11 @@ void format_commit_message(const struct commit *commit,
 		"m",		/* left/right/bottom */
 		NULL
 	};
-	strbuf_expand(sb, format, placeholders, format_commit_item, (void *)commit);
+	struct format_commit_context context;
+
+	memset(&context, 0, sizeof(context));
+	context.commit = commit;
+	strbuf_expand(sb, format, placeholders, format_commit_item, &context);
 }
 
 static void pp_header(enum cmit_fmt fmt,
-- 
1.5.3.5.1651.g30bf
