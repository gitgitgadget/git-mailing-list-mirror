Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97924C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3B66101C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhDSUtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:49:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56389 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbhDSUsA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 16:48:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09704C82B6;
        Mon, 19 Apr 2021 16:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8gtfptF4Z5b+nd+y8gmGEbTTG+c=; b=dNlXJ3
        hV4URXg2bS48CZ6HcF2Cb2Hj7/feWrxY3lXMxeU9GW+hzy/RKgD076zYn/EMHM+q
        3+fh7D3q32PkANj8WMeUbqzB4c/k3AiHGzs2oEJYhyxjk2CjgFBuvfGckhz1Gx9y
        s3L9QHG/D5cgJaWKrXmAjo+b/buPknj/MXv1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EszirFgWWFoT5aMQRr3V0cgOH2cYWkI1
        xJ00DhUp/QIM0Wy+v7H0lsZexY5+7EczHttE6kVpggdW2pDqfaQknuv9ine7byWw
        66qo87RxFb1VK8wbDXKB8J1pAP0cMNZEnuVIO09zb1MJfUjyeReExQMNuxdtUeae
        mhml4ZztVlE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F379EC82B5;
        Mon, 19 Apr 2021 16:47:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BB3CC82B4;
        Mon, 19 Apr 2021 16:47:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cristian Morales Vega <christian.morales.vega@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git checkout behaviour when only ctime of file changes
References: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
Date:   Mon, 19 Apr 2021 13:47:26 -0700
In-Reply-To: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
        (Cristian Morales Vega's message of "Mon, 19 Apr 2021 10:11:12 +0100")
Message-ID: <xmqqh7k29f35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73AEE690-A150-11EB-BA16-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cristian Morales Vega <christian.morales.vega@gmail.com> writes:

> I thought you may want to take a look at
> https://issues.jenkins.io/browse/JENKINS-65395.
>
> Basically after something updates the ctime of a file, a
> "git checkout" can behave differently depending on whether a
> "git update-index --refresh" has been run before or not.

Changes to ctime, not just to mtime, participate in "the path may
have been changed so need to go back to the contents to see if it
truly has" logic, and "update-index --refresh" is a mechanism to
clear that "the path may have been changed" bit.  

So if your "behave differently ... with or without refresh" happens
equally if you replace 'ctime' in your statement with 'mtime', then
everything is working as designed.  But it was unclear from your
description.

Assuming that the difference with and without refresh after mtime
change is the same as the difference with and without refresh after
ctime change, the "core.trustctime" configuration variable is for
those whose files have untrustworthy ctime (due to background
scanners and other funnies).

