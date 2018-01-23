Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978BF1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeAWUNP (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:13:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56564 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeAWUNO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:13:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DF5DB9B5C;
        Tue, 23 Jan 2018 15:13:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r1r5xb5Hl9zRSa9xQrZsPgdEjl0=; b=pAj/wl
        Z135OpJJ/z6MdWMFgXKJM4XvGoMjp23dOxabh28L/T5zQuLCe3H0Th98wFE8MDzI
        acYHr35m0EuKTY+yQ/3qHJfpSjKVVyBsMjLoMRoRbgEirzR/NprzlFY9tZVBh2C6
        jQhN38EhAGw+adeLrIOAq5K+ssdtPdVZyEVwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q3dMFrXdqMzblTrdmhCOJFLUNeIgvt68
        MYyvziwlj1ZPVpTUxmaSlYZpbswiYiHdyWEALDwzMD4NExUz/mTHM+wZLKOtg4DA
        BsV7du2cAUKL2l2cx4LIx3AfV3qTe+vW3tf4GJJT7kT7cVwO5PYZlQ+RXDbe3l0L
        tjbdV9Dd65I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 558A1B9B5B;
        Tue, 23 Jan 2018 15:13:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88D40B9B58;
        Tue, 23 Jan 2018 15:13:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to recreate merges
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de>
        <CAPig+cSn_X-0iir-cKSd=P8p5QCxrR2qU_GBj7zDbv8zTc+AQw@mail.gmail.com>
Date:   Tue, 23 Jan 2018 12:13:12 -0800
In-Reply-To: <CAPig+cSn_X-0iir-cKSd=P8p5QCxrR2qU_GBj7zDbv8zTc+AQw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 19 Jan 2018 05:34:20 -0500")
Message-ID: <xmqqa7x4gwpz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D72ADF6A-0079-11E8-B87E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +               is_octopus = to_merge && to_merge->next;
>> +
>> +               if (is_octopus)
>> +                       BUG("Octopus merges not yet supported");
>
> Is this a situation which the end-user can trigger by specifying a
> merge with more than two parents? If so, shouldn't this be just a
> normal error message rather than a (developer) bug message? Or, am I
> misunderstanding?

BUG() is "we wrote code carefully so that this should not trigger;
we do not _expect_ the code to reach here".  This one is expected to
trigger, and I agree with you that it should be die(), if the series
is meant to be released to the general public in the current form
(i.e. until the limitation is lifted so that it can handle an
octopus).

If the callers are made more careful to check if there is an octopus
involved and reject the request early, then seeing an octopus in
this location in a loop will become a BUG().
