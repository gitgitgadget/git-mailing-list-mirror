Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B368C433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235CB207F5
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgG3AOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:14:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:42088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgG3AOo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:14:44 -0400
Received: (qmail 10734 invoked by uid 109); 30 Jul 2020 00:14:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Jul 2020 00:14:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12641 invoked by uid 111); 30 Jul 2020 00:14:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 20:14:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 20:14:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200730001442.GA2996059@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net>
 <xmqqv9i6814y.fsf@gitster.c.googlers.com>
 <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 03:50:01PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The fast-export side lifted the "single branch is special"; we
> > didn't do something similar for "fmt-merge-msg".
> >
> >> So I think a path forward is more like:
> >>
> >>   1. Add a new config option to shorten fmt-merge-msg's output when the
> >>      destination branch matches it (and this should perhaps not even be
> >>      a single name, but a set of globs, which supports more workflows).
> >>      Call it merge.suppressDest or something.
> >>
> >>   2. Optionally a repository created with "git init" could copy its
> >>      init.defaultBranch into merge.suppressDest. And likewise a clone
> >>      might copy the remote HEAD into that variable. I'm not sure if that
> >>      is worth doing or not, but it would restore the original behavior
> >>      for the most part.
> >
> > Yeah, that sounds like a good plan.
> 
> A rough outline I did while waiting for today's integration builds
> to finish looks like this, which does not look _too_ bad.  We can
> replace the literal 'master' with the default branch name determined
> at runtime, but I am not sure if that is needed.

This looks like a good direction overall.

I'm on the fence on how magical to make the default. Having "master"
there gets Linus's case back where he wanted without having to configure
anything, which is probably reasonable. I'm not sure if people would
want their init.defaultBranch in addition / instead. Since it's a list
it's tempting to say that those could be added to the list even if the
user has specified some value, but I guess that makes things awkward if
you don't want them (I see you put in a way to clear the list, which is
good; I'm more talking about the fact that people would have to actually
remember to do so in their config).

Just a few comments on the patch itself:

>  fmt-merge-msg.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Tests and docs, obviously, but I know this is just a preview. :)

> +	} else if (!strcmp(key, "merge.suppressdest")) {
> +		if (!value)
> +			string_list_clear(&suppress_dest_patterns, 0);
> +		else
> +			string_list_append(&suppress_dest_patterns, value);
> +		suppress_dest_pattern_seen = 1;

I kind of hate the option name, despite being the one who suggested it.
But I don't have anything better. I do like naming it after the specific
action we plan to use it for, and not some "these are default branches"
list, which is too vague.

> @@ -451,7 +461,15 @@ static void fmt_merge_msg_title(struct strbuf *out,
>  			strbuf_addf(out, " of %s", srcs.items[i].string);
>  	}
>  
> -	strbuf_addf(out, " into %s\n", current_branch);
> +	for_each_string_list_item(item, &suppress_dest_patterns) {
> +		if (!wildmatch(item->string, current_branch, WM_PATHNAME)) {
> +			suppress_merge_dest = 1;
> +			break;
> +		}
> +	}

I think a list with globs should be plenty flexible. I really hope
nobody would need to include "foo*" but exclude "*bar" from that. If
they do they can write that patch later.

I think this will be matching branch names, not fully qualified refs.
Seems reasonable, but we should be sure to document that.

This loop might be nicer in a helper function with an early return, if
only to avoid extra local variables in fmt_merge_msg_title().

-Peff
