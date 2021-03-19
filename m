Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AFBC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3C161977
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 16:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCSQGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:06:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSQFp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 12:05:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD115BA42E;
        Fri, 19 Mar 2021 12:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7yfL01AoqX4iHBLH09lGknUNs60=; b=a10XPo
        Eg3+v4IZ7r4zg2/17tSNm07vzAPnOpfrTvh3bELyiLTWe8gC/O7CcJnAxVxYJZ8H
        ngHS1PZsPcuhoyTOIXnMZ+E4mtp8TPkooTOCe2B7nfTrXf9RcSRNr0RWs4aoKgA0
        PkDv+DpxZ/B8B3GDkar/lPl0yvt/JVBUntnUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xPqYYQozuaWHXxpyle65ZERs8UXSC16b
        7O4qPO8crGzP/Y+3bWsOAuZHeNhbwaDEN+6gowWH83IiBvjqUxrJoazUnFrywdVp
        8Mg2V5SJHxlQNnBORhlmUwSOO2aFvDjY92ilso6isXnrZRQUR/6mS81SxTv2a04r
        X55wIaM47Dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4D63BA42D;
        Fri, 19 Mar 2021 12:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E2C2BA42C;
        Fri, 19 Mar 2021 12:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 5/7] refresh_index(): add
 REFRESH_DONT_MARK_SPARSE_MATCHES flag
References: <cover.1615588108.git.matheus.bernardino@usp.br>
        <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
        <xmqqsg4sowks.fsf@gitster.g> <xmqqo8fgovuz.fsf@gitster.g>
        <CAHd-oW4V4_XrY7XfQO1gLEZZmzcLbG0_M2ys+Meh4Ysu0Psz0Q@mail.gmail.com>
Date:   Fri, 19 Mar 2021 09:05:43 -0700
In-Reply-To: <CAHd-oW4V4_XrY7XfQO1gLEZZmzcLbG0_M2ys+Meh4Ysu0Psz0Q@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Fri, 19 Mar 2021 09:23:03
        -0300")
Message-ID: <xmqqlfajnn6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5AD29C8-88CC-11EB-BC51-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> In other words, the change makes me wonder why we are not adding a
>> flag that says "do we or do we not want to match paths outside the
>> sparse checkout cone?", with which the seen[] would automatically
>> record the right thing.
>
> Yeah, makes sense. I didn't want to make the flag skip the sparse
> paths unconditionally (i.e. without matching them) because then we
> would also skip the ce_stage() checkings below and the later
> ce_mark_uptodate(). And I wasn't sure whether this could cause any
> unwanted side effects.
>
> But thinking more carefully about this now, unmerged paths should
> never have the SKIP_WORKTREE bit set anyway, right? What about the
> CE_UPTODATE mark, would it be safe to skip it? I'm not very familiar
> with this code, but I'll try to investigate more later.

I do not offhand know the answers to these questions you ask in the
last paragraph myself, and it could turn out to be that the "let
processing go as before, matching what those excluded paths by the
matcher, but making the caller responsible for filtering out the
paths excluded by sparcity out of the result from the matcher, but
tweak seen[]" approach, however ugly, is the most practical, after
your investigation.  But I'd prefer to see how bad the situation is
first ;-).

Thanks.
