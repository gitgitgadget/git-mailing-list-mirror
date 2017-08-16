Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B251F667
	for <e@80x24.org>; Wed, 16 Aug 2017 19:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbdHPTjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 15:39:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751847AbdHPTjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 15:39:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82AFBA5C0F;
        Wed, 16 Aug 2017 15:39:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C/C7MyL9vJKK2K0j0Tj6neUGv24=; b=rJurVC
        28tZ4bjRyKaPplkGxt6Vg36uFb31VUKPzweknJXf0KaCMnX5mKgIwDFHkBxkK/Cr
        /hRgcAEVHsdQxGCZM77TW8oRaUdLVXKYJLWLpG6/yvWaTooRZup+JirC+H7IOV1+
        4M8l5YoNtwO7hFr/K5Cz74abgwJCo+Lelc834=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OGIIG66GC6JFei9kpHxhGGAiJy4opLWT
        0THAwfcJHPV98b3IuisQSl59CMdEQX/bk5DBk4+rhM+iL11gq7PtzE56c0S2fO6o
        dSvwDF9v+86jOFnluGdNc9yYtVe8N3DZWcoQ2XXL3BQj2QMfsu3H14BnvNUeyZAT
        SaFb3yz9GoA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AA60A5C0E;
        Wed, 16 Aug 2017 15:39:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFBE9A5C0B;
        Wed, 16 Aug 2017 15:39:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 5/5] commit: rewrite read_graft_line
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
        <xmqqo9rgr8eh.fsf@gitster.mtv.corp.google.com>
        <CAJfL8+RVNYh1ryZ5EkiWxiZRo3Loq-MjujD94zGBMEGykmSWeg@mail.gmail.com>
Date:   Wed, 16 Aug 2017 12:39:06 -0700
In-Reply-To: <CAJfL8+RVNYh1ryZ5EkiWxiZRo3Loq-MjujD94zGBMEGykmSWeg@mail.gmail.com>
        (Patryk Obara's message of "Wed, 16 Aug 2017 15:07:54 +0200")
Message-ID: <xmqqmv6zjo9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91C6CF34-82BA-11E7-9993-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> I am not sure if this is a good approach.  Just like in 2/5 you can
>> use the MAX thing instead of 20, instead of having each graft entry
>> allocate a separate oid_array.oid[].
>
> Once MAX values were increased memory corruption was caused exactly by
> this line:
>
>> - graft = xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));
>
> I could've replaced it by:
>
>     graft = xmalloc(st_add(sizeof(*graft), st_mult(sizeof(struct
> object_id), i)));
>
> But it seemed to me like short-sighted solution (code might be broken if
> object_id will be modified again in future).

Why?  

Assuming that "struct object_id" would have to be prepared to handle
more than one types of hash functions at the same time, it would be
sufficiently large to hold any type of hash, plus possibly another
member that tells which kind.

The decision to choose between a flex array and a separately
allocatable structure primarily should come from how the enclosing
struct (i.e. the commti_graft structure) is meant to be used.  It is
not meant to be tweaked by adding more parents or removing parents
once it is constructed, which argues for having a flex array to hold
the known and fixed number of parents once it is constructed.
