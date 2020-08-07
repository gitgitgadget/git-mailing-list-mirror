Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87DC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FBB2177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J0T01Izt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHGWFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:05:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53855 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGWFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:05:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE3B2601F9;
        Fri,  7 Aug 2020 18:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/Mm8gCVyurbEH4i1Tzbu/xkS3c=; b=J0T01I
        zt0a7IE1JwRxsHr2OcM9VCvRT6QbtDccmcx1usmaGI3uJh2J1bz+9XHOsGERaVgX
        Fkzun5UIqQH7sAHCJUeJ1MwO4VQBKbp4u1ExhGWSHoZUiBAQKAguTciJn6I8iIhY
        C2q8BWS9wRi33rTIuu2m5YNvxdL1cPV+cRc2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b0Ho+awc9BYJ+DYJoD1uBhn+wAmbI3HK
        xsOq0dZ2IHpkOJDM9MjtuD5WhqXOBb2XYKitNF1LyJnme7qD3LjCclWwUASWiOui
        Y4xxUzzmDWtw02An8pXwBMTk6zZQtSqzV9fliOWa1tsaY3eTgyRj2zGwZAthc8tu
        NKqJYh64pPY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5DFC601F7;
        Fri,  7 Aug 2020 18:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42276601F5;
        Fri,  7 Aug 2020 18:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nuthan Munaiah <nm6061@rit.edu>, git@vger.kernel.org
Subject: Re: `git blame` Line Number Off-by-one
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
        <20200807212159.GA1871940@coredump.intra.peff.net>
        <20200807213349.GB1871940@coredump.intra.peff.net>
Date:   Fri, 07 Aug 2020 15:05:27 -0700
In-Reply-To: <20200807213349.GB1871940@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 17:33:49 -0400")
Message-ID: <xmqq7duaf6xk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A4C58A4-D8FA-11EA-8C60-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Dropping it entirely, as below, doesn't break any tests. Junio, do you
> know of a case this is meant to improve?

I think the only conceivable case is that in the middle of a single
block of text in an ancient version, another block of lines gets
inserted during the evolution of the file, but in the end these
intermediate edits all go away and the same original text remains.

In such a case, without coalescing, we would not treat the original
single block of text as a single unit.

IIRC, blame has some threshold that makes too small a block not
subject to move and copy detection, and it is most likely to avoid
fragmenting the blocks too small.

