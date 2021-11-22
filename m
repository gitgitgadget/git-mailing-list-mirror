Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461BC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbhKVOzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:55:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59964 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbhKVOzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:55:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0106217BA;
        Mon, 22 Nov 2021 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637592744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKl/wjM3QcXtAWEpTSQZhoCUvdk6UZZ6jTMZJ7ZpewA=;
        b=mdMARPaoFZizjFtc95qKxN3JwhyGWjbzr6l8yswPcw6nN/IBVzr0QydeI7JRW8vznu6NGm
        t2zcw9dXYW/9Tx1yg5820snLvnwH0ezyqsGBumVbRjxp9DZFu7C11hr53N13QirNl9n7Pn
        cchPZUAV/68Pp0O6DR5Ph//VA089l2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637592744;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKl/wjM3QcXtAWEpTSQZhoCUvdk6UZZ6jTMZJ7ZpewA=;
        b=HpNtA4y41XCkgYk464XpG02cv84KffT7CVmm56fWeD+IGVw9fs6JtrmDB1q4MoUezyWbbf
        8xtBEklfJ7dHQJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DB1F13B44;
        Mon, 22 Nov 2021 14:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LjoDBqium2HtAQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 22 Nov 2021 14:52:24 +0000
Date:   Mon, 22 Nov 2021 11:52:22 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Message-ID: <20211122145222.m2zrmtbaeu5kzbtt@cyberdelia>
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
 <xmqqfsrplz3z.fsf@gitster.g>
 <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Jeff King wrote:
>On Sun, Nov 21, 2021 at 06:10:08PM -0800, Junio C Hamano wrote:
>> Well, not to me X-<.  This is way too aggressive a change to be made
>> lightly without auditing the current users of run_command API.
>
>Yikes. Thanks for a dose of sanity. I was looking too much at just the
>pager tests.

Thanks for your input, Junio. I was, too, focused only on pager side and
even more so on the bug itself.

<snip> as I have no familiarity with other parts of the code </snip>

>> When merged to 'seen', this literally destroys tons of tests (the
>> first and easiest one to observe may be t0002).
>
>Forget 'seen'. Applying it on master shows plenty of breakages. :)

I should *probably* run the full test suite next time...

>I think we should probably punt on this direction, and just make sure
>that setup_pager() either reinitializes the child_process as appropriate
>(as in the patch I showed in the earlier thread) or just refuses to try
>running the pager twice (I didn't show a patch, but it should just be a
>matter of setting a static flag).

I'm preparing v3 with the above suggestions in mind.


Cheers,

Enzo
