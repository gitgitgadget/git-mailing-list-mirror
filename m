Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB271F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 13:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeKVAMT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:12:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55420 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeKVAMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:12:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 617311116D2;
        Wed, 21 Nov 2018 08:37:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1KY8RsINPBgGL9aaat7jIYRVNug=; b=BsfNrV
        /Pj7DDs7i86lj0gIvwGl03/ozMzMYE0rul7IcStUIXZPpSttVqtnk61NEdKRZ+Lu
        28c6KY8kGEo+Rr1aV+/Ihjj/zSS8TWC65JkB7XlICF7NskA4lgYSv2ycZhIuSyPa
        rkfxmbGkyQ7YOKOJ3li2r3/9APjL2Bel8nH8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ts0Gyl+5iv0dOAF/7TaSqoMNmFWh7JSZ
        u3+kDL/Bxya1iWsZL2vq9u8BhZLi+SZu3TVYxwe5wiLTUnLYOQwm1ukM1ZjmL0Q1
        TNTlYYXZE0vAANudimm0M4asfdOLMhGAFuirPj1I63Pew8S/He8C9GHXOEEbQ6Qi
        GURZAI8LWgQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59A591116D1;
        Wed, 21 Nov 2018 08:37:51 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC4DC1116D0;
        Wed, 21 Nov 2018 08:37:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: pathspec: problems with too long command line
References: <c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com>
        <20181121132152.GA8246@sigill.intra.peff.net>
Date:   Wed, 21 Nov 2018 22:37:49 +0900
In-Reply-To: <20181121132152.GA8246@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 21 Nov 2018 08:21:52 -0500")
Message-ID: <xmqq7eh67dqq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A412A7AA-ED92-11E8-B7A7-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 21, 2018 at 10:23:34AM +0100, Marc Strapetz wrote:
>
>> From our GUI client we are invoking git operations on a possibly large set
>> of files. ...
>> command line length, especially on Windows [1] and OSX [2]. To workaround
>> this problem we are currently splitting up such operations by invoking
>> multiple git commands. This works well for some commands (like add), but
>> doesn't work well for others (like commit).

> Quite a few commands take --stdin, which can be used to send pathspecs
> (and often other stuff) without size limits. I don't think either
> "commit" or "add" does, but that might be another route.

A GUI client, like your server, should not be using end-user facing
Porcelain commands like "add" and "commit" anyway.  In the standard
"update-index" followed by "write-tree" followed-by "commit-tree"
followed by "update-ref" sequence, the only thing that needs to take
pathspec is the update-index step, and it already does take --stdin.

In any case, I share your gut feeling that this should not be a
magic pathspec, but should instead be "--stdin[-paths]", for command
line parsing's sanity.  Catchng random strings that begin with
double dash as fishy is much simpler and more robust than having to
tell if a string that is a risky or a benign magic pathspec.



