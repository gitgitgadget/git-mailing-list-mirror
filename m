Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E947C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 03:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B9B64DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 03:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhA2DLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:11:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60302 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhA2DLA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 22:11:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59986B6EB0;
        Thu, 28 Jan 2021 22:10:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wdJCLz6KBkRQXCYSP6dmcGz29BA=; b=QL0mGy
        doq+VFJLcoomfWJ8v5UB0BvqwcJ5pbCezWyIncmd+JUleyDI32hvMmrqy+UA0cOC
        mTOZKHF2vRxHS875fQdk+GExj5QSbAd8FgzCwpT2ZZ57sOTaHMoUTmOsZZXlz9kb
        3MCBSyQ7a69QXLg4wQB/m5QJWiTXu5nGmZvyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WXMitk5MzBG0JlwpUgFyc8KdbSCE0/c6
        mU/HJB2wlkGIlGPbc/HkQWtJr0xL/47xzVa2D1GSMpSZZXxUZ7TqVt0PGhUsyaAf
        EwNs7cnYFeuHU45ZrHHAPEIA2uhHQFFA5wlnoz8xVjKhVo7O3ETGSrzadoBWbAYD
        LaMAuN2PVlM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A556B6EAE;
        Thu, 28 Jan 2021 22:10:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61756B6EAC;
        Thu, 28 Jan 2021 22:10:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 02/10] revision: learn '--no-kept-objects'
References: <cover.1611098616.git.me@ttaylorr.com>
        <4184529648abe7451b5c7b772493df8c067cec82.1611098616.git.me@ttaylorr.com>
Date:   Thu, 28 Jan 2021 19:10:04 -0800
In-Reply-To: <4184529648abe7451b5c7b772493df8c067cec82.1611098616.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 19 Jan 2021 18:24:05 -0500")
Message-ID: <xmqqo8h8tp4j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C31FCFE-61DF-11EB-8C76-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Some callers want to perform a reachability traversal that terminates
> when an object is found in a kept pack. The closest existing option is
> '--honor-pack-keep', but this isn't quite what we want. Instead of
> halting the traversal midway through, a full traversal is always
> performed, and the results are only trimmed afterwords.

True.  

Is there a reason to keep both kinds?  It is obvious that stopping
traversal once we hit a kept pack would be more time and space
efficient (I presume that the reason why .kept pack matters is
because we are repacking everything else) to enumerate the objects
that need to be repacked than traversing all the way and filtering
out objects that appear in .kept packs, but would there be some
correctness implications to replace the existing use of
"--honor-pack-keep" with "--no-kept-objects=on-disk"?  

What it means to be excluded by the former is quite clear: any
object that appears in a kept pack, whether another copy of it
appears elsewhere, is excluded from getting enumerated for
repacking.  It is quite unclear what it means to enumerate objects
with "--no-kept-objects".  It is clear from the implementation side
of the thing (stop traversal at objects that appear in any kept
pack), but it is totally unclear what such a meaning defined
operationally affects the resulting enumeration.  We know that the
enumerated objects do not appear in any of the kept pack, but it
does not mean all objects that are reachable/in-use that are not in
any kept packs are enumerated.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 002379056a..817419d552 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -856,6 +856,13 @@ ifdef::git-rev-list[]
>  	Only useful with `--objects`; print the object IDs that are not
>  	in packs.
>  
> +--no-kept-objects[=<kind>]::
> +	Halts the traversal as soon as an object in a kept pack is
> +	found. If `<kind>` is `on-disk`, only packs with a corresponding
> +	`*.keep` file are ignored. If `<kind>` is `in-core`, only packs
> +	with their in-core kept state set are ignored. Otherwise, both
> +	kinds of kept packs are ignored.

Is it explained anywhere how "in-core kept state" is bootstrapped,
modified and maintained?

The patch to C-part itself is a trivially correct implementation of
"stop at an object that can be found in a kept pack", and there is
no comment, but it is not clear to me what we want to achieve by
this.  Is the underlying assumption that no objects in .kept pack
would refer to outside world, either loose or packs that are not
kept?  How are we guaranteeing it?

