Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C95DC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8A76124B
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhEaFuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:50:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhEaFuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:50:16 -0400
Received: (qmail 20284 invoked by uid 109); 31 May 2021 05:48:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 May 2021 05:48:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26622 invoked by uid 111); 31 May 2021 05:48:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 May 2021 01:48:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 May 2021 01:48:36 -0400
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
Message-ID: <YLR4tMOvkR81+ACq@coredump.intra.peff.net>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 11:23:39AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Hopefully the final iteration. Updates a commit message to explain why
> I moved away from File::Spec::Functions, rebases on master, and
> explains and deals with the "undef in config" issue Jeff King noted.

Thanks. The solution was less invasive than I feared.

I guess here:

>     @@ git-send-email.perl: sub read_config {
>      -			my @values = Git::config(@repo, $key);
>      -			next unless @values;
>      +			my @values = @{$known_keys->{$key}};
>     ++			@values = grep { defined } @values;
>       			next if $configured->{$setting}++;
>       			@$target = @values;
>       		}
>       		else {
>      -			my $v = Git::config(@repo, $key);
>     --			next unless defined $v;
>      +			my $v = $known_keys->{$key}->[0];
>     + 			next unless defined $v;
>       			next if $configured->{$setting}++;
>       			$$target = $v;
>     - 		}

we'd ignore such undef values, whereas presumably before they'd have
triggered an error via Git::config(). I don't think it matters all that
much either way, though.

-Peff
