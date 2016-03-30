From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] abbrev_sha1_in_line: don't leak memory
Date: Wed, 30 Mar 2016 10:06:41 -0700
Message-ID: <xmqqzitfuc7y.fsf@gitster.mtv.corp.google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-5-git-send-email-sbeller@google.com>
	<20160330011111.GB2237@sigill.intra.peff.net>
	<CAPig+cR=Zc2QAQTPAqTt4M-nJRw4StCoqT2hYtmHOvi6LseN_A@mail.gmail.com>
	<20160330013127.GA6680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:06:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJZy-0002gh-9s
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbcC3RGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:06:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753140AbcC3RGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:06:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E8184FADB;
	Wed, 30 Mar 2016 13:06:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H/+4rSYOudlqTkzx5nUjRYcEYZM=; b=vxoz24
	vqm22Sr9fmwXZ5HaUEBvdbydYG11DqzviDRztK+0gw/6+MdIqhFWEmXNqr2D0Zkz
	vaUsgXW1SGxxiFExo3B0P3MWcXRC/gOx04kBKqPWM25rjy1ChiuZcommICokxPPs
	J7vslkDZ02Lx0N2/c8VsRUYyOh9GxVxTELXk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iwf/+tXjV5FAZf63yeFjwu8PRWfQEydK
	SqBVhpyVFTNcjxR05duYY0msaREy6q2Yoty7fBuC3ISIBe6G3xCtqyqtdC+jQB0y
	iXTtOwHw8eX1NY/kqln60f03gC/kjqkORF8T6gSMZ1Ryo1DI9UzKrZXCjTGo6mrb
	4BrvxW5kJyQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6310B4FADA;
	Wed, 30 Mar 2016 13:06:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AA2854FAD9;
	Wed, 30 Mar 2016 13:06:42 -0400 (EDT)
In-Reply-To: <20160330013127.GA6680@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Mar 2016 21:31:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C69AA5E0-F699-11E5-82A7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290318>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 29, 2016 at 09:30:38PM -0400, Eric Sunshine wrote:
>
>> The implementation of strbuf_list_free() is this:
>> 
>>     struct strbuf **s = sbs;
>>     while (*s) {
>>         strbuf_release(*s);
>>         free(*s++);
>>     }
>>     free(sbs);
>> 
>> which means that wt-status.c is leaking not only 'split', but also
>> each element of split[], right?
>
> Yeah, I didn't notice that, but I think you're right.

Correct.

I suspect that we would be better off in the longer term if
we made conscious effort to deprecate and eradicate the use
of strbuf_split* API functions.  They are easy to write
crappy code with, inefficient, and error prone.  You would
rarely need to have N resulting pieces as strbufs to be
easily manipulatable [*1*].

The function can be written by not using the "split and then
rebuild" pattern, perhaps like so, and the result is even
easier to read and understand, I would say.  A sample rewrite
is attached at the end.


[Footnote]

*1* I wouldn't be this harsh if the function were to fill an
    array of pointers or offsets into the original string.

 wt-status.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ef74864..4886c35 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1037,35 +1037,30 @@ static int split_commit_in_progress(struct wt_status *s)
  */
 static void abbrev_sha1_in_line(struct strbuf *line)
 {
-	struct strbuf **split;
-	int i;
+	const char *cp, *ep, *abbrev;
+	unsigned char sha1[20];
 
-	if (starts_with(line->buf, "exec ") ||
-	    starts_with(line->buf, "x "))
+	/* the oddball "exec" does not have 40-hex as the second token */
+	if (starts_with(line->buf, "exec ") || starts_with(line->buf, "x "))
 		return;
 
-	split = strbuf_split_max(line, ' ', 3);
-	if (split[0] && split[1]) {
-		unsigned char sha1[20];
-		const char *abbrev;
+	/* find the second token on the line */
+	cp = strchr(line->buf, ' ');
+	if (!cp)
+		return;
+	cp++;
+	ep = strchr(cp, ' ');
+	if (!ep)
+		return;
 
-		/*
-		 * strbuf_split_max left a space. Trim it and re-add
-		 * it after abbreviation.
-		 */
-		strbuf_trim(split[1]);
-		if (!get_sha1(split[1]->buf, sha1)) {
-			abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
-			strbuf_reset(split[1]);
-			strbuf_addf(split[1], "%s ", abbrev);
-			strbuf_reset(line);
-			for (i = 0; split[i]; i++)
-				strbuf_addf(line, "%s", split[i]->buf);
-		}
-	}
-	for (i = 0; split[i]; i++)
-		strbuf_release(split[i]);
+	/* is it 40-hex? */
+	if (ep - cp != GIT_SHA1_HEXSZ || get_sha1_hex(cp, sha1))
+		return;
 
+	/* replace it with its abbreviation */
+	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
+	strbuf_splice(line, cp - line->buf, GIT_SHA1_HEXSZ,
+		      abbrev, strlen(abbrev));
 }
 
 static void read_rebase_todolist(const char *fname, struct string_list *lines)
