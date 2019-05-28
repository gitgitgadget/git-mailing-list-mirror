Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA221F609
	for <e@80x24.org>; Tue, 28 May 2019 16:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfE1QHt (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:07:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64525 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfE1QHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:07:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1414B143296;
        Tue, 28 May 2019 12:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=In76jA0hDsuWdEH8sR5KN1sZTW0=; b=WPX35z
        UkCj+EJ0WpEJBBKnVjoW60rWWAsGKQ/pYowqvcQRTFHwVJ69QTyo6TG0/8N/6W6+
        ynwJ7RVUApmUKMeohbqHqOh5Hx9CfeUVc50LyfwMbjtl5aTmmjhiK0sUeIcFdRLv
        Rw+bLcBR1EzGu/NFSfgcS1H/Hm6Rg9KbAnrnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNlUflxaw4t0qfHErd6d4aYMVc2MVp3x
        4TXNxR6WZ0JSy1Cc4OMuWV/CLwfNSDeWtZgcwVDEAXQjUzHdtsAKlCym1Z0uzgJC
        MGa0ce3VMd0rjU2aujqPIkRijgBe71l47nzWT162kL3l8fHj6Xbsd87ejwVy4cEE
        PB5vyfu0fM4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 084A7143295;
        Tue, 28 May 2019 12:07:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FA19143294;
        Tue, 28 May 2019 12:07:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Antonio Ospite <ao2@ao2.it>,
        Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] repository.c: always allocate 'index' at repo init time
References: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com>
        <20190519025636.24819-1-pclouds@gmail.com>
        <20190520131702.GB13474@sigill.intra.peff.net>
        <CACsJy8CoauTdJ1huU=w2YNbw53iea5U304yAu2oCUuTvFRaV7w@mail.gmail.com>
Date:   Tue, 28 May 2019 09:07:44 -0700
In-Reply-To: <CACsJy8CoauTdJ1huU=w2YNbw53iea5U304yAu2oCUuTvFRaV7w@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 21 May 2019 17:34:02 +0700")
Message-ID: <xmqqblzm5zqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAF2187A-8162-11E9-BEE8-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, May 20, 2019 at 8:17 PM Jeff King <peff@peff.net> wrote:
>> The patch looks good, though I wonder if we could simplify even further
>> by just embedding an index into the repository object. The purpose of
>> having it as a pointer, I think, is so that the_repository can point to
>> the_index. But we could possibly hide the latter behind some macro
>> trickery like:
>>
>>   #define the_index (the_repository->index)
> ...
>> So it's definitely non-trivial to go that way. I'm not sure if it's
>> worth the effort to switch at this point, but even if it is, your patch
>> seems like a good thing to do in the meantime.

Yeah, the fact that the_reopsitory->index is not an embedded
instance has bothered me from the very beginning, and I am happy to
see others share the same feeling ;-)

>> Either way, I think we could probably revert the non-test portion of my
>> 581d2fd9f2 (get_oid: handle NULL repo->index, 2019-05-14) after this.
>
> Yeah. I'm thinking of doing that after, scanning for similar lines
> too. But it looks like it's the only one. Will fix in v2.

Thanks.
