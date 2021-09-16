Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D1FC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03ADE6113A
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhIPVQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:16:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60503 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhIPVQi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:16:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43590D85BA;
        Thu, 16 Sep 2021 17:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oQ0hyg9s+YsxxWm6jsYKnF0wtZSr99zz64AUkx
        Txrjk=; b=deIkYNMzK2JU9LSCIKpUcYZPQEYacoLH99BrFzd22SP7L1C6/cCSFy
        CKvSAg9DZfgmDHD5hGPVbLZ3JdzibfuWkfYem0OgWwEFn78ZnEDFxCyR1olfCgra
        MbqFjrubTf7/DE7F0cudiZvR3SqaUfTjDpwNSPf/QZrVljmQgcP4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A042D85B9;
        Thu, 16 Sep 2021 17:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABFCAD85B7;
        Thu, 16 Sep 2021 17:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
Date:   Thu, 16 Sep 2021 14:15:16 -0700
In-Reply-To: <87sfy497ed.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        16 Sep 2021 12:50:02 +0300")
Message-ID: <xmqqy27wrzmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3090FA5C-1733-11EC-9AAA-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I'm afraid this issue is left up in the air after application of the
> fix-up patch, as usage of --cc in the diff-index is still undocumented.

Yeah, I do think documentation update is needed, but being buried by
other topics I haven't had a chance to revisit the way how --cc is
described in the wider context in order to make an intellgent
suggestion on how to present it in the context of "diff-index".

> I.e., the fix-up just restores the historical status quo that has a
> problem by itself.

I do agree "show -p" on merge is an oddball that trips new people,
because it does not imply the "do present the changes for merges"
bit unlike "show -c/--cc" do, and from that point of view, the
generalization --diff-merges tried to bring us was a good thing.

But "-c/--cc" are explicit enough in what they want to do.  It does
want to present the changes to compare a single end state with
possibly more than one starting state (e.g. a merge) and not
requiring an explicit "-m" is quite natural.  Even more, when it
compares the end state with only one starting state (e.g. showing a
single parent commit), there is only one pairwise result to
"combine", so it is also natural that it ends up showing the same
output as "-p".  So I do not quite see the behaviour of "diff*/show
--cc" as a problem, though.  IOW, the use pattern in gitk is more
than just "historical status quo", but is quite sensible, I would
have to say.

Thanks.
