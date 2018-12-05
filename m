Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3828211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 03:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbeLEDa0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 22:30:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50735 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 22:30:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D359011824A;
        Tue,  4 Dec 2018 22:30:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N/vObjs/Ebfw
        6MiphPsXSZTdE1Q=; b=fptdXHQw2FxunjplV3yjqU9rxICFF/OWdI/v9rbioDpz
        PeqcRWolFfApSQlNS/BOb11EOlS5QJipXV/axzrUF6Ozm1wKCWhjg7mzd2ceMC2W
        3x1YX4LjfHwXdcoySFg0RXUwzf2UaE7GvDVIeUv9UPWrt0VBOVlMniW/xujczgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q4nF6f
        WZ6a2jj7ile4I9+WLkZYwher4C1p2eW8s0//9fvoqgC8TV1Lceoa3Scat3ypZQNn
        vQA5mNpoC2r3kqpshgpYBRwaTkpLSqZDYcVjkhDEYuuzPomMvb3veBcpKXTreN+3
        P4ipIMVcBzpWu40bNAewO0S4lFwa6SkRPAyvs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB0EF118249;
        Tue,  4 Dec 2018 22:30:23 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42B30118246;
        Tue,  4 Dec 2018 22:30:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How de-duplicate similar repositories with alternates
References: <87zhtsx73l.fsf@evledraar.gmail.com>
        <20181204065930.GA11010@sigill.intra.peff.net>
        <87tvjtvah0.fsf@evledraar.gmail.com>
Date:   Wed, 05 Dec 2018 12:30:22 +0900
In-Reply-To: <87tvjtvah0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 04 Dec 2018 11:43:07 +0100")
Message-ID: <xmqq4lbsejld.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 196A78B0-F83E-11E8-95CC-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think a warning (or even error) like this would be more useful:
>
>     test ! -d $objdir && error... # current behavior
>     test -d $objdir/objects && error "Did you mean $objdir/objects, sil=
ly?" # new error

If it is an error common enough, perhaps we could even DWIM it, I
guess, that is...

	if test ! -d $objdir
	then
		error
	elif test -d $objdir/objects/pack
	then
		possibly warn
		objdir=3D$objdir/objects
	fi

> I.e. I suspect I'm not the only one who's not read the documentation
> carefully enough and thought it was a path to the root of the repo and
> wondered why it silently didn't work.
