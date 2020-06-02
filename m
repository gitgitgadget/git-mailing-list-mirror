Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93CC433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3642072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rm/O0228"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFBQ0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:26:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBQ0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 12:26:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 828AFCE01F;
        Tue,  2 Jun 2020 12:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=54XGg+uZ1Gbb57MVptniLRqReDo=; b=rm/O02
        28lgcSmIPuzN3/MNElmFFLGCErchGUVnkSAC6KpjGPeT0pd+2d2TiBSH+ZhCsQ2u
        Y9RAH4R9r82h1EBMSNPBeFwwrPR+ZWPcINfZMQ+Rc+1KDCQ02s3fl/F1nBHLvi9r
        uJxN98TBgh4lnk8++BUqzb417QrhWeT4dyVxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/r2O8slI0Fd4h2FgcKr2IMuybvCwBVw
        1CGDevgQv6krhd9p87V6Y0DKi+L6QFvRVZknk7HatuJffwsG9yxUbsKo2S/xC0ET
        cIk54wuEgAWTEKXkdjUCPKM11PoANJSQk6TiLmUfoM80EWJZXcBpjj1JDgFz3ppH
        6dgTlYPN2Ok=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A876CE01E;
        Tue,  2 Jun 2020 12:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC8CACE01D;
        Tue,  2 Jun 2020 12:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     John Siu <john.sd.siu@gmail.com>, git@vger.kernel.org
Subject: Re: Git multiple remotes push stop at first failed connection
References: <CAGKX4vGhTbEqZS9+iYA2wZWRRaddQC6O4KV+zLaNYKkZgN36Xg@mail.gmail.com>
        <20200601214003.GA3309882@coredump.intra.peff.net>
Date:   Tue, 02 Jun 2020 09:26:35 -0700
In-Reply-To: <20200601214003.GA3309882@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 1 Jun 2020 17:40:03 -0400")
Message-ID: <xmqqr1uxtow4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D51D3B1C-A4ED-11EA-9171-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's really no benefit to doing it all in a single Git process, as
> we'd connect to each independently, run a separate independent
> pack-objects for each, etc.
>
> I'd even suggest that Git implement such a loop itself, as we did for
> "git fetch --all", but sadly "push --all" is already taken for a
> different meaning (but it might still be worth doing under a different
> option name).

I wonder if it is possible to update the implementation to do so
without changing the UI at all, though.

The presence of the "--all" option in "fetch" command is tied
closely to the fact that it makes no sense to have multiple URLs
that are used to download from at the same time under a single
remote name (e.g. what should "remotes/origin/master" point at if
two URLs say different things if such an arrangement were allowed?).

On the other hand, the pushURL for a single remote can be multiple
places for redundancy (a possible #leftoverbits here is that we
should probably disable the "pretend that we immediately turned
around and fetched from them after pushing" optimization when
pushing to a remote that has multiple pushURLs defined) does not
need an extra option.  If the way we currently push is suboptimal
and it is better to spawn a separate "git push" instance via the
run_command() API, that can safely be done as a bugfix without
affecting any UI elements, no?

