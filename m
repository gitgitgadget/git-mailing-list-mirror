Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07961C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3D260FE5
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhEaOls (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 10:41:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:42144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234281AbhEaOjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 10:39:48 -0400
Received: (qmail 22455 invoked by uid 109); 31 May 2021 14:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 May 2021 14:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29174 invoked by uid 111); 31 May 2021 14:38:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 May 2021 10:38:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 May 2021 10:38:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/13] send-email: various optimizations to speed up
 by >2x
Message-ID: <YLT0znOFZGd/zmDa@coredump.intra.peff.net>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <YLR4tMOvkR81+ACq@coredump.intra.peff.net>
 <874kej2pjw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kej2pjw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 11:53:04AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I guess here:
> >
> >>     @@ git-send-email.perl: sub read_config {
> >>      -			my @values = Git::config(@repo, $key);
> >>      -			next unless @values;
> >>      +			my @values = @{$known_keys->{$key}};
> >>     ++			@values = grep { defined } @values;
> >>       			next if $configured->{$setting}++;
> >>       			@$target = @values;
> >>       		}
> >>       		else {
> >>      -			my $v = Git::config(@repo, $key);
> >>     --			next unless defined $v;
> >>      +			my $v = $known_keys->{$key}->[0];
> >>     + 			next unless defined $v;
> >>       			next if $configured->{$setting}++;
> >>       			$$target = $v;
> >>     - 		}
> >
> > we'd ignore such undef values, whereas presumably before they'd have
> > triggered an error via Git::config(). I don't think it matters all that
> > much either way, though.
> 
> They didn't error before, they were treated the same as the empty
> string.
> 
> This is because Git.pm uses "git config --get" to retrieve them, but we
> now use "--list --null".
> 
> This ultimately comes down to a limitation of git-config's one-shot CLI
> interface. You get the empty string and zero exit code for both of:
> 
>     git -c foo.bar= config --get foo.bar
>     git -c foo.bar config --get foo.bar

Ah, OK. Thanks for clarifying.

> Ignoring them here for list values is technically a behavior change if
> we were treating this as a black box, but in reality we know that these
> could only conceivable be useful for the bool values, for list values
> like "list of e-mail addresses" it makes no sense to have that in a the
> middle of a list, and we were implicitly ignoring them anyway before
> when we processed the empty string.

Right, it was the list one I was most puzzled by. But if we were already
conflating implicit-bool and the empty string, I think it's OK.  I agree
that all of this is something that _shouldn't_ happen in the first
place, for well-formed config.

-Peff
