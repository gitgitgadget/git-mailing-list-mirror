Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9159E1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 04:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbfKGEh4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 23:37:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58853 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfKGEh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 23:37:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45E982FA66;
        Wed,  6 Nov 2019 23:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+VA8SSGdyvzud1SCNeJitiLeLFo=; b=PZwg6e
        kJqAAZGghe023Iktvt6bkpftb4hSxPprijaaU3PydN53/sb+/sLdo3a1AOZ+xO3K
        eFhwmG4R8vMHOC2rID+23CR4FWzXdX6wMltXyeQQfz/Xnpwe16ozIuZWtYDMqki0
        2LIQwB4Bd90G3hyTxMtjAxY7HMkjxrqFLvqVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AT6tn0Ha+JaL7XRqWqm3xzpK58y7EnBX
        tAf8M5oc4JHTfBMPXTc32oeImrG83AYID9paSKzVS4kBCk4Fb5PlJk3sF5zg9Che
        kRoJ44udMzh09QF+0zZDxae4C28xG9GvcSTmlUrrC8zvdkGH+d/jElzAh7CROPcW
        0WsrvEx7mTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D9BC2FA65;
        Wed,  6 Nov 2019 23:37:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E60A2FA63;
        Wed,  6 Nov 2019 23:37:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
        <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
        <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
        <20191106040955.GD4307@sigill.intra.peff.net>
Date:   Thu, 07 Nov 2019 13:37:52 +0900
In-Reply-To: <20191106040955.GD4307@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Nov 2019 23:09:55 -0500")
Message-ID: <xmqqpni4s3mn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CD71D9A-0118-11EA-89FE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this is OK for now, though it does make me wonder if
> "--progress" ought to perhaps override "delayed" in some instances,
> since it's a positive signal from the caller that they're interested in
> seeing progress.

I did have the same reaction after seeing the change to 5318 where
the expected output from "git commit-graph write --progress" has
become unreliable.

I think there are possibly three kinds of folks:

 - I do not want the output smudged with any progress (e.g. I am a
   script);

 - I want to see progress if it takes very long, but do not waste
   vertical screen real estate if it does not make me wait (e.g. I
   am an interactive user who occasionally wants a cue to leave the
   keyboard to grab coffee); and

 - I want to see all progress (... now who am I?  Taking a
   screenshot to write a tutorial or something???).

In the ideal world, the three choices above should probably be
"--progress=(no|auto|always)" where not having any defaults to one
of them (probably "auto", as the code can use isatty() to further
turn it to "no").

Making "--progress" to mean "--progress=always" is OK, but it leaves
no way to override an earlier --[no-]progress on the command line,
which feels somewhat satisfying.

Thanks.



