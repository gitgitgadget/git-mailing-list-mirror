Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB6FC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DFC208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x+Ff6iwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgAGRBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:01:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54285 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGRBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 12:01:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35BC7AE0A3;
        Tue,  7 Jan 2020 12:01:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6byWSSp7XYBg4y3nfqz0tdyg5j0=; b=x+Ff6i
        wM4XD2cQhZF6zoqK/v3kxTE34nltLe7MojVDi9yuqeqx+Y+XjJtLhihjZI7Yt9Jr
        QjhNYxdC0jOmunDv938BhKO4Z93r+97SxiiJ566OHDXUHIrFnr88QroU3HZWhRyX
        3Updm8WVQuwSdLk+Gv0zhmhK2MTSDvQzY8DFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uzxhQ+BS520RKiHLUcaGYZm1FYBDs870
        8selmU7hgsiterSV77RTMdCT3vQTsCWCqeNQFnvyCFq/al1FRIrtNcy0Xcu66xQK
        K5n7TCPDGjEXIr21KOHXiUgmoZBPUOQacYydLy+nnQij97G4l0oLt+spKH99AxM+
        pk0NFDLbTdM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D9BFAE0A2;
        Tue,  7 Jan 2020 12:01:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49D2CAE0A1;
        Tue,  7 Jan 2020 12:01:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Rudyshin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sergey Rudyshin <540555@gmail.com>
Subject: Re: [PATCH 1/1] Preserve topological ordering after merges This modifies the algorithm of topopological ordering. The problem with the current algoritm is that it displays the graph below as follows
References: <pull.514.git.1578393057.gitgitgadget@gmail.com>
        <542a02020c8578d0e004cb9c929bced8719b902a.1578393057.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2001071305330.46@tvgsbejvaqbjf.bet>
Date:   Tue, 07 Jan 2020 09:01:45 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001071305330.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 7 Jan 2020 13:08:18 +0100 (CET)")
Message-ID: <xmqqr20b5hfq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63C42300-316F-11EA-81CD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> please note that the commit message's first line should not be longer than
> 76 characters per line, and it should be followed by an empty line. I
> think that you forgot the empty line, looking at
> https://github.com/gitgitgadget/git/pull/514/commits/542a02020c8578d0e004cb9c929bced8719b902a

Thanks for a good suggestion.

Also, please do *not* CC iterations of a patch to me that hasn't
seen a concensus that it is a good idea on the list yet, unless
you know I am the area expert and am interested in seeing it.

Thanks.
