Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DCC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A786C21582
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FqLyReu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLPU6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:58:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57102 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLPU6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 15:58:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 933E13C924;
        Mon, 16 Dec 2019 15:58:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r2UVRc6oyS2Jrr188MjEsnLof3M=; b=FqLyRe
        u7DxQJ8oL+5syT7GgegsbJgDRlTvSnNsrAVR3hKruVQeHh+w2lDcWWl4gYxuAQFt
        EknNQLOt4+qzwRpNuINd9JdGdbVYuTX/98kPal32zST+/SvYKpstNZTSDrJvv6Jn
        mNdIlkjmBaTM3cXrcOyuHzQEG/baf8PJSDaQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yin3DuU1TT9XygRodHzTr4go1yG2foRT
        5hwTkfaDiOyAu+cOcUp04FttiAZSooe+xr49KZNpdoNxb4fRoQi0MxM+wAzigzj8
        4jhqmLJd1xcIu5Za4diZTwUT/rVtJWuhqI/aHcm4mu3qYAhNMpV8rE/tk2Da7XJv
        xGQ4Nh7ip+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B7773C923;
        Mon, 16 Dec 2019 15:58:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBBF73C922;
        Mon, 16 Dec 2019 15:58:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] gpg-interface: add minTrustLevel as a configuration option
References: <20191216153204.8906-1-hji@dyntopia.com>
Date:   Mon, 16 Dec 2019 12:58:45 -0800
In-Reply-To: <20191216153204.8906-1-hji@dyntopia.com> (Hans Jerry Illikainen's
        message of "Mon, 16 Dec 2019 15:32:03 +0000")
Message-ID: <xmqq4ky0j8ca.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA425608-2046-11EA-B5A4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> I think it makes sense to refactor the processing of TRUST_ status lines
> such that users can configure a minimum trust level that is enforced
> globally, rather than have individual parts of git (e.g. merge) do it
> themselves.

OK.

> I also think it makes sense to not store the trust level in the same
> struct member as the key/signature status.  While the presence of a
> TRUST_ status code does imply that the signature is good (see the first
> paragraph in the included snippet above), as far as I can tell, the
> order of the status lines from GPG isn't well-defined; thus it would
> seem plausible that the trust level could be overwritten with the
> key/signature status if they were stored in the same member of the
> signature_check structure.

I agree that this is a good move---ever since gpg-interface.c was
written, I have found it disturbing that the order of the lines in
the output can affect the result we store and return to our callers

> This patch introduces a new configuration option: gpg.minTrustLevel.  It
> consolidates trust-level verification to gpg-interface.c and adds a new
> `trust_level` member to the signature_check structure.

Nice.

> Unfortunately, it breaks backward-compatibility in two ways:
>
> 1. The default trust level is TRUST_UNDEFINED.  This is compatible with
>    the old behavior of every code path *except* for
>    verify_merge_signature() (since, again, it used to die()s on trust
>    levels below TRUST_MARGINAL).

This might be a bit problematic.  If we can keep the default
behaviour identical to the code before this patch, while allowing
the configuration to tweak the behaviour, that would have been
more easily acceptable.

That is, can we rearrange this patch so that each user of the
verification code define its default minimum trust level (and
verify-merge-signature would have a bit higher standard than
everybody else), so that the uneven trust requirement is kept by
default?  And when the user explicitly sets the gpg.minTrustLevel
configuration, these uneven default would all set to the given
value.  Later when the code gets a bit more mature, we would declare
that we'd break the backward compatibility and set the default trust
level for all codepaths even (either by raising everybody to
marginal-or-better, or lowering everybody to undefined).

> 2. The %G? format specifier no longer includes 'U' for signatures made
>    with a key that is either TRUST_UNDEFINED or TRUST_NEVER.

Hmm, I can sort-of-see why you want to introduce a new placeholder
"%GT" to disambiguate two sources of 'U', but why would this change
to "%G?" necessary?

>    Instead, a
>    new %GT format specifier is introduced that outputs the trust level
>    (as a complete string to avoid ambiguity with TRUST_UNDEFINED and
>    TRUST_ULTIMATE).

