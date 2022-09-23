Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A883C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 16:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiIWQal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiIWQag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 12:30:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861A113B4A
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 09:30:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B43951ABAAD;
        Fri, 23 Sep 2022 12:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yqH2pHjegR2wNfeXinsFrjjHE/4G6Ja/B9Nj8p
        99Tt0=; b=nAYtZrGgk8vxyYY9vmixa/En9BdVEMQ9PZDBOlkLsqHNUt8AZMcLPJ
        rWgTnnTSjYo7bg7am5QJWB2QjrHva1EXBy0pcNqSXONbvg9j2w7qhCn+boJ5ho/q
        njyG430Tl3PYG7t/6Ope7CX3xGMhsulpmHfZAfWN9SDLgvr09db/w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC63E1ABAAB;
        Fri, 23 Sep 2022 12:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B42D1ABAA9;
        Fri, 23 Sep 2022 12:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git --archive
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
        <xmqqleqbxj4h.fsf@gitster.g>
        <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
        <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net>
Date:   Fri, 23 Sep 2022 09:30:27 -0700
In-Reply-To: <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 23 Sep 2022 00:49:08 +0000")
Message-ID: <xmqqedw2vysc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08E906B2-3B5D-11ED-B7A2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Maybe they can technically be stored in any order, but people don't want
> git archive to produce non-deterministic archives...
> ...  I feel like it would be very difficult to achieve the
> speedups you want and still produce a deterministic archive.

I am not going to work on it myself, but I think the only possible
parallelism would come from making the reading for F(n+1) and
subsequent objects overlap writing of F(n), given a deterministic
order of files in the resulting archive.  When we decide which file
should come first, and learns that it is F(0), it probably comes the
tree object of the root level, and it is very likely that we would
already know what F(1) and F(2) are by that time, so it should be
possible to dispatch reading and applying content filtering on F(1)
and keeping the result in core, while we are still writing F(0) out.

Thanks.
