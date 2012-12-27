From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: grep author/committer using mailmap
Date: Thu, 27 Dec 2012 10:48:56 -0800
Message-ID: <7vwqw3l49z.fsf@alter.siamese.dyndns.org>
References: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
 <1356622318-19523-1-git-send-email-apelisse@gmail.com>
 <7v1uebmizx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 19:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToIW5-0002s8-RX
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 19:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab2L0StA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 13:49:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369Ab2L0Ss7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 13:48:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 931ECA0CE;
	Thu, 27 Dec 2012 13:48:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aZQMgE2+bdzQ6Atgkjdxzu3ieR8=; b=ND8GZK
	PKwx1XE0QbKXl3j0D/gW6CV/xHTDwv6jVC4PcaprSx5vahdyJGLgIR+f5UDdOMgX
	xf4xgiVAoEZKbwWPRRG9DsbMVVQZQNwT7HGWikeUVaVH1I39BHpIAI+9vVZmJWbG
	9SzcLEjYA/heu+C5xzFJS2MYF8huctEmOoHVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lWUYBya4HohAXRU2YkPp7aaz48nPfzMr
	DcPK60zcQRzHsUuMtHTL7epdC66LTkOcSkhspmTq9xxhQRs4QvjjTRrWBmdG0uw2
	F9msnDUdGp88499lx6EMukX/qfc/kdkxB+UJ8c6H5BjV2L7P71LvvxvGKBwfnTl+
	EWc+OKowC/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804B1A0CD;
	Thu, 27 Dec 2012 13:48:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6C8FA0C8; Thu, 27 Dec 2012
 13:48:57 -0500 (EST)
In-Reply-To: <7v1uebmizx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 27 Dec 2012 10:45:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12375464-5056-11E2-9D9C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212209>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  I'll queue this on top.
>
> -- >8 --
> Subject: [PATCH] log --use-mailmap: optimize for cases without --author/--committer search

And this I will *not* queue further on top.

-- >8 --
Subject: [PATCH] [DO NOT USE] log --use-mailmap --author/--committer: further
 optimize identity rewriting

We used to always allocate a temporary buffer to search for
author/committer names even when the author/committer does not
appear in the mailmap.  Update the logic to do the allocation
on demand to reduce needless malloc()/free() calls.

It turns out that this does not affect performance at all; all the
time is spent in map_user() which is a look-up in string_list, so
let's not use this patch in the production, but it illustrates an
interesting point.

In map_identities() function, we already know who the author
recorded in the commit is, either in "author" strbuf, or in buffer
between [a_at..a_len], so we could grep_buffer() the author
regexp(s) specified from the command line right there, and combine
that result with the main grep_buffer() done for the --grep= option
at the end of the commit_match() function.

That may essentially amount to going in the totally opposite
direction from what 2d10c55 (git log: Unify header_filter and
message_filter into one., 2006-09-20) attempted to do.  We used to
have two grep expressions (one for header, the other one for body)
commit_match() runs grep_buffer() on and combined the results.
2d10c55 merged them into one grep expression by introducing a term
that matches only header elements.  But we would instead split the
"header" expression into "author" and "committer" expressions
(making it three from one) if we go that route.

In any case, I *think* the bottleneck is in map_user() so until that
is solved, such an update (or this patch) is not very useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 95 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/revision.c b/revision.c
index 56b72f7..4b66598 100644
--- a/revision.c
+++ b/revision.c
@@ -2220,49 +2220,73 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+static void map_person(const char *buf, size_t len, const char *head, int headlen,
+		       struct strbuf *result, struct string_list *mailmap,
+		       int *matchofs, int *matchlen)
 {
-	char *person, *endp;
-	size_t len;
+	struct ident_split ident;
+	const char *endp, *person;
 	struct strbuf name = STRBUF_INIT;
 	struct strbuf mail = STRBUF_INIT;
-	struct ident_split ident;
 
-	person = strstr(buf->buf, what);
+	person = memmem(buf, len, head, headlen);
 	if (!person)
-		goto left_intact;
-
-	person += strlen(what);
+		return;
+	person += headlen;
 	endp = strchr(person, '\n');
 	if (!endp)
-		goto left_intact;
-
-	len = endp - person;
-
-	if (split_ident_line(&ident, person, len))
-		goto left_intact;
-
+		return;
+	*matchofs = person - buf;
+	*matchlen = endp - person;
+	if (split_ident_line(&ident, person, *matchlen))
+		return;
 	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
 	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
-
-	if (map_user(mailmap, &mail, &name)) {
-		strbuf_addf(&name, " <%s>", mail.buf);
-
-		strbuf_splice(buf, ident.name_begin - buf->buf,
-			      ident.mail_end - ident.name_begin + 1,
-			      name.buf, name.len);
-
-		strbuf_release(&name);
-		strbuf_release(&mail);
-
-		return 1;
-	}
-
-left_intact:
+	if (map_user(mailmap, &mail, &name))
+		strbuf_addf(result, "%s <%s>", name.buf, mail.buf);
 	strbuf_release(&name);
 	strbuf_release(&mail);
+}
 
-	return 0;
+static void map_identities(struct strbuf *buf, const char *buffer, struct string_list *mailmap)
+{
+	const char *eob;
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf committer = STRBUF_INIT;
+	int a_at = -1, a_len, c_at = -1, c_len;
+
+	eob = strstr(buffer, "\n\n");
+	if (!eob)
+		eob = buffer + strlen(buffer);
+	map_person(buffer, eob - buffer, "\nauthor ", 8, &author, mailmap,
+		   &a_at, &a_len);
+	map_person(buffer, eob - buffer, "\ncommitter ", 11, &committer, mailmap,
+		   &c_at, &c_len);
+	if (!author.len && !committer.len)
+		goto done;
+
+	/* Now, we know we need rewriting */
+	if (!buf->len)
+		strbuf_addstr(buf, buffer);
+
+	if (c_at < 0 || !committer.len) {
+		strbuf_splice(buf, a_at, a_len, author.buf, author.len);
+	} else if (a_at < 0 || !author.len) {
+		strbuf_splice(buf, c_at, c_len, committer.buf, committer.len);
+	} else if (a_at < c_at) {
+		strbuf_splice(buf, c_at, c_len, committer.buf, committer.len);
+		strbuf_splice(buf, a_at, a_len, author.buf, author.len);
+	} else {
+		/*
+		 * The commit records committer before the author, which is malformed,
+		 * which we may want to warn about.
+		 */
+		strbuf_splice(buf, a_at, a_len, author.buf, author.len);
+		strbuf_splice(buf, c_at, c_len, committer.buf, committer.len);
+	}
+ done:
+	strbuf_release(&author);
+	strbuf_release(&committer);
 }
 
 static int commit_match(struct commit *commit, struct rev_info *opt)
@@ -2283,13 +2307,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (buf.len)
 		strbuf_addstr(&buf, commit->buffer);
 
-	if (opt->grep_filter.header_list && opt->mailmap) {
-		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
-
-		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
-		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
-	}
+	if (opt->grep_filter.header_list && opt->mailmap)
+		map_identities(&buf, commit->buffer, opt->mailmap);
 
 	/* Append "fake" message parts as needed */
 	if (opt->show_notes) {
-- 
1.8.1.rc3.221.g8d09d94
