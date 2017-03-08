Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B176B202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754258AbdCHSr7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:47:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58940 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754236AbdCHSry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F57B6C059;
        Wed,  8 Mar 2017 13:47:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgPny3SafAz3rkvVdWfImnUpbJM=; b=bXtiwI
        jhJIS32Moq22YlX1mvu+Sjzm7mFse3wHKfuAoyvyMb+miqCYizEBzphmwStqyaTf
        +TnRkkNMkGixEtUAx1Cuo3WbcfZs7YbWsFhFuDddYJ22KrhXObNUi3Agx2DVKaT7
        oZkiIF8/jfYH25woeypRd+hvp3GBqWLnLTyWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y0Vmt8UwguW35i8LnY/HIEKV/s3piZ7w
        RVNRUDaSNI5gVOU8VdHYoGHQQKXTe536WVZY1oakYbVWThWNNMaYDVeGj0U6SKNS
        9yZJzIEAMvpbmMUq/XiPOLY0+k75RyK216mVWODBWhFEKLjVrWKTr8TeVjTWwFXy
        M8lDsLgXcYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 069AC6C058;
        Wed,  8 Mar 2017 13:47:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5ED226C057;
        Wed,  8 Mar 2017 13:47:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n --partial-special
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
        <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
Date:   Wed, 08 Mar 2017 10:47:41 -0800
In-Reply-To: <1488994685-37403-3-git-send-email-jeffhost@microsoft.com> (Jeff
        Hostetler's message of "Wed, 8 Mar 2017 17:37:57 +0000")
Message-ID: <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6300BF6-042F-11E7-AB3E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> From: Jeff Hostetler <git@jeffhostetler.com>
>
> Teach pack-objects to omit blobs from the generated packfile.
>
> When the --partial-by-size=n[kmg] argument is used, only blobs
> smaller than the requested size are included.  When n is zero,
> no blobs are included.

Does this interact with a more traditional way of feeding output of
an external "rev-list --objects" to pack-objects via its standard
input, and if so, should it (and if not, shouldn't it)?  

It is perfectly OK if the answer is "this applies only to the case
where we generate the list of objects with internal traversal." but
that needs to be documented and discussed in the proposed log
message.

> When the --partial-special argument is used, git special files,
> such as ".gitattributes" and ".gitignores" are included.

And not ."gitmodules"?  

What happens when we later add ".gitsomethingelse"?

Do we have to worry about the case where the set of git "special
files" (can we have a better name for them please, by the way?)
understood by the sending side and the receiving end is different?

I have a feeling that a mode that makes anything whose name begins
with ".git" excempt from the size based cutoff may generally be
easier to handle.

I am not sure how "back-filling" of a resulting narrow clone would
safely be done and how this impacts "git fsck" at this point, but if
they are solved within this effort, that would be a very welcome
change.

Thanks.
