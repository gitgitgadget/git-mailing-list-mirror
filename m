Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598AC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhKVWej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:34:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhKVWef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:34:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0823155C8B;
        Mon, 22 Nov 2021 17:31:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=TP9USyzhDZg6Icx8bakfRpDAKkt1vOWL9AkypNC4Oso=; b=RSgf
        A9699h5yN80ciXZCRj4ElSBr2G6bq2+8L0x5BzTjRKsF6JNrMoNj+7NBI6m+FP0c
        9moPwlyM5fjR9VIVUS43I+TrqwDh6blS7G1YCroGRL63v29iY37SElWEkoRVBJmX
        mxnS2UREEc4+0JoCZsXKi9+e8wNXzlr4YmAGN0s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9BAA155C8A;
        Mon, 22 Nov 2021 17:31:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55171155C89;
        Mon, 22 Nov 2021 17:31:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/4] test-ref-store: tweaks to for-each-reflog-ent format
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <8a1b094d54732b8b60eacb9892ab460a411bcec3.1637590855.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:31:24 -0800
Message-ID: <xmqqr1b7bz5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED5DB5AA-4BE3-11EC-B3BA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Follow the reflog format more closely, so it can be used for comparing

There is no v$n designator on the title line, but I have this
feeling that I've seen this patch before.  More importantly, I
remember that I found it unclear what you exactly mean "the" reflog
format.  Is that what the files backend stores on one line in its
file?  The reason I suspect that may be the answer is because I do
not recall documenting "the" reflog format in Documentation/ and
whatever we have historically been writing would be the most
canonical and/or authoritative format.

> reflogs in tests without using inspecting files under .git/logs/

I agree 100% with the goal.  

It seems that one line of .git/logs/HEAD looks like

<new> SP <old> SP <user> SP '<' <email> '>' SP <time> SP <zone> HT <oneline> LF

and being able to extract a line like that for given reflog entry
out of any backend in a consistent way is valuable when testing
different backends.

It seems that is what the new code is writing, so perhaps the first
paragraph can be clarified to indicate as such.

    We have some tests that read from files in .git/logs/ hierarchy
    when checking if correct reflog entries are created, but that is
    too specific to the files backend.  Other backends like reftable
    may not store its reflog entries in such a "one line per entry"
    format.

    Update for-each-reflog-ent test helper to produce output that
    would be identical to lines in a reflog file files backend uses.
    That way, (1) the current tests can be updated to use the test
    helper to read the reflog entries instead of (parts of) reflog
    files, and perform the same inspection for correctness, and (2)
    when the ref backend is swapped to another backend, the updated
    test can be used as-is to check the correctness.

or something along the line?

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/helper/test-ref-store.c | 5 ++---
>  t/t1405-main-ref-store.sh | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index b314b81a45b..0fcad9b3812 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
>  		       const char *committer, timestamp_t timestamp,
>  		       int tz, const char *msg, void *cb_data)
>  {
> -	printf("%s %s %s %"PRItime" %d %s\n",
> -	       oid_to_hex(old_oid), oid_to_hex(new_oid),
> -	       committer, timestamp, tz, msg);
> +	printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
> +	       oid_to_hex(new_oid), committer, timestamp, tz, msg);

Looks good to me.  We might want to make the printf format
conditional to add \t%s only when msg is not empty, though.
Hopefully such a change would follow the reflog format even more
closely to make 4/4 unnecessary?

>  	return 0;
>  }
>  
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index a600bedf2cd..76b15458409 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
>  
>  test_expect_success 'for_each_reflog_ent_reverse()' '
>  	$RUN for-each-reflog-ent-reverse HEAD >actual &&
> +	head -n1 actual | grep recreate-main &&

I am not sure how this new test helps validate the change to the
code.

What was different in the old output was that the timezone was not
in %+05d format, and the field separator before the log message was
not HT.  So if this grepped for HT or +0000 to make sure we are
using the format that is close to what actually is stored in the
files, I would understand this change, but it is unclear what it
proves to make sure that the oldest entry has recreate-main.

In fact, with the code part of the patch reverted, this new test
seems to pass.

>  	tail -n1 actual | grep one
>  '
