Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B4C41513
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGXSSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGXSSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 14:18:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100510CE
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 11:18:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65AE62868F;
        Mon, 24 Jul 2023 14:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RUTVKbJxWso4jmhguu4jvvwWVJemPuQtaiynyt
        hKAXk=; b=vKU01XSlFMcRTiCGiiXYPymcIv2dPhuYG+hpsqfPTOlfg2ul/fRsFd
        U+JOND6gexDShzcqQEu3etIdTse1RtmSOqt422YUBTJZoomdrPZh+x6Ib7EVfghb
        +tOa2ZhzMhgxyrieClIdF92xlNHnBysaMBjc/UIjGEjA27HJ9C0QQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E4282868E;
        Mon, 24 Jul 2023 14:18:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5C652868D;
        Mon, 24 Jul 2023 14:18:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] repack: implement `--filter-to` for storing
 filtered out objects
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-8-christian.couder@gmail.com>
        <xmqq5y6y1agl.fsf@gitster.g>
        <CAP8UFD1tqzp744j0KORw-zcgOn6Tufm4Kk3yct3vHGY29pbm-w@mail.gmail.com>
Date:   Mon, 24 Jul 2023 11:18:24 -0700
In-Reply-To: <CAP8UFD1tqzp744j0KORw-zcgOn6Tufm4Kk3yct3vHGY29pbm-w@mail.gmail.com>
        (Christian Couder's message of "Mon, 24 Jul 2023 11:00:56 +0200")
Message-ID: <xmqqy1j5p40f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B4E36F6-2A4E-11EE-AE29-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In version 3, the doc for the --filter-to option and the corresponding
> gc.repackFilterTo config flag look like this:
>
> +--filter-to=<dir>::
> +       Write the pack containing filtered out objects to the
> +       directory `<dir>`. Only useful with `--filter`. This can be
> +       used for putting the pack on a separate object directory that
> +       is accessed through the Git alternates mechanism. **WARNING:**
> +       If the packfile containing the filtered out objects is not
> +       accessible, the repo could be considered corrupt by Git as it

"could be considered" -> "can become".

> +       migh not be able to access the objects in that packfile. See

"migh" -> "might".

> +       the `objects` and `objects/info/alternates` sections of
> +       linkgit:gitrepository-layout[5].
>
> +gc.repackFilterTo::
> +       When repacking and using a filter, see `gc.repackFilter`, the
> +       specified location will be used to create the packfile
> +       containing the filtered out objects. **WARNING:** The
> +       specified location should be accessible, using for example the
> +       Git alternates mechanism, otherwise the repo could be
> +       considered corrupt by Git as it might not be able to access the
> +       objects in that packfile. See the `--filter-to=<dir>` option
> +       of linkgit:git-repack[1] and the `objects/info/alternates`
> +       section of linkgit:gitrepository-layout[5].
>
> So they warn about possible issues with the feature and link to some
> relevant doc.

In all other parts of the system, we tend to avoid such an "unsafe
by default" desgin, especially when the risk is known before there
is an implementation, and instead allow an explicit end-user action
(ranging from command line option to interactive confirmation) to
opt-into more risky behaviour.  Should we consider --filter-to as
such an "always risky and prone to repository corruption" option
(just like "--hard" to "reset" is always loses changes in the
working tree without warning)?

I am OK with that myself, but others may disagree.

Come to think of it, we haven't seen much reviews from those other
than Taylor.  Are folks content with the direction this series is
going in general?

Thanks.

