Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB18E81813
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 02:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjIZCuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIZCub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 22:50:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D17127
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 19:50:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 809E61BBB90;
        Mon, 25 Sep 2023 22:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=aq3GBY8KfMZb+xqnhATT1pMSso1KqO3y5ZNVln
        LmLXU=; b=IPZrUU3zkSmHyrDZwZX9gqCzY7kd7YJxliFRaCI170UsIFk3BXdKIx
        KmsFsgtOBd/oqxGvoA2L9FH7XxAZ8baa+zFN2tjTMZKOPuF/TUJsZUwPbbXIhK8e
        Ov2Zm57bubYL6r3UDURxvKRjyHNcyObU/eJ9UrgwjQ7lM9rwiCMkc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76DE61BBB8F;
        Mon, 25 Sep 2023 22:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1D561BBB8D;
        Mon, 25 Sep 2023 22:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
In-Reply-To: <87ttrudkw9.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        16 Sep 2023 21:37:42 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g> <87y1h8wbpo.fsf@osv.gnss.ru>
        <xmqqzg1nfixw.fsf@gitster.g> <87ttrudkw9.fsf@osv.gnss.ru>
Date:   Mon, 25 Sep 2023 19:50:22 -0700
Message-ID: <xmqqjzsdps0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70A2FAB6-5C17-11EE-9ADC-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> P.S. I also figure that maybe our divergence comes from the fact that I
> consider merge commits to be primarily commits (introducing particular
> set of changes, and then having reference to the source of the changes),
> whereas you consider them primarily merges (joining two histories, and
> then maybe some artificial changes that make merges "evil"). That's why
> we often end up agreeing to disagree, as both these points of view seem
> pretty valid.

It rarely is the case that two opposing world views are equally
valid, though.

If there were an option that forbids any comparison output from a
single parent commit (say --ndfnm "no-diff-for-non-merge"), then
those with "merges are the primary thing, single-parent commits on
the merged branches are implementation details" worldview would be
commonly using "--diff-merges=first-parent --patch --ndfnm" and (1)
viewing only the combined effect of merging side branches without
seeing noise from individual commits whose effects are already shown
in these merges, and (2) traversing the side branches as well, so
that merges from side-side branches into the side branches are
viewable the same way as merges into the mainline.

But because no such option exists and nobody asked for such an
option during the whole lifetime of the project, I highly doubt
that it is a valid world view with wide backing from the users.

Even if it were a valid world view with wide backing, the
combination "--diff-merges=first-parent --patch" would be less than
ideal presentation for them (due to lack of "--ndfnm").  And as I
already said, it would not be useful without --first-parent
traversal for the worldview git has supported.

That is why I find it of dubious value to let short-and-sweet '-d'
be squatted by less than ideal "--diff-merges=first-parent --patch"
combination.  Shorthands are scarse resources, and we want to be
careful before handing them out.

Thanks.


