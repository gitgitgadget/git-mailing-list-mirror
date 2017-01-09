Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D8020A93
	for <e@80x24.org>; Mon,  9 Jan 2017 22:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbdAIW0u (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 17:26:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62852 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933905AbdAIW0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 17:26:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA9D1603C1;
        Mon,  9 Jan 2017 17:26:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RJTh8i+hLAjyjdfiuKyhsOnDrdM=; b=F1UVbj
        q3U9a1m0edSARUX4ijNq3F8YfrVyDptvqBR2N6veK/WF9OQ8Un+9nccOaCorprnG
        S0wSeLZ0+/Azz44bDcSjvN6R97bdlx/HxBzkuckqiXmYf2G0OOnTZM+ZyjaHADe+
        xaZHbyDWE9SaFCKm0/z4xkgQ/IIOWIhkDW2uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ovZ2z2nD0rn9+dNeSawXaKJbconGM2im
        K4BaXCf9v6pnnMGEH1HoSvGkulwGjGpwqjT7yUc4lYEfeIhqKMRG9LNR5RtdMZM0
        54K4QGKJJJtVgjySpqq0t8BeItAJ4E/gFZS7lwvkgfczmHqk8ALrxfn4jV/4NQQk
        bGIChDb1eho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2C50603C0;
        Mon,  9 Jan 2017 17:26:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 287B3603BF;
        Mon,  9 Jan 2017 17:26:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's backend
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
Date:   Mon, 09 Jan 2017 14:26:46 -0800
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Mon, 2 Jan 2017 16:25:59 +0100 (CET)")
Message-ID: <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B516C3E2-D6BA-11E6-9723-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v2:
>
> - fixed a TRANSLATORS: comment
> ...
> - replaced a spawned `diff-tree` command by code using the diff functions
>   directly

I just finished skimming the interdiff (the difference between the
result of merging the v2 into 'master' and the result of applying
this series on 'master').  I didn't cross reference it with all the
review comments that I saw on the list for the previous round, I
wouldn't have noticed even if there are issues that still haven't
been addressed.  But what I saw in the interdiff were mostly good
changes.

I however think that the renaming of read_author_script() is totally
backwards from maintainability's point of view.  

Both "am" and "rebase" use an external file whose name is the same
"author-script" (because they are meant to serve the same purpose),
and introduction of new code that is different from what "am" uses
to read it in v2 was bad enough.  If the rename of the function in
this round really means "author-script of 'am' can hold only author
information, but that of 'rebase' can hold anything the end user
desires", it makes things even worse.  If 'rebase' side extends the
file to hold other environment variables (in its own code), users
would wonder why the same extension will not be available in 'am'
side (and vice versa).

I ran out of time for the day and haven't looked at individual
patches yet.  I may find other issues, but from the interdiff, that
was the only thing that I found even worse than the previous round,
and everything else was either the same or has improved.

Thanks.
