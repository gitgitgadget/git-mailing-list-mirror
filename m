Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA34C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiA0Xrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:47:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56251 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiA0Xri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 18:47:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB3BA177111;
        Thu, 27 Jan 2022 18:47:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nvT0wYI4ZaqxWUISMQ1ArK2ZabzW4J19HvCfo1
        bMd3U=; b=Yk+bWk/vvJMqlIxeGJ6k55Tb9F/K39Kmg81wxZfwMAhXn3c4yAZAIk
        IZ4Cn/GpVDegfWTp5Gl14Qu6y01ifSoX7oAVGHk0CcW2WWmBCF9X93CQLsIFW6zu
        giYDH5HFMVRK9ppKlTS5p1n4ndrkDN52+AUI6Fo03GG8Lt346/Mn4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3CFE177110;
        Thu, 27 Jan 2022 18:47:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D49E17710E;
        Thu, 27 Jan 2022 18:47:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin.jarry@6wind.com>
Cc:     "Emily Shaffer" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive
 when client exits
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
        <20220126214438.3066132-1-robin.jarry@6wind.com>
        <xmqqv8y54wxc.fsf@gitster.g> <CHGCP9P33XDQ.3FEWHU0PBMNU6@diabtop>
        <xmqqr18t2fxl.fsf@gitster.g> <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
Date:   Thu, 27 Jan 2022 15:47:34 -0800
In-Reply-To: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop> (Robin Jarry's message of
        "Thu, 27 Jan 2022 21:53:32 +0100")
Message-ID: <xmqqa6fgzqp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81056332-7FCB-11EC-9524-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin.jarry@6wind.com> writes:

> My main goal is to abort a push if a user hits ctrl-c (or is
> disconnected) before the objects have been moved to permanent storage.
>
> But this always leads to errors on the client side when receive-pack
> sends the "keepalive packet":

Yes, you'd need to make all three new combinations work if you touch
the protocol.  An updated "receive-pack" must be inter-operable with
a vanilla "push" as well as an updated "push", and an updated "push"
must be inter-operable with a vanilla "receive-pack".

You'd need to invent a new protocol capability, advertise it on the
updated "receive-pack" side, and the updated "push" must check if
the capability is advertized before asking to activate it.  Then
only after both ends discover that the other side knows how to deal
with "keepalive" packets, use that feature.

