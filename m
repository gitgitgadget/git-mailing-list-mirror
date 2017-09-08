Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18AD020286
	for <e@80x24.org>; Fri,  8 Sep 2017 03:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbdIHDhc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 23:37:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55211 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754083AbdIHDha (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 23:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F185FB0044;
        Thu,  7 Sep 2017 23:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IfOYCaCvJylcOnmgRgwm1O1DvpY=; b=DZz2w3
        9BQAJ774s0pzmoy42GK4Svwx0i0mFqfSWoqpGndXcseXFnIaup5isJsxFW5hREoC
        K8LFnHlfgaYI3/fmuXKyeChXLh2SIo5etupodT5VirdF0gkCqIZUhkc+6lhuoGnS
        1ifTcwEzg3fVX69fs8mYm1eWqSCzM7WAd4WhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PyThilu9Y7wfG5PTXfoDdaNdNL1KPyMt
        8Y3yJd9AaSEO/oxoYlua/uN0xe3U2gWhZLcVKvpbGhnUIVYerG3dPX398obqAgJy
        NDwgF9F4O6gXuBl0hya5mRivyHc94JsqdkAGEUVuOPvVDatAVFHpvSg430bOIwrR
        hbNHKC1pDfQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8763B0043;
        Thu,  7 Sep 2017 23:37:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 576FDB0042;
        Thu,  7 Sep 2017 23:37:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Pawe=C5=82?= Marczewski <pwmarcz@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Strange behavior of git rev-list
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
        <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net>
        <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
        <20170907101126.u574pr7l5odff6zo@sigill.intra.peff.net>
        <CAGZ79kaubRDXnetj+EXawnr50LMo4tGObz+-Bd-=KerndLfSaA@mail.gmail.com>
        <20170908031705.5zqs7jhamzgda47t@sigill.intra.peff.net>
Date:   Fri, 08 Sep 2017 12:37:28 +0900
In-Reply-To: <20170908031705.5zqs7jhamzgda47t@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 7 Sep 2017 23:17:05 -0400")
Message-ID: <xmqqwp59zwqv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A411210-9447-11E7-86B2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 07, 2017 at 12:24:02PM -0700, Stefan Beller wrote:
>
>> > We've discussed storing true generation numbers in the past, which would
>> > make this optimization more robust, as well as allow us to speed up many
>> > other traversals (e.g., the "tag --contains"). It's something I'd like
>> > to revisit, but it's not at the top of the pile.
>> 
>> (We just had an office discussion if this is part of the hash transition plan,
>> i.e. have a field in the commit object to contain its generation number.
>> and as I think the generation numbers would lead to fast and correct
>> behavior unlike the current heuristic which is only fast, I would try
>> to make a strong point actual generation numbers inside commit objects)
>
> I'm still moderately against storing generation numbers inside the
> objects. They're redundant with the existing parent pointers, which
> means it's an opportunity for the two sets of data to disagree. And as
> we've seen, once errors are cemented in history it's very hard to fix
> them, because you break any history built on top.
>
> I'm much more in favor of building a local cache of generation numbers
> (either on the fly or during repacks, where we can piggy-back on the
> existing pack .idx for indexing).

I guess our mails crossed.  Yes, objects that are needlessly broken
only because they botch computation of derivable values are real
problem, as we need to accomodate them forever because histories can
and will be built on top of them.

On the other hand, seeing that the world did not stop even with some
projects have trees with entries whose mode are written with 0-padding
on the left in the ancient part of their histories, it might not be
such a big deal.  I dunno.
