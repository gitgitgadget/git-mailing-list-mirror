Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D7E1FF6D
	for <e@80x24.org>; Wed, 21 Dec 2016 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756173AbcLUVIZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:08:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755986AbcLUVIY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:08:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6C5E587CA;
        Wed, 21 Dec 2016 16:08:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZLq1uBvvRTvrB7AIkD62IqHi+b4=; b=HNHkjs
        eiiqk3FI5G4cV8A6NnI6DtuH2Xub60GUWTlfLD3Ike2e5At+yW9iHdgAcjiKE77k
        8mrEiWkwf567F3RXkBbO83ua7VgWNnq3Ho7BJfuxhMJcEAuVFHKqaPkUNSGoS+M0
        l5ApyrVkyTS9tkYVh8fWby1pcVQhCgyIq6QJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pwNiIA2zw81/+CY8wELlf/1j5gjm5Ed7
        aTWYpQqZRL/aUWB6RwZrYtDSjNbw0A/QPqZlw5bl73Xvnx6FF8cvV+UqYaG3opvl
        hS6VY3m0MLH1cTIpyqyxsmq6AYRsfMyxBIZgc62j8m0jKSt0bzymFC8Ui5Opozyy
        A/6OWMCS+MM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC92A587C6;
        Wed, 21 Dec 2016 16:08:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52160587C4;
        Wed, 21 Dec 2016 16:08:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Races on ref .lock files?
References: <20161216164751.GA12174@inner.h.apk.li>
        <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com>
        <20161221100033.GB1206@inner.h.apk.li>
Date:   Wed, 21 Dec 2016 13:08:21 -0800
In-Reply-To: <20161221100033.GB1206@inner.h.apk.li> (Andreas Krey's message of
        "Wed, 21 Dec 2016 11:00:33 +0100")
Message-ID: <xmqq4m1xhtx6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AF1E490-C7C1-11E6-ACB5-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Krey <a.krey@gmx.de> writes:

> In a different instance, we have a simple bare git repo that we
> use for backup purposes. Which means there are lots of pushes
> going there (all to disjunct refs), and I now cared to look
> into those logfiles:
>
> ----snip
> Wed Dec 21 05:08:14 CET 2016
> fatal: Unable to create '/data/git-backup/backup.git/packed-refs.lock': File exists.
>
> If no other git process is currently running, this probably means a
> git process crashed in this repository earlier. Make sure no other git
> process is running and remove the file manually to continue.
> error: failed to run pack-refs
> To git-backup-user@socrepo.advantest.com:backup.git
>  + 8aac9ae...2df6d56 refs/zz/current -> refs/backup/socvm217/ZworkspacesZsocvm217ZjohanabtZws-release_tools.Ycurr (forced update)
> ----snip
>
> I interpret this as "I updated the refs files, but packing them
> didn't work because someone else was also packing right now."

Correct.

> Is that happening as designed, or do I need to be afraid
> that some refs didn't make the push?

Correct and No.  Packing refs into the packed-refs file is merely a
performance thing and done under the lock (needless to say, updating
individual refs is also done under the lock).  Your push may have
competed with somebody else's push that started earlier and you may
have given up packing refs, but no ill effect should be left behind.

When the lock holder (the other guy who competes with your push)
stuffs refs into a packed-refs file, the values for the refs you
pushed may not be in the packed-refs file, because the other guy may
have observed and captured the value before your push updated them.
Those refs updated by you that are missed by the other guy will be
left as loose refs.  Because whenever Git tries to find the value
for a ref, it always checks the loose refs first, there is no issue
due to this.

