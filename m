Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC37EE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 15:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjHVPbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjHVPbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 11:31:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DFCDD
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 08:31:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D78A1E56D;
        Tue, 22 Aug 2023 11:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a4Ia2gPmlxqVL0N/5f2XIy9MGSV+JNMp9ZU83c
        nmmwU=; b=upJk6gv5EBz7T0DfHEv5mrdTbTrySABcMf59Du2xIiIjyz8O+raE/b
        P5GWx8qMkiStiJTtzFkXZQV28vHz3vg6RAlWsEdVvIABb9P4cdrbmR5boGnMbeql
        t2gv5UsuKPFllq75btQdgBvzjzMrT9t7oGkZn4SKbfh7TsC//FXws=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35C561E56C;
        Tue, 22 Aug 2023 11:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A1B31E56B;
        Tue, 22 Aug 2023 11:31:16 -0400 (EDT)
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
Date:   Tue, 22 Aug 2023 08:31:15 -0700
In-Reply-To: <99e19de6-c17d-e85f-dc58-1019aed1e2b1@gmx.de> (Johannes
        Schindelin's message of "Tue, 22 Aug 2023 06:48:33 +0200 (CEST)")
Message-ID: <xmqqjztnm6v0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF0955D0-4100-11EE-BF66-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Right, we'd need that `concurrency: ${{ github.sha }}` attribute on the
> `config` job.

That was my first thought, but I am not sure how it would work.

Doesn't skip-if-redundant grab the workflow runs that have succeeded
and then see if one for the same commit already exists?  If you used
concurrency on the 'config', what gets serialized between two jobs
for the same commit is only the 'config' phase, so 'master' may wait
starting (because 'config' is what everybody else 'needs' it) while
'config' phase of 'main' runs, and then when it gets to the turn of
'config' phase of 'master', it would not find the run for the same
commit being done for 'main' completed yet, would it?

> BTW there is another caveat. According to the documentation, if a job is
> queued while another job is already queued, that other job is canceled in
> favor of the latest one.

Yes, that was the impression I got; your second one will wait (so
you need a working skip-if-redundant to turn it into noop), but the
third and subsequent ones are discarded without starting, which
unfortunately is what we may want to see happen.

Hmph, from that point of view, would the best and simplest we can do
be to use the commit object name as the concurrency key for the
'config' phase, and use something similar to cancel-in-progress
(which kills the other one when the new one starts, but what we want
is what stops the new one to start when it notices there is already
one running)?
