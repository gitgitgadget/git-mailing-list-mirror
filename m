Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23957C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0955A60F58
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 16:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhHEQRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:17:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55056 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhHEQRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 12:17:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3303E61FB;
        Thu,  5 Aug 2021 12:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2VkOZFeuzs5jPXZceRXHccO1u7I53viN/FwtcS
        kwhcI=; b=F6dQCsJgkonKKZKyK9GG5pC9zyKa0p1FSD1zP2k7fteHczR3aax0eY
        mN6nw5YP9oEHhyhUNF6duDL1UebiL8GKiEYToB/h10buarmrS+O5Y1rEduGw0vdu
        y/fnJwrDic+xpNAC+WRBOdUD4AvFqGsa7+sSGOVyiIftIOdzjGXFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E81B4E61FA;
        Thu,  5 Aug 2021 12:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 677B2E61F9;
        Thu,  5 Aug 2021 12:16:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 4/4] revision: avoid hitting packfiles when commits
 are in commit-graph
References: <cover.1624858240.git.ps@pks.im> <cover.1627896460.git.ps@pks.im>
        <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
        <xmqqwnp3vcow.fsf@gitster.g> <YQkJdDvRtyOPzszU@ncase>
        <xmqqmtpytcny.fsf@gitster.g> <YQvFGuf3Ba/5UNXk@ncase>
Date:   Thu, 05 Aug 2021 09:16:52 -0700
In-Reply-To: <YQvFGuf3Ba/5UNXk@ncase> (Patrick Steinhardt's message of "Thu, 5
        Aug 2021 13:01:46 +0200")
Message-ID: <xmqqy29flvd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C07BE76-F608-11EB-BA87-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 03, 2021 at 02:56:49PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > I wonder what our stance on this is. I can definitely understand the
>> > angle that this would be a deal breaker given that we now claim commits
>> > exist which don't anymore.
>> 
>> An optimization that produces a wrong result very fast is a useless
>> optimization that has no place in our codebase.  But don't we have
>> some clue recorded in the commit graph file that tells us with what
>> packfile the graph is to be used (iow, if the named packfile still
>> exists there, the objects recorded in the graph file are to be found
>> there) or something?
>
> Unfortunately, no. For bitmaps we have this information given that a
> bitmap is tied to a specific pack anyway. But for commit-graphs, the
> story is different given that they don't really care about the packs per
> se, but only about the commits.

[jc: refreshed Cc: list to limit to those in "shortlog commit-graph.[ch]"]

On this subject, I'd ask those who have worked on the commit-graph
for ideas.  It would be a glaring flaw _if_ the data structure that
is designed to be a "cache of precomputed summary that would help
runtime performance" has no way to detect out-of-date cache and/or
to invalidate when it goes stale, but I somehow doubt that is the
case, given the caliber of folks who have worked in it.  To me, it
feels a lot more likely that we may be missing an existing mechanism
to do so.  It could be that ...

> We can do the following on top though:
>
> diff --git a/revision.c b/revision.c
> index 3527ef3f65..9e62de20ab 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -368,6 +368,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  				object = NULL;
>  				goto out;
>  			}
> +		} else if (!repo_has_object_file(revs->repo, oid)) {
> +			die("bad object %s", name);
>  		}
>  	}
>
> We assert that the object exists, but `repo_has_object_file()` won't try
> to unpack the object header given that we request no info about the
> object. And because the object ID has been part of the commit-graph, we
> know that it's a commit. It's a bit slower compared to the version where
> we don't assert object existence, but still a lot faster compared to
> looking up the object type via the ODB.

... the above is the designed way to correctly use the commit-graph
data?  That is, you find an object in the commit-graph, and you make
sure the object exists in the object store in some other means
(because there is no mechanism for commit-graph to prevent a gc from
pruning an object recorded in it away) before you consider you can
use the object.

Thoughts and help?

Thanks.
