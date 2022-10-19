Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C74C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 16:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJSQ6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiJSQ6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 12:58:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE81CFF25
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 09:58:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C62B41AC0FC;
        Wed, 19 Oct 2022 12:58:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QuedxrVhVEFi8qyCAvfUf+XMVSOlYTU9O6M3b/
        kPg3g=; b=EJBHFXf+24dghaR/gafmSfp987AS+bsC0U/BJbBlO/yaKODKrKfS8p
        AOSMoBu6pKUmboSc0gLl02c2mkMmBBJTiD7b/8rm2i/W6qc2Jkdnmh/g4/VbpT9z
        JrCZkpQ8Eo18eyPbQTY24QdZMAH6LhmChD8FR+uS9a+por7pZdYi8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B26CC1AC0FB;
        Wed, 19 Oct 2022 12:58:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAE321AC0F9;
        Wed, 19 Oct 2022 12:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqo7u9wyt7.fsf@gitster.g>
        <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
        <221019.86bkq8hake.gmgdl@evledraar.gmail.com>
        <CAPig+cRi8RVdmPbDdTzDCpXKjUsbOJNc5Pr+d02OQ9jENHUjfQ@mail.gmail.com>
Date:   Wed, 19 Oct 2022 09:58:22 -0700
In-Reply-To: <CAPig+cRi8RVdmPbDdTzDCpXKjUsbOJNc5Pr+d02OQ9jENHUjfQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 18 Oct 2022 22:28:14 -0400")
Message-ID: <xmqqedv3sqc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E3985CC-4FCF-11ED-82EC-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I don't know how germane it is to the current thread, but previous
> discussions[1,2,3,4] favored dropping use of Apple's Common Crypto
> altogether since it doesn't seem to buy us much (or anything) and is
> incomplete; it doesn't support all of the OpenSSL API Git uses.

Yeah, that matches my recollection.  Unless the situation has much
changed, dropping it may not be a bad thing to do.

But

 * Fixing the fsmonitor code so that it can also be used with things
   other than Common Crypto is the most urgent.  The topic gave us a
   grave regression (those who used to successfully build Git can no
   longer build with their favourite configuration).

 * Updating the build procedure so that sha1dc is used by default
   everywhere is a good idea, but that is less urgent and should be
   done separately, preferrably long after the dust settles from the
   above.

 * Removing Common Crypto support may not be a bad idea, but that is
   even less urgent, unless the support burden is slowing us down or
   forcing us to settle on common set of features that is too
   limiting.

Thanks.
