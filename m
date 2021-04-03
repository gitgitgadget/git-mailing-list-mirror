Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D4DC433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 04:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C74611ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 04:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhDCE0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 00:26:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61484 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhDCE0J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 00:26:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8AAA1319B8;
        Sat,  3 Apr 2021 00:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aGrs8U63kdmIYUzlvl+0i0NxzSg=; b=LlEUKV
        wq36ELFFaSNVZmhIA3m3xiDOmQhl1EK5vDyZsJaKbYU2+60piI6ve3UPrV7iSnob
        Ina2b/VqNHaahAAJtTPX29gm8Jw8RLkFSpNhONhWGZR+75ngPh02G2q6vcRlNzX/
        8CXK7TuNrHvCNpGZH74TNUKUiz3Sa96NLGv9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K+nor8njhmvEm3aInD12k7zmxEzDDWIm
        7jhcdOxPtaEXB+LpD0Q+5KVNsQyM6yGqxLkQMB6OZc+FPhkjF0ILCUyWYSkKrUU3
        G+vqvm41yWPnsu1uG6mTwyVCOBmQ2lVecogdKO75oYhkNnDqUT2ueYUWnP6R9ujJ
        GQhQC4lMALA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0EBD1319B7;
        Sat,  3 Apr 2021 00:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 037111319B6;
        Sat,  3 Apr 2021 00:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jerry Zhang <jerry@skydio.com>,
        Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        abe@skydio.com, brian.kubisiask@skydio.com,
        Jerry Zhang <jerryxzha@googlemail.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way
 options
References: <20210403013410.32064-1-jerry@skydio.com>
        <20210403013410.32064-2-jerry@skydio.com>
        <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
Date:   Fri, 02 Apr 2021 21:26:00 -0700
In-Reply-To: <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 2 Apr 2021 20:46:44 -0700")
Message-ID: <xmqqy2e00zaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B32E5A68-9434-11EB-AC0A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm not that familiar with apply.c, but let me attempt to take a look...

I am (well, at least I was the one who invented 3way and added the
"index" line to the diff output format) ;-)

> scenarios.  If I'm right, the current implementation is problematic at
> least if not the idea of using these options together.

Yes, the conflicted case cannot sanely be handled _without_ leaving
higher stage entries in the index, and that is exactly why I made it
incompatible with the "--cached" mode.

It might be OK to only allow the combination when everything auto
resolves cleanly and fail the operation without touching either the
index or the working tree.  Pretending there was no delete/modify
conflicts or adding contents with unresolved conflicts as if nothing
bad happened as stage 0 entries would never be acceptable.

Perhaps

 * Error out if the index does not match HEAD.

 * Try applying to the contents in the index.  If there are any
   structural conflicts, leave these paths at higher stage and do
   not touch their contents.

 * For paths without structural conflict but need content merges,
   attempt ll-merge of the contents.  If autoresolves cleanly,
   register the result at stage 0.  Otherwise, discard the failed
   conflicted merge, and leave stages 1, 2 and 3 as they are.

 * Exit with status 0 if and only if everything has resolved
   cleanly.  Otherwise, exit with non-zero status.

would be the minimally-acceptably-safe behaviour.


