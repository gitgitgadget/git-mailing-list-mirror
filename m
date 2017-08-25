Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1DA2208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933826AbdHYQIB (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 12:08:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64958 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933744AbdHYQIA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 12:08:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBD8F9D13E;
        Fri, 25 Aug 2017 12:07:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i35iIbTXrws7eFIRtG8uUF5jV5M=; b=bCskIz
        u9v8Jha1VVO2f4cCpoVdhlp/FdSTsKd169gvSwL7/XvHNxECnJ1f4bm4nW66B6mh
        aOocLbBq5yYJB5SCvplPB7maJUZyVLehMRxQ4y4EwnfekKU2/R6y5ws9bMUA5WJ7
        b84mvcazUh24SgMNPRnCbwzzI2ZBSxCAXs87I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WMQoHVeL2iVC8Ga6sY9K61pGR9nc1h4S
        jeU9EcQYf1ayRXXuWkgmGEthlzmn2X/9SmwROD0PDPANDIVLojUyyvdm0o81QPDK
        NMwYyvSj1VRRFJ2MCFvgrXmadzEtiHG162YqxxNzYElxCPAmW306/+72cAeoEVT4
        TeU6KMy0z3o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACCBE9D13D;
        Fri, 25 Aug 2017 12:07:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CB919D138;
        Fri, 25 Aug 2017 12:07:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Should rerere auto-update a merge resolution?
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
        <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
        <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
        <xmqqwp5ru17n.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 25 Aug 2017 09:07:57 -0700
In-Reply-To: <xmqqwp5ru17n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 25 Aug 2017 08:16:44 -0700")
Message-ID: <xmqqshgftyua.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9042FCB8-89AF-11E7-A349-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
>>  - when I tell it to forget, won't it forget the pre-resolution state?
>
> I do not recall the details of what I did ;-) so I played around a
> bit.  Here is what I did:
> ...
> After git rerere forget, I observe (check subdirectories in
> .git/rr-cache/ whose timestamps are recent) that postimage gets
> removed but preimage and thisimage stay.

Having said that, I suspect that it may be a bug if this procedure
kept the original preimage.  It should either remove it, or update
it to record the state before the ealier resolution was applied
(i.e. make the updated preimage identical to thisimage, so that a
corrected resolution can be taken from the working tree to pair with
it).

As you may be able to see, "rerere forget" is much less used, hence
much less exposed to end-user needs to gain both feature and
usability polish than other parts of "rerere".  I'd expect there
would be many cases where an extra cleverness can be used without
making the result less robust, and it would be a good thing to see
if we can improve them.  We must avoid the cleverness leading us to
a "works most of the time" machinery whose operation cannot be
trusted, though.

The way the current machinery works is

 * "rerere" sees an unmerged index entry.  It computes the conflict id
   to look into its database, finds a <pre,post> image pair, and
   does a three-way merge to update the working tree file (with
   conflict markers) with pre->post change (i.e. previous resolution).

and that's it.  We may be able to make "updating the resolution"
easier, perhaps like so:

 * The end user edits working tree file further to correct the
   mistake in the earlier resolution that was applied.

 * The end user says "rerere update <path>", which internally does
   the equivalent of "checkout -m <path>" to unmerge and then
   computes the preimage for this round by redoing the original
   merge, write out the preimage and take the working tree file as
   the postimage

We might even be able to do a bit more in the "normal application"
codepath to make it record the result of the three-way merge,
perhaps in an index extension.  Then "rerere update <path>" may not
even be needed---at strategic places in the workflow (e.g. when the
user adds the path to the index), we can check if the contents is
different from what rerere wrote out as the resolution and if they
differ, do the "rerere update <path>" automatically.

But we may be taking the extra cleverness a bit too close to a
danger zone by trying to automate too much without thinking the
ramification through, so I'd stop speculation at this point.

