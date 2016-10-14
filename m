Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6921F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbcJNRkd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:40:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752988AbcJNRka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:40:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A69545573;
        Fri, 14 Oct 2016 13:39:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zBMbUCUNTKnqkdGS39W6eTfVCw4=; b=KIHzWn
        GanW9aa6sIkMsCjmA7o5+sM7rU37mh47bUq3zcuWwFKuj8z01oH8Qyf+asoWjh4t
        fVjti/VM2+yfV5gLGGHbO5SXdXT/rFzNyKpfMFg7AJ4iauEJjyThu4u/cNIV+asZ
        IbICk18okWmBrwN+SxsbpLNmzd9XcH/rlIhtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjJXMoWSdBA/U0o9M5/cE563sO05zoUy
        Aoiv45m9bV5Pl6ErXP4yPqF5D6CuxMviZ95gmU/1kPC2veiEvzkp7gdsZLK4Af+E
        isAbg9lite78FMBo9Bt2+96fraJcxtAQHFgJVz+VqLMVlsPlBDw3UTvX4vHPhTXK
        h85SNzXA3Ew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2334545572;
        Fri, 14 Oct 2016 13:39:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93F5B45571;
        Fri, 14 Oct 2016 13:39:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: use "quick" has_sha1_file for tag following
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
        <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
        <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
        <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
        <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
        <20161013200644.lnustevmpvufbg5y@sigill.intra.peff.net>
Date:   Fri, 14 Oct 2016 10:39:52 -0700
In-Reply-To: <20161013200644.lnustevmpvufbg5y@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Oct 2016 16:06:44 -0400")
Message-ID: <xmqqfunyzv6f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37B438D6-9235-11E6-B2D0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So it's certainly better. But 7500 packs is just silly, and squeezing
> out ~400ms there is hardly worth it. If you repack this same case into a
> single pack, the command drops to 5ms. So yes, there's close to an order
> of magnitude speedup here, but you get that _and_ another order of
> magnitude just by repacking.

"7500 is silly" equally applies to the "quick" (and sloppy, if I am
reading your "Failing in this direction doesn't make me feel great."
correctly) approach, I think, which argues for not taking either
change X-<.

I agree that the fallout from the inaccuracy of "quick" approach is
probably acceptable and the next "fetch" will correct it anyway, so
let's do the "quick but inaccurate" for now and perhaps cook it in
'next' for a bit longer than other topics?
