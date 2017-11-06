Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDC620450
	for <e@80x24.org>; Mon,  6 Nov 2017 12:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdKFMYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 07:24:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:47552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751717AbdKFMYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 07:24:13 -0500
Received: (qmail 23577 invoked by uid 109); 6 Nov 2017 12:24:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 12:24:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20352 invoked by uid 111); 6 Nov 2017 12:24:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 07:24:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Nov 2017 07:24:11 -0500
Date:   Mon, 6 Nov 2017 07:24:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>, git@vger.kernel.org
Subject: Re: git grep -P fatal: pcre_exec failed with error code -8
Message-ID: <20171106122411.dhi2ltyegzquebhk@sigill.intra.peff.net>
References: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org>
 <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net>
 <4e2bc579-429f-9927-4502-5929e5235740@aegee.org>
 <20171106103125.fwtrxv6zycrbihcv@sigill.intra.peff.net>
 <878tfj62y2.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878tfj62y2.fsf@evledraar.booking.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 06, 2017 at 12:50:45PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Some replies to the thread in general, didn't want to spread this out
> into different replies.
> 
>  * Yes this sucks.
> 
>  * Just emitting a warning without an appropriate exit code would suck
>    more, would break batch jobs & whatnot that expcept certain results
>    from grep.

That was my first thought, too, but something that does:

  git grep foo && echo found

would behave basically the same. Do you mean here scripts that actually
do:

  git grep foo
  case "$?" in
  0) echo found ;;
  1) echo not found ;;
  *) echo wtf? ;;
  esac

I agree it would be nice to at least have _some_ way to distinguish
between those final two cases.

Though something like "git log --grep" is even more complicated. We
perhaps _would_ want to distinguish between:

  - match (in which case we print the commit)

  - no match (in which case we do not)

  - error (in which case we do not print, but also mark the exit code as
    failing)

>  * As you point out it would be nice to print out the file name we
>    didn't match on, we'd need to pass the grep_source struct down
>    further, it goes as far as grep_source_1 but stops there and isn't
>    passed to e.g. look_ahead(), which calls patmatch() which calls the
>    engine-specific matcher and would need to report the error. We could
>    just do this, would slow down things a bit (probably trivally) but we
>    could emit better error messages in genreal.

I'm not sure if the grep_source has enough information for all cases.
E.g., if you hit an error while grepping in commit headers, you'd
probably want to mention the oid of the commit. There's an "identifier"
field in the grep_source, but it's opaque.

The caller may also want to do more things than just print an error
(like the exit code adjustment I mentioned above). Which implies to me
we should be passing the error information up, not trying to bring the
context down.

>  * You can adjust these limts in PCRE in Git, although it doesn't help
>    in this case, you just add (*LIMIT_MATCH=NUM) or
>    (*LIMIT_RECURSION=NUM) (or both) to the start of the pattern. See
>    pcresyntax(3) or pcre2syntax(3) man pages depending on what version
>    you have installed.

I saw that in the pcre manual, but I had the impression you can't
actually raise the limits above the defaults with that, only lower them.

>  * While regexec() won't return an error its version of dealing with
>    this is (at least under glibc) to balloon CPU/memory use until the
>    OOMkiller kills git (although not on this particular pattern).

So in a sense our current behavior with pcre is the same. We just have
to provoke the death ourselves. ;)

-Peff
