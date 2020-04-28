Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE35FC83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A419B2082E
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4fJk+7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgD1RZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:25:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64098 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgD1RZP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 13:25:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A627DBFCEA;
        Tue, 28 Apr 2020 13:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=82WpxbKBMsDH16AQF7INg11QnEU=; b=j4fJk+
        7KMRHrcStIGkrHLaNC26pKzbpvhV9M3czOiv3EAvufWjtsqwtUxGY663DgGETQp9
        4R2nP46oKwMA1J0E4dOuKoJdVPI+cH4Szn+Us0tLXZ3jS4Jte0y4g/4cXz0cBWsc
        npjJG0FyNuNgrj+qPraYtMqFEDw5TgLKqTPkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CxLCzP0tR1iQbkzc55M0/9WcFt68Bo49
        RMLdksWJKiEcnrRoMlwhWDduGhAeUcfhWCHYrei6qE/IL625/P6yH5SF9Zu6TYbZ
        cVXgEu9eOzzbv+cjdB3H7JCORpMWmHjZ30XTQorr+Qbvz95Xz+Vb3dRYV5Fmct0n
        BkaR1q81pqE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F424BFCE9;
        Tue, 28 Apr 2020 13:25:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8564BFCE8;
        Tue, 28 Apr 2020 13:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: proto v2 fixes for maint (was Re: Preparing for a Git 2.26.3 release)
References: <20200428055514.GB201501@google.com>
Date:   Tue, 28 Apr 2020 10:25:09 -0700
In-Reply-To: <20200428055514.GB201501@google.com> (Jonathan Nieder's message
        of "Mon, 27 Apr 2020 22:55:14 -0700")
Message-ID: <xmqq7dxz4j62.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3698B108-8975-11EA-972E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Since then we've heard about a few related (non-security) regressions.
> I'd like to avoid giving people an excuse not to upgrade, so this
> morning[1] I promised a discussion of what I'd like to see in a 2.26.3
> release to help with that.

Thanks for starting this.  

I'll have chances to comment on other areas you listed, but since
I've answered on v2-proto stuff to somebody else already...

> The protocol version change was painful for users that fetch in the
> same repo from linux-next and other linux remotes[5].  The problem has
> been isolated and fixed, so we could either apply the revert or apply
> the fixes[6].

The demote patch hasn't even hit 'master'.  

My preference is to merge the demotion down to 'master' and 'maint'
while merging down this fix to 'next' and to 'master'.

And immediately revert the demotion on 'master', which will make the
tip of 'master' with v2 as the default, with "this" fix.

That way, those who want to help us polish the code further for the
next release would use v2 as default with the proposed fix for this
breakage and can hunt for other breakages in v2, while those on the
maintenance track (and v2.26.3 JNeider wants to see happen soon)
would revert to the original protocol as default.

In short, my preference is to ship 2.26.3 with the "demote v2 from
default", and hopefully try 2.27 with "v2 with negotiation fix" and
hope people won't find any other remaining glitches in 2.27.  After
that, we may want to merge the negotiation fix down to 2.26.x track
but I am not comfortable merging it in a release on the maintenance
track with the timeframe we seem to be talking about (i.e. a few
weeks, presumably).



