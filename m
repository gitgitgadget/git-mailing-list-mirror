Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AABB1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 03:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfINDGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 23:06:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53849 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfINDGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 23:06:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDF8E30DD9;
        Fri, 13 Sep 2019 23:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6SHh7UrNv0GNPXhqT29niS6wq9U=; b=iandul
        fUJZ5gRg497c/QW0K6Sae0ufxDZHnZmXnX/J5vI36zV1qjzvTFafvwGSv1JnDXXu
        hODagcr9lgud5507g6Wkb9V2g+mMcBofttsd/lFVZY52zl/yGwJ8/vOKG/k8WngA
        WbCDlNjYYJqMvMf34+tNg8D/W1a106A1DR+lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IXwuyHppj68W1MQiqQI2Z3698JH15lnC
        DM8QsocxwhEWil5mf/l05eQcbeElfBIWK0Isr/KeNIhl/qU+NnMusxNcAWZZWWd7
        /PmuzvFaG9ekf+xzDuQ2lbsceLLresscrjEQIj+wbLEIdBYAbwJwx5zzDlQVhFjh
        pxFVZt0znbc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8FA730DD8;
        Fri, 13 Sep 2019 23:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D974530DD7;
        Fri, 13 Sep 2019 23:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
        <20190913130226.7449-11-chriscool@tuxfamily.org>
        <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
        <20190914020225.GB28422@sigill.intra.peff.net>
Date:   Fri, 13 Sep 2019 20:06:01 -0700
In-Reply-To: <20190914020225.GB28422@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 13 Sep 2019 22:02:25 -0400")
Message-ID: <xmqqy2yrbmqu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95DDA27C-D69C-11E9-B633-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 13, 2019 at 03:29:00PM -0700, Junio C Hamano wrote:
>
>> This comment has nothing to do with the change, but the way the
>> patch is presented is quite hard to follow, in that the preimage or
>> the common context lines do not help understand what the new code is
>> doing at all ;-)
>> 
>> I'll come back to the remainder of the patch later.  Thanks.
>
> I applaud Christian's effort to tease it out into separate patches.

Ah, no question about it.  I have a suspicion that 10/10 alone may
still be a bit too large a ball of wax, but with all the earlier
preparatory steps are bite-sized and trivial to see how they are
correct.

The "way the patch is presented" comment was not at all about what
Christian did, but was about what the diff machinery computed when
comparing the 9th step Christian created and the final step.  In its
attempt to find and align common context lines, it ended up finding
blank lines and almost nothing else in the earlier part of the
patch, not just making it harder to read the new helper function
(i.e. the best way to read record_reused_object(), for example, is
to look only at '+' and ' ' lines, because the '-' lines are
irrelevant), it also made it hard to see what got discarded.

