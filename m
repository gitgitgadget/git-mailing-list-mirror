Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEFCC20951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdCNWDj (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:03:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60283 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbdCNWDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:03:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B893725A3;
        Tue, 14 Mar 2017 18:03:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tr1ZAFiFBmnGmmlBRxhnV1U4CU0=; b=qDx7JG
        hZ5gBDP5528coGmxQxdJDVNEYqyilv4nWDbE8O5qH7kLtEgBnUgh3opQdwxzfBgr
        XA+Ynq1rZKDo76pdE55wHZFf++0kBSC6VfxOGGiNlpoVyqaREZeEZl2hXn4Uujf6
        Hwvyski7ktWz4+hxM1rKTrwGfK82Lr+ll4YPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pBI46AIkqMqSGzHppSFLavpjQ97qug+b
        MoMG0JKAIZ2B15BBdIG9+w6vbbMVjmySnEk1bJZwNh7EnKo7yE0RazLn5IkeTlfM
        hSYg56jCwdsWhXVRgEg61rko/+GTlGPNxEy8zqHYXTr06t4J62l/eJ0c1N1rRigf
        moMrWd9NDXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74B88725A1;
        Tue, 14 Mar 2017 18:03:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D70DC725A0;
        Tue, 14 Mar 2017 18:03:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
        Mislav =?utf-8?Q?Marohni=C4=87?= <mislav.marohnic@gmail.com>
Subject: Re: [PATCH] add--interactive: do not expand pathspecs with ls-files
References: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
Date:   Tue, 14 Mar 2017 15:03:34 -0700
In-Reply-To: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Mar 2017 12:30:24 -0400")
Message-ID: <xmqqd1djh5xl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1240FFC8-0902-11E7-AE90-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We can improve this by skipping "ls-files" completely, and
> just feeding the original pathspecs to the diff commands.
> This solution was discussed in 2010:
>
>   http://public-inbox.org/git/20100105041438.GB12574@coredump.intra.peff.net/
>
> but at the time the diff code's pathspecs were more
> primitive than those used by ls-files (e.g., they did not
> support globs). Making the change would have caused a
> user-visible regression, so we didn't.

Heh.  The change and the reasoning are both obviously correct, but
how did you find this?  Do you have a pile of "old patches that
should be resurrected when time is right" and this was picked out of
it, or did you see somebody else hit the same thing recently and
then went back to the archive?

>   b. If the repository contains filenames with literal wildcard
>      characters (e.g., "foo*"), the original code expanded
>      them via "ls-files" and then fed those wildcard names
>      to "diff-index", which would have treated them as
>      wildcards. This was a bug, which is now fixed (though
>      unless you really go through some contortions with
>      ":(literal)", it's likely that your original pathspec
>      would match whatever the accidentally-expanded wildcard
>      would anyway).
>
>      So this takes us one step closer to working correctly
>      with files whose names contain wildcard characters, but
>      it's likely that others remain (e.g., if "git add -i"
>      feeds the selected paths to "git add").

We didn't run with --literal-pathspecs which was a bug, but I
suspect that it didn't exist back then ;-).
