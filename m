Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D3C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F8864DD1
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhA1Fuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 00:50:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58184 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhA1Fuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 00:50:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1DB511FF20;
        Thu, 28 Jan 2021 00:50:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LMlVeBDMVSz23QvLYZS5n/Z2fkQ=; b=tLnT+Y
        5STYw+daVLkW/LJRAgh9GwMzLyk8Id62XfaP/vt2GrtBj/s4U54/JJdD3NZPcbI5
        IXx1+XcYZjkAfJa+mPKpFw44F9uvtm0PUvLJzjWcO+8yr6N6AY8ZLpYv1P4BE/1e
        J0OxgcThCOENQMSKNzA/5bdQ59/UuNtY/YGvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kNIiB8vOUIgMd0tB2m1+zf4X2/ZriARZ
        cfmMyBqSRIHxEE7J1qfyCg1ttPrZIghVw+V9EpC2zkYwBTL038CHjb9Moi2KMPbY
        PYSGcp2wXfqFRk+/W7SP5n+TY/r3Ye9x1ZwJBQyPtniqpqfLMLhrPBB556f1/rpG
        2oWY7fFmrjs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA9D411FF1F;
        Thu, 28 Jan 2021 00:50:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2ADB711FF1E;
        Thu, 28 Jan 2021 00:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] clone: respect remote unborn HEAD
References: <YAnr8lBESOO+ACL/@coredump.intra.peff.net>
        <20210126182212.2337587-1-jonathantanmy@google.com>
        <YBCf8SI3fK+rDyox@coredump.intra.peff.net>
Date:   Wed, 27 Jan 2021 21:50:05 -0800
In-Reply-To: <YBCf8SI3fK+rDyox@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Jan 2021 18:04:17 -0500")
Message-ID: <xmqqeei5y5iq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACE20578-612C-11EB-9978-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Afterwards, we
> call it for the unborn HEAD (which I can buy is necessary) but _also_
> for that regular path. I.e., why is the new code not:
>
>   if (unborn_head_target && ...) {
>           ref = unborn_head_target;
> 	  unborn_head_target = NULL;
> 	  create_symref("HEAD", ref, "");
>   } else {
>           branch = git_default_branch_name();
> 	  ref = xstrfmt("refs/heads/%s", branch);
>   }
>
> I.e., I don't understand:
>
>   - why create_symref() wasn't need before (assuming it was not), and
>     why it is OK to run it now in the non-unborn code path
>
>   - why we need create_symref() in the unborn path (which is probably
>     something mundane)
>
> I can even buy the argument that it is simply for consistency, so that
> all of the HEAD-setup commands are shared between the two paths. And
> that it is OK to do so, because we are just overwriting what init-db did
> before (even if sometimes it is the same thing). But I feel like that
> deserves explanation in the commit message. :)

Yes, during yesterday's communication glitch, I also independently
was wondering about this and am dying to know if this is an
unrelated "fix", applicable even without the "unborn" support, or
breaking the non "unborn" side of the codepath.

Thanks.
