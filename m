Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337D920954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdLDVfG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:35:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58241 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751701AbdLDVfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:35:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8037AAF131;
        Mon,  4 Dec 2017 16:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=voAieSLBWDz/tQHKsiO8udCDPV0=; b=jGtR6e
        naxr0Euw3G2aaIK0KVzadQigRCM03cAOm/maPHLtwT7EnZ9/x+DfLoqqQvvoUM74
        Temd5CqZ1IM6MpiIPSFBK38QDXi9kjQ/u9iEqB52IHoKfQVFB1gBDkFwpiewwS6D
        PHW8WAxhNYf4lRcsOyw/gT+xyGWBRl264/5z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jyGBzbPymTvwR9u7Oep1vgn32fJ3gx/l
        5EyEjAOhTtJdg0278p5K89bTBCkLiaONCV1cBzGW66odwDZ32dwU4OSB1+QleHKQ
        Y7JxlGQmmBqnb3jccw5mnaksdHsqY4L5ffKKwh1lN+I8f939H+SlKBGTYJasdLXC
        UGDvN+udvvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74530AF130;
        Mon,  4 Dec 2017 16:35:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD9D4AF122;
        Mon,  4 Dec 2017 16:35:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, peff@peff.net, nico@cam.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] progress: print progress output for all operations taking longer than 2s
References: <20171204203647.30546-1-lars.schneider@autodesk.com>
Date:   Mon, 04 Dec 2017 13:35:00 -0800
In-Reply-To: <20171204203647.30546-1-lars.schneider@autodesk.com> (lars
        schneider's message of "Mon, 4 Dec 2017 21:36:47 +0100")
Message-ID: <xmqqzi6ykwhn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCACF810-D93A-11E7-A15F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> In 180a9f2 we implemented a progress API which suppresses the progress
> output if the progress has reached a specified percentage threshold
> within a given time frame. In 8aade10 we simplified the API and set the
> threshold to 0% and the time frame to 2 seconds for all delayed progress
> operations. That means we would only see a progress output if we still
> have 0% progress after 2 seconds. Consequently, only operations that
> have a very slow start would show the progress output at all.
>
> Remove the threshold entirely and print the progress output for all
> operations that take longer than 2 seconds.

Isn't this likely to result in much chattier progress output (read:
regression) forplaces whose the (P, N) was (0%, 2s) before 8aade107
("progress: simplify "delayed" progress API", 2017-08-19)?

Before or after that change, the places that passed (0%, 2s)
refrained from showing any progress, if at least 1 per-cent of the
work has finished at 2-second mark.  With this change, they will
suddenly start showing progress after 2-second mark, even if they
completed that much work already.

The places that did change the behaviour with the cited change are
the ones that used parameters different from (0%, 2s).  "git blame",
"diffcore-rename" and "unpack-trees" seem to be among them; they
used (50%, 1s), and we'd have seen the progress meter after 1s,
unless half of the work is already done by that time.  By replacing
that with (0%, 2s), the change made it a lot less likely to trigger.

The analysis in the cited commit log claims that (50%, 1s) is
equivalent to (0%, 2s) when the workload is smooth, but I think that
math is bogus X-<.

And the one in prune-packed, which used to be (95%, 2s), is quite
different from the value after the simplification.  We deliberately
made it 95 times more unlikely to trigger with that commit---it used
to be that unless 95% of work is already done, we saw progress
starting at 2-second mark, but now we see progress only when less
than 1% of work is done at 2-second mark.

