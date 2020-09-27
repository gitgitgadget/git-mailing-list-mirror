Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25334C4727E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 00:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C227E2388E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 00:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SpDBdgZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgI0AIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 20:08:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56699 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0AIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 20:08:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 598EEA3A8F;
        Sat, 26 Sep 2020 20:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O40AlvAo8ls/66VejgH9DZ2jrHc=; b=SpDBdg
        ZKZAclDglTEsNWwCMWjR+cXEkj+8iHIw8IAb/GxZ3cqVnFhLcMr0KDbbQK4lpU8l
        PuJzeWtZd/TcA/JqK5EWOVemlF21pw0doz0MgLMiFUwefAk4T+u14qvShrXfLIKT
        juRFE+SPwhQuIEoL5mGW9qMwV88FNz1xrpXvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WafPeAS7fOY6SgUprma8UDkBNdRkEZ2p
        LXdf6KGDsiEB8+Y73W/ljfdOsaIFJz8eh4hwRV+NA3ANWUts/EYPUo/QcA27g8rb
        tboVg8+OSJIXtYyx5jc4igU74DzrSOCxUXzeDmvHLNnS7fZtm9U4iew9IPSvAu63
        217bi20041s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51EBDA3A8E;
        Sat, 26 Sep 2020 20:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB3ABA3A8D;
        Sat, 26 Sep 2020 20:08:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFH] sequencer: simplify logic around stopped-sha file
References: <xmqq8scymmo1.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009262320530.50@tvgsbejvaqbjf.bet>
Date:   Sat, 26 Sep 2020 17:08:46 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009262320530.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 26 Sep 2020 23:28:14 +0200 (CEST)")
Message-ID: <xmqqo8lsgjxt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CE09C76-0055-11EB-B904-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is there something obvious I am not seeing that makes this change a
>> bad idea (other than "somebody may be in the middle of a rebase and
>> all of a sudden, version of Git gets updated to contain this one,
>> which is unable to read abbreviated object name the current version
>> left on disk", which I am deliberately ignoring)?
>
> At least in my understanding, you are not missing anything:
>
> - this file is an implementation detail,
>
> - it is not exposed directly via any user-visible interface,
>
> - any reader will _have_ to be prepared for an unabbreviated object ID (in
>   the highly unlikely case that an object ID would be ambiguous if
>   abbreviated even by one hex character),

Ah, no that was not what I was worried about.  If an existing code,
after restarting and reading the abbreviated object name back from
the file, compares that shortened string against list of shortened
strings it has in-core (perhaps it reads todo back from the user in
abbreviated form, does comparison with stopped-sha as-is, before it
expands the object names from todo to full length), this change
would break it.

> - and most importantly: just like we expand the commit IDs in the todo
>   list, we actually want to expand them in `stopped-sha` because it _is_
>   possible that a new object is written that makes the previous
>   unambiguously abbreviated object ID now ambiguous (e.g. when the user
>   commits in a separate worktree while the rebase is interrupted, before
>   continuing the rebase).

Exactly.  I just wasn't sure if stopped-sha is handled with the same
carefulness as the object names in todo, which are expanded after
read and shortened before given back to the users.

Thanks.
