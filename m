Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDE31F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 08:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeKNSIo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 13:08:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64767 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeKNSIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 13:08:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D6E011DB54;
        Wed, 14 Nov 2018 03:06:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U79eFeIN5zvhlSpOHb/0mUxPhtc=; b=RRpbsc
        4rooIX4veTIuxVZxCQ/zaz3rDJgRTK/+VpOD7OdVs+QmgUByz2luW42IZJkDWW9N
        ickH/YSDI/pdED1mN545pINcZvj4c5CEeWtdRetTiohqZ98veXGApgdIiqotVN6e
        WS1cg8R9v7T4G/W1tVxf+H/XO7zsHc/bEHT2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sNRsKC1S2asei23zBIuZ53/N0fISknZI
        ph0r9URJLAhAvHHUcpYzDOPJara7QduJGjmg3xhq4jAGN67i4EqxYDRVbbQQdtTf
        sMzFueNj2U9KI2dGqJrnx66GMm4iUPJ6XroNNdhf1o00MTJBi8Q7V1q5ptRlv1gA
        XeeG8csDLC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43C1011DB53;
        Wed, 14 Nov 2018 03:06:34 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7401E11DB52;
        Wed, 14 Nov 2018 03:06:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] commit: don't add scissors line if one exists
References: <cover.1542172724.git.liu.denton@gmail.com>
        <1c16b9497bd630f0636aa7729082da7a90ba42d9.1542172724.git.liu.denton@gmail.com>
Date:   Wed, 14 Nov 2018 17:06:32 +0900
In-Reply-To: <1c16b9497bd630f0636aa7729082da7a90ba42d9.1542172724.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 14 Nov 2018 00:24:53 -0500")
Message-ID: <xmqqwopgm6bb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3359E748-E7E4-11E8-A061-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> If commit.cleanup = scissors is specified, don't produce a scissors line
> if one already exists in the commit message.

It is good that you won't have two such lines in the end result, but
is this (1) hiding real problem under the rug? (2) losing information?

If the current invocation of "git commit" added a scissors line in
the buffer to be edited already, and we are adding another one in
this function, is it possible that the real problem that somebody
else has called wt_status_add_cut_line() before this function is
called, in which case that other caller is what we need to fix,
instead of this one?

If the existing line in the buffer came from the end user (perhaps
it was given from "-F <file>", etc., with "-e" option) or --amend,
how can we be sure if it is OK to lose everything after that
scissors looking line?  In other words, the scissors looking line
may just be part of the log message, in which case we may want to
quote/escape it, so that the true scissors we append at a later
place in the buffer would be noticed without losing the text before
and after that scissors looking line we already had when this
function was called?

