Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA66C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1492082E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qWG6wSzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgG2TCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:02:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51779 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgG2TCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 15:02:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 090D6800D9;
        Wed, 29 Jul 2020 15:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tiV3bWMciI5Q130llhiW9kXLtwM=; b=qWG6wS
        zwS7a+UqF/+4xjjGd4vesUY1g+IqJcCTw9xyPsO8rTLuxcfOm4mVRVrlbTyvk0SE
        iRmmK/Qm2fPT8n7k5y6oYJfBXNheQH7esNySIXp2kIAG/oYCWOXLv1Xa30Vcry8a
        w4JH5Fppu5yUctiAjuhNg9/KnGnj4r5Cp0GH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oWVulAUlhafUiqASrqA5hxyBaIXWvemo
        55AObAk8rJZiLa7DJ8hFWAxd7J40Jg3KCPXqOJhRBlfaxYRzW8cMCtN2sfA7JxLr
        s83COMR42bFtjivFG/9BQl4BjJFl4lr6tzMygS3RyJzZU2T8UkTy81NhSK5Os9M7
        TFW7pd6tCwg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F4155800D8;
        Wed, 29 Jul 2020 15:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BD43800D7;
        Wed, 29 Jul 2020 15:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
References: <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
        <20200728192350.352978-1-jonathantanmy@google.com>
        <20200728200847.GA1019822@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 12:02:28 -0700
In-Reply-To: <20200728200847.GA1019822@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 16:08:47 -0400")
Message-ID: <xmqqr1su9mbf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C9CA340-D1CE-11EA-B81C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just to play devil's advocate for a moment...
>
>> (Also, I think that debugging within a process is easier than debugging
>> across processes, but that might not be a concern that other people
>> share.)
>
> This is definitely true sometimes, but I think is sometimes the
> opposite. When we push things out to a sub-process, then the interface
> between the two processes has to be well-defined (e.g., writing results
> to a file with a particular format).

I agree that it forces us to be more disciplined to separate them
into two processes and clearly define the way they communicate with
each other.  When done poorly, it tends to make a bigger mess.

> That said, I think I could buy the argument that "fetch" works pretty
> well as a basic building block for users. It's pretty rare to actually
> use fetch-pack as a distinct operation. This is all a monolith vs module
> tradeoff question, and the tradeoff around modularity for fetch isn't
> that compelling.

Yup.  

The "more naive and stupid way to run them as subprocesses, just
like we do for cURL based transport" was primarily because I thought
it would be easier to get right (as the transport API and interface
has long been established) than hunting down all the callers of
die() and touch all the functions involved in the callchain.  I
won't complain or block if a harder-but-more-correct approach is
taken ;-)
