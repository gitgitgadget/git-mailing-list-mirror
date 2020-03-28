Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF31C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 10:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F45206CC
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 10:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgC1KyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:54:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:54326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbgC1KyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 06:54:20 -0400
Received: (qmail 23309 invoked by uid 109); 28 Mar 2020 10:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 10:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 460 invoked by uid 111); 28 Mar 2020 11:04:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 07:04:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 06:54:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
Message-ID: <20200328105418.GA639140@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
 <20200327091004.GA610157@coredump.intra.peff.net>
 <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 10:44:27AM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] t/README: suggest how to leave test early with failure
> 
> Over time, we added the support to our test framework to make it
> easy to leave a test early with failure, but it was not clearly
> documented in t/README to help developers writing new tests.

Thanks for getting started on this. Everything you wrote looks correct,
but I think we can be more succinct. And I think it's worth being so,
since there are a lot of "do's" already, and we don't want to overwhelm
the user.

> + - Be careful when you loop
> +
> +   You may need to test multiple things in a loop, but the following
> +   does not work correctly:
> +
> +	test_expect_success 'git frotz on various versions' '
> +	    for revision in one two three
> +	    do
> +		    echo "frotz $revision" >expect &&
> +		    git frotz "$revision" >actual &&
> +		    test_cmp expect actual
> +	    done &&
> +	    test something else
> +	'

We could shrink this example down to the bare minimum. Perhaps:

  for i in a b c; do
    do_something "$i"
  done &&
  do_something_else

The key thing is that the "&&" will pick up only the value of
"do_something $c" and will ignore "a" and "b". That might be too dense,
but it does reduce any cognitive burden from unimportant details.

> +   If the output from the "git frotz" command did not match what is
> +   expected for 'one' and 'two', but it did for 'three', the loop
> +   itself would not fail, and the test goes on happily.  This is not
> +   what you want.

This explanation works fine, though I think you can also explain it as:

  The result code of a shell loop is the result of the final iteration;
  the results of do_something for "a" and "b" are discarded, and we'd
  pass the test even if they fail.

(I'm happy with either, just thinking out loud).

> +   You can work it around in two ways.  You could use a separate
> +   "flag" variable to carry the failed state out of the loop:

IMHO it's not worth giving this alternative. It's perfectly valid, but
we promise the "return" version works exactly so we don't have to deal
deal with this ugly and error-prone code.

> +    Or you can fail the entire loop immediately when you see the
> +    first failure by using "return 1" from inside the loop, like so:

I think we can jump straight to "in our test suite", like:

  One way around this is to break out of the loop when we see a failure.
  All test_expect_* snippets are executed inside a function, allowing an
  immediate return on failure:

    for i in a b c; do
      do_something "$i" || return 1
    done &&
    do_something_else

Possibly we'd also want to say:

  Note that we still &&-chain the loop to propagate failures from
  earlier commands.

but certainly the &&-chain linter would remind them of that. :)

>  And here are the "don'ts:"
>  
>   - Don't exit() within a <script> part.
>  * A tangent.  441ee35d (t/README: reformat Do, Don't, Keep in mind
>    lists, 2018-10-05) added these lines
> 
>     Here are the "do's:"
>     And here are the "don'ts:"
> 
>    Is the placement of the colons on these lines right?  I am
>    tempted to chase them out of the dq pair and move them at the end
>    of their lines, but obviously that is outside of the scope of
>    this patch.

I think it's a matter of taste. Most writing style guides put
punctuation inside quotes, but they're also expecting the output to be
typeset, where a trailing period ends up more under the quotes than
beside. I'm not sure what such style guides would say about colons, as
they're a bit taller.

But regardless, I actually prefer putting punctuation outside of the
quotes. It looks better to me in a fixed-width terminal setting. Plus I
guess as a programmer it feels like a parsing error. ;)

I don't know that it matters too much either way, though.

-Peff
