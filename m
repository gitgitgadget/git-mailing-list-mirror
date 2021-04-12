Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C5C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD98561356
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhDLRrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:47:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56477 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbhDLRrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:47:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E881137CA8;
        Mon, 12 Apr 2021 13:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VMNLsaS/W/wNnmFToQ1pkJMT2iA=; b=sLFaKb
        JoDNdUNcw1mlGUqSYJ/eJ3bHFHE2a1yheJGj1MppIGzgPVXJ764+Si8pDDiQepnF
        PqOTOCCmzjiVkkzJUWoAFxUx6dUqc6IY6QXFIAzZgiEStfUkMnBkbA1ws7M50tDO
        a/niT5P6E0xomVvWPLR22h5fqRno/ZERn++Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rAbbZRyGlJlWWNSgEfL80xLjagNVWVbw
        X1iCJvVwyUkJ1/3ac/PO/JNbWWWdgN5QsKswOfqXq68HVxZ6tUsmgEZTNBTeZ+PJ
        pYCrEZnLTM3LaKXUFDcBe2J39YamTgMTjz4K2lh25WfyX6BM3lrz0A0X4l+6XhSr
        icFfqFI2kKw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 188BA137CA7;
        Mon, 12 Apr 2021 13:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C0AE137CA4;
        Mon, 12 Apr 2021 13:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2] merge-ort: only do pointer arithmetic for non-empty
 lists
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
        <pull.930.v2.git.1618139107203.gitgitgadget@gmail.com>
        <CABPp-BE2D933Bc6w-OeaJc1r+1_tvMeK2M-HK4eEKPkQb3BdQQ@mail.gmail.com>
Date:   Mon, 12 Apr 2021 10:47:19 -0700
In-Reply-To: <CABPp-BE2D933Bc6w-OeaJc1r+1_tvMeK2M-HK4eEKPkQb3BdQQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Apr 2021 08:52:14 -0700")
Message-ID: <xmqqo8eje6oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21D66AC6-9BB7-11EB-A8CE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>         /* Pre-allocate some space in buf */
>>         extra = hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL char */
>>
>> base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
>> --
>> gitgitgadget
>
> Otherwise, this patch looks good to me; thanks!

By the way, I noticed the post-context comment and got curious.

	/* Pre-allocate some space in buf */
	extra = hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL char */
	for (i = 0; i < nr; i++) {
		maxlen += strlen(versions->items[offset+i].string) + extra;
	}
	strbuf_grow(&buf, maxlen);

Because "6 for mode" is wrong if it means "%06o", but the format
used in the code is "%o" so there is no correctness issues in the
code (Phew).  This "grow" is to avoid having to repeatedly
reallocate "nr" times in the loop that comes, but

 (1) s/6 for mode/up to 6 for mode/ to make it less misleading.

 (2) does this preallocation really help performance?

 (3) it is really disturbing to find a custom tree-writing code that
     is exercised only by ort here.  Tree-writing has been one major
     source of broken objects in various reimplementation of Git---
     all known ones made a mistake sometime in the past---and I'd
     strongly prefer to see a single helper that formats a tree
     object, given a set of <mode, object name, path> in the longer
     code health.



