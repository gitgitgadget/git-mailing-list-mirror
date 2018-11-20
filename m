Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FB61F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 05:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbeKTQ0s (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:26:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57725 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeKTQ0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:26:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE49E1265EF;
        Tue, 20 Nov 2018 00:59:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sGiUd7+eObnneJ7zlwr6tJRbOSQ=; b=n6vwt2
        baX0n0//7WBNpSOOrO4VmJx9YMF1ay3+7u4E/cQ/22JDo+GxqEezBCuQE6DoxSdW
        5E+RbD0aLyXhPVnH6qmPdULO30+iuuQE3PfZq6LulBdA+4fYTBP9e1xAOSAofk4P
        cES9NOybCG0hIIR/u+VieuQcxY/ZQZ8c+Dxvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q/iWyPYfQKUNjNXBgOWnBmQjI6B1a2tA
        hJ7nJIRUyTR0APsReMz18verHjpR/hhg4HD6tEtEZpWSC2zteMbax+r8yKxzbdlD
        BbsxTjSlo5MgcMdztJhcB8HZUIso0lxKrrzJgD6dCoNTSis++ZycY0cHCqSK03lG
        nQUeEl48yPo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A724B1265EE;
        Tue, 20 Nov 2018 00:59:27 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19C321265ED;
        Tue, 20 Nov 2018 00:59:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: allow showing specific trailers
References: <20181104152232.20671-1-anders@0x63.nu>
        <20181118114427.1397-1-anders@0x63.nu>
        <20181118114427.1397-3-anders@0x63.nu>
Date:   Tue, 20 Nov 2018 14:59:25 +0900
In-Reply-To: <20181118114427.1397-3-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 18 Nov 2018 12:44:24 +0100")
Message-ID: <xmqqy39o9tmq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7029367A-EC89-11E8-BCE4-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> +  followed by a colon and zero or more comma-separated options:
> +  ** 'only': omit non-trailer lines from the trailer block.
> +  ** 'unfold': make it behave as if interpret-trailer's `--unfold`
> +     option was given.
> +  ** 'key=<K>': only show trailers with specified key. Matching is
> +     done case-insensitively and trailing colon is optional. If option
> +     is given multiple times only last one is used.

It would be good to allow multiple keys, as

	%(trailers:key=signed-off-by,key=helped-by)

and

	%(trailers:key=signed-off-by)%(trailers:key=helped-by)

would mean quite a different thing.  The former can preserve the
order of these sign-offs and helped-bys in the original, while the
latter would have to show all the sign-offs before showing the
helped-bys, and I am not convinced if the latter is the only valid
use case.

Also, use of 'key=' automatically turns on 'only' as described, and
I tend to agree that it would a convenient default mode (i.e. when
picking certain trailers only with this mechanism, it is likely that
the user is willing to use %(subject) etc. to fill in what was lost
by the implicit use of 'only'), but at the same time, it makes me
wonder if we need to have a way to countermand an 'only' (or
'unfold' for that matter) that was given earlier, e.g.

	%(trailers:key=signed-off-by,only=no)

Thanks.
