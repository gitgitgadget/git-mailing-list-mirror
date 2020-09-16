Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56077C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBBD2078D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 04:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M+MQ88IJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIPERq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 00:17:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59174 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgIPERp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 00:17:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E046377DEB;
        Wed, 16 Sep 2020 00:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hMuoStxvaWBSOKLyqR40+yXQg44=; b=M+MQ88
        IJ9a6zcQLVCWixdEHt0oE00EpCk2V3zkBKak39IOdGA2XjSvpB+tHZBoB4rD/jMj
        vXw1TyUqVQ7mn51WF9z7AtNjo1suQbEuKpN80VmcKhM5ITia+TgxBGoB5C+mJeBo
        eVBf/ZHGm1hw4Vaz8kwG0qN97MyxbhPfNEhIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U/qR+4vKip0KoQIMSFdR/hcV+AGsyhxo
        6mvR14b72Crhg2GkckumPrXgCgcUewKf/LPBohZ5ctGJ0I55PW7suDTBmWKLfbrR
        vj4CfDl33dhfpBum5S/KvVU4AfR3r5hJ3nyZnjP5xtFonCr7zIloHGgBPwBOEhf4
        WA5Vg3QqjWo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D79EB77DEA;
        Wed, 16 Sep 2020 00:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67E3C77DE9;
        Wed, 16 Sep 2020 00:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Pass --ipv4 and --ipv6 options to sub-fetches when
 fetching multiple remotes and submodules
References: <20200915115025.GA18984@pflmari> <20200915115407.GA31786@pflmari>
        <20200915130606.GB2839276@coredump.intra.peff.net>
Date:   Tue, 15 Sep 2020 21:17:41 -0700
In-Reply-To: <20200915130606.GB2839276@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 15 Sep 2020 09:06:06 -0400")
Message-ID: <xmqqimcexsm2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 909A45F0-F7D3-11EA-8F58-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 15, 2020 at 01:54:07PM +0200, Alex Riesen wrote:
>
>> The options indicate user intent for the whole fetch operation, and
>> ignoring them in sub-fetches is quite unexpected when, for instance,
>> it is intended to limit all of the communication to a specific transport
>> protocol for some reason.
>> 
>> Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
>> ---
>
> Regardless of whether we move forward with the parse-options flag or
> config discussed in the other thread, I think this is an obvious
> improvement that we should take in the meantime.

Yes.  Others can wait.  ipversion configuration variable is probably
easier to sell; parse_options thing deserves a longer and deeper
thought as it will affect the API future codebase would rely on.

Thanks.
