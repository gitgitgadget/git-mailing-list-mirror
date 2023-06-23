Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BE7C001B0
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFWU57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFWU54 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 16:57:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744102135
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:57:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37068191349;
        Fri, 23 Jun 2023 16:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w72bU91mtobgMoZuvZ1udwIinETAkfpV1gC8WD
        TEI/4=; b=PkybrR+FGU0SeblJB7UE7qQROEGgQlpd72oqXTw8vrHGGpRmNUOMx3
        1UWSP2a9p94SpkJXSKDsuY59+Rp2f5B1tH4nIw0h7AJGCjqe2mPFsY+6m0cwoxYP
        Le3A1DqX5TmYWBnqBlliyeqvhOG013qycgfSS2PiipIzpPMODtOQA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 302A3191348;
        Fri, 23 Jun 2023 16:57:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9586F191347;
        Fri, 23 Jun 2023 16:57:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
        <ZJRBsDq8NI9EInel@nand.local> <ZJRDZ7NhyNpTV8jD@nand.local>
        <941CCF5B-1FE6-46BE-9ED7-77C11E943E2E@gmail.com>
Date:   Fri, 23 Jun 2023 13:57:50 -0700
In-Reply-To: <941CCF5B-1FE6-46BE-9ED7-77C11E943E2E@gmail.com> (John Cai's
        message of "Fri, 23 Jun 2023 15:16:52 -0400")
Message-ID: <xmqqo7l5aoc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E1482D4-1208-11EE-B175-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

>>> After reading this description, I am not sure why you can't "include" a
>>> reference that would otherwise be excluded by passing the rules:
>>>
>>>   - refs/heads/exclude/*
>>>   - !refs/heads/exclude/but/include/me
>>>
>>> (where the '!' prefix in the last rule is what brings back the included
>>> reference).
>>>
>>> But let's read on and see if there is something that I'm missing.
>>
>> Having read this series in detail, I am puzzled. I don't think that
>> there is any limitation of the existing reference hiding rules that
>> wouldn't permit what you're trying to do by adding the list of
>> references you want to include at the end of the exclude list, so long
>> as they are each prefixed with the magic "!" sentinel.
>
> To be honest, I had no idea "!" would have this effect--so thanks for bringing
> it to my attention.

FWIW, "--exclude=!" gets zero hits in t/ directory.

ref_excluded() merely calls wildmatch() like so:

        int ref_excluded(const struct ref_exclusions *exclusions, const char *path)
        {
                const char *stripped_path = strip_namespace(path);
                struct string_list_item *item;

                for_each_string_list_item(item, &exclusions->excluded_refs) {
                        if (!wildmatch(item->string, path, 0))
                                return 1;
                }

                if (ref_is_hidden(stripped_path, path, &exclusions->hidden_refs))
                        return 1;

                return 0;
        }

so I do not know what to think about it.  This is called from inside
callback of things like "log --exclude=A --exclude=B ... --all" when
we are trying to add all refs in response to "--all", and it appears
to me that the first match would already determine the ref's fate
without even looking at the later patterns (prefixed with bang '!'
or not).  Taylor, am I looking at a wrong code?

Puzzled...

