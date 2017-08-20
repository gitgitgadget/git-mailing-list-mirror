Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A7E208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 06:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdHTGko (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 02:40:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51480 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751607AbdHTGkn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 02:40:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEF0D99470;
        Sun, 20 Aug 2017 02:40:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t4urxoMbKob6703CXNDZFNmhuhA=; b=JNoT6Y
        zc7BjdryyGDhGsvJOfpmhp9gC/16w0MtaWxITJkgtmlcVdp6bepdQDCsdAQFt0jp
        3hvO1kvu76OlPWa8AYpxe2kT1DCQzxVs0gMAidYUlFucZZNjVgg0/Mkt0OCgeEIZ
        WIes9ZrCSv3K8vtqdrGFTUY730baF9jXFd96c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MO50Gz3rrf8ZX5RXQ/L0sp1aEpgS4qiX
        INS7Q+nIlvUhXTwiaye1UNj5OS5JxgRgtO+up4A1wN2dNStSRTHFejSaN76+HFsO
        Kh3IbEiGi5TPwbxP15E5FXBDOV6xGpkaf7ddCS9clFKBgyjFeL3bUM7OjjjeADvW
        dqhl1LQ3kvM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A55839946F;
        Sun, 20 Aug 2017 02:40:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 156359946D;
        Sun, 20 Aug 2017 02:40:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH v3 00/23] Move exported packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1503094448.git.jonathantanmy@google.com>
        <xmqqk2209fm8.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 19 Aug 2017 23:40:33 -0700
In-Reply-To: <xmqqk2209fm8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 19 Aug 2017 00:33:03 -0700")
Message-ID: <xmqqd17q91y6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 786945FC-8572-11E7-BBF0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I have to say that this was a painful topic to integrate.
>
> As you may know, the mk/use-size-t-in-zlib topic is being retracted
> and getting rerolled as a larger size_t series, most of which still
> needs help in reviewing.
>
> The jt/sha1-file-cleanup topic is the only one among the other four
> that are still not in 'next', and I think that topic, as well as the
> other three, are all good and serve as a good base to build on top.
> So I first rebuilt your patches on top of these four topics.  This
> took some time but it wasn't all that painful.

... but it turns out that I screwed it up in at least one place,
making Linux32 build fail (Thanks Lars and folks who pushed hard to
arrange Travis to build all my pushes to 'pu').  I'm pushing out my
second attempt.  Let's see how it goes.

A change like this that only moves code around without changing
anything is painful to everybody to keep around, as nobody can
safely touch the affected code while it is in flight.  On the other
hand, as long as it is only moving code around, such a change is
reasonably safe, and it is relatively easy to ensure that there is
no change other than code movement is involved.  So let's 

 (1) make sure that the topics this depends on are sound by
     re-reading them once again, and merge them quickly down to
     'master';

 (2) merge this topic to 'next', optionally after rebasing it on
     'master', after (1) happens; and

 (3) quickly merge it to 'master', to get it over with.

In the meantime we'd need to refrain from taking code that touch
things that are moved by this series.

I plan to be offline for a week or so near the end of this month, so
I am hoping that we can do all of the above before that. That may
make us break our usual "tip of the 'master' is more stable and
robust than any released version" promise by potentially leaving it
broken for a while, but nobody can build on top of a fluid codebase
that is in the process of moving things around in a big way, so it
might not be such a bad idea to make it coincide with the period
when the tree must become quiescent due to my being offline.  We'll
see.

Thanks.
