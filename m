Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B86520286
	for <e@80x24.org>; Fri,  8 Sep 2017 04:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbdIHEgh (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 00:36:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:60428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750853AbdIHEgg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 00:36:36 -0400
Received: (qmail 12083 invoked by uid 109); 8 Sep 2017 04:36:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 04:36:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5672 invoked by uid 111); 8 Sep 2017 04:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 00:37:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 00:36:34 -0400
Date:   Fri, 8 Sep 2017 00:36:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rene Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 27/34] shortlog: release strbuf after use in
 insert_one_record()
Message-ID: <20170908043633.smytugbn7ge4twlm@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
 <20170830180037.20950-8-l.s.r@web.de>
 <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
 <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
 <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
 <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 11:56:48PM -0400, Jeff King wrote:

> > True; I do not think string_list API does.  But for this particular
> > application, I suspect that we can by looking at the util field of
> > the item returned.  A newly created one has NULL, but we always make
> > it non-NULL before leaving this function.
> 
> Yeah, I agree that would work here.
> 
> I also wondered if we could get away with avoiding the malloc entirely
> here. Especially in the "shortlog -n" case, it is identical to the name
> field we already have in ident.name. So ideally we'd do a lookup to see
> if we have the entry before allocating anything (since we do one lookup
> per commit, but only insert once per unique author).
> 
> But that doesn't quite work, because ident.name doesn't put to a
> NUL-terminated string, and string_list only handles strings.

I happened to look at this more while digging on an unrelated shortlog
bug. I think the whole thing could actually be reorganized a bit.

We call insert_one_record() from shortlog_add_commit(). The latter
formats "%an <%ae>", only to have the former parse it back to its
constituent parts. That seems rather silly.

This is an artifact of shortlog's original mode, which was to parse "git
log" output. But for an internal traversal, we can just format the
correct item right off the bat. That part of insert_one_record() is also
where we handle the mailmap mapping. But again, the internal traversal
can just "%aE" to format that correctly in the first place.

IOW, something like the patch below, which pushes the re-parsing out to
the stdin code-path, and lets the internal traversal format directly
into the final buffer. It seems to be about 3% faster than the existing
code, and fixes the leak (by dropping that variable entirely).

-Peff

---
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
