Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE18C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F64B206ED
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k9UkVeL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBMQSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:18:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51618 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgBMQSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 11:18:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA6DB3D598;
        Thu, 13 Feb 2020 11:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7MHgys3rU1h4AWSpBbTDFsXKexE=; b=k9UkVe
        L/itqWwC0rVZAet7rqh/xDghnzdEj+B3Wg/rA9aDnB//Q4l4x0pBwG8jXs/z9JHo
        f4b/1VuWHXIN/r5C57blD1jL1ZBqOkSp9W2r1KWy8TbflgW99iMsz/n3J5X4uwHy
        slVT6Nc6IIy+OaPugo6aEUfR21BcOzNi/+lMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KhlDSLF6zKtQHwt5Or4FSeV4Oo/odH3H
        2Wl6vnyEXRLioXdTrvKkShR/7fpQo5uDzW4U1Iq7+HQPuPBfS/wgILXt2Cz3G0C8
        jLoLWbnQmdSm9H4ZL9RtLAiV90iK4uA1KvnQ5VJD0GPUAjZVl/pTpKV/94KcapuK
        4ye1/PHqEe0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D36BD3D597;
        Thu, 13 Feb 2020 11:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41F0B3D596;
        Thu, 13 Feb 2020 11:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: recursive cloning with --reference-if-able + --dissociate
References: <83602548-c0a6-db37-ccdf-5c0f4b233b2e@rasmusvillemoes.dk>
Date:   Thu, 13 Feb 2020 08:18:38 -0800
In-Reply-To: <83602548-c0a6-db37-ccdf-5c0f4b233b2e@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Thu, 13 Feb 2020 15:45:14 +0100")
Message-ID: <xmqqv9oasboh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E770EA4-4E7C-11EA-B0F0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> At $dayjob, most of our projects are organized as a rather small
> superproject, with a number of git submodules. Usually, one of those
> submodules is a linux kernel git tree.
>
> For CI testing, we create a fresh docker container which starts by doing
> a "git clone --recursive $superproject", which takes quite a while due
> to the linux repo. So we'd like to speed that up by having a reasonable
> up-to-date linux repo on each build slave, mapping that into the docker
> container, and then telling git "when you get to cloning the src/linux
> submodule, look over here for objects", i.e. having some way to have
> --reference-if-able and --disassociate in effect for submodules.
>
> If this is already possible, I can't find it in the documentation. And
> if it doesn't exist, I can't really think of a good way to define the UI
> for giving those options (other than, perhaps, having a top-level
> --reference-if-able pass down to the submodules with the meaning 'when
> initializing the submodule at some/path, try to use the submodule, if
> any, at some/path in the referenced top-level repo'".

Sorry for not giving a full solution but I suspect that discussing
this topic will lead to a useful new feature, similar in spirit to
the url rewriting (i.e. "url.$LOCAL.insteadOf = $REMOTE") to tell
Git to use a local mirror $LOCAL instead of the remote authentic
repository when interacting with $REMOTE.

Perhaps "url.$LOCALREF.autoReference = $REMOTE" to specify a local
mirror that does not have to be completely up-to-date, that will
altomatically be used as if "--reference-if-able $LOCALREF" is
passed when running "git clone $REMOTE", or something like that.

The actual design has to get a lot more involved, including
deciding:

 - if autoReference is orthogonal to --disssociate (I think it
   should be but others may differ).

 - how the way --dissociate is passed down from the top-level
   superproject to cloning of submodules is controlled (passing
   unconditionally would probably be too coarse, but I dunno).

etc. etc.
