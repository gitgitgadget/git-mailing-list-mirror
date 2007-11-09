From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 00:16:30 +0100
Message-ID: <4734EA4E.8070405@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqd62-0007Ii-Tq
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbXKIXQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXKIXQw
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:16:52 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:33800
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752005AbXKIXQv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 18:16:51 -0500
Received: from [10.0.1.201] (p57B7F63C.dip.t-dialin.net [87.183.246.60])
	by neapel230.server4you.de (Postfix) with ESMTP id 88644873BA;
	Sat, 10 Nov 2007 00:16:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071109045040.GC31760@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64272>

Jeff King schrieb:
> - formatting expensive items multiple times will incur work 
> proportional to the number of times the item is used (in the old 
> code, it was calculated just once).  e.g., "%h%h%h%h"
> 
> - formatting some items goes to some work that can be re-used by
> other items (e.g., %ad and %ar both need to parse the author date)
> 
> And we could obviously overcome both by caching the results of
> expensive operations.  I'm not sure if these will be a problem in
> practice. For the first one, the new code is so much faster that I
> needed to do
> 
> git-log --pretty=format:%h%h%h%h%h%h%h%h
> 
> to get a performance regression from the old code, which seems rather
>  unlikely. For the second, it is easy to imagine multiple "person"
> items being used together, although their cost to produce is not all
> that high. It looks like about .05 seconds to parse a date (over all
> commits in git.git):
> 
> $ time ./git-log --pretty='format:' >/dev/null real    0m0.441s user
> 0m0.424s sys     0m0.004s
> 
> $ time ./git-log --pretty='format:%ad' >/dev/null real    0m0.477s 
> user    0m0.472s sys     0m0.000s
> 
> $ time ./git-log --pretty='format:%ad %aD' >/dev/null real
> 0m0.527s user    0m0.520s sys     0m0.004s
> 
> where the last two could probably end up costing about the same if we
> cached the author parsing (but the caching will have a cost, too, so
> it might not end up being a big win).
> 
> So it might make sense to cache some items as we figure them out.
> This should be done by the calling code and not by strbuf_expand
> (since it doesn't know which things are worth caching (and for fast
> things, allocating memory for a cache entry is likely to be slower),
> or how the expansions relate to each other).

I fully agree with the above.

> A partial patch on top of yours is below (it caches commit and tree 
> abbreviations; parent abbreviations and person-parsing are probably 
> worth doing). Some timings:

... but I object to the choice of items to cache.  Are there real-world
formats containing the same placeholder twice or even more often?

There is probably more to gain from the interdependencies of different
placeholders.  The patch below attempts to avoid parsing the commit
twice, by saving pointers to the different parts.

(next)
$ time git log --pretty=format:"* %cd %cn%n%n%s%n%b" >/dev/null

real    0m0.631s
user    0m0.584s
sys     0m0.040s

(next+patch)
$ time git log --pretty=format:"* %cd %cn%n%n%s%n%b" >/dev/null

real    0m0.570s
user    0m0.512s
sys     0m0.044s

The format is from http://svn.tue.mpg.de/tentakel/trunk/tentakel/Makefile
which I found while googling for real-world use cases.

While the code size is increased by the patch, most of the code gets
simplified.


 pretty.c |  128 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 42 deletions(-)

diff --git a/pretty.c b/pretty.c
index 9fbd73f..b2f10a3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -354,14 +354,69 @@ static void format_person_part(struct strbuf *sb, char part,
 	}
 }
 
+struct parsed_commit_header {
+	int parsed;
+	const char *subject_start;
+	const char *author_start;
+	const char *committer_start;
+	const char *encoding_start;
+	const char *body_start;
+	size_t subject_len;
+	size_t author_len;
+	size_t committer_len;
+	size_t encoding_len;
+};
+
+struct format_commit_context {
+	const struct commit *commit;
+	struct parsed_commit_header *parsed_commit_header;
+};
+
+static void parse_commit_header(struct parsed_commit_header *pch,
+                                const struct commit *commit)
+{
+	const char *msg = commit->buffer;
+	int i;
+	enum { HEADER, SUBJECT, BODY } state;
+
+	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
+		int eol;
+		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
+			; /* do nothing */
+
+		if (state == SUBJECT) {
+			pch->subject_start = msg + i;
+			pch->subject_len = eol - i;
+			i = eol;
+		}
+		if (i == eol) {
+			state++;
+			/* strip empty lines */
+			while (msg[eol + 1] == '\n')
+				eol++;
+		} else if (!prefixcmp(msg + i, "author ")) {
+			pch->author_start = msg + i + 7;
+			pch->author_len = eol - i - 7;
+		} else if (!prefixcmp(msg + i, "committer ")) {
+			pch->committer_start = msg + i + 10;
+			pch->committer_len = eol - i - 10;
+		} else if (!prefixcmp(msg + i, "encoding ")) {
+			pch->encoding_start = msg + i + 9;
+			pch->encoding_len = eol - i - 9;
+		}
+		i = eol;
+	}
+	pch->body_start = msg + i;
+	pch->parsed = 1;
+}
+
 static void format_commit_item(struct strbuf *sb, const char *placeholder,
                                void *context)
 {
-	const struct commit *commit = context;
+	struct format_commit_context *c = context;
+	const struct commit *commit = c->commit;
+	struct parsed_commit_header *pch = c->parsed_commit_header;
 	struct commit_list *p;
-	int i;
-	enum { HEADER, SUBJECT, BODY } state;
-	const char *msg = commit->buffer;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -429,45 +484,28 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 	}
 
 	/* For the rest we have to parse the commit header. */
-	for (i = 0, state = HEADER; msg[i] && state < BODY; i++) {
-		int eol;
-		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
-			; /* do nothing */
+	if (!pch->parsed)
+		parse_commit_header(pch, commit);
 
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
+		strbuf_add(sb, pch->subject_start, pch->subject_len);
+		return;
+	case 'a':
+		format_person_part(sb, placeholder[1],
+		                   pch->author_start, pch->author_len);
+		return;
+	case 'c':
+		format_person_part(sb, placeholder[1],
+		                   pch->committer_start, pch->committer_len);
+		return;
+	case 'e':
+		strbuf_add(sb, pch->encoding_start, pch->encoding_len);
+		return;
+	case 'b':
+		strbuf_addstr(sb, pch->body_start);
+		return;
 	}
-	if (msg[i] && placeholder[0] == 'b')	/* body */
-		strbuf_addstr(sb, msg + i);
 }
 
 void format_commit_message(const struct commit *commit,
@@ -505,7 +543,13 @@ void format_commit_message(const struct commit *commit,
 		"m",		/* left/right/bottom */
 		NULL
 	};
-	strbuf_expand(sb, format, placeholders, format_commit_item, (void *)commit);
+	struct parsed_commit_header pch;
+	struct format_commit_context context;
+
+	memset(&pch, 0, sizeof(pch));
+	context.commit = commit;
+	context.parsed_commit_header = &pch;
+	strbuf_expand(sb, format, placeholders, format_commit_item, &context);
 }
 
 static void pp_header(enum cmit_fmt fmt,
