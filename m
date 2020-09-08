Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D12C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57FD2098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SODcG2at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgIHQeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:34:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbgIHQeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:34:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C5ACEC756;
        Tue,  8 Sep 2020 12:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SThnONbQdSWwt8YL0THWX6oMUk4=; b=SODcG2
        at23IToB82zNnmRFv2qMBPBdYHNcfkyfEgP/ZqH62w+igfk0HHTyGisMVFETyg8A
        veW59yhkxG35RGyDJyd6LH1QHIMtFMuhY10w8pSDKnUWQIsMiTNkWve2jSadHAaa
        1Zu7wLgS6sukijLRHk6to13QkKRTkjEEeK8K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jiDK5n+RGkVHfZQ+XWp2iMa8zJD7EZOp
        YtJszT0tD/WgnIxhSNy50njiKjmwMsUPW5tPlgGfe3MhHmS3Xl7pi+T21HqeLMVT
        cqLj+8Bzw8XibCUIGClGK4AcR7RxM7ASLY+FcfZZcyFTSWEKg3johYXb8onDv/gT
        6UHXc3PjHbo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75498EC754;
        Tue,  8 Sep 2020 12:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C01BFEC750;
        Tue,  8 Sep 2020 12:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ash Holland <ash@sorrel.sh>
Cc:     git@vger.kernel.org
Subject: Re: `git describe --dirty` doesn't consider untracked files to be dirty
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
Date:   Tue, 08 Sep 2020 09:33:59 -0700
In-Reply-To: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
        (Ash Holland's message of "Mon, 7 Sep 2020 10:04:17 +0100")
Message-ID: <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A3F8E84-F1F1-11EA-AF73-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ash Holland <ash@sorrel.sh> writes:

> There seems to be a discrepancy between how `git describe --dirty` is
> documented and how it actually behaves. The documentation describes
> the --dirty flag like this:
>
>> If the working tree has local modification "-dirty" is appended to it.

Not limited to what "describe" does, whenever we mention "local
modification", we only mean modification to tracked contents,
because by definition we do not detect or track "modifications" to
anything that is not tracked.  Untracked paths may have been
modified multiple times, but since they are not even added, we do
not notice nor care.

That is to say that the documentation and the code are consistent
with each other.

Having said all that, a source that was forgotten to be added, yet
affects the built product by a build rule with wildcard e.g.
"compile all *.c files and link them into a single binary", would
happen in real life, so from that point of view, appending "-dirty"
only when there is a local modification may not be all that useful,
and tweaking the "--dirty" option to also pay attention to untracked
(but not ignored) might have merit.  

I do not think this is something we want to hide behind a
configuration knob, but I am undecided between (1) declare that this
is a bug and change the behaviour of "--dirty" and (2) declare that
we discovered another useful behaviour and add a new option next to
"--dirty".

Thanks.
