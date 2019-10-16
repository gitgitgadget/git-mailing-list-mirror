Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41A91F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 02:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfJPCBn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 22:01:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52275 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfJPCBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 22:01:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F8217C4D1;
        Tue, 15 Oct 2019 22:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TDKiMhkNR1diGYwT8Q5cK7EnOuE=; b=xrBBGr
        wWaL5DeafpsQp6QBwpy3HnY7qkB1orQYXGtHRyv85e7vS8vzWxN3cV9Zmcu381kF
        xl4WioDidnQ0QsDhUTS4MeQl5AGQS1okr4oPEfJkdmYqWKKxPA3tfJyfW8lDmfyo
        G/YaN13vh1gIVuZclsw+wTQvk8Y6isCRxrRsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wCJ6WyPY8kDcE+LMzCN4cppVxxWM58En
        HQSvvBXUxA2O4BkghvqWrEsnpMB/g8VSKNUTOdlFFR7jMLwk2UTrifw6uvn1403l
        UpS5MOqIcdo7MX0UCyrQjkrJwtdR6aT25gzdSUxrxCTa9hHR+kYd2JGH+SMCaCLC
        tFWeezeWnog=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39B0D7C4D0;
        Tue, 15 Oct 2019 22:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 665E57C4CF;
        Tue, 15 Oct 2019 22:01:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] notes: copy notes to HEAD by default
References: <20191015163631.21808-1-congdanhqx@gmail.com>
        <20191015163631.21808-2-congdanhqx@gmail.com>
Date:   Wed, 16 Oct 2019 11:01:34 +0900
In-Reply-To: <20191015163631.21808-2-congdanhqx@gmail.com> (Doan Tran Cong
        Danh's message of "Tue, 15 Oct 2019 23:36:31 +0700")
Message-ID: <xmqqpnixa1oh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E27CA5DA-EFB8-11E9-B384-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doan Tran Cong Danh <congdanhqx@gmail.com> writes:

> The target objects for copying notes was defaulted to HEAD from very
> early stage of git-notes.
>
> However, that default was limited by commit bbb1b8a35a, ("notes: check
> number of parameters to "git notes copy"", 2010-06-28).

Sorry, I don't quite get the above.  The said commit made sure 'git
notes copy' gets the right number of arguments, saying """Otherwise
we may segfault with too few parameters."""  I take that as a sign
that before that commit it was not defaulting to HEAD but attempting
to access the missing argv[2] (or whatever the index the <to-object>
should be at) and dereferencing a NULL?

    ... goes and digs ...

I think v1.6.6.1-458-g74884b524e is the commit that made the command
line parsing into the current shape, i.e. one parse_options() call
in each of the subcommand that gets dispatched, and you are right
that with that version a single argument given on the command line
is taken as the <from-object> and <to-object> defaults to HEAD.

So... what happend between that vesrion and v1.7.1-200-gbbb1b8a35a?

    ... goes and looks at bbb1b8a35a again ...

Ah, I think there is an off-by-one.  When not from-stdin and not
using rewrite-cmd, before that patch, we did not even check if
from-obj exists, so in that sense, the commit had a right idea that
it must check for "too few parameters", but it shouldn't have
insisted that we have at least two.  It is OK to have just one,
i.e. only the from-obj, for our purpose.

>  copy::
> -	Copy the notes for the first object onto the second object.
> -	Abort if the second object already has notes, or if the first
> +	Copy the notes for the first object onto the second object (defaults to
> +	HEAD). Abort if the second object already has notes, or if the first
>  	object has none (use -f to overwrite existing notes to the
>  	second object). This subcommand is equivalent to:
>  	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`

This is OK.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 02e97f55c5..95456f3165 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -513,7 +513,7 @@ static int copy(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	if (argc < 2) {
> +	if (argc < 1) {
>  		error(_("too few parameters"));
>  		usage_with_options(git_notes_copy_usage, options);
>  	}

So is this.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index d3fa298c6a..a8f9a0f36c 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -908,6 +908,10 @@ test_expect_success 'allow overwrite with "git notes copy -f"' '
>  	git notes copy -f HEAD~2 HEAD &&
>  	git log -1 >actual &&
>  	test_cmp expect actual &&
> +	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
> +	git notes copy -f HEAD~2 &&
> +	git log -1 >actual &&
> +	test_cmp expect actual &&
>  	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
>  '

This I am not sure is a good test to add to, especially as a fix to
bbb1b8a, which added this test:

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 64f32ad94d..2d67a40fc1 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1044,4 +1044,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	git log -1 > output &&
 	test_cmp expect output
 '
+
+test_expect_success 'git notes copy diagnoses too many or too few parameters' '
+	test_must_fail git notes copy &&
+	test_must_fail git notes copy one two three
+'
+
 test_done

The lack of testing that "git notes copy <from-obj>" succeeding is
why the off-by-one bug was not noticed, so I think that test (which
still exists to this day) is the right place to add a test to
protect this fix.

As to the log message, here is how I would explain/justify the
change, if I were writing it.

	notes: fix minimum number of parameters to "copy" subcommand

	The builtin/notes.::copy() function is prepared to handle
	only one argument given from the command line; in such a
	case, to-obj defaults to HEAD.

	When bbb1b8a3 ("notes: check number of parameters to "git
	notes copy"", 2010-06-28) tried to make sure "git notes
	copy" (with *no* other argument) does not dereference NULL
	by making sure we did not get too few parameters, it
	incorrectly insisted that we get two arguments, instead of
	just one.  This disabled the defaulting to-obj to HEAD.
	Correct it.

Thanks.
