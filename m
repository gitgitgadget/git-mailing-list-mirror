Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9230C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A55660FD8
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhDKUWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:22:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51598 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKUWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 16:22:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CFEA813085F;
        Sun, 11 Apr 2021 16:22:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fJO9XQxrqdbIhl+p7zg7JijDuM0=; b=sqxpoD
        xCuP8L+2C7IFutKtm69t2NVJSfjZmEOWsc7EUuLm34MoCIHlLVUzeupI396VYtcR
        BtCbKs4uUuf2Si1cSCfQFZuL3tmX8QEaIdhLQjvtFFsx52Tmq2P9AoIbZRxYCwRI
        AFAy55lHUVFvWke2WBPDRNyrYEzonavEKuQWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fsZm43ruz0CTQ62omaZiEn2w2uq1m448
        0El+fYdY2nZnM1GcJTFAOpGADrhdZCs4HAf4+r/qysNzSMDX9PO3zv91Vlb0kBvk
        bd2IGbCaDvon6i6qkSgrDaeIprFwNAzWEZd0a8yTM7vq5rw9Qp0tC02jDUX++ihP
        xGoDVbuvb3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8B7013085E;
        Sun, 11 Apr 2021 16:22:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1BD0B13085C;
        Sun, 11 Apr 2021 16:22:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 2/4] bisect--helper: reimplement
 `bisect_visualize()`shell function in C
References: <20210411095538.34129-1-mirucam@gmail.com>
        <20210411095538.34129-3-mirucam@gmail.com>
Date:   Sun, 11 Apr 2021 13:22:27 -0700
In-Reply-To: <20210411095538.34129-3-mirucam@gmail.com> (Miriam Rubio's
        message of "Sun, 11 Apr 2021 11:55:36 +0200")
Message-ID: <xmqq35vwh8qk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3445028-9B03-11EB-B6A1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> +	strvec_pushl(&args, "--bisect", "--", NULL);
> +
> +	strbuf_read_file(&sb, git_path_bisect_names(), 0);
> +	sq_dequote_to_strvec(sb.buf, &args);
> +	strbuf_release(&sb);

Even though it is textually not all that different, this part
changed the behaviour (hopefully in a good way) quite a bit from the
previous round.  It would make a big difference when an element in
the pathspec has shell specials.

I suspect that the reason why you didn't notice the breakage before
submitting the previous round (v2) is because of a gap in the test
coverage.  Can we add a test, or tweak an existing one?  I think a
file with a space in its name would be sufficient to demonstrate the
breakage in v2 and its fix in this round around "split" (in v2) vs
"dequote" (in v3).  A file whose name begins with a dash would
demonstrate the bug that would arise due to lack of "--".

Thanks.
