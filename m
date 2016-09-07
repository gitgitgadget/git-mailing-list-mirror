Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2011F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934812AbcIGR6P (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:58:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932255AbcIGR6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DBE537761;
        Wed,  7 Sep 2016 13:58:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FgJsAtQlmKb3CxBTb8MIbjJXU28=; b=gviIEm
        8diR80XMdEdTgocPbU2dmKOlS6EKAI6sCQ38zQFcFAKSbtDcEgHquEBR3pIsu3wy
        5qPOV8lA26TjdlsgPou4diBiPI9UjY2wUzryRWnktdndcHUaBfcTk+XE+rw4vd//
        cgMtgJwbNHHd8UGVgByob75Xg/uH/41w1aCCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mnferx4NRqjf8lXeVOPbZ9h9FSu/CS/y
        wLpjjQU3ehM0kvBDq4/kpgNL/3Gg5i4VQm5pg8frHpqMVOs8M7fRsYCZwTRnG2Yh
        csviPA0+Xk4UiOFgOoEAse/94YU79dNfZLHv2irc9ezQDW6YGVyPonJPGxTCCam1
        ekqhcJQ4ej0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 658783775F;
        Wed,  7 Sep 2016 13:58:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E33833775E;
        Wed,  7 Sep 2016 13:58:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 7/7] blame: actually use the diff opts parsed from the command line
References: <cover.1471864378.git.mhagger@alum.mit.edu>
        <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
        <fe96d9e6-b306-0b57-8f24-6106b7e285cb@web.de>
        <a6d9e9a7-76c4-5b26-0b49-55698369180d@alum.mit.edu>
Date:   Wed, 07 Sep 2016 10:58:10 -0700
In-Reply-To: <a6d9e9a7-76c4-5b26-0b49-55698369180d@alum.mit.edu> (Michael
        Haggerty's message of "Mon, 5 Sep 2016 06:12:41 +0200")
Message-ID: <xmqq37lboaml.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5123780-7524-11E6-818A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The reason that I would prefer to change `blame` as part of this patch
> series is that I think it would be disconcerting for `git diff` and `git
> blame` to use different heuristics when computing diffs. It would make
> their output inconsistent.

I do think it is the right thing to do.  With your shifting heuristics,
"git diff" would attribute an addition of a whole block more
correctly, e.g.

	 }

        +foo {
        +	bar
        +       baz
	+}

instead of attributing the tail of the new thing to the old author,
and the "blame" should take advantage of the better heuristics as
well.
