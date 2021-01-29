Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B368CC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A98864DF1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhA2XD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:03:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61309 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhA2XDx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:03:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6C66108C13;
        Fri, 29 Jan 2021 18:03:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1M8B1SvrCjpaJJtvktiweZWSD1w=; b=ePc+BF
        dKCcPj/JXIqGS08U1WoaMljqXtElfTeMF2EWvLg07wT9M0JEInIm1vvMbNWOYRBB
        SAAu810cSWvLYfOrU0MSMI8v3Hz30oX0dJdXZ01g/kuCt/e3ErYGAyvFiWNdoT/f
        rEMkkKsc9lq2Wo+Tjwor/LrTbJ+94CcITmrZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L6fVnPzorjak5JZGymeS80e0QbQP2X8E
        ng6KN06VE4ORzCrzwcGkFWEtXf4uvItMk5Lns9ZMJGaJrA1gFaG7erBKO/kPavw5
        OPg57DxtPOhXy+e7sGZJDjKCdYEDNssY85XHv/A4bw7CTE22pxDH80BZLOaebuVD
        XyFItHl/V+g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF5FE108C12;
        Fri, 29 Jan 2021 18:03:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B315108C11;
        Fri, 29 Jan 2021 18:03:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
References: <cover.1611098616.git.me@ttaylorr.com>
        <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
        <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
        <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
        <YBRprCmIX4IrHAi0@nand.local>
        <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
        <YBSHzG9T72nYYVt4@nand.local>
Date:   Fri, 29 Jan 2021 15:03:08 -0800
In-Reply-To: <YBSHzG9T72nYYVt4@nand.local> (Taylor Blau's message of "Fri, 29
        Jan 2021 17:10:20 -0500")
Message-ID: <xmqqh7mzs5w3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 280168C0-6286-11EB-BBD5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> So, I think that teaching pack-objects a way to understand a caller that
> says "include objects from packs X, Y, and Z, but not if they appear in
> packs A, B, or C, and also pull in any loose objects" is the best way
> forward here.

Are our goals still include that the resulting packfile has good
delta compression and object locality?  Reachability traversal
discovers which commit comes close to which other commits to help
pack-objects to arrange the resulting pack so that objects that
appear close together in history appears close together.  It also
gives each object a pathname hint to help group objects of the same
type (either blobs or trees) with like-paths together for better
deltification.

Without reachability traversal, I would imagine that it would become
quite important to keep the order in which objects appear in the
original pack, and existing delta chain, as much as possible, or
we'd be seeing a horribly inefficient pack like fast-import would
produce.

Thanks.
