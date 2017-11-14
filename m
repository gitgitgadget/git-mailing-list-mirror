Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67637201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 05:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbdKNFr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:47:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750795AbdKNFry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C8D9AED80;
        Tue, 14 Nov 2017 00:47:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPxvq9RxMtVQEUW9VQncK5/aO+A=; b=xYK1N+
        AEL5eH+sNRzPsIX8eNc9NOCtV7ZBUPgHncG+Ce1+4PICyknoTMAu9YAJWV1JId2f
        LgMqY4DlzYYNETxH/afEquuuonPjQDHgARxU2KTB0bR3R+iWMpdtMyTCPHIS0vzX
        lNyoga+9Y89C92V36su3bNq6pEBWXwGTKAErI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AiuS/dFtLt+j39Ce96Lz9L4BrHdla/I2
        /3auYzk35UUlbPVUp1G5DPalBM22LyaDj2fOsghBYwc+qOA1aMK8UrVEHaatlbgi
        gthnM1HO/R33YKUP1jsbI1DonOKAuaIyjYldrK5zIVcGHjRuIjBw1sF3BKoXbbR+
        ZkrQYyGwcZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 130F2AED7F;
        Tue, 14 Nov 2017 00:47:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85DEDAED7D;
        Tue, 14 Nov 2017 00:47:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 1/3] mailinfo: extract patch series id
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <2252b046-a608-b2aa-d67a-8f7e95fe2dbc@suse.de>
Date:   Tue, 14 Nov 2017 14:47:52 +0900
In-Reply-To: <2252b046-a608-b2aa-d67a-8f7e95fe2dbc@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Mon, 13 Nov 2017 18:13:32 +0100")
Message-ID: <xmqqfu9h4div.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B82FA52-C8FF-11E7-ADDC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

> Extract the patch ID and series length from the [PATCH N/M]
>  prefix in the mail header
>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  mailinfo.c | 35 +++++++++++++++++++++++++++++++++++
>  mailinfo.h |  2 ++
>  2 files changed, 37 insertions(+)

As JTan already mentioned, relying on a substring "PATCH" may not be
very reliable, and trying to locate "%d/%d]" feels like a better
approach.

cleanup_subject() is called only when keep_subject is false, so this
code will not trigger in that case at all.  Is this intended?

I would have expected that a new helper function would be written,
without changing existing helpers like cleanup_subject(), and that
new helper gets called by handle_info() after output_header_lines()
helper is called for the "Subject".

Whenever mailinfo learns to glean a new useful piece of information,
it should be made available to scripts that run "git mailinfo", too.
Perhaps show something like

	PatchNumber: 1
	TotalPatches: 3

at the end of handle_info() to mi->output?  I do not think existing
tools mind too much, even if we added a for-debug output e.g.

	RawSubject: [RFC 1/3] mailinfo: extract patch series id

to the output.
