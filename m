Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C997B207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 17:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756155AbcILRdS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 13:33:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60076 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752070AbcILRdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 13:33:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1972B3AC23;
        Mon, 12 Sep 2016 13:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dmEYoPY9ZrXIGIuZtBdW8E/58Qg=; b=M62ook
        LW3hGA6c1LysDFBTaBKZ7ZHQGL9gWOpZx1Y6GIt6JfjznQ5xCwJuMV/yzJRqc4XJ
        lxS1nq3/2PoknWIg2b89p7JEUEeYeGjUItd+8CZWqpWkNWkmBA/orWlNRuXyFaDe
        7uYsPGEGPOV84Oo8lWT1mwkCHeWtPsZ8CYxgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hAdo0rFBwB5kDIbQPXzjx3LgiDX6SGP+
        qO07k/1AhiHNM9xq97UTWNsGkutWLv61w0787q/ptA6VVD+nzSlg5XbDnKXt8uF7
        q75p62VnqsIgAOFXY/fD5taXvZ12jDw31cR2KdmdrjGne7Z0l7CwlPJwAaZQ234m
        DviJ9XsR90k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 103AE3AC22;
        Mon, 12 Sep 2016 13:33:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F6B63AC1E;
        Mon, 12 Sep 2016 13:33:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2 v5] pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use
References: <20160809192858.GA25822@teco.navytux.spb.ru>
        <20160809193143.32213-1-kirr@nexedi.com>
        <20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net>
        <20160910145738.x6ihp2gqzpk7dbi3@teco.navytux.spb.ru>
Date:   Mon, 12 Sep 2016 10:33:11 -0700
In-Reply-To: <20160910145738.x6ihp2gqzpk7dbi3@teco.navytux.spb.ru> (Kirill
        Smelkov's message of "Sat, 10 Sep 2016 17:57:39 +0300")
Message-ID: <xmqqy42x2fc8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB711FE0-790E-11E6-8838-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> On Thu, Aug 18, 2016 at 01:52:22PM -0400, Jeff King wrote:
> > 
> > Good to know there is no regression. It is curious that there is a
> > slight _improvement_ across the board. Do we have an explanation for
> > that? It seems odd that noise would be so consistent.
>
> Yes, I too thought it and it turned out to be t/perf/run does not copy
> config.mak.autogen & friends to build/ and I'm using autoconf with
> CFLAGS="-march=native -O3 ..."
>
> Junio, I could not resist to the following:
> ...
> With corrected t/perf/run the timings are more realistic - e.g. 3
> consecutive runs of `./run 56dfeb62 . ./p5310-pack-bitmaps.sh`:

Wow, that's what I call an exchange with quality during a review ;-)

Thanks for the curiosity and digging it to the root cause of the
anomaly.  Some GNUism/bashism in the way copying is spelled in the
patch bothers me, but that is easily fixable.

Thanks.
