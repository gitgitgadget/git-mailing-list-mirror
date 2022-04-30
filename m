Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20530C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 23:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiD3XR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiD3XR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 19:17:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40893FD8A
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 16:14:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E27B197AA6;
        Sat, 30 Apr 2022 19:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O7/nWpB9B1joYBUy+PX/XocBeeV5lchIvzJgYa
        fTiIg=; b=MjDm6tPjkbT8rR29S79EXYXGD+8Ctbb+4LO8D9t40Ube9enlMn2pBj
        K9QqN9MZtILF8O5fBafuzsTH4TXGCt+TFbmv0LCWA49WqHEtY37IvS7x6Xyvc5zq
        CDXHeZsPRSUvPjEbKpEvuj2N28ixtUf8s05gK/DPaMJLFvc1SiCD8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B520197AA5;
        Sat, 30 Apr 2022 19:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6741197AA2;
        Sat, 30 Apr 2022 19:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
        <20220430041406.164719-2-gitter.spiros@gmail.com>
        <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
        <xmqqpmky70jb.fsf@gitster.g>
        <a3e06290-052e-af36-4170-301e567d561d@iee.email>
Date:   Sat, 30 Apr 2022 16:13:56 -0700
In-Reply-To: <a3e06290-052e-af36-4170-301e567d561d@iee.email> (Philip Oakley's
        message of "Sat, 30 Apr 2022 22:38:52 +0100")
Message-ID: <xmqqr15e5fm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36834078-C8DB-11EC-8171-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I think it goes both ways when the 'bad' style can be cargo-cult copied
> too easily, negating the value of the guidance.

Yes, and the cocci rules by themselves do not help protecting our
codebase against it all that much.

In order to help developers follow the guideline to avoid adding
_new_ instances (by copying-and-pasting), it should be easy to use
such a checker in such a way that we can notice only _new_ breakges
while ignoring existing offenders.  I do not think the current cocci
check target in our Makefile is prepared for that.

And there are two ways to deal with that shortcoming.

One, which often appears easier to implement but in the medium term
is very costly, is to freeze the codebase and apply tree-wide code
churn to make warning disappear.

Then _any_ breakages noticed by an inadequate tool, which does not
allow us to notice only the new breakages, after applying a patch to
such a cleansed codebase by definition are coming from the patch.

But it is costly.  The codebase is rarely frozen, so there isn't a
good time to apply such a patch, whether it is 22-patch series or a
single patch that concatenates everything into one.  There may be
more urgent issues than style fixes that would force us to revert a
change made before such a tree-wide clean-up, and when that happens,
such a "clean-up for clean-up's sake because we cannot check
incrementally" will inevitably conflict with such a change.

The other approach is to make it possible (and easy) to check
incrementally, so that we can detect new instances made by copying
and pasting.

Thanks.




