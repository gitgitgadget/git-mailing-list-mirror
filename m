Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1E41F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHMRcs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 13:32:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50164 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfHMRcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 13:32:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 820441702A4;
        Tue, 13 Aug 2019 13:32:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7repOoAE7F8Te3Z+99TRLZ8k8ts=; b=g5MAev
        Gv/ddPY9vX62KrEu+E6mTkjLprNeU3e2+hWt3AbWtIYTPPUBiNQHykdsNJg++yjw
        mbbAmJY3dweIJwxCfGYoAHV6ibsA9GWNaHuNCPFdcNg2aTFrhxMPiBuM7ZFJoLrE
        z0LycT6A1bRmP/uAptrjJ5wGshd1lfqgGuv84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JI+4Pn3BQUDl8aTFutCJ+Mzm89vroKMZ
        D/uf1ZjGQBNEhWLMDypcJf8gca67c/JeDNvN/bnUoPV8PHAwzesAhY2PCdXESqRt
        uYHHrF43RJmH5WiFIguFG7FpXAr6z+4bpRYKR5AWY0TMJzobsdJULQ7xJOW1Xtgn
        7HliTBrXVIM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 795181702A3;
        Tue, 13 Aug 2019 13:32:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D41AD1702A2;
        Tue, 13 Aug 2019 13:32:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: How to reset selected lines?
References: <20190813141816.yoer6pfjdnlgtj76@localhost.localdomain>
        <20190813154239.GA22514@sigill.intra.peff.net>
Date:   Tue, 13 Aug 2019 10:32:44 -0700
In-Reply-To: <20190813154239.GA22514@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 13 Aug 2019 11:42:39 -0400")
Message-ID: <xmqqblwt7yyr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CD64E80-BDF0-11E9-8934-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Git's index and trees only understand whole files, so at some point you
> must generate the final file content. A diff is an easy way to represent
> the changes, apply them to the existing state, and then get that final
> content. But it doesn't _have_ to be. You could make some modifications
> to what is in the working tree and then say "OK, now stage this.".
>
> BUT. That is probably not what the user wants, if the content in the
> index actually has some modifications that are not in the working tree
> (i.e., you wouldn't want to overwrite them). Hence we tend to work with
> diffs, saying "make these changes to what is already in the index, and
> if they conflict, then bail".
>
> So "git add -p", for example, also works by creating diffs, modifying
> them, and feeding the result to "apply". You can see the implementation
> in git-add--interactive.perl, where it literally calls diff and apply
> commands.
>
> And that leads us to the answer to the first question. That script
> implements "add -p", but also "checkout -p" (which is what you want),
> "reset -p", "stash -p", etc. They differ only in what we diff and how we
> apply the result; the main engine of slicing and dicing the diff through
> user interaction is the same. See the %patch_modes hash for the list.

I was about to respond but you said everything I wanted to say and
said it a lot better than I could ;-)

