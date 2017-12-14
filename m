Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9CC1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbdLNWok (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 17:44:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58630 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754064AbdLNWok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 17:44:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EEDACACA5;
        Thu, 14 Dec 2017 17:44:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s7vgV+irnKP6CJYz6F1YnylO2ho=; b=eOhoBd
        lewhpWTrkB4Bv1m6AwMxBqmD9+k7RMIjpoVw2yUpFLJoTONld9CGiFJGfwzwPGKx
        iVrWekv14/1xEWhpJ5q7WQ00FGjG09L1gc0qLV01OMpyqgqmRs7TXlwqikLEDH9w
        eDhzgmwGf247CeRtUomP6ZcJifHujeuMo/4b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TGd6IarR7LVXIoP2o3bfXvfP/wRg2FfI
        5b9mrdMW2i2PZEQZMWziFStY5DEPRLZI+2FcvqvW6hXYeIZaEfD/YaOHzvvuQqLL
        IeRSynk4N2rWDA6/2jjyKDbfvnIeGzHEio28nSF3k1hOT3YTgferxBVqrq6RrOWB
        vM8ESYlloSY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76D2CCACA4;
        Thu, 14 Dec 2017 17:44:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB2F0CACA3;
        Thu, 14 Dec 2017 17:44:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
        <20171212012422.123332-1-sbeller@google.com>
        <20171214212234.GC32842@aiede.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 14:44:37 -0800
In-Reply-To: <20171214212234.GC32842@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 14 Dec 2017 13:22:34 -0800")
Message-ID: <xmqqefnxrktm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF7F7C2-E120-11E7-97AA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Putting it in context, we have:
>
> 	pickaxe options:
> 	-S: detect changes in occurence count of a string
> 	-G: grep lines in diff for a string
>
> 	--pickaxe-all:
> 		do not filter the diff when the patch matches pickaxe
> 		conditions.
>
> 		kind of like log --full-diff, but restricted to pickaxe
> 		options.
> 	--pickaxe-regex: treat -S argument as a regex, not a string
>
> Is this another kind of pickaxe option?  It feels similar to -S, but
> at an object level instead of a substring level, so in a way it would
> be appealing to call it --pickaxe-object.  Does --pickaxe-all affect
> it like it affects -S and -G?

It does feel quite close to -S, but is slightly different.

Instead of spelling out the exact contents to pass as the argument
to the -S option, you are giving a blob object name instead.

However, if you rename path F to G without any modification, or if
you flip only the mode bits, -S would reject such a filepair, as
both sides have the same number of the sought-after string, I think.
Unlike -S, this new thing should show such a filepair because it is
designed to show any filepair with either (or both) side has the
sought-after object.

We could make this identical to -S, i.e. only when a filepair has
sought-after object on either (or both) sides *and* its pre and post
image sides do not talk about the same object.

    Note.  I am phrasing the above awkwardly because we can ask for
    more than one object, and a filepair that changes a path from
    object A to object B, both of which are what we are looking for,
    want to be caught.  If I phrased the above as "only when only
    one side of a filepair has an object we are looking for and the
    other side does not", such a filepair would not be shown.

I have a suspicion that such a change may be worthwhile.

> Another context to put it in is:
>
> 	--diff-filter:
> 		limit paths (but not commits?) to those with a change
> 		matching optarg

IIUC, this is applied at the output phase after all of the rename,
pickaxe etc. are done (e.g. "Now you have the diff to give me, show
me only the additions in it").  It is a poor match for this new
thing, as "Now you have the diff to give me, show me only the ones
that involve these blobs" does not sound all that useful.



