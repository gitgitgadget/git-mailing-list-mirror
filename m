Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD22C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353002064B
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xXTBasNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLTT2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:28:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54544 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfLTT2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 14:28:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D4E899AF3;
        Fri, 20 Dec 2019 14:28:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZR68AwvhwZHI8upjbSmOwnQqNeQ=; b=xXTBas
        NiIF9oIwq4LroKOBhggW7kKsCTKGdfRi0hSAmIVUQTTVb+UKZpKa6N3vymQ5uE/D
        rMrrv73VYJWyDeIqEH79xtBzq8FcRwMK1F1UUuplKt5qI1172uO28MI4zdDo+scu
        u3d/2rXWtRwE6hqjk50fBzNjgIICoFEGRMKVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gi2atHk9ch6PeEZzYekOxI4tTIChyAAw
        EKDsvZAAT6Tmxa/6lIts7CnIjUDsKlAf6pvK+kTyisYBWNxZWHvkzbq/ybkKdAo7
        B3XVTqmvwIIRweAY3hliVF09iQU7h7s9I2ukO4kGNOUpl+Nq4DQ3Jldkn0NRzFkC
        F032e6+xCXY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 051CF99AF2;
        Fri, 20 Dec 2019 14:28:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA45499AF0;
        Fri, 20 Dec 2019 14:28:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        plroskin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] am: pay attention to user-defined context size
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
        <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 11:28:02 -0800
In-Reply-To: <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 20 Dec 2019
        18:53:55 +0000")
Message-ID: <xmqqwoaq94ql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8256EF8-235E-11EA-982B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> am previously only checked gpg-related config options and the default
> config options while ignoring any diff-related options.  This meant that
> when users tried to set diff.context to something larger than the
> default value of 3, it was ignored.  Pay attention to the diff settings
> too.

Can the benefit brought in by this change demonstrated by a new test
or two?


Puzzled.  "am" accepts whatever patch somebody else prepared and
has no control over how the incoming "diff" was produced by that
somebody else.  

Besides, I do not think it should be affected by any diff_*UI*_config()
in the first place.
