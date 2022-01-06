Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F16C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 23:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiAFXlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:41:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54590 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245583AbiAFXlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 18:41:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 693AA16656A;
        Thu,  6 Jan 2022 18:41:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v1EeomDEHb3qYXTVapC2I/2UnsViuKsnDSoGYZ
        iLftg=; b=PpKQ3t+Ec/VVAJIiRdne1yxfpyHGEAfps+b4cYnCfwctSCu5bpxegU
        in44W3g/74CH1je+HE68MYeO1f7/dsxhtv94sxjyt7p8c4ybkZEDJ35+9EC7GCHi
        nU+PWtH9Y3aPJLb3Gf1atIxkePRs8SmBSdAu5nFTB1johwgAZvIJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 625E7166569;
        Thu,  6 Jan 2022 18:41:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE57B166567;
        Thu,  6 Jan 2022 18:41:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for
 CHERI/Arm's Morello
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
        <xmqqczl4bhmo.fsf@gitster.g>
        <BE9D3BD5-EC19-4881-872D-CEB4039A382D@jrtc27.com>
Date:   Thu, 06 Jan 2022 15:41:00 -0800
In-Reply-To: <BE9D3BD5-EC19-4881-872D-CEB4039A382D@jrtc27.com> (Jessica
        Clarke's message of "Thu, 6 Jan 2022 23:02:23 +0000")
Message-ID: <xmqqwnjca0vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B572502-6F4A-11EC-B508-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

>> I actually wonder if it results in code that is much easier to
>> follow if we did:
>> 
>> * Introduce an "enum apply_symlink_treatment" that has
>>   APPLY_SYMLINK_GOES_AWAY and APPLY_SYMLINK_IN_RESULT as its
>>   possible values;
>> 
>> * Make register_symlink_changes() and check_symlink_changes()
>>   work with "enum apply_symlink_treatment";
>> 
>> * (optional) stop using string_list() to store the symlink_changes;
>>   use strintmap and use strintmap_set() and strintmap_get() to
>>   access its entries, so that the ugly implementation detail
>>   (i.e. "the container type we use only has a (void *) field to
>>   store caller-supplied data, so we cast an integer and a pointer
>>   back and forth") can be safely hidden.
>
> Those would be better if you want a less-minimal change.

The first two at least would make an understandable change, as
opposed to the code as posted, which is totally opaque why we need
to take size_t and cast it to uintptr_t in the first place.

I have no confidence in myself that I would not accept a future
patch that reverts the change made by this patch happily.  I usually
try to be careful to go back to the originating commit by running
"blame" on the preimage and may find your commit, but that's only
"usually".  If I were to work only with the file contents after
applying this patch, because no clue ...

	ent->util = (void *)((uintptr_t)what | ((uintptr_t)ent->util));

... on this line of code hints why we must be called with size_t and
have to cast it here, instead of working with uintptr_t throughout,
I am reasonably sure I'd happily take such a patch and break your
"fix" here.

If we make the code pass around the enum, have a temporary variable
of the same enum type to compute the next value we stuff in
ent->util, and make an assignment of that enum value to ent->util,
it is much less likely that I'd blindly accept a patch to take us
back to deal with uintptr_t directly.
