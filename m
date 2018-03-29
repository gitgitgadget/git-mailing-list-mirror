Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D5D1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC2Vcf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 17:32:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:48014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750820AbeC2Vcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 17:32:32 -0400
Received: (qmail 28549 invoked by uid 109); 29 Mar 2018 21:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 21:32:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22600 invoked by uid 111); 29 Mar 2018 21:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 17:33:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 17:32:30 -0400
Date:   Thu, 29 Mar 2018 17:32:30 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 7/9] git config --unset: remove empty sections (in normal
 situations)
Message-ID: <20180329213229.GG2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <c246c8bc2fb1cd6fe6307463d299cf56fbe4dc5b.1522336130.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c246c8bc2fb1cd6fe6307463d299cf56fbe4dc5b.1522336130.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:19:00PM +0200, Johannes Schindelin wrote:

> Let's generalize this observation to this conservative strategy: if we
> are removing the last entry from a section, and there are no comments
> inside that section nor surrounding it, then remove the entire section.
> Otherwise behave as before: leave the now-empty section (including those
> comments, even the one about the now-deleted entry).

Yep, as I said earlier, this makes a ton of sense to me.

> +/*
> + * This function determines whether the offset is in a line that starts with a
> + * comment character.
> + *
> + * Note: it does *not* report when a regular line (section header, config
> + * setting) *ends* in a comment.
> + */
> +static int is_in_comment_line(const char *contents, size_t offset)
> +{
> +	int comment = 0;
> +
> +	while (offset > 0)
> +		switch (contents[--offset]) {
> +		case ';':
> +		case '#':
> +			comment = 1;
> +			break;
> +		case '\n':
> +			break;
> +		case ' ':
> +		case '\t':
> +			continue;
> +		default:
> +			comment = 0;
> +		}
> +
> +	return comment;
> +}

This doesn't pay any attention to quoting, so I wondered if it would get
fooled by a line like:

  key = "this content has a # comment in it"

or even:

  [section "this section has a # comment in it"]

but those don't count because the line doesn't _start_ with the comment
character. Could we design one that does? This isn't valid:

  [section]
  key = multiline \
    # with comment

But I think this is:

  [section]
  key = "multiline \
    # with comment"

So let's see if we can fool it:

-- >8 --

cat >file <<-\EOF
[one]
key = "multiline \
  # with comment"
[two]
key = true
EOF

# should produce "multiline   # with comment"
./git config --file=file one.key

# this should ideally remove the section
./git config --file=file --unset two.key
cat file

-- 8< --

That seems to work as expected. I'm not 100% sure why, though, since I
thought we'd hit the "seen_section && !is_in_comment_line" bit of the
look_before loop. Running it through gdb, I'm not convinced that
is_in_comment_line is working correctly, though. Shouldn't it stop when
it sees the newline, and return "comment"? There's a "break" there, but
it doesn't break out of the loop due to the switch statement.

So we'll _always_ walk back to the beginning of file. So I suspect your
test passes because it does:

  # this is the start of the file
  [section]
  key = true

but:

  [anotherSection]
  key = true
  # a comment not at the start
  [section]
  key = true

does the wrong thing, and removes [section]. If we fix that bug like
this:

diff --git a/config.c b/config.c
index b04c40f76b..3b2c7e9387 100644
--- a/config.c
+++ b/config.c
@@ -2461,7 +2461,7 @@ static int is_in_comment_line(const char *contents, size_t offset)
 			comment = 1;
 			break;
 		case '\n':
-			break;
+			return comment;
 		case ' ':
 		case '\t':
 			continue;

then it keeps "[section]" correctly. But now if we go back to our funny
multiline example, it does the wrong thing (it keeps [two], even though
that's not _really_ a comment).

To be honest, I could live with that as an open bug. It's a pretty
ridiculous situation, and the worst case is that we err on the side of
caution and don't remove the section. And I think it would be hard to
fix. We could look for the continuation backslash when we find the
newline, but that gets fooled by:

  # a comment \
  # with a pointless backslash

You can't just notice the quote and say "oh, I'm in a quoted section"
because that gets fooled by:

  # a pointless "quote

To know whether that quote is valid or not, you have to find the other
quote. But doing that backwards is hard (if not impossible).

> +static void maybe_remove_section(const char *contents, size_t size,
> +				 const char *section_name,
> +				 size_t section_name_len,
> +				 size_t *begin, int *i_ptr, int *new_line)
> +{
> +	size_t begin2, end2;
> +	int seen_section = 0, dummy, i = *i_ptr;
> +
> +	/*
> +	 * First, make sure that this is the last key in the section, and that
> +	 * there are no comments that are possibly about the current section.
> +	 */
> +next_entry:
> +	for (end2 = store.offset[i]; end2 < size; end2++) {
> +		switch (contents[end2]) {
> +		case ' ':
> +		case '\t':
> +		case '\n':
> +			continue;
> +		case '\r':
> +			if (++end2 < size && contents[end2] == '\n')
> +				continue;
> +			break;
> +		case '[':
> +			/* If the section name is repeated, continue */
> +			if (end2 + 1 + section_name_len < size &&
> +			    contents[end2 + section_name_len] == ']' &&
> +			    !memcmp(contents + end2 + 1, section_name,
> +				    section_name_len)) {
> +				end2 += section_name_len;
> +				continue;
> +			}
> +			goto look_before;
> +		case ';':
> +		case '#':
> +			/* There is a comment, cannot remove this section */
> +			return;
> +		default:
> +			/* There are other keys in that section */
> +			break;
> +		}

OK, this all makes sense. We're scanning forward to find the next '[',
without finding any keys or comments. We don't have to worry about
quoting because we'd quit as soon as we see a key anyway. I like the
special-case for finding our same section name, since that would help
clean up cruft from existing versions of Git.

It looks like there may be an off-by-one, though. Should it be checking:

  contents[end2 + 1 + section_name_len] == ']'

to skip over the opening '['? In a simple example:

  [foo]
  bar = true
  [foo]

we don't seem to remove the second section header. It works with the
patch below:

diff --git a/config.c b/config.c
index b04c40f76b..48dcb52840 100644
--- a/config.c
+++ b/config.c
@@ -2508,10 +2508,10 @@ static void maybe_remove_section(const char *contents, size_t size,
 		case '[':
 			/* If the section name is repeated, continue */
 			if (end2 + 1 + section_name_len < size &&
-			    contents[end2 + section_name_len] == ']' &&
+			    contents[end2 + 1 + section_name_len] == ']' &&
 			    !memcmp(contents + end2 + 1, section_name,
 				    section_name_len)) {
-				end2 += section_name_len;
+				end2 += section_name_len + 1;
 				continue;
 			}
 			goto look_before;

Unfortunately I think this whole thing breaks down with subsections. If
we try this:

  [foo "subsection"]
  bar = true
  [foo "subsection"]

then the section_name variable contains "foo.subsection", which we can't
textually match. And we end up failing to remove either section (the
latter one because of this loop, and the former because of the same
problem in the look_before loop).

> +		/*
> +		 * Uh oh... we found something else in this section. But do
> +		 * we want to remove this, too?
> +		 */
> +		if (++i >= store.seen)
> +			return;
> +
> +		begin2 = find_beginning_of_line(contents, size, store.offset[i],
> +						&dummy);
> +		if (begin2 > end2)
> +			return;
> +
> +		/* Looks like we want to remove the next one, too... */
> +		goto next_entry;
> +	}

OK, makes sense.

> +look_before:
> +	/*
> +	 * Now, ensure that this is the first key, and that there are no
> +	 * comments before the entry nor before the section header.
> +	 */
> +	for (begin2 = *begin; begin2 > 0; )
> +		switch (contents[begin2 - 1]) {
> +		case ' ':
> +		case '\t':
> +			begin2--;
> +			continue;
> +		case '\n':
> +			if (--begin2 > 0 && contents[begin2 - 1] == '\r')
> +				begin2--;
> +			continue;
> +		case ']':
> +			if (begin2 > section_name_len + 1 &&
> +			    contents[begin2 - section_name_len - 2] == '[' &&
> +			    !memcmp(contents + begin2 - section_name_len - 1,
> +				    section_name, section_name_len)) {
> +				begin2 -= section_name_len + 2;
> +				seen_section = 1;
> +				continue;
> +			}

OK, this is the backwards mirror image of the earlier part. Which makes
sense. And this handles the reverse case for the doubled section name:

  [foo]
  [foo]
  bar = true

because we'd hit this section-name check twice, and just set
"seen_section = 1" both times. So that works (modulo the subsection
parsing thing).

As far as quoting goes, now we're coming from the back of each line now.
And I don't think we strictly require double-quotes around string
values. So imagine this:

  [one]
  foo = this has [brackets]
  bar = this does not

When deleting one.bar, we'd erroneously think that closing bracket is
the prior section header. I _think_ it behaves correctly, though,
because we then say "well, delete everything back to that bracket
character". Which happens to be the correct thing to do anyway.

But let's get more devious. What about this:

  [one]
  foo = fake section [one]
  bar = whatever

If I unset foo.bar with your patch, I end up with the truncated:

  [one]
  foo = fake sectio

Yikes. This is obviously a ridiculous example, but the failure case is
pretty nasty.

Again, the tricky thing here is that we're parsing backwards. We don't
know what's syntactically relevant and what isn't.

> +
> +			/*
> +			 * It looks like a section header, but it could be a
> +			 * comment instead...
> +			 */
> +			if (is_in_comment_line(contents, begin2))
> +				return;

This would get fooled if we allowed line continuation in subsection
names, like:

  [one "subsection\
     # with newline"]
  key = true

but it looks like our parser doesn't allow that (aside from it being
slightly insane, of course). Good.

> +			/*
> +			 * We encountered the previous section header: This
> +			 * really was the only entry, so remove the entire
> +			 * section.
> +			 */
> +			if (contents[begin2] != '\n') {
> +				begin2--;
> +				*new_line = 1;
> +			}
> +
> +			store.offset[i] = end2;
> +			*begin = begin2;
> +			*i_ptr = i;
> +			return;

OK, makes sense.

> +		default:
> +			/*
> +			 * Any other character means it is either a comment or
> +			 * a config setting; if it is a comment, we do not want
> +			 * to remove this section. If it is a config setting,
> +			 * we only want to remove this section if this is
> +			 * already the next section.
> +			 */
> +			if (seen_section &&
> +			    !is_in_comment_line(contents, begin2)) {
> +				if (contents[begin2] != '\n') {
> +					begin2--;
> +					*new_line = 1;
> +				}
> +
> +				store.offset[i] = end2;
> +				*begin = begin2;
> +				*i_ptr = i;
> +			}
> +			return;
> +		}

Here's where we get fooled by is_in_comment_line() that I showed at the
beginning. We don't have to worry about other quoting, because any key
(quoted or not) would cause us to abort, since it's in the section.

> +	/* This section extends to the beginning of the file. */
> +	store.offset[i] = end2;
> +	*begin = begin2;
> +	*i_ptr = i;
> +}

Right, makes sense.


Ok, phew. That was a tough read. So here's what I see:

  1. Minor bug in is_in_comment_line(), patch above.

  2. Minor bug in matching section names, patch above.

  3. Matching subsection names doesn't work. I think this should be
     fixable with a helper function which can match '[one "two"]' when
     given "one.two".

  4. Backwards parsing causes is_in_comment_line to trigger more than it
     should. I can live with that because the trigger is arcane, and the
     error behavior is pretty harmless.

  5. Backwards parsing can find a bogus section. Also arcane, but the
     error behavior is pretty scary.

(4) and (5) are the ones that I don't see a way to fix, given the
current way in which we do the config-writing (i.e., running it through
the regular read-parser and then trying to "patch up" the found
locations). I think that's also what's contributing to the code being
hard to read, since you end up doing quite a lot of manual re-parsing.

I think the sane way to do this would be to parse the whole thing into
a tree (that includes things like comments and whitespace), and then we
could much more easily manipulate that tree, without dealing with the
parsing (forwards _and_ backwards). But that's a pretty big change from
the current code.

It also potentially means duplicating the parsing logic, unless we teach
the regular reader to do the tree-parse, and then pick out the config
from that. That's likely much slower than the existing parser (since
we'd allocate a bunch of tree nodes instead of just dumping strings to
the callbacks). But these days we cache the parsed config anyway, so I'm
not sure if a slight slowdown would actually matter that much.

I guess the holy grail would be a parser which reports _all_ syntactic
events (section names, keys, comments, whitespace, etc) as a stream
without storing anything. And then the normal reader could just discard
the non-key events, and the writer here could build the tree from those
events.

-Peff
