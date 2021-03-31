Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0BCC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105E561055
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhCaSll (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:41:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65456 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhCaSlW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:41:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92AF4122E5E;
        Wed, 31 Mar 2021 14:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xVqLaRUHEwV71Q3DIZxtzE6QUDI=; b=nI9UlD
        OH+IZDTK8JspZsnebZUef5UuT97YMjg4ASGrXZFJtZZ3TC7owZDcZ5UFBJpQqcpe
        PjwAtIMr4uRFnrXQi+XMoTw+rSuTY72apK4yW5RLEbvbu56CsUikFZaxFl5IgNrN
        CsxBR01MM97a8AsnP+3+aPKKW8sHvK/JSwkcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=exMPgkYhqf8qV7qIYx4SbScz9G0gWgTY
        c+AWdnf5Ll4rFMqXDVUQLjMN3I02PLszjhh66COwf/nGf/OhQ31hpTX34YPB3/5e
        7ZVpjdPJc1s5K8NFG9kYjuYXCKMka4IUbXze3PjtOvEHqSoLYaqB7s7elX9H0a5i
        CLAoIS1tySQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ABEC122E5D;
        Wed, 31 Mar 2021 14:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BCC40122E5C;
        Wed, 31 Mar 2021 14:41:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
References: <20210308200426.21824-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
        <xmqq35wdfaw5.fsf@gitster.g>
        <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
Date:   Wed, 31 Mar 2021 11:41:18 -0700
In-Reply-To: <YGRWqX+qF+Rtqr20@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 31 Mar 2021 07:02:01 -0400")
Message-ID: <xmqqv9976u9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF1D16E8-9250-11EB-B5EC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
> +				error(_("object %s is a %s, but was referred to as a %s"),
> +				      oid_to_hex(&obj->oid), type_name(obj->type),
> +				      type_name(type));
> +			else
> +				error(_("object %s referred to as both a %s and a %s"),
> +				      oid_to_hex(&obj->oid),
> +				      type_name(obj->type), type_name(type));
> +		}

Am I correct to understand that the latter is after we read a tree
that refers to an object with 100644 (blob) and then another tree
that refers to the same object with 40000 (tree), before we have a
need/chance to actually find out what that object is?  The error
would trigger while reading the second tree and find the second
mention of the object that conflicts with the earlier one?

