Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE6AC64EC4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 15:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBOPQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBOPQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 10:16:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA34439B8B
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 07:16:03 -0800 (PST)
Received: (qmail 11660 invoked by uid 109); 15 Feb 2023 15:16:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 15:16:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14331 invoked by uid 111); 15 Feb 2023 15:16:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 10:16:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 10:16:02 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v2 0/3] get rid of sscanf() when shortening refs
Message-ID: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
References: <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
 <xmqq7cwk955b.fsf@gitster.g>
 <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
 <xmqq3578924s.fsf@gitster.g>
 <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
 <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
 <CAPig+cTH1hUTSN+TRCo9brGMosEW-OWV0JVBATK+moB0EZec3w@mail.gmail.com>
 <Y+u/xUQJoWVWULn6@coredump.intra.peff.net>
 <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 01:38:13PM -0500, Jeff King wrote:

> OK, here it is. I split it into a few patches to hopefully make it a bit
> easier to follow.
> 
>   [1/3]: shorten_unambiguous_ref(): avoid integer truncation
>   [2/3]: shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES constant
>   [3/3]: shorten_unambiguous_ref(): avoid sscanf()

And here's a v2 fixing the "refs/headsXfoo" problem from v1. I also
added a few tests to cover that case along with some others, including
the original problem that spawned this thread.

I hope setting LC_ALL is OK in the test suite (i.e., at worst it just
becomes a noop on platforms that don't have that locale).  We can drop
it, but then the test itself becomes kind of meaningless, as I do not
think it would even fail on macOS. I would be curious to see if the test
as written does fail with the current code (I lack access to a system to
test).

In writing these, I noticed that this patch is actually fixing another
bug in the original. ;) The "%s" match in scanf is greedy, so we'd never
turn "refs/remotes/foo/HEAD" into "foo" (instead we say "foo/HEAD"). I
doubt anybody cares very much, and you might even argue that "foo/HEAD",
while not the shortest possible answer, is preferable because it's more
descriptive. But I think "foo" matches the intent of the code, and
certainly it's an unambiguous shortening.

Anyway, here's the patches and the range diff.

  [1/3]: shorten_unambiguous_ref(): avoid integer truncation
  [2/3]: shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES constant
  [3/3]: shorten_unambiguous_ref(): avoid sscanf()

 refs.c                  | 93 +++++++++++++++++++++--------------------
 t/t1401-symbolic-ref.sh | 34 +++++++++++++++
 2 files changed, 82 insertions(+), 45 deletions(-)

1:  56762dc84b = 1:  f84edd1791 shorten_unambiguous_ref(): avoid integer truncation
2:  83326a396a = 2:  9287afb50f shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES constant
3:  754ea4eb40 ! 3:  7cc6a8b89d shorten_unambiguous_ref(): avoid sscanf()
    @@ Commit message
         that against the refname, pulling the "%s" content into a separate
         buffer.
     
    -    This has two downsides:
    +    This has a few downsides:
     
           - sscanf("%s") reportedly misbehaves on macOS with some input and
             locale combinations, returning a partial or garbled string. See
             this thread:
     
               https://lore.kernel.org/git/CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com/
     
    +      - scanf's matching of "%s" is greedy. So the "refs/remotes/%s/HEAD"
    +        rule would never pull "origin" out of "refs/remotes/origin/HEAD".
    +        Instead it always produced "origin/HEAD", which is redundant with
    +        the "refs/remotes/%s" rule.
    +
           - scanf in general is an error-prone interface. For example, scanning
             for "%s" will copy bytes into a destination string, which must have
             been correctly sized ahead of time to avoid a buffer overflow. In
    @@ Commit message
         to the lookup rules with "%.*s"), and then copy it only when returning
         to the caller.
     
    +    There are a few new tests here, all using symbolic-ref (the code can be
    +    triggered in many ways, but symrefs are convenient in that we don't need
    +    to create a real ref, which avoids any complications from the filesystem
    +    munging the name):
    +
    +      - the first covers the real-world case which misbehaved on macOS.
    +        Setting LC_ALL is required to trigger the problem there (since
    +        otherwise our tests use LC_ALL=C), and hopefully is at worst simply
    +        ignored on other systems (and doesn't cause libc to complain, etc,
    +        on systems without that locale).
    +
    +      - the second covers the "origin/HEAD" case as discussed above, which
    +        is now fixed
    +
    +      - the remainder are for "weird" cases that work both before and after
    +        this patch, but would be easy to get wrong with off-by-one problems
    +        in the parsing (and came out of discussions and earlier iterations
    +        of the patch that did get them wrong).
    +
    +      - absent here are tests of boring, expected-to-work cases like
    +        "refs/heads/foo", etc. Those are covered all over the test suite
    +        both explicitly (for-each-ref's refname:short) and implicitly (in
    +        the output of git-status, etc).
    +
         Reported-by: 孟子易 <mengziyi540841@gmail.com>
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Jeff King <peff@peff.net>
    @@ refs.c: int update_ref(const char *msg, const char *refname,
     -		size_t total_len = 0;
     -		size_t offset = 0;
     +	/*
    -+	 * Check that rule matches refname up to the first percent
    -+	 * in the rule. This is basically skip_prefix(), but
    -+	 * ending at percent in the prefix, rather than end-of-string.
    ++	 * Check that rule matches refname up to the first percent in the rule.
    ++	 * We can bail immediately if not, but otherwise we leave "rule" at the
    ++	 * %-placeholder, and "refname" at the start of the potential matched
    ++	 * name.
     +	 */
    -+	do {
    ++	while (*rule != '%') {
     +		if (!*rule)
     +			BUG("rev-parse rule did not have percent");
    -+		if (*rule == '%')
    -+			break;
    -+	} while (*refname++ == *rule++);
    ++		if (*refname++ != *rule++)
    ++			return NULL;
    ++	}
      
     -		for (i = 0; i < NUM_REV_PARSE_RULES; i++)
     -			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
     -			total_len += strlen(ref_rev_parse_rules[i]) - 2 + 1;
     +	/*
    -+	 * Check that we matched all the way to the "%" placeholder,
    -+	 * and skip past it within the rule string. If so, "refname" at
    -+	 * this point is the beginning of a potential match.
    ++	 * Check that our "%" is the expected placeholder. This assumes there
    ++	 * are no other percents (placeholder or quoted) in the string, but
    ++	 * that is sufficient for our rev-parse rules.
     +	 */
     +	if (!skip_prefix(rule, "%.*s", &rule))
     +		return NULL;
    @@ refs.c: char *refs_shorten_unambiguous_ref(struct ref_store *refs,
      	return xstrdup(refname);
      }
      
    +
    + ## t/t1401-symbolic-ref.sh ##
    +@@ t/t1401-symbolic-ref.sh: test_expect_success 'symbolic-ref pointing at another' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'symbolic-ref --short handles complex utf8 case' '
    ++	name="测试-加-增加-加-增加" &&
    ++	git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
    ++	# In the real world, we saw problems with this case only
    ++	# when the locale includes UTF-8. Set it here to try to make things as
    ++	# hard as possible for us to pass, but in practice we should do the
    ++	# right thing regardless (and of course some platforms may not even
    ++	# have this locale).
    ++	LC_ALL=en_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
    ++	echo "$name" >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'symbolic-ref --short handles name with suffix' '
    ++	git symbolic-ref TEST_SYMREF "refs/remotes/origin/HEAD" &&
    ++	git symbolic-ref --short TEST_SYMREF >actual &&
    ++	echo "origin" >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'symbolic-ref --short handles almost-matching name' '
    ++	git symbolic-ref TEST_SYMREF "refs/headsXfoo" &&
    ++	git symbolic-ref --short TEST_SYMREF >actual &&
    ++	echo "headsXfoo" >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'symbolic-ref --short handles name with percent' '
    ++	git symbolic-ref TEST_SYMREF "refs/heads/%foo" &&
    ++	git symbolic-ref --short TEST_SYMREF >actual &&
    ++	echo "%foo" >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_done
