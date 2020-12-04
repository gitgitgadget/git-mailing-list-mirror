Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AA4C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE4922A85
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgLDUIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:08:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64134 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLDUIm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:08:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D9B310E201;
        Fri,  4 Dec 2020 15:08:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1nUxZN2B3gR0xqx85vey1FdfvwQ=; b=iLOWie
        ksgJC4fVJbXgIgT52I0n/KOOBRsSlmIjiyHVekwG2qu9tlHIb0Y63CQI11XUhCxt
        NL4MEBI6+ABkQ25uYboPKLcTEvs/g532zW2h2HvmG9J4cj7ct6TvquStFT8TSKpD
        +qBw2qfkOLNsKq36+riIcW7ciLdnizKKlwoP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SVUkmT7nid5Rw5rOrrpaO3933RYuXs3I
        d6zbPLsFaO2sZ/DbjWgILUr9aUqFWVK651Rzt1nSNbHPhh6Ug6ViUtb182eS0RFl
        CFOUvV52BjUu7RrbBP3yk0lRmzOWbhJ9LozCPliXYchR7Kc4JZFEYpHV9Hf4K5VZ
        nno6x0CFL9Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 960E010E200;
        Fri,  4 Dec 2020 15:08:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DFB0710E1FD;
        Fri,  4 Dec 2020 15:07:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sofia Syria <sofiasyria@gmail.com>, git@vger.kernel.org
Subject: Re: diff-filter can't identify renaming if not done directly
References: <CAOsoBv7ors39UzVgq5VcqEwoaEbkXb5ApEf5NqW4bo_fymdruQ@mail.gmail.com>
        <X8pmURHeWcNLwmvs@coredump.intra.peff.net>
Date:   Fri, 04 Dec 2020 12:07:56 -0800
In-Reply-To: <X8pmURHeWcNLwmvs@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 4 Dec 2020 11:39:45 -0500")
Message-ID: <xmqqh7p1e3mr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 671DC792-366C-11EB-9D2D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 04, 2020 at 03:59:03PM +0100, Sofia Syria wrote:
>
>> quick question about using diff-filter in linux. In the scenario
>> that in my repository, I first copy file1 to file2, then move file2 to
>> file3 and delete file1, "git diff" returns:
>> 
>> diff --git a/file1 b/file3
>> similarity index 100%
>> rename from file1
>> rename to file3
>> 
>>  but running "git diff --diff-filter=r" doesn't return anything. Only
>> flag "t" will return the change. Can this be considered as a bug?
>
> Lowercase filters exclude particular types. From "git help diff":
>
>     --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
> 	   Select only files that are Added (A), Copied (C), Deleted
> 	   (D), Modified (M), Renamed (R), have their type (i.e. regular
> 	   file, symlink, submodule, ...) changed (T), are Unmerged (U),
> 	   are Unknown (X), or have had their pairing Broken (B). Any
> 	   combination of the filter characters (including none) can be
> 	   used. When * (All-or-none) is added to the combination, all
> 	   paths are selected if there is any file that matches other
> 	   criteria in the comparison; if there is no file that matches
> 	   other criteria, nothing is selected.
>
> 	   Also, these upper-case letters can be downcased to exclude.
> 	   E.g. --diff-filter=ad excludes added and deleted paths.
>
> So "--diff-filter=R" asks to see only renames. But "--diff-filter=r"
> asks to exclude them. And "--diff-filter=t" excludes typechanges, which
> means that renames are still OK. Doing "--diff-filter=a", etc, would
> still show it as well.

Correct.  I should have scanned my inbox to find that the same
question was asked twice and one of the copies already got a good
answer.

