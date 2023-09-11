Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E5DCA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349099AbjIKVce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbjIKTTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 15:19:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46EF9
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 12:19:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 828DE1AAD61;
        Mon, 11 Sep 2023 15:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=t38zn8akjc3JiOD7HJkNcbq3qlTQL174a+h8Bp
        foIag=; b=aDXdsfrw70jBhgfxTXiSpXPMTymkVRt8vaB6G1/4LUOaoa6JMIBTnF
        lRK9u2945lQO2zaJUaNLFDM+PCaBUjtbILBfJeAYTMon36l5JD7VuS33pXGcUCT9
        YQkKp+6IcVqj4s7/jV89SEpaqCnbPVfj4I7ZboeF+zJ3chx7fskD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B1691AAD5E;
        Mon, 11 Sep 2023 15:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1D411AAD5A;
        Mon, 11 Sep 2023 15:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
In-Reply-To: <ZP4NrVeqMtFTLEuf@nand.local> (Taylor Blau's message of "Sun, 10
        Sep 2023 14:40:45 -0400")
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
        <ZP4NrVeqMtFTLEuf@nand.local>
Date:   Mon, 11 Sep 2023 12:19:17 -0700
Message-ID: <xmqq7cowv7pm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AE4BA5A-50D8-11EE-A611-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> callback, something like:
>
>     struct option {
>         /* ... */
>         union {
>             void *value;
>             int *value_int;
>             /* etc ... */
>         } u;
>         enum option_type t;
>     };
>
> where option_type has some value corresponding to "void *", another for
> "int *", and so on.

Yup, that does cross my mind, even though I would have used

	union {
		void *void_ptr;
		int *int_ptr;
	} value;

or something without a rather meaningless 'u'.

> Alternatively, perhaps you are thinking that we'd use both the value
> pointer and the value_int pointer to point at potentially different
> values in the same callback. I don't have strong feelings about it, but
> I'd just as soon encourage us to shy away from that approach, since
> assigning a single callback parameter to each function seems more
> organized.

We have seen (with Peff's "-Wunused" work) that there are small
number of cases that it would be handy for a callback to be told the
locations of multiple external variables, but I do not think it
would be a good solution to that problem to have "void *value" and
"int value_int" next to each other and allow them to coexist, as it
would work only when these multiple variables happen to be of the
right types.
