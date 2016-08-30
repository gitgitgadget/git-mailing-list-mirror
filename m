Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7F81F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 16:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758371AbcH3QyZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:54:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63775 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758348AbcH3QyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 12:54:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7132A39E6C;
        Tue, 30 Aug 2016 12:54:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ABsZ9lxKzy9x7jLR0LeB0DsxLqk=; b=nzltB3
        IGcjPPmlpdWBX5ZcfkV4Ov8E952AbHzvd9er9lRgSPmn9+yQLXesE88YcPGHdg+7
        NAOx2IB8Ge9aWKVAlve/oagWGvtir/LGv84XXXnHgsXafpYSZt6ixe1oTZlx6YjP
        SBzxIm4kNSFt3CXVf7Gj88ME5EUPDuq3LNWBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fM7g+ofsljHadx3hegU861f71rySrvzg
        LlSi2uc/QVpdVUbQNJAPi8fQmIc1IwX7bfJ2UXLeeur0lvw0byn56RiDBh58hJMr
        3JjtFX5Oiwxc/52relXPaGSC0X9j26vVDHHDPlWYF9fjotzPHYccOX0kfOSNjzmN
        bw+XS2mRUlo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A05939E6B;
        Tue, 30 Aug 2016 12:54:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E541039E6A;
        Tue, 30 Aug 2016 12:54:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git am and duplicate signatures
References: <1472573556.5512.93.camel@perches.com>
Date:   Tue, 30 Aug 2016 09:54:16 -0700
In-Reply-To: <1472573556.5512.93.camel@perches.com> (Joe Perches's message of
        "Tue, 30 Aug 2016 09:12:36 -0700")
Message-ID: <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647DD9E8-6ED2-11E6-AAFB-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> git-am -s will avoid duplicating the last signature
> in a patch.
>
> But given a developer creates a patch, send it around for
> acks/other signoffs, collects signatures and then does
> a git am -s on a different branch, this sort of sign-off
> chain is possible:
>
> 	Signed-off-by: Original Developer <od@domain.com>
> 	Acked-by: Random Developer <rd@domain.com>
> 	Signed-off-by: Original Developer <od@domain.com>

Both correct and allowing the earlier one duplicated as long as
there is somebody/something else in between is deliberate.

> Should there be an option to avoid duplicate signatures
> in a sequence where an author can git-am the same patch?

I dunno.  The way "Signed-off-by" is handled is designed
specifically to support the meaning of that footer, namely to record
where it originated and whose hands it passed, used in the kernel
and Git land.  Other projects certainly may have need for footers
that denote different things that want different semantics (e.g. Who
authored it and who cheered on it), but that is outside the scope of
the "Signed-off-by" supported by "am -s" and "commit -s".

Support for more generic footers was supposed to come when the
"interpret-trailers" topic started, but the author of the topic
seems to have lost interest before the mechanism has become ready to
be integrated in the workflow commands like "am", "commit", "rebase"
etc., which is unfortunate.

> sequencer.c:append_signoff() has a flag for APPEND_SIGNOFF_DEDUP

Yes, I think this is one of the warts we talked about getting rid of
but haven't got around to it.  It is there because "format-patch -s"
was incorrectly written to dedup Signed-off-by: from anywhere in its
early implementation and to keep the same behaviour.  We should drop
that flag from append_signoff() function.
