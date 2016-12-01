Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61EF01FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760182AbcLAUOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:14:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756676AbcLAUOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:14:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33FC253837;
        Thu,  1 Dec 2016 15:14:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uwa3DJwtaVSl7v+FTOJiw1JETc0=; b=vHjXR9
        GK/tOSzSXYr9kfP6hvgtkw50F3vMEAwEp5gtLubJFVxSkgb6hZD/ruVRGlqqZDoV
        t9EEt4GdJIk67YpgxhBQ53CGM+4yxXrG6LQ8tjPr5yPlq8hqD0Z0VYA3NN1HxCZw
        rQXvjALbYKwJGGKzqgmfzburd4cNTfrNsF80c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oO5HnCis6LCG2DH/NYnA62hO420RA2S7
        CAzDAOYLhP6oit8ABurpzWfm9g7LTKVE8HbI4zgEUTZSLmWBEoTEfh/Smhz+wnde
        lvrM2NHGK9q6cQkhKtwPu7qjv/Ozi2za/f9v13Jsc7h7598kqJFOTRqkiIonvbLJ
        9220U4zLVyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 282A053836;
        Thu,  1 Dec 2016 15:14:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9060053835;
        Thu,  1 Dec 2016 15:14:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
        <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
        <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 12:14:42 -0800
In-Reply-To: <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 14:35:56 -0500")
Message-ID: <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC295BF2-B802-11E6-A554-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To make matters more fun, apparently[1] there are multiple variants of
> qsort_r with different argument orders. _And_ apparently Microsoft
> defines qsort_s, but it's not quite the same thing. But all of that can
> be dealt with by having more specific flags (HAVE_GNU_QSORT_R, etc).
>
> It just seems like we should be able to do a better job of using the
> system qsort in many cases.

If we were to go that route, perhaps we shouldn't have HAVE_QSORT_S
so that Microsoft folks won't define it by mistake (instead perhaps
call it HAVE_ISO_QSORT_S or something).

I like your suggestion in general.  The body of git_qsort_s() on
systems without ISO_QSORT_S can do 

 - GNU qsort_r() without any change in the parameters, 

 - Microsoft qsort_s() with parameter reordered, or 

 - Apple/BSD qsort_r() with parameter reordered.

and that would cover the major platforms.

Eh, wait.  BSD and Microsoft have paramters reordered in the
callback comparison function.  I suspect that would not fly very
well.

