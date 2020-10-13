Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB01C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D325358
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJXP3y6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgJMR3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:29:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56522 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgJMR3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 13:29:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5F3994ED0;
        Tue, 13 Oct 2020 13:29:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v3zXbd8+2ZyglQ7fLpA4abAMc3I=; b=rJXP3y
        6jDsQQc6B/BtXDTLg3AOZPvUjixkGXxXIIjfWgvxo4l/r7M5cvEWBmEKJweFdr0F
        CcSozWd+2Dvtd/X/RZ0G+ltTgyYD8hL9nobUBRiVBovf9qfPI/2SCjsEGkRb/9jP
        GZJmpy7Uuh6reTyw+3ITj30fvo7Zk87wJpy+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p/F5WD06rSQLIXytnwl9PHYVf5g3KuF+
        mZUBwsDc3Xbin+4FEVOV/GI6ew/xsMXeudBlFv62YarBFmeTS+hjZvTvWXKenJdq
        wf01tQOENc+vPbB0TfEDCD6wzOKAGJE8hwkKhjt2rX53XbZ0AkzO9yHMkyYr2/Uc
        EmRSREgdHnM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADBFC94ECF;
        Tue, 13 Oct 2020 13:29:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 407E094ECE;
        Tue, 13 Oct 2020 13:29:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        peff@peff.net, masayasuzuki@google.com
Subject: Re: [PATCH] remote-curl: add testing for intelligent retry for HTTP
References: <20201012184806.166251-1-smcallis@google.com>
        <20201012201940.229694-1-smcallis@google.com>
        <xmqqy2kbmalb.fsf@gitster.c.googlers.com>
        <CAM4o00e4wYOHkn38H8UwqboRMSzAs4QCvTN6Ef6PuUnYfwOoXg@mail.gmail.com>
        <xmqqd01nm60u.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010131624060.50@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Oct 2020 10:29:45 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010131624060.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 13 Oct 2020 16:25:11 +0200 (CEST)")
Message-ID: <xmqq7drukp9y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B02C8688-0D79-11EB-B5AB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We should also consider using `test-tool genrandom <seed>` instead (where
> `<seed>` would have to be predictable, but probably would have to change
> between `gen_nonce()` calls).

Yup, that is exactly why I asked Sean about randomness requirement.

It turns out that they care only about uniqueness, so the comparison
is between keeping an ever-incrementing counter and (1) echoing its
current contents and/or (2) feeding it to "test-tool genrandom" as
the seed.  The complexity of the code _we_ need to write anew is the
same, but echo would probably be a win in both the number of forks
and cycles departments.

Thanks.
