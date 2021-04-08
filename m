Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D1C43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5958610E6
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhDHNXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:23:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65198 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:23:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 588E612C7C9;
        Thu,  8 Apr 2021 09:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4/28D5Yu5A3vafkP7/aYM3g+pZE=; b=kAsdrJ4KifOCwEN8Eb7c
        YyIYJef75Sy8pVP9xZwfHejkIbgMGR9sN1CLoACguupF54bvxDRUbvZahYj6lV6Z
        y66y7nkdt55bqHecAkNN4PGe09dyfR43rOHSR9sd68UtBYOMHN+GAB1d1CSheHH+
        gKE1Mv6zWpaGqEquilaZWjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=k5NuPafMVyr3srTTG8WZ3RLlbE3beztIejYVDsEVv/ffrk
        tU0PALaQyeR7qI6F8jY01407Z5DTumNlqKho741Kl391uOL/2fhWrL87RzXO01md
        thvmcdO9kzXZFjdP15Ju5FvT9r//PWQZb9pjX1j8+Pt0JRcS1Q2t4yt9wxiJI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51B4D12C7C8;
        Thu,  8 Apr 2021 09:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29FAF12C7C7;
        Thu,  8 Apr 2021 09:23:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] cache-tree.c: remove implicit dependency on
 the_repository
References: <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
        <pull.915.v4.git.1617778489719.gitgitgadget@gmail.com>
        <xmqqsg41wvdi.fsf@gitster.g>
        <0df415b7-73b7-6e72-1885-3ca606acf8fd@gmail.com>
Date:   Thu, 08 Apr 2021 06:23:05 -0700
Message-ID: <xmqqmtu8vrk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E572660-986D-11EB-89C7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chinmoy Chakraborty <chinmoy12c@gmail.com> writes:

> Is it safe to make this assumption?

It was the question I asked, and I didn't see a reason to believe it
is safe.

> I mean to be completely sure of this, one would have to track back
> to all the callers.

Yes.  If we audit the callers to make sure istate->repo always
points at the right repository, add missing assignment to
istate->repo as necessary, and add

	if (!istate->repo)
		BUG("caller of cache_tree_udpate() did not fill istate->repo");

then that would be an improvement.  But...

> Should a check like:
>
>     if(!istate->repo)
>
>         istate->repo = the_repository;
>
> be required?

... if we add such an "if the caller did not set istate->repo,
assume the_repository" code, then the resulting code explicitly
assumes that the istate the caller passed to us without setting
istate->repo belongs to the default repository.

I do not quite see the point of such a change---it is not all that
better than "implicit dependency on the_repository" the patch tries
to address, is it?

