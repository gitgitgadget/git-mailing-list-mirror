Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002F820986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbcJDVSF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:18:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65264 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754212AbcJDVSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:18:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D594D432C6;
        Tue,  4 Oct 2016 17:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h7vtR3n5l7nSPC+0/pCN+PYc/cM=; b=wyixpu
        82sch/iOOEQChixrkJs69IWjcYC/8CjaFfFuogM4QMH8QlSHO5l0GgOq8VPb+A86
        hu3N2CBbG/ukvtmKgYN0xwyFRp3uqSiiBHeZ56LhuM14wkcsABTCX9RmaoRZhByl
        BFYQQ04l1bIVR8vOSi6M+lfpO0dKq97ChL21U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RSDdbMy0e3qeEcaivE9JQR6LZKsIMQjS
        sKlRZF+NcNoGq/f/9t6nPcCAS+gIosCVRJg32YvFVY+P3cT3XG/fA1HknC4SEPYJ
        Vkpy0K7iZm3yrUDm7s4v/ycv3jxwhl9QC4lLG5Q2knUhw8yp6J918vKMaFBbi/5s
        OF3yKFc9rTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E74432C5;
        Tue,  4 Oct 2016 17:18:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30DA3432C0;
        Tue,  4 Oct 2016 17:18:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 08/18] link_alt_odb_entry: refactor string handling
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 14:18:01 -0700
In-Reply-To: <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 16:34:48 -0400")
Message-ID: <xmqqoa2zstiu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08F1B434-8A78-11E6-8556-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The string handling in link_alt_odb_entry() is mostly an
> artifact of the original version, which took the path as a
> ptr/len combo, and did not have a NUL-terminated string
> until we created one in the alternate_object_database
> struct.  But since 5bdf0a8 (sha1_file: normalize alt_odb
> path before comparing and storing, 2011-09-07), the first
> thing we do is put the path into a strbuf, which gives us
> some easy opportunities for cleanup.
>
> In particular:
>
>   - we call strlen(pathbuf.buf), which is silly; we can look
>     at pathbuf.len.
>
>   - even though we have a strbuf, we don't maintain its
>     "len" field when chomping extra slashes from the
>     end, and instead keep a separate "pfxlen" variable. We
>     can fix this and then drop "pfxlen" entirely.
>
>   - we don't check whether the path is usable until after we
>     allocate the new struct, making extra cleanup work for
>     ourselves. Since we have a NUL-terminated string, we can
>     bump the "is it usable" checks higher in the function.
>     While we're at it, we can move that logic to its own
>     helper, which makes the flow of link_alt_odb_entry()
>     easier to follow.

Also I find that this bit is a nice touch:

>  	/* recursively add alternates */
> -	read_info_alternates(ent->base, depth + 1);
> -
> -	ent->base[pfxlen] = '/';
> +	read_info_alternates(pathbuf.buf, depth + 1);

We used to leave ent->base[] string terminated with NUL while
calling read_info_alternates() and then added '/' after that, but
because the new code uses a separate pathbuf for the call, ent->base[]
can be prepared into the desired shape upfront.

Much easier to follow.

