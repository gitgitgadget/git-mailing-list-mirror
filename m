Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60821F4C1
	for <e@80x24.org>; Sat, 12 Oct 2019 00:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfJLAr1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 20:47:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58829 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfJLAr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 20:47:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B21481C19;
        Fri, 11 Oct 2019 20:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CO9axGqz1y4LEQdJXXUZrblVOo4=; b=aCu6XY
        UuJG29W2z3kI5nhqEiy/Ras6srHTVB1OwwyKIgvrrLAHwLGMT5w+QaUitACpqqTt
        vJROSKlWKuB+YhhWKte9Ol6KON5DVlrGwq+3B7XUFRIucR/sbn8mPh5qyVhomYk4
        NWf1tCJB41H9b6TjchJ24HMKYKTsL8AeLbjc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZxhcXCiTukN8+xB6THW/l94iJ2PjLRiY
        XvHR32JBla5Gqrd/n5Xox9MsQ3Ju9tGqecZBIBGhe0E2DaxHZ+xd1hprrzTGLT+v
        s/IBAmKZSFCir5Cvq3GjRcCFwwmiCGqcw0sJjBlRFoCIDTazPK4N6soetVCTomnC
        q+CEctwT4AY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6263E81C18;
        Fri, 11 Oct 2019 20:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8EE5181C15;
        Fri, 11 Oct 2019 20:47:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-pack: never fetch when checking exclusions
References: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
        <20191008183739.194714-1-jonathantanmy@google.com>
        <20191011061257.GD20094@sigill.intra.peff.net>
        <a87cf3ce-fbff-ef4e-941e-bd2da0bf182f@gmail.com>
        <20191011161504.GB19741@sigill.intra.peff.net>
Date:   Sat, 12 Oct 2019 09:47:20 +0900
In-Reply-To: <20191011161504.GB19741@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Oct 2019 12:15:05 -0400")
Message-ID: <xmqqftjyg57r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA24B094-EC89-11E9-B714-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As a general rule (and why I'm raising this issue in reply to Jonathan's
> patch), I think most or all sites that want OBJECT_INFO_QUICK will want
> SKIP_FETCH_OBJECT as well, and vice versa. The reasoning is generally
> the same:
>
>   - it's OK to racily have a false negative (we'll still be correct, but
>     possibly a little less optimal)
>
>   - it's expected and normal to be missing the object, so spending time
>     double-checking the pack store wastes measurable time in real-world
>     cases

31f5256c ("sha1-file: split OBJECT_INFO_FOR_PREFETCH", 2019-05-28)
separated SKIP_FETCH_OBJECT out of FOR_PREFETCH, the latter of which
was and is SKIP_FETCH and QUICK combined.  Use SKIP_FETCH_OBJECT
alone may need to be re-examined and discouraged?

