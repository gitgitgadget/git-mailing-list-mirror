Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4443A1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfHFQYm (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:24:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53660 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHFQYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:24:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D4301666B7;
        Tue,  6 Aug 2019 12:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8kkGb4WxZQq/M24D9IIBdAQJECI=; b=rj4inm
        x3BddeIFLxo9sDWsCecNaynz/i+NNzLM8NICA1T80chGElPWTHRtyO2H/TU+JTYw
        4uCrdsNu0Xjtpnx8i0mOgGGNPVgj87J2+fXnrXERbliIse41CIOrZiArbuXBoHLM
        QEYV1nL4zIZp64jrlmHfC8Rc0TN0MNb5WgeHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IuMoZbFuHFKbDxvjqN6QhpWjQGzDmXAq
        2+KhzWgCiMZuBtbT3807uDiHmdr8/ygFUPew/ecxZeyeHsrFFG2lLto4ZRjWtKOY
        IyufjM4XHKbaYk6UUFzKCzvS6AzTMMRwcpf7CR1AvtG2zdhEYYu2tEzZQC6BF6Tu
        HwSkHo2fVHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23E801666B6;
        Tue,  6 Aug 2019 12:24:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 828181666B5;
        Tue,  6 Aug 2019 12:24:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
References: <20190806143829.GA515@sigill.intra.peff.net>
Date:   Tue, 06 Aug 2019 09:24:38 -0700
In-Reply-To: <20190806143829.GA515@sigill.intra.peff.net> (Jeff King's message
        of "Tue, 6 Aug 2019 10:38:30 -0400")
Message-ID: <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B04CADB4-B866-11E9-A6DA-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's hard for scripted uses of rev-list, etc, to avoid option injection
> from untrusted arguments, because revision arguments must come before
> any "--" separator. I.e.:
>
>   git rev-list "$revision" -- "$path"
>
> might mistake "$revision" for an option (with rev-list, that would make
> it an error, but something like git-log would default to HEAD).

Just to make sure I understand what I just read, let me paraphrase.
We would want to accept

	git rev-list --max-parents=4 \
		--end-of-options \
		--count -- docs/

so that '--count' would go thru the usual "as we have -- later, it
must be a rev and we do not even disambiguate.  What does get_sha1()
say it is?" and "docs/" would be taken as a pathspec.

"git rev-list --max-parents=4 --count -- docs/" would have treated
"--count" as an option and would error out due to lack of any
starting revision.

On the other hand, "git log --count -- docs/" would take "--count"
as an option, but does not complain about lack of any revs.  It just
starts digging from HEAD and ends up ignoring the "--count" branch
(or is this feature meant to support tags?  As far as I recall, we
do not allow branch names that begin with a dash).

> This series provides an alternative to "--" to stop option parsing
> without indicating that further arguments are pathspecs.
>
>   [1/3]: revision: allow --end-of-options to end option parsing
>   [2/3]: parse-options: allow --end-of-options as a synonym for "--"
>   [3/3]: gitcli: document --end-of-options
>
>  Documentation/gitcli.txt | 6 ++++++
>  parse-options.c          | 3 ++-
>  revision.c               | 8 +++++++-
>  t/t0040-parse-options.sh | 7 +++++++
>  t/t4202-log.sh           | 7 +++++++
>  t/t6000-rev-list-misc.sh | 8 ++++++++
>  6 files changed, 37 insertions(+), 2 deletions(-)
