Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3241FC47247
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA2206B8
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uTpRPNAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgEHPJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:09:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57591 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHPJL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:09:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96C64DF7F1;
        Fri,  8 May 2020 11:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WKJmpanbm2XR6CZKXsjDQYYPyQw=; b=uTpRPN
        Ai657nTgIvnEfdRxCOUcPfJPR9U3xFOgurYfdPY2JHkZvvNy532W6XCCVIx6R9tK
        LTG8Vllr86/QANhZ7qN88eCrmgWDHSq8cDYP+DAkMNBVxmcnmPyqN2R75twuEbk2
        oJcvVeECZvgfGbWOyU8FqYzDfQOLQx550H5vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H9GY+rtsAkbk2ygmledGiOMnfwBCrUKH
        Fv25pHrjsiAx+nQEN4XI5c4iv0Qyt68jz6htHefuLMeikmZT4tGjO63rooKX5a0U
        dSnewHXJxVWpCQ/Pqz/KlsVizjO1fasx49e6MRiDC7k9GaMDyhonxUcQKGTXi1LI
        0x4HpgczdqY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E304DF7F0;
        Fri,  8 May 2020 11:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 362F8DF7EE;
        Fri,  8 May 2020 11:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmaill.com, peff@peff.net,
        me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/10] unpack-trees: avoid array out-of-bounds error
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
        <5bfe3f3fc8a99b3d4fdd4286da17cd935090c614.1588857462.git.gitgitgadget@gmail.com>
        <xmqqk11n2xf3.fsf@gitster.c.googlers.com>
        <63dce1f7-3dbd-1540-c6e5-547962555f57@gmail.com>
Date:   Fri, 08 May 2020 08:09:04 -0700
In-Reply-To: <63dce1f7-3dbd-1540-c6e5-547962555f57@gmail.com> (Derrick
        Stolee's message of "Fri, 8 May 2020 08:19:35 -0400")
Message-ID: <xmqqd07e1n1r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC3F723E-913D-11EA-8E77-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> As I mentioned in the cover letter, this is worth taking on its own. Could
> you queue the collaborative patch? I'll eject it from the next version of
> this series. 

Yes, I think this is worth taking independently.

I do not think people would find the updated version "much better",
but it made it readable at least to me.

Thanks.
