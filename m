Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71670C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE88206EF
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fz43vcj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgBVR0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:26:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55132 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 12:26:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FEA6BA27E;
        Sat, 22 Feb 2020 12:25:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6k2qcVbaqebK2f64oj96E+qloSU=; b=fz43vc
        j19KkO9kXpNv3UZ9mBxj7ZHv2H+uo/uDTq65cseDZvk779MBJtmKoUtuSC4PpCkV
        Db5OLO49GFVRpPNHRCOX4PHOELpv5YPruzaozYa9tPKe0mCT6woXv9gIv+NQHc7K
        wtr3Z6q60vmc+3Qxg5YXFPxsW9mq/2Ss3sCAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YFB8rqDFdbCI0HJN3rJfy/hudSQbaAt9
        F76wgMmuGtL0EohEXEZW/7qDDo8SADaOx5q/i/OuQzMuyPxRmFEe3sSvaC38FB+6
        fgBatfwGFE9+9st9Ggb0mwQ9Zoy35XOoo7RxDg4XWyY/vnevwX5Kgq50An1KmOdQ
        6hakOhtcWiI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67E10BA27D;
        Sat, 22 Feb 2020 12:25:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92D2FBA27C;
        Sat, 22 Feb 2020 12:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/2] Document two partial clone bugs, fix one
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
        <pull.556.v2.git.1582321648.gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 09:25:54 -0800
In-Reply-To: <pull.556.v2.git.1582321648.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 21 Feb 2020 21:47:26
        +0000")
Message-ID: <xmqqy2su5yal.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 629E8310-5598-11EA-97FA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While playing with partial clone, I discovered a few bugs and document them
> with tests in patch 1. One seems to be a server-side bug that happens in a
> somewhat rare situation, but not terribly unlikely. The other is a
> client-side bug that leads to quadratic amounts of data transfer; I fix this
> bug in patch 2.
>
> UPDATES in V2:
>
>  * Added "|| return 1" inside the for loops.
>    
>    
>  * Added an in-test comment about the test ordering.
>    
>    
>  * Required protocol.version=2 in the tags test due to the bisect Junio
>    performed.
>    
>    
>  * Updated the commit message via Jonathan Tan's suggestion.
>    

Now this can safely be queued directly on v2.25.0, I'll
rebase it (earlyer I queued it after the merge to make protocol v2
the default).

Thanks.
