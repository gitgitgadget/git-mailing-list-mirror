Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEF31F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdAYVQD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:16:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdAYVQC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:16:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E489564083;
        Wed, 25 Jan 2017 16:16:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4Vo2tO2ARCaI
        g5svnUGUgFqFPHU=; b=GrL7attXSHM6keXWmQvTMxh7wPmDOD+5t7pDE6nULksv
        4HXK27di0X1Oi94GJ/JGHUhRVOaih+5CvnQttySqSNAtPq4hlf4h6ZatazBxSeJy
        4WaC0X5WkaeaStHsM7dUNE1oBEuZozwBERNMGm27p3PNr+fFKC7cGrdekWTP6mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZVFPu5
        f1g4m9L+ODem3S2Eqvsi9jCATLi5CJN2vp7E3lpKMPqox4yF5i6e7dQ9DpvUZfcE
        i4lDdoFQMjdimsL29yi5giR0vNHxaDCz6ky7yNVP9/I/nA4o4t+1+7jVaXjBulXM
        zXsNgyaWyy0Y+dnrptQ0DaSh1XIwCOo/acyTg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DAE864082;
        Wed, 25 Jan 2017 16:16:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C39864081;
        Wed, 25 Jan 2017 16:15:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        jacob.keller@gmail.com
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
        <20170125125054.7422-1-pclouds@gmail.com>
        <20170125125054.7422-5-pclouds@gmail.com>
Date:   Wed, 25 Jan 2017 13:15:58 -0800
In-Reply-To: <20170125125054.7422-5-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 25 Jan 2017 19:50:53 +0700")
Message-ID: <xmqqk29ialip.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77FA2446-E343-11E6-AE69-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Behavior change: "--exclude --blah --remotes" will not exclude remote
> branches any more. Only "--exclude --remotes" does.
>
> This is because --exclude is going to have a new friend --decorate-refl=
og
> who haves the same way. When you allow a distant --remotes to complemen=
t
> a previous option, things get complicated. In
>
>     --exclude .. --decorate-reflog ... --remotes
>
> Does it mean decorate remote reflogs, or does it mean exclude remotes
> from the selected revisions?

I would expect that the effect of exclude, decorate-reflog and
friends will extend until the next occurrence of --remotes (or --all
or whatever you catch in parse_ref_selector_option() function).

So, I'd read it as "add all remote tracking refs, but (1) exclude
exclude the refs matching pattern .. and (2) use reflog of them if
they match pattern ...".

Or did you mean by "..." something other than a single argument that
is a pattern?

