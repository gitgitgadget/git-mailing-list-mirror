Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0823E1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbdAZSvb (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:51:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62817 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752201AbdAZSvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:51:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03C4F6202B;
        Thu, 26 Jan 2017 13:51:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2WDsM5Snkg/colIsJKKbz4YaZKo=; b=CDn851
        pquHL9dcbP0dPXBxxquFp2Ne20zeK8su+I0jXV1veAUWLRjt466uJv/Qer53q11w
        Qaa9fSbQyN91VHNk05Pm1Yk3qx8sKvJOTgMbO602pljxOUUvMwqMWEbQBvRoRKds
        QWwW18/vGQTP0uURjq21QmZHcejTf7ZumFmUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nui1SxralPMtvH7PWkjNbglU8o1IfH9N
        ZusOgNydRDdPKG6JCgaooBSxiXyvTN+rNs+ePNAqYutlYltjmatg3mWv9OMyqZoa
        hQpBO8I05Jhj6w5OIcFG05fCHEt/jTriD6DJkdd0S21m7TFqY7AaC1bkZjJXrvTi
        pBdjFZrZqdk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F05C46202A;
        Thu, 26 Jan 2017 13:51:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6E8F62027;
        Thu, 26 Jan 2017 13:51:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fsck: lazily load types under --connectivity-only
References: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
        <20170126041206.5qfv7r7czbwfqvaa@sigill.intra.peff.net>
Date:   Thu, 26 Jan 2017 10:51:00 -0800
In-Reply-To: <20170126041206.5qfv7r7czbwfqvaa@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 23:12:07 -0500")
Message-ID: <xmqqziid4puz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62293408-E3F8-11E6-AF72-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The recent fixes to "fsck --connectivity-only" load all of
> the objects with their correct types. This keeps the
> connectivity-only code path close to the regular one, but it
> also introduces some unnecessary inefficiency. While getting
> the type of an object is cheap compared to actually opening
> and parsing the object (as the non-connectivity-only case
> would do), it's still not free.
>
> For reachable non-blob objects, we end up having to parse
> them later anyway (to see what they point to), making our
> type lookup here redundant.
>
> For unreachable objects, we might never hit them at all in
> the reachability traversal, making the lookup completely
> wasted. And in some cases, we might have quite a few
> unreachable objects (e.g., when alternates are used for
> shared object storage between repositories, it's normal for
> there to be objects reachable from other repositories but
> not the one running fsck).
>
> The comment in mark_object_for_connectivity() claims two
> benefits to getting the type up front:
>
>   1. We need to know the types during fsck_walk(). (And not
>      explicitly mentioned, but we also need them when
>      printing the types of broken or dangling commits).
>
>      We can address this by lazy-loading the types as
>      necessary. Most objects never need this lazy-load at
>      all, because they fall into one of these categories:
>
>        a. Reachable from our tips, and are coerced into the
> 	  correct type as we traverse (e.g., a parent link
> 	  will call lookup_commit(), which converts OBJ_NONE
> 	  to OBJ_COMMIT).
>
>        b. Unreachable, but not at the tip of a chunk of
>           unreachable history. We only mention the tips as
> 	  "dangling", so an unreachable commit which links
> 	  to hundreds of other objects needs only report the
> 	  type of the tip commit.
>
>   2. It serves as a cross-check that the coercion in (1a) is
>      correct (i.e., we'll complain about a parent link that
>      points to a blob). But we get most of this for free
>      already, because right after coercing, we'll parse any
>      non-blob objects. So we'd notice then if we expected a
>      commit and got a blob.
>
>      The one exception is when we expect a blob, in which
>      case we never actually read the object contents.
>
>      So this is a slight weakening, but given that the whole
>      point of --connectivity-only is to sacrifice some data
>      integrity checks for speed, this seems like an
>      acceptable tradeoff.

The only weakening is that a non-blob (or a corrupt blob) object
that sits where we expect a blob (because the containing tree or the
tag says so) would not be diagnosed as an error, then?  I think that
is in line with the spirit of --connectivity-only and is a good
trade-off.
