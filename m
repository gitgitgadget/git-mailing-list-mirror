Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B922082D
	for <e@80x24.org>; Fri,  8 Sep 2017 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756313AbdIHRPz (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 13:15:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62289 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756227AbdIHRPy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 13:15:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DE889FD4F;
        Fri,  8 Sep 2017 13:15:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MxU5WIcFxWDMwTl9VVitKo+SE9I=; b=ozR5+8
        rSbRHXoqhB87/jIZXUBNS/GKU2CEMucYQeFNtfTID6ZgU3s58i9hnmKvIttT/wCK
        DVeWShyayHjr0PqvWtmWc12NiNEgNcUBeYZR0gBBllcjgQcck8yYcfzCZdemFeXh
        /uXgUwEPjmHIJAN1tBMrkB2k41f/xbTVSuI1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TKdz6ZWxHK/b+BWogGFhTmIWYQwU/QJM
        R+wjuRV7NBlsdwXcDuRpUJaZPDEZufVe7+Luby7SNsSEgTsNXhelXDHajnRej8mi
        Of3pJY7JpHy+OKdjiQsHujhryy20MJoqdrrVhqYERVwe8XS6NJE9eEBFI7kAZ9z7
        DXo20HcrSsY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73C579FD4E;
        Fri,  8 Sep 2017 13:15:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C50949FD4C;
        Fri,  8 Sep 2017 13:15:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH] refs: make sure we never pass NULL to hashcpy
References: <20170904200504.15249-1-t.gummerer@gmail.com>
        <xmqqh8wgaa7s.fsf@gitster.mtv.corp.google.com>
        <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
        <xmqqvaku10gj.fsf@gitster.mtv.corp.google.com>
        <ab0c4064-6eaa-c298-a26d-58fc83e4574f@alum.mit.edu>
Date:   Sat, 09 Sep 2017 02:15:51 +0900
In-Reply-To: <ab0c4064-6eaa-c298-a26d-58fc83e4574f@alum.mit.edu> (Michael
        Haggerty's message of "Fri, 8 Sep 2017 17:08:17 +0200")
Message-ID: <xmqqfubxyuuw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E31A1EC-94B9-11E7-8052-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> So `ref_transaction_update()` *does* need to set or clear the `HAVE_NEW`
> and `HAVE_OLD` bits as I sketched, to impedance-match between the two
> conventions.

OK, so ignoring HAVE_NEW/HAVE_OLD bits that the callers of
ref_transaction_update() may set in flags, and having
ref_transaction_update() compute these bits based on new/old_sha1
pointers from scratch, would be the right thing to do.

IOW

	flags &= ~(REF_HAVE_NEW|REF_HAVE_OLD);
	if (new_sha1)
		flags |= REF_HAVE_NEW;
	if (old_sha1)
		flags |= REF_HAVE_OLD;

and your earlier "Does the warning go away if you change the line
to" does essentially the same thing.

> It's a shame how much time we've wasted discussing this. Maybe the code
> is trying to be too clever/efficient and needs a rethink.

It might be the case, but I do not know what to blame is "the two
conventions", an over-eager compiler, or a confused commenter on the
thread (that's me), though ;-).
