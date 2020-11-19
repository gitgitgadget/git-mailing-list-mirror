Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B956C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AD422242
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 21:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LodSneeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgKSVcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:32:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60794 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSVcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 16:32:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBFD6116493;
        Thu, 19 Nov 2020 16:32:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Hml9x5Gu2XWIKKeShI4aDCdefo=; b=LodSne
        eX33l60/0vYvQynB9jw8Erl2O6xC7+ax7bUUGhchUeDQLWkM9QCpxtGKY5AWmNW+
        dPVFS/AaZ3eZhE6AXVQ/Ibg9B4PlCmJ5guIKfnkwfE707d7q/tqj8xTufDEt/LsS
        aiIm63yd3CL4+UpU1e8W3njU3FE52p/axZ5Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uLc6EV/TLhqOkJ1DdtIGjE3+064oO0fK
        6BvldobWlZ3ezSGzwZ5sIS/qLRIs8J1LcCkq532NrzdAss7BohvYzjlx22TkKkNk
        5UsQq6mQ6v5oyzeW2hE+5SSvq08CHu5tzcNOiqsVnqXyCN5MOxU2ddssBcRm9AFc
        jWi/cjrl9Mk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E45DE116492;
        Thu, 19 Nov 2020 16:32:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 05BC1116491;
        Thu, 19 Nov 2020 16:32:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related
 hooks
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
        <pull.790.v4.git.1605819390.gitgitgadget@gmail.com>
        <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
        <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
Date:   Thu, 19 Nov 2020 13:32:09 -0800
In-Reply-To: <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 19 Nov 2020 16:23:11 -0500")
Message-ID: <xmqqwnyhvxra.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AECEC376-2AAE-11EB-BDE4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Rather than making such a fundamental change and having to deal with
> the fallout by introducing complexity to handle various special-cases
> which pop up now and in the future, I wonder if it makes more sense to
> instead just update documentation to tell hook authors to read
> explicitly from the console rather than expecting stdin to be
> available (since stdin may already be consumed for other purposes when
> dealing with hooks or commands which invoke the hooks).

;-)

Thanks for saying this.
