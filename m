Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C41C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC9160D07
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhJ1Rcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:32:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:48922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1Rcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:32:53 -0400
Received: (qmail 16969 invoked by uid 109); 28 Oct 2021 17:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 17:30:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6659 invoked by uid 111); 28 Oct 2021 17:30:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 13:30:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 13:30:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: pre-v2.34.0-rc0 regressions: 'git log' has a noisy iconv()
 warning
Message-ID: <YXreMYZrTCUkpHXz@coredump.intra.peff.net>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
 <YXk0hAgaSJbLUgeB@coredump.intra.peff.net>
 <xmqqmtmuwdh9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtmuwdh9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 11:04:50AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The firehose of warnings for "git log --encoding=nonsense" was known and
> > discussed in fd680bc558 (logmsg_reencode(): warn when iconv() fails,
> > 2021-08-27). It's ugly for sure, but I'm still OK with it for the
> > reasoning there: your next step is to fix the --encoding argument you
> > gave. Whether you saw one line of warning or many is not that important,
> > IMHO. Giving a single more sensible warning ("your encoding 'nonsense'
> > isn't valid") would be better, but I think it's hard to do without
> > creating other problems.
> >
> > But the most compelling argument against warning at all is the case you
> > gave earlier: that there may be historical garbage commits, and you
> > can't get rid of them, so being warned constantly that we're not going
> > to show or grep them correctly is just annoying. And that is true
> > whether the user sees one warning or a hundred.
> 
> Is it really a "firehose"?  I won't use the word for one warning
> message per commit in the output of "git log --encoding=nonsense".
> 
> If you are running "git log --oneline", it may indeed be annoying to
> double the number of lines shown, and indeed
> 
>     $ git log --oneline --encoding=US-ASCII -4 ab/doc-lint
>     warning: unable to reencode commit to 'US-ASCII'
>     414abf159f docs: fix linting issues due to incorrect relative section order
>     warning: unable to reencode commit to 'US-ASCII'
>     ea8b9271b1 doc lint: lint relative section order
>     warning: unable to reencode commit to 'US-ASCII'
>     cafd9828e8 doc lint: lint and fix missing "GIT" end sections
>     warning: unable to reencode commit to 'US-ASCII'
>     d2c9908076 doc lint: fix bugs in, simplify and improve lint script

It's a bit more than that. You get similar warnings for commits which we
--grep but don't show (and which _might_ have been shown if the encoding
conversion had been different). Try "git log --grep=foo --encoding=bar".

And of course the interleaved output you see above looks OK in a pager.
But if you're sending the output of log (or diff-tree, etc) elsewhere,
you're just going to get a stream of messages on stderr. That would be a
bit less egregious if the message mentioned the commit oid, so they
weren't strict duplicates.

> is indeed annoying, as everything that is _shown_ ought to be
> presentable in US-ASCII.  This observation makes us realize an
> obvious approach to improve over the current behaviour without
> losing the warning when it matters, but I think the required code
> change, to first split the commit message into pieces (which roughly
> corresponds to the atoms in the --format= placeholder language) and
> reencode only these pieces that will be shown, may be too involved
> to be worth the effort.

Yeah, I think that would complicate things significantly, with the way
the code is currently structured. It also means parsing commits that are
in arbitrary encodings, which is not possible in most general sense.
E.g., imagine an encoding which doesn't have ASCII as subset, like
UTF-16.  Though I suspect such encodings probably do not work for
commits anyway (there is a chicken-and-egg with reading the encoding
header in the first place).

> > So while I do hate to have Git just silently ignore errors, probably the
> > original behavior is the least-bad thing, and we should just revert
> > fd680bc558 (logmsg_reencode(): warn when iconv() fails, 2021-08-27). We
> > probably want to salvage the documentation change (minus the "along with
> > a warning") part.
> 
> I am all for making it convenient to squelch, but it would be sad to
> lose the convenient way to notice possible misencoding in recent
> commits.  Or can we have a command line option and pass it through
> the callchain, or would that be too involved?

Do you mean a command-line option to squelch the warnings? I think it
would not be too hard to do it as a config option (which is probably
what you'd want anyway, since historical commits would come up over and
over again).

-Peff
