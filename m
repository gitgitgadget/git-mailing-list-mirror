Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5E91F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 19:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHMTNT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 15:13:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52184 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHMTNS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 15:13:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBCFE8862A;
        Tue, 13 Aug 2019 15:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k0ppOUn819H8NEoneKBT6RUxn4Q=; b=cxH4kD
        ljl8Ly+cFBvmdL8fQ/e1J6kplM/uf81k0v1TMWNbAnwr/ByVbcGT1/SIq6c/jR1F
        AGqi4sf6paE8Q/WRqrykxClEqYcAOfGaOlU20Hgrg8IFwTH+GzoTvPBDQZsIA5Rt
        4ArMTinR4bDPD82oZvFwzZ3eqhMG8iPe451UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3DdB0Cw6XtoY71IYYOdMtkbhpfqcwJc
        gH3h4D7LvVjt10MU+ECxatl//e4fmxFI2gY/Oh6yMhc3EziiB4GJ2jvBDkJmA0Ip
        BGQKTkArz/RNfubHT4ciHkFZIY6Xs9p1ohB+bO54dLi0GmrW+i4/ttCG5YFsnj5I
        01kEHTQ4Xp8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B415988629;
        Tue, 13 Aug 2019 15:13:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAF6688628;
        Tue, 13 Aug 2019 15:13:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, git@vger.kernel.org
Subject: Re: Non-robust lock files in containers can lead to repo corruption
References: <qimq0i$49gn$1@blaine.gmane.org>
        <20190812163812.GB26231@sigill.intra.peff.net>
Date:   Tue, 13 Aug 2019 12:13:11 -0700
In-Reply-To: <20190812163812.GB26231@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 12 Aug 2019 12:38:13 -0400")
Message-ID: <xmqq36i498vs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65B4223A-BDFE-11E9-B9FA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think there are. Most of Git's locks are predicated purely on
> the existence of the lockfile (with the intent that they'd work over
> systems like NFS). The gc lock is a weird one-off.
>
> And while it's not great for multiple gc's to run at the same time
> (because it wastes CPU), two of them running at the same time shouldn't
> cause a corruption. If you have a reproducible demonstration where that
> happens, I'd be very interested to see it.

Good point.

And come to think of it, gc "lock" does not have to be a lock to
begin with.  It is not "I am forbidding all of you guys from doing
gc, because that would break the result of gc _I_ am doing right
now", which is what we traditionally call "lock".  It is merely a
"We need to do this every once in a while and I am doing it now.  I
let others know that I am already doing so, so they do not have to
start the same thing right now" advisory.

And the code (i.e. lock_repo_for_gc()) allows the current process to
run when

 - "--force" option is given, or
 - the lockfile cannot be open()ed, or
 - the lockfile cannot be fstat()ed, or
 - the lockfile is older than 12 hours, or
 - the lockfile has malformed contents, or
 - the lockfile was taken on a host with the same name from ours,
   and a process with the same pid as recorded is not running.

Following the """12 hour limit is very generous as gc should never
take that long. On the other hand we don't really need a strict
limit here, running gc --auto one day late is not a big
problem. --force can be used in manual gc after the user verifies
that no gc is running.""" reasoning, I suspect that it shouldn't be
too bad even if we dropped the last condition (i.e. "is the process
still running?")  from the set of these conditions.
