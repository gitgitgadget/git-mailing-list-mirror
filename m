Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B90AC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D080D20735
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iedP9Mhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgKEUzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:55:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58383 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKEUzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 15:55:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1D9AF9A86;
        Thu,  5 Nov 2020 15:55:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rzdFUGaYknqZSpv6ZOjMXR9lkcE=; b=iedP9M
        hkEKG7HQb9599laN52srlyVuFi93loa7yWyo2iGfeZ5bCW/nfrfID1/w6FYXFtV1
        HJLOxoShvM7hP0vZf9c2hM172BMux+bTDGpSkLyCnsq51/yt5QK6ZOJyMJ1c42Bf
        JYX+nNGcIYdAecdutuPgD9l8K8WsUx/n4k8Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vcRZaoEw2gp9P7ZPvy4KxbAuN/+zVypv
        fsdIRpiKdHd0Lky1EDdyABqvzvYk11ZZy31L8VHLIxzFXfLqwLkGe7MY7RZkgTrn
        Gf75HDPTZS6srprLnVhSUl5kTsZLoQCdpIgXsY49CIF+CmSUiE/mdT1CsMo1I4PT
        jD18fThByks=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA5FEF9A83;
        Thu,  5 Nov 2020 15:55:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01844F9A82;
        Thu,  5 Nov 2020 15:55:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: range-diff should suppress context-only changes?
References: <20201105133437.GC91972@coredump.intra.peff.net>
Date:   Thu, 05 Nov 2020 12:55:09 -0800
In-Reply-To: <20201105133437.GC91972@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Nov 2020 08:34:37 -0500")
Message-ID: <xmqqmtzvikwi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3262B276-1FA9-11EB-B97B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 05, 2020 at 12:22:32AM +0000, Elijah Newren via GitGitGadget wrote:
>
>> Range-diff vs v3:
>> [...]
>>   7:  42633b8d03 !  7:  5e8004c728 strmap: add more utility functions
>>      @@ strmap.h: void *strmap_get(struct strmap *map, const char *str);
>>       + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
>>       + */
>>       +#define strmap_for_each_entry(mystrmap, iter, var)	\
>>      -+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
>>      -+		var; \
>>      -+		var = hashmap_iter_next_entry_offset(iter, 0))
>>      ++	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
>>       +
>>        #endif /* STRMAP_H */
>>   8:  ea942eb803 =  8:  fd96e9fc8d strmap: enable faster clearing and reusing of strmaps
>>   9:  c1d2172171 !  9:  f499934f54 strmap: add functions facilitating use as a string->int map
>> [...]
>>       @@ strmap.h: static inline int strmap_empty(struct strmap *map)
>>      - 		var; \
>>      - 		var = hashmap_iter_next_entry_offset(iter, 0))
>>      + #define strmap_for_each_entry(mystrmap, iter, var)	\
>>      + 	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
>>        
>>       +
>>       +/*
>>      @@ strmap.h: static inline int strmap_empty(struct strmap *map)
>
> Definitely not a problem with your patches, but I noticed this curiosity
> in the range-diff. Patch 7 changes the definition of the macro, but it
> gets mentioned again in patch 9, even though the code wasn't touched.
> The issue is that it the change from 7 ends up in the context of 9; the
> actual modification in patch 9 is in those final couple lines touching a
> comment (and they didn't change at all between the two versions).
>
> I wonder if it would be reasonable to suppress range-diff hunks in which
> all of the changed lines are context lines.

Sounds like a reasonable thing to do.  As we know the shape of what
is compared in the outer diff we should be able to accurately notice
where hunk boundaries are and a hunk whose change is only on context
lines.

