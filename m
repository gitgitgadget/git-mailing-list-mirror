Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8FEE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 16:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbjHWQK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHWQK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 12:10:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31A810E9
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:10:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 728B726E9B;
        Wed, 23 Aug 2023 12:10:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=izmRxY+Qw9sC5MGIKTONIqHNTVTK7meaOHLR+a
        cbxkU=; b=fNWdyDE+XJdArVyM4jLCIroNXHU53Vys/lLc/n7cVKfw1w9OomfdN6
        xr3KJ8SGQk3sNhXeCOzR3Jui5vFnGBQdfNGYZNEjQcXPRbwKm3BJRfzDrT2iA+rr
        PpkN940KN5gujafSS4OY+QGUuBTQrRgwKqkNwWndBafqYUlyTyt1w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C1B926E9A;
        Wed, 23 Aug 2023 12:10:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0519126E99;
        Wed, 23 Aug 2023 12:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        'Jeff King' <peff@peff.net>, 'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>
Subject: Re: [PATCH] ci: avoid building from the same commit in parallel
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        <xmqq7cpwjhr1.fsf@gitster.g>
        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
        <xmqq350kjfk8.fsf@gitster.g>
        <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
        <ZNv5PQlkn6tbUcH7@nand.local>
        <20230816022420.GA2248431@coredump.intra.peff.net>
        <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
        <xmqqo7j5uqza.fsf@gitster.g>
        <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de>
        <xmqqttssqsj5.fsf@gitster.g> <xmqq1qfvor35.fsf_-_@gitster.g>
        <xmqqpm3fn16f.fsf@gitster.g>
        <99e19de6-c17d-e85f-dc58-1019aed1e2b1@gmx.de>
        <xmqqjztnm6v0.fsf@gitster.g>
        <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de>
Date:   Wed, 23 Aug 2023 09:10:44 -0700
In-Reply-To: <1da763f3-60bf-a572-2c71-336b1fa5553d@gmx.de> (Johannes
        Schindelin's message of "Wed, 23 Aug 2023 10:42:45 +0200 (CEST)")
Message-ID: <xmqqzg2hg2nv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E074ED8-41CF-11EE-9AD8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Here is the patch:
>
> -- snipsnap --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 21 Aug 2023 17:31:26 -0700
> Subject: [PATCH] ci: avoid building from the same commit in parallel

I forgot to say that I do not think I deserve the credit in the end
result, as you've done all the hard part.  

Mind taking the authorship, while demoting me to "Helped-by" status?

Thanks.
