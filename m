Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7591FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbcLFVXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:23:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54885 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750953AbcLFVXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:23:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A22FD54408;
        Tue,  6 Dec 2016 16:23:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T1ZCX8C8zbeTjUFjuqdtbosaWWU=; b=Lki8O0
        gT7riXJuM2H/bHgpeRIZbiqRfwPAqcNBuVXBUTIs7sWCvEZRjZkQswjFi4r9lG9q
        SLy8gKPsj1XSRQt/zTtgnnbg321EmypP5oQ+z32gCn7XYYL35aX9G+BMzGrX6E/x
        2LkfGWCEszdrkPR9DcqOgFu6Z0ATITWwkMbsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tVFUhgbUKEoLDRKkpwqjLSh7NM1G42SW
        tSaJQr6FBRKsuj+kcQGd9s9XQGQcHUAsClCADdC546+qYHmiStFOYHHQwXKQraqG
        FLL+EvQ5zintqYUjsATVYWNoRISCUH/g2r5lRAKXgubjdsLKHQKNRJDLHQ8y7Mhl
        g8O2x0RSwSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98FEE54407;
        Tue,  6 Dec 2016 16:23:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06CBF54404;
        Tue,  6 Dec 2016 16:23:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] xdiff: Do not enable XDL_FAST_HASH by default
References: <alpine.DEB.2.10.1611302310240.20145@buzzword-bingo.mit.edu>
        <20161201045243.mlr7wqvkbm2yd37m@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 13:23:11 -0800
In-Reply-To: <20161201045243.mlr7wqvkbm2yd37m@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 30 Nov 2016 23:52:43 -0500")
Message-ID: <xmqqh96gzr9c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31A45B26-BBFA-11E6-B50B-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a nice incremental step in the sense that people can still
> enable it if they want to in order to time it, play with it, etc. But
> given what we know, I wonder if the help text here should warn people.
>
> Or I guess we could move straight to dropping it entirely.
>
> Here's what that patch might look like (I retimed it just be sure, and
> was sad to see that it really _is_ making some cases faster. But I still
> think slower-but-predictable is a better default).

I like this version that drops quite a lot of code ;-)

> Subject: [PATCH] xdiff: drop XDL_FAST_HASH
> ...
> The idea of XDL_FAST_HASH is to speed up the hash
> computation. But the generated hashes have worse collision
> behavior. This means that in some cases it speeds diffs up
> (running "git log -p" on git.git improves by ~8% with it),
> but in others it can slow things down. One pathological case
> saw over a 100x slowdown[1].
>
> There may be a better hash function that covers both
> properties, but in the meantime we are better off with the
> original hash. It's slightly slower in the common case, but
> it has fewer surprising pathological cases.
>
> [1] http://public-inbox.org/git/20141222041944.GA441@peff.net/
