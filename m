Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B533202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 09:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbdIHJVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 05:21:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:60728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753498AbdIHJV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 05:21:29 -0400
Received: (qmail 29838 invoked by uid 109); 8 Sep 2017 09:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 09:21:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7170 invoked by uid 111); 8 Sep 2017 09:22:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 05:22:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 05:21:27 -0400
Date:   Fri, 8 Sep 2017 05:21:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rene Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: [PATCH] shortlog: skip format/parse roundtrip for internal traversal
Message-ID: <20170908092126.55o3342macegtlga@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
 <20170830180037.20950-8-l.s.r@web.de>
 <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
 <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
 <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
 <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
 <20170908043633.smytugbn7ge4twlm@sigill.intra.peff.net>
 <xmqqk219zobb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk219zobb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 03:39:36PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > IOW, something like the patch below, which pushes the re-parsing out to
> > the stdin code-path, and lets the internal traversal format directly
> > into the final buffer. It seems to be about 3% faster than the existing
> > code, and fixes the leak (by dropping that variable entirely).
> 
> Wow, that is soooo logical a conclusion that I somewhat feel ashamed
> that I didn't think of it myself.
> 
> Nicely done.

Thanks. Here it is with a commit message.

Note that the non-stdin path no longer looks at the "mailmap" entry of
"struct shortlog" (instead we use the one cached inside pretty.c). But
we still waste time loading it. I'm not sure if it's worth addressing
that. It's only once per program invocation, and it's a little tricky to
fix (we do shortlog_init() before we know whether or not we're using
stdin). We could just load it lazily, though, which would cover the
stdin case.

-- >8 --
Subject: shortlog: skip format/parse roundtrip for internal traversal

The original git-shortlog command parsed the output of
git-log, and the logic went something like this:

  1. Read stdin looking for "author" lines.

  2. Parse the identity into its name/email bits.

  3. Apply mailmap to the name/email.

  4. Reformat the identity into a single buffer that is our
     "key" for grouping entries (either a name by default,
     or "name <email>" if --email was given).

The first part happens in read_from_stdin(), and the other
three steps are part of insert_one_record().

When we do an internal traversal, we just swap out the stdin
read in step 1 for reading the commit objects ourselves.
Prior to 2db6b83d18 (shortlog: replace hand-parsing of
author with pretty-printer, 2016-01-18), that made sense; we
still had to parse the ident in the commit message.

But after that commit, we use pretty.c's "%an <%ae>" to get
the author ident (for simplicity). Which means that the
pretty printer is doing a parse/format under the hood, and
then we parse the result, apply the mailmap, and format the
result again.

Instead, we can just ask pretty.c to do all of those steps
for us (including the mailmap via "%aN <%aE>", and not
formatting the address when --email is missing).

And then we can push steps 2-4 into read_from_stdin(). This
speeds up "git shortlog -ns" on linux.git by about 3%, and
eliminates a leak in insert_one_record() of the namemailbuf
strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 56 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 43c4799ea9..e29875b843 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -52,26 +52,8 @@ static void insert_one_record(struct shortlog *log,
 			      const char *oneline)
 {
 	struct string_list_item *item;
-	const char *mailbuf, *namebuf;
-	size_t namelen, maillen;
-	struct strbuf namemailbuf = STRBUF_INIT;
-	struct ident_split ident;
 
-	if (split_ident_line(&ident, author, strlen(author)))
-		return;
-
-	namebuf = ident.name_begin;
-	mailbuf = ident.mail_begin;
-	namelen = ident.name_end - ident.name_begin;
-	maillen = ident.mail_end - ident.mail_begin;
-
-	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
-	strbuf_add(&namemailbuf, namebuf, namelen);
-
-	if (log->email)
-		strbuf_addf(&namemailbuf, " <%.*s>", (int)maillen, mailbuf);
-
-	item = string_list_insert(&log->list, namemailbuf.buf);
+	item = string_list_insert(&log->list, author);
 
 	if (log->summary)
 		item->util = (void *)(UTIL_TO_INT(item) + 1);
@@ -114,9 +96,33 @@ static void insert_one_record(struct shortlog *log,
 	}
 }
 
+static int parse_stdin_author(struct shortlog *log,
+			       struct strbuf *out, const char *in)
+{
+	const char *mailbuf, *namebuf;
+	size_t namelen, maillen;
+	struct ident_split ident;
+
+	if (split_ident_line(&ident, in, strlen(in)))
+		return -1;
+
+	namebuf = ident.name_begin;
+	mailbuf = ident.mail_begin;
+	namelen = ident.name_end - ident.name_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+
+	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	strbuf_add(out, namebuf, namelen);
+	if (log->email)
+		strbuf_addf(out, " <%.*s>", (int)maillen, mailbuf);
+
+	return 0;
+}
+
 static void read_from_stdin(struct shortlog *log)
 {
 	struct strbuf author = STRBUF_INIT;
+	struct strbuf mapped_author = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	static const char *author_match[2] = { "Author: ", "author " };
 	static const char *committer_match[2] = { "Commit: ", "committer " };
@@ -134,9 +140,15 @@ static void read_from_stdin(struct shortlog *log)
 		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
 		       !oneline.len)
 			; /* discard blanks */
-		insert_one_record(log, v, oneline.buf);
+
+		strbuf_reset(&mapped_author);
+		if (parse_stdin_author(log, &mapped_author, v) < 0)
+			continue;
+
+		insert_one_record(log, mapped_author.buf, oneline.buf);
 	}
 	strbuf_release(&author);
+	strbuf_release(&mapped_author);
 	strbuf_release(&oneline);
 }
 
@@ -153,7 +165,9 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
-	fmt = log->committer ? "%cn <%ce>" : "%an <%ae>";
+	fmt = log->committer ?
+		(log->email ? "%cN <%cE>" : "%cN") :
+		(log->email ? "%aN <%aE>" : "%aN");
 
 	format_commit_message(commit, fmt, &author, &ctx);
 	if (!log->summary) {
-- 
2.14.1.769.g4f4ea7dfd3

