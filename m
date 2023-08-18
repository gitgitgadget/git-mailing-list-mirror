Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D2DC71131
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 00:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356662AbjHRAN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 20:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356763AbjHRANX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 20:13:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8E10C9
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 17:12:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D601A8C87;
        Thu, 17 Aug 2023 20:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=swH2ahqrippSh+EYWQ9gsiDdPfsch6bgRBvxP4
        FwnJc=; b=LNkFx+TLARVBXX7/uJng3pZlc8slkugctM3djALsN2nm48A3SHIoiz
        z4yDSm033nx2YMD4lhNXBU1AeBVEx1U3z3KT7Lxymu1VKUKVo6jf/gXvvZiegzMT
        tbVNsH7xlJMpczjzZYjq2KmXiYNKMaJBCXec11o2elEc51zkk5Y5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC4021A8C86;
        Thu, 17 Aug 2023 20:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12F581A8C85;
        Thu, 17 Aug 2023 20:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>, phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        rsbecker@nexbridge.com
Subject: Re: [PATCH v7 2/3] unit tests: add TAP unit test framework
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1692297001.git.steadmon@google.com>
        <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
Date:   Thu, 17 Aug 2023 17:12:12 -0700
In-Reply-To: <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 17 Aug 2023 11:37:22 -0700")
Message-ID: <xmqq350hw6n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E22C6D78-3D5B-11EE-87C3-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +test_expect_success 'TAP output from unit tests' '
> +	cat >expect <<-EOF &&
> +	ok 1 - passing test
> +	ok 2 - passing test and assertion return 0
> +	# check "1 == 2" failed at t/unit-tests/t-basic.c:76
> +	#    left: 1
> +	#   right: 2
> +	not ok 3 - failing test
> +	ok 4 - failing test and assertion return -1
> +	not ok 5 - passing TEST_TODO() # TODO
> +	ok 6 - passing TEST_TODO() returns 0
> +	# todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/t-basic.c:25
> +	not ok 7 - failing TEST_TODO()
> +	ok 8 - failing TEST_TODO() returns -1
> +	# check "0" failed at t/unit-tests/t-basic.c:30
> +	# skipping test - missing prerequisite
> +	# skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:32
> +	ok 9 - test_skip() # SKIP
> +	ok 10 - skipped test returns 0
> +	# skipping test - missing prerequisite
> +	ok 11 - test_skip() inside TEST_TODO() # SKIP
> +	ok 12 - test_skip() inside TEST_TODO() returns 0
> +	# check "0" failed at t/unit-tests/t-basic.c:48
> +	not ok 13 - TEST_TODO() after failing check
> +	ok 14 - TEST_TODO() after failing check returns -1
> +	# check "0" failed at t/unit-tests/t-basic.c:56
> +	not ok 15 - failing check after TEST_TODO()
> +	ok 16 - failing check after TEST_TODO() returns -1
> +	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/unit-tests/t-basic.c:61
> +	#    left: "\011hello\\\\"
> +	#   right: "there\"\012"
> +	# check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-basic.c:62
> +	#    left: "NULL"
> +	#   right: NULL
> +	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/unit-tests/t-basic.c:63
> +	#    left: ${SQ}a${SQ}
> +	#   right: ${SQ}\012${SQ}
> +	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/unit-tests/t-basic.c:64
> +	#    left: ${SQ}\\\\${SQ}
> +	#   right: ${SQ}\\${SQ}${SQ}
> +	not ok 17 - messages from failing string and char comparison
> +	# BUG: test has no checks at t/unit-tests/t-basic.c:91
> +	not ok 18 - test with no checks
> +	ok 19 - test with no checks returns -1
> +	1..19
> +	EOF

Presumably t-basic will serve as a catalog of check_* functions and
the test binary, together with this test piece, will keep growing as
we gain features in the unit tests infrastructure.  I wonder how
maintainable the above is, though.  When we acquire new test, we
would need to renumber.  What if multiple developers add new
features to the catalog at the same time?

> diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
> new file mode 100644
> index 0000000000..e292d58348
> --- /dev/null
> +++ b/t/unit-tests/.gitignore
> @@ -0,0 +1,2 @@
> +/t-basic
> +/t-strbuf

Also, can we come up with some naming convention so that we do not
have to keep adding to this file every time we add a new test
script?

> diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
> new file mode 100644
> index 0000000000..561611e242
> --- /dev/null
> +++ b/t/unit-tests/t-strbuf.c
> @@ -0,0 +1,75 @@
> +#include "test-lib.h"
> +#include "strbuf.h"
> +
> +/* wrapper that supplies tests with an initialized strbuf */
> +static void setup(void (*f)(struct strbuf*, void*), void *data)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	f(&buf, data);
> +	strbuf_release(&buf);
> +	check_uint(buf.len, ==, 0);
> +	check_uint(buf.alloc, ==, 0);
> +	check(buf.buf == strbuf_slopbuf);
> +	check_char(buf.buf[0], ==, '\0');
> +}

What I am going to utter from here on are not complaints but purely
meant as questions.  

Would the resulting output and maintainability of the tests change
(improve, or worsen) if we introduce

	static void assert_empty_strbuf(struct strbuf *buf)
	{
		check_uint(buf->len, ==, 0);
                check_uint(buf->alloc, ==, 0);
		check(buf.buf == strbuf_slopbuf);
		check_char(buf.buf[0], ==, '\0');
	}

and call it from the setup() function to ensure that
strbuf_release(&buf) it calls after running customer test f() brings
the buffer in a reasonably initialized state?  The t_static_init()
test should be able to say

	static void t_static_init(void)
	{
		struct strbuf buf = STRBUF_INIT;
		assert_empty_strbuf(&buf);
	}

if we did so, but is that a good thing or a bad thing (e.g. it may
make it harder to figure out where the real error came from, because
of the "line number" thing will not easily capture the caller of the
caller, perhaps)?  

> +static void t_static_init(void)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	check_uint(buf.len, ==, 0);
> +	check_uint(buf.alloc, ==, 0);
> +	if (check(buf.buf == strbuf_slopbuf))
> +		return; /* avoid de-referencing buf.buf */

strbuf_slopbuf[0] is designed to be readable.  Do check() assertions
return their parameter negated?

In other words, if "we expect buf.buf to point at the slopbuf, but
if that expectation does not hold, check() returns true and we
refrain from doing check_char() on the next line because we cannot
trust what buf.buf points at" is what is going on here, I find it
very confusing.  Perhaps my intuition is failing me, but somehow I
would have expected that passing check_foo() would return true while
failing ones would return false.

IOW I would expect

	if (check(buf.buf == strbuf_slopbuf))
		return;

to work very similarly to

	if (buf.buf == strbuf_slopbuf)
		return;

in expressing the control flow, simply because they are visually
similar.  But of course, if we early-return because buf.buf that
does not point at strbuf_slopbuf is a sign of trouble, then the
control flow we want is

	if (buf.buf != strbuf_slopbuf)
		return;

or

	if (!(buf.buf == strbuf_slopbuf))
		return;

The latter is easier to translate to check_foo(), because what is
inside the inner parentheses is the condition we expect, and we
would like check_foo() to complain when the condition does not hold.

For the "check_foo()" thing to work in a similar way, while having
the side effect of reporting any failed expectations, we would want
to write

	if (!check(buf.buf == strbuf_slopbuf))
		return;

And for that similarity to work, check_foo() must return false when
its expectation fails, and return true when its expectation holds.

I think that is where my "I find it very confusing" comes from.

> +	check_char(buf.buf[0], ==, '\0');
> +}

> +static void t_dynamic_init(void)
> +{
> +	struct strbuf buf;
> +
> +	strbuf_init(&buf, 1024);
> +	check_uint(buf.len, ==, 0);
> +	check_uint(buf.alloc, >=, 1024);
> +	check_char(buf.buf[0], ==, '\0');

Is it sensible to check buf.buf is not slopbuf at this point, or
does it make the test TOO intimate with the current implementation
detail?

> +	strbuf_release(&buf);
> +}
> +
> +static void t_addch(struct strbuf *buf, void *data)
> +{
> +	const char *p_ch = data;
> +	const char ch = *p_ch;
> +
> +	strbuf_addch(buf, ch);
> +	if (check_uint(buf->len, ==, 1) ||
> +	    check_uint(buf->alloc, >, 1))
> +		return; /* avoid de-referencing buf->buf */

Again, I find the return values from these check_uint() calls highly
confusing, if this is saying "if len is 1 and alloc is more than 1,
then we are in an expected state and can further validate that buf[0]
is ch and buf[1] is NULL, but otherwise we should punt".  The polarity
looks screwy.  Perhaps it is just me?

> +	check_char(buf->buf[0], ==, ch);
> +	check_char(buf->buf[1], ==, '\0');
> +}

In any case, this t_addch() REQUIRES that incoming buf is empty,
doesn't it?  I do not think it is sensible.  I would have expected
that it would be more like

	t_addch(struct strbuf *buf, void *data)
	{
		char ch = *(char *)data;
		size_t orig_alloc = buf->alloc;
		size_t orig_len = buf->len;

		if (!assert_sane_strbuf(buf))
			return;
                strbuf_addch(buf, ch);
		if (!assert_sane_strbuf(buf))
			return;
		check_uint(buf->len, ==, orig_len + 1);
		check_uint(buf->alloc, >=, orig_alloc);
                check_char(buf->buf[buf->len - 1], ==, ch);
                check_char(buf->buf[buf->len], ==, '\0');
	}

to ensure that we can add a ch to a strbuf with any existing
contents and get a one-byte longer contents than before, with the
last byte of the buffer becoming 'ch' and still NUL terminated.

And we protect ourselves with a helper that checks if the given
strbuf looks *sane*.

	static int assert_sane_strbuf(struct strbuf *buf)
	{
        	/* can use slopbuf only when the length is 0 */
		if (buf->buf == strbuf_slopbuf)
                	return (buf->len == 0);
		/* everybody else must have non-NULL buffer */
		if (buf->buf == NULL)
			return 0;
                /* 
		 * alloc must be at least 1 byte larger than len
		 * for the terminating NUL at the end.
		 */
		return ((buf->len + 1 <= buf->alloc) &&
		    	(buf->buf[buf->len] == '\0'));
	}

You can obviously use your check_foo() for the individual checks
done in this function to get a more detailed diagnosis, but because
I have confused myself enough by thinking about their polarity, I
wrote this in barebones comparison instead.

