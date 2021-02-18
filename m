Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA47C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5629464EE1
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBRU00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:26:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51993 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBRU0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 15:26:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AAB01091E7;
        Thu, 18 Feb 2021 15:25:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1/nOlOwFUgXYpkECWr7n7IN0zac=; b=bZxMzR
        ixR+g0pScEjL9CvIzZNNSGAxujaytZokDnngyP75iPA6Qb/gBrDb20yJ2wdLYaMg
        IbDMPyVO0YlM5kPZx7OzCPqFYASzsgLevG3ce8LZOVL26oq30HEDfUGynbNM8Uj5
        omAa+PbLLbrPmhNwe6iSKCC6EfqzKjccVnlbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VBNWqGPM77s2C/XpAZ7QS1fER5wsyRcW
        +wbupo6V6SzqvDW4XAXYw2w+iweKatQJduQb8RSCPjtW5F8dXcbYHsNdqk5pzSS/
        UsLuDoLh/l5r6jTOrGK4H5Hnl+IFHnpR062dQeJLy0wdg+C7ijFTKCKK5xc2fCZ6
        vmrVrhSYXXs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 434F31091E6;
        Thu, 18 Feb 2021 15:25:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57AC71091E4;
        Thu, 18 Feb 2021 15:25:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
References: <20210218012100.928957-1-jonathantanmy@google.com>
        <xmqqwnv6gnuq.fsf@gitster.g>
Date:   Thu, 18 Feb 2021 12:25:23 -0800
In-Reply-To: <xmqqwnv6gnuq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        17 Feb 2021 17:34:53 -0800")
Message-ID: <xmqqy2fldsy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6ED60C8C-7227-11EB-AE40-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Any comments are welcome, especially if you have ideas about the overall
>> design or implementation, and/or if you've thought about similar things
>> before.

I think that it is a good way to prototype by adding a separate
session with the upload-pack to only learn about what is common
before talking to the receive-pack, presumably running on the same
repository and may share common view with the previous upload-pack.

And the code seems to implement the idea just fine.  I wonder how
much we can cut out the unnecessary resource usage in pathological
cases with this approach.

 - If the target ref got rewound, with the current send-pack
   approach, we may not find any common commit, or we may end up
   using a mediocre one---that would result in unnecessary packdata
   transfer, which we may be able to cut down significantly.

   I thought you guys have some server-side hacks to send a bit
   stale commit as a "fake" ref to help with this situation, though.
   So the comparison is really between how much each of these two
   approaches helps.

 - With this approach, we can cut down the initial ref advertisement
   from the receiving end to the minimum.  The protocol with
   negotiation could work correctly without receiving end
   advertising no refs, but I suspect that it would be very common
   in a publishing repository (not a shared everybody-pushes-into
   repository) that the tip of the target repository is known by the
   pusher, and it may help such a case to know where the ref being
   updated with this push originally points at.  But even in such a
   case, additional negotiation may help---the target branch may
   have not advanced, but may of the side branches the pusher have
   merged into the commit being pushed to the target branch may
   already be known by the receiver.

For a real implementation, I think we'd want to do the negotiation
inside the conversation between send-pack and receive-pack, so that
what is agreed to be common between two parties will not shift in
the middle (in the same spirit that upload-pack grabs all the
relevant refs first, advertises them, negotiates what is common and
creates a pack, all using the same worldview of where the tips of
refs are throughout the process, even if some refs change in the
meantime).

Thanks for a fun read.
