Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A581DC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 09:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA261420
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 09:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhD1JLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:11:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58951 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhD1JLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 05:11:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04824B0636;
        Wed, 28 Apr 2021 05:10:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OrjBnlfDjCyexHzpcbgoHGPFYmaJfRIt3p5yb/
        EFq2g=; b=AAmXcyPU+J5SyydRznlnlwlKybAPM3aTkdby8eVsJ55IH0tmFr6+gh
        btxuy6Ps5fVU/sTIU4+PBKgMxnLIQl1AqycnS1NjJCoFHS1vXTZTcFQrsmz/04lw
        3xxuc6GP3DhUciIBJlU2tL0R50SF5RTOJ2PMbf6vhs2mymdD+Aijc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDFE4B0632;
        Wed, 28 Apr 2021 05:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45EBEB0631;
        Wed, 28 Apr 2021 05:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Moussu <moussu.robin@pm.me>
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request: `git restore $commit $file` =?utf-8?Q?shouldn?=
 =?utf-8?Q?=E2=80=99t?= override
 uncommited changes
References: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me>
        <20210427192906.7obdkopxwajqnv53@gmail.com>
        <I_ZK84DfFkUoO9FcqjidSjmsvktNt-k4tPiAGNIP5ztKjk0RQCfFmyRrRHaB414UaWsJO7kWPBcgHlRqAecH7r9mAj0TLm5k6T5_YzmiZ4c=@pm.me>
Date:   Wed, 28 Apr 2021 18:10:35 +0900
In-Reply-To: <I_ZK84DfFkUoO9FcqjidSjmsvktNt-k4tPiAGNIP5ztKjk0RQCfFmyRrRHaB414UaWsJO7kWPBcgHlRqAecH7r9mAj0TLm5k6T5_YzmiZ4c=@pm.me>
        (Robin Moussu's message of "Wed, 28 Apr 2021 08:35:46 +0000")
Message-ID: <xmqqy2d2ai5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97F92C10-A801-11EB-8F28-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Moussu <moussu.robin@pm.me> writes:

> On the contrary, if `--source $commit` is specified, I would like
> to get an error if $file has uncommitted changes.

Not necessarily.  I've done this number of times:

 - start from the current state (HEAD), make changes

 - end up making a mess that I'd rather not use.

 - realize that the endgame I seek is fairly close to the work I did
   for another branch.

 - "git checkout $that_branch -- $those_paths".

So, it is not cut-and-dried that it _always_ (or even _often_) is a
mistake to try overwriting a working tree file with modifiations with
a version of a file from commit that is not HEAD.  It may be _always_
an error for your work habit.  It would almost always be what I want
in my experience for me.


