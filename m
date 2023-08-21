Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8803EE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjHUQSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjHUQSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 12:18:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D51AA
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 09:17:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 273431BA7FD;
        Mon, 21 Aug 2023 12:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cpGlzuepADJRNUJx4p0H38regLRgcldWs4Cvp+
        IPoEc=; b=Dedkfeq7Lu3X5NPHCIL1ckznSW3YszBeFklR5w24WFBp0BH1yDzQEF
        GuHxyco/iZvi3xQg7MK02DsKKhHTQUi+mYFPMhyjQnKT+z9+r1oSc1hBqkueEwTC
        NHRCriztMYGfhgoheyer33HS5OHY0N5joJ2ob7X2Pjwr+pyNcAFbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D97F1BA7FC;
        Mon, 21 Aug 2023 12:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A8B01BA7FB;
        Mon, 21 Aug 2023 12:17:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>, git@vger.kernel.org
Subject: Re: main != master at github.com/git/git
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
Date:   Mon, 21 Aug 2023 09:17:18 -0700
In-Reply-To: <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de> (Johannes
        Schindelin's message of "Mon, 21 Aug 2023 16:56:28 +0200 (CEST)")
Message-ID: <xmqqttssqsj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33BC9282-403E-11EE-AB62-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My understanding is that the recommended way to handle this via the
> `concurrency` key [*1*]. That is, if we changed
>
>     concurrency:
>       group: windows-build-${{ github.ref }}
>       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>
> to
>
>     concurrency:
>       group: windows-build-${{ github.sha }}
>
> then pushing both `master` and `next` pointing at the same commit would
> start only one of the workflow runs immediately, keeping the second one
> pending until the first run is done.

Perfect.  It is much better than pushing 'master@{24.hours.ago} to
'main' which was what I used to do avoid the problem between these
two, which I stopped doing because it did not work well.

> If the first run succeeds, the second
> run will pick up that status and avoid running everything all over again,
> via `skip-if-redundant`.

Nice.  I understand that this would kick in regardless, but the
right use of the concurrency key would make it far more effective.

Very nice.
