Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76734C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiGUPFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGUPFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:05:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED54E096
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:05:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 504D71A9100;
        Thu, 21 Jul 2022 11:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w//NnfQ0JR66a55uWoY/mUdVulmJgDpEnu8cT+
        0wIeY=; b=qE3R6guiDqcvRsE/5aWH42XftN+6FhzbZR1EliA4aRelTGcjOBMbXE
        wABSGfOZ93PZigWJndHOCxfql77USZ4XiauPyUgj6OnrgyyjF1Zwia8SNQ9q+zIE
        /7L1CB5+90d9xRq55ApABoEFPyeosyHEguZexSwtpjl/Vq+YT6QpA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A0001A90FF;
        Thu, 21 Jul 2022 11:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A48F31A90FE;
        Thu, 21 Jul 2022 11:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
Date:   Thu, 21 Jul 2022 08:05:39 -0700
In-Reply-To: <xmqqilnr1hff.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Jul 2022 16:40:52 -0700")
Message-ID: <xmqq35eumrp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D95808-0906-11ED-AEBA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  * "git merge" would learn an option to recognize that the branch
>    being merged has such an empty commit at the tip, and instead
>    merge the parent of the tip of the branch into the integration
>    branch, while using the log message of the discarded tip commit
>    in the log message of the merge itself.

An issue that needs to be worked out at the Porcelain level is that
this layout will make "git branch --[no-]merged master", which is an
effective way to list what's in and what's left out of the 'master'
integration branch, more or less useless.  A topic branch with the
cover letter commit at the tip may want to be merged to 'next' and
then after cooking for a while merged down to 'master', and each
time it gets merged, the merge has to leave the cover letter commit
alone.  In spirit, such a merge commit merges the topic "fully", but
at the topological level, the topic is not (and will never be)
merged fully, and "git branch --merged next" will not show.

I guess once the topic hits the oldest integration track that it
meant to go, we could "pop" the cover letter commit out of the
topic, and at that point it would appear to have been merged to
'master' as well as to 'next'.  But it would be nice if we did not
have to discard the cover letter commit only to please "git branch".
IOW, it would be helpful to teach "git branch --[no-]merged" to
compute the "right thing" in such a layout.
