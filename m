Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D24A1FAD6
	for <e@80x24.org>; Sat,  9 Sep 2017 03:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757262AbdIIDSV (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 23:18:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753201AbdIIDSV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 23:18:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECD17A78CB;
        Fri,  8 Sep 2017 23:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZlhMMjuWFe25ou2BuHlOj0YDxm8=; b=GO9rmj
        teVInW/kNYQmH3De8cPckYK8gxalqxCqmV92w2khqf2Wyj1CqfPRZIEKE1I2GXcS
        jSuyNI3fl1s+ho93ZYS/3gfbWTbWd+H1GkREiMmOQUeGyqI3BDVuwAVx/C2ZBRgR
        YTYWpalfwt+E/o13Kpf76UTtIwr1qZ19ukfIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nQU2saf36H6xdm1MGzv7Ln0PKzrO1MVK
        lKkQFiAUyauq7WMJtPXyIkcXKR25rEB3hKFvsJv2Po3LmealR37Yvi6bIu2DDw4C
        pB9ZaE9XMo1Lhepf0ff4yrJ8Jjc9IdLrK11LXjZFc5+v0Mna101hLkxbJWVYubaH
        /0hFOFoXDMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3E03A78CA;
        Fri,  8 Sep 2017 23:18:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F326A78C7;
        Fri,  8 Sep 2017 23:18:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
Date:   Sat, 09 Sep 2017 12:18:18 +0900
In-Reply-To: <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        (Kevin Willford's message of "Fri, 8 Sep 2017 20:02:33 +0000")
Message-ID: <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87323BCA-950D-11E7-AFDC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> 1. reset mixed when there were files that were added
>
> In this case the index will no longer have the entry at all because
> the reset is making the index look like before the file was added
> which didn't have it. When not using the sparse-checkout this is fine
> because the file is in the working directory and the reset didn't touch
> it.  But using the sparse-checkout on that file and if the file was not
> in the working directory, the index gets reset and the entry for that
> file is gone and if we don't put the index version of the file before the
> reset into the working directory, then we have lost the content for
> that file

I do not quite understand this argument.  If you do

	edit $path
	git add $path
	rm $path
	git reset

for a $path that is not involved in the sparse thing, the version
that was previously indexed will be lost, but that is fine---the
user said that version is expendable by saying "reset".

How would that be different when the $path were not to be
materialized in the working tree due to sparseness?  Where did that
"blob" object in the index immediately before you called "reset"
came from, and why do you say that the user does *not* consider that
one expendable, unlike the case for non-sparse path example above?

I suspect that a similar reasoning would apply to your 2., but I
didn't think it through.  

The possible misconception, which I perceive in both of these, is
that you are somehow disagreeing with this basic assumption: by
saying "git reset [<tree-ish>]", the user is telling us that the
version in the index, even if that is different from HEAD,
<tree-ish>, or the file in the working tree, is *unwanted* and be
replaced with the one in HEAD (or <tree-ish> when given).  Touching
the working tree files upon "git reset" is the last thing the user
expects to happen.


