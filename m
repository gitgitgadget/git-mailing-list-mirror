Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563EC1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 17:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbcLPRUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 12:20:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63196 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751014AbcLPRUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 12:20:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AF125688C;
        Fri, 16 Dec 2016 12:20:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UVQXiZvwPEdVCyRlatBlyFnEvg0=; b=OqGTSG
        EjabOrZs2CTohAuNfhhV8xUR/yBWaRsFi8DBmVDQy3RlTv2wIuxBsRNhe04tv9/K
        CkKIHpuyFAeQLpT12YsLnNcosXLGZFAzfonmF1Q8T6StGW9R+knEp94bcbH+WVEg
        FVb2+eJq5lWWDvu1DKv1g3k6d3Ke3qCKOe/28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LV7BL3K4qpJRgZvdyjqBo4oYxfUSd13o
        TKFf8k/KjwHi5VVIGARpeCYgEun4BzxK+E/On72Cno0voNn237xD717DhGMhLuUE
        dJa1M0C3YfQhlGTJgTVlK5s95jK1P2BhUjKgrJ3exe8WgeedRVbnyDW1x69avwjB
        Nxh3MhJRRnY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 225405688B;
        Fri, 16 Dec 2016 12:20:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CF855688A;
        Fri, 16 Dec 2016 12:20:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Races on ref .lock files?
References: <20161216164751.GA12174@inner.h.apk.li>
Date:   Fri, 16 Dec 2016 09:20:07 -0800
In-Reply-To: <20161216164751.GA12174@inner.h.apk.li> (Andreas Krey's message
        of "Fri, 16 Dec 2016 17:47:51 +0100")
Message-ID: <xmqqpokru6yg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4CD0B9C-C3B3-11E6-8426-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Krey <a.krey@gmx.de> writes:

> We're occasionally seeing a lot of 
>
>   error: cannot lock ref 'stash-refs/pull-requests/18978/to': Unable to create '/opt/apps/..../repositories/68/stash-refs/pull-requests/18978/to.lock': File exists.
>
> from the server side with fetches as well as pushes. (Bitbucket server.)
>
> What I find strange is that neither the fetches nor the pushes even
> touch these refs (but the bitbucket triggers underneath might).
>
> But my question is whether there are race conditions that can cause
> such messages in regular operation - they continue with 'If no other git
> process is currently running, this probably means a git process crashed
> in this repository earlier.' which indicates some level of anticipation.

I think (and I think you also think) these messages come from the
Bitbucket side, not your "git push" (or "git fetch").  Not having
seen Bitbucket's sources, I can only guess, but assuming that its
pull-request is triggered from their Web frontend like GitHub's
does, it is quite possible when you try to "push" into (or "fetch"
from, for that matter) a repository, somebody is clicking a button
to create that ref.  We do not know what their "receive-pack" that
responds to your "git push" (or "upload-pack" for "git fetch") does
when there are locked refs.  I'd naively think that unless you are
pushing to that ref you showed an error message for, the receiving
end shouldn't care if the ref is being written by somebody else, but
who knows ;-) They may have their own reasons wanting to lock that
ref that we think would be irrelevant for the operation, causing
errors.



