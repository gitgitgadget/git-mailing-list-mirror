Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A8C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 20:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhLEUQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 15:16:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61629 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 15:16:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 620E8102BCC;
        Sun,  5 Dec 2021 15:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N7kn9c7jVkAgRmq6T0JrXHT32zrLhegImliglL
        ofxgA=; b=I2M81cRfIVSn8rJzeDteSYyqPGm7AaRq1auIIG28gJ6dDc7hkKZOWk
        22qXh4Ce3Ie24w7PaBbcerfc0KByvzVaeZYdVtJXe2S3aNX+C6dT47MTdogby4gm
        1i0f8IZ9kF4tjaqLkCPN8S2WpjZItPsQ3HNoQCNlj1K7dHXbnpWXc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A5EF102BCB;
        Sun,  5 Dec 2021 15:13:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B501A102BC9;
        Sun,  5 Dec 2021 15:13:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
References: <xmqqee6vwj67.fsf@gitster.g>
        <20211202102855.23907-1-jengelh@inai.de> <xmqqee6spz9s.fsf@gitster.g>
        <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr>
        <xmqqtufnonor.fsf@gitster.g>
        <34pqs81o-36p6-s416-s791-1onsqo1734oo@vanv.qr>
Date:   Sun, 05 Dec 2021 12:13:27 -0800
In-Reply-To: <34pqs81o-36p6-s416-s791-1onsqo1734oo@vanv.qr> (Jan Engelhardt's
        message of "Sun, 5 Dec 2021 11:13:32 +0100 (CET)")
Message-ID: <xmqq7dcilsig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF7EBDC6-5607-11EC-B2C9-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> writes:

>>Also, will the real Git clients, which are the primary intended
>>audiences this program is trying to talk to, be OK if we suddenly
>>start giving a non-empty 404 page?
>
> I am confident enough to say yes. It's not like git-http-backend
> returned anything previously in the 404 case (like JSON or so),
> therefore clients could not possibly depend on content.
>
>>If any implementations of Git HTTP client this program is serving
>>(1) uses a 404 response as a cue to decide its next request
>>(e.g. there may be some "try this URL and if it fails, do another
>>one" fallback logic)
>
> Not sure if they heed Location: headers, but I am not changing
> that :-)

I was more worried about clients barfing because they depend on
*not* having content.  They parse the status (404) out, and then
leave the message part untouched---they may not even read the
message in full, and that did not matter because there wasn't
anything to read and discard.  Now we are sending more.

As long as the leftover bytes would not cause problem with the
action they take after that step, we would be OK.
