Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B0FC6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 16:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCPQYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjCPQYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 12:24:20 -0400
X-Greylist: delayed 280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 09:24:12 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269631E2C
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:24:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A3A01824AE;
        Thu, 16 Mar 2023 12:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VzRZjz7sYB1GjD11UEe52aaRmA+WetWCLKil+M
        mSC8Y=; b=xYs1iumI1Y/p3SOJGc0RJsdTB+rtwvGX7MDpkC1/tFGBSMuC3vDKhi
        0tf8t3KGDgpY/Xo+CYCt0XDazIvKfHogR1nF8jRUjGiKUbsLcVzuJ1ZNFuzS/V1h
        pEru6LpcKyrcVL3HfwwEAiwqV1p9ZPtyUybGewlWo0bDQ4AZimRk8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E931824AD;
        Thu, 16 Mar 2023 12:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.92.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89AE71824AB;
        Thu, 16 Mar 2023 12:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] fetch: move reference width calculation into
 `display_state`
In-Reply-To: <ZBMwUmBhqEd74YAx@ncase> (Patrick Steinhardt's message of "Thu,
        16 Mar 2023 16:05:54 +0100")
References: <cover.1678878623.git.ps@pks.im>
        <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
        <xmqqedppohno.fsf@gitster.g> <ZBMwUmBhqEd74YAx@ncase>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Thu, 16 Mar 2023 09:19:10 -0700
Message-ID: <xmqqmt4cmzy9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4942EC22-C416-11ED-90D0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> Given that in the previous step, what used to be called display got
>> renamed to display_buffer (I think "buffer" ought to be sufficient
>> in this context, though), the variable of "struct display_state"
>> type should NOT be named "display", as it would be confusing when
>> two things are related to "display" and only one of them is called
>> as such.  Either "display_state" or "state" would be fine.
>
> Fair enough. In that case I may just as well drop the first patch.

If you plan to get rid of an independent "display_buffer" in the
endgame by moving it into the bigger struct as its .buffer member,
then I think the naming is fine as there will remain only one thing
that is "display".  The fact that I didn't see that plan through
when I read only the first two patches would probably mean that the
route this iteration of the series took was somewhat roundabout, and
there may be a more transparent and possibly a more direct way to
get to that goal?

I am not entirely sure if the buffer should go inside the
display_state structure in the endgame.  An alternative may be to
make it a on-stack variable of format_display() (which will later be
modified to do everything up to and including writing out the
result) and pass it through the callchain below to its helpers, just
like the current code already does.  And in such an approach, you'd
still need to name that variable passed to the helper functions
called by format_display()---"buffer" would be a good name for that.

Just thinking aloud.

Thanks.

