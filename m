Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD761C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 02:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E57561406
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 02:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhDUCP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 22:15:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60351 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhDUCPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 22:15:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D967ABB212;
        Tue, 20 Apr 2021 22:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=neM4ko7FdOwZYm7m1jFtbd3dygU=; b=odX27Q
        6Lj6AzJuWZ4I1W2nRmptzHxS7Rx5yJvGs7clsgLAGMXIB+vdP8RRErsgCO9wcc5+
        1PeArGFTI0sBEfHLLbrXDLi2pQYPzlHANeYeb4neCt0BKT13EgD67c2zZA64Y+uv
        VhSRKRyz2hn4PjYuwRqBcGmrbf5vJMpP90VUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E0F5ELo1F7sbMp2qPezpkaR/NPRQmlUR
        /W1yvVbH7XLoKdShKpcroXGa712Qg3zlriCYvNuhhqUpOWxEkOaboNvT0SUlEUky
        zTpMthOFiQAYmEhWjiZbNgIv1gIOXBNlPa7W0CT9I6jvOR3VHzmwc/wCnoZze43d
        8msq/qs1QFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0A01BB211;
        Tue, 20 Apr 2021 22:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 566DDBB210;
        Tue, 20 Apr 2021 22:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: silence errors for success cases
References: <20210421004733.22395-1-jerry@skydio.com>
Date:   Tue, 20 Apr 2021 19:14:51 -0700
In-Reply-To: <20210421004733.22395-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 20 Apr 2021 17:47:33 -0700")
Message-ID: <xmqqtuo0z8mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B5717BE-A247-11EB-AD5C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Certain invocations of "git apply --3way"
> will print error messages even though git
> is able to fall back on apply_fragments and
> apply the patch successfully with a return
> value of 0. To fix, return early from
> try_threeway() in the following cases:

I suspect that this is a recent breakage after we swapped the order
of 3way fallback.  It used to be that we tried the straight
application first (while suppressing the error messages) and then
fell back on 3way (while fully exposing the error messages).

It is understandable if we just swapped the order without changing
when errors are squelched, we may leak unnecessary error messages
while trying 3way and failing.

After having written all of the above, I just realized that the
swapping of the order was _your_ topic and you didn't have to be
explained any of the above ;-)  Just consider it as my thinking
aloud for the benefit of those who are reading from the sideline
(i.e. those not on the To/Cc list but are reading because this
message is sent to git@ mailing list).

