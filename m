Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CB11F462
	for <e@80x24.org>; Tue, 11 Jun 2019 20:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406036AbfFKUsV (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 16:48:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52112 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405881AbfFKUsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 16:48:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB33872D40;
        Tue, 11 Jun 2019 16:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FKOQTuB9nKKs
        okYlq9Xrz7vSdmE=; b=L0UIDn9AOU5eTSOLYKONCPbMHQmY/6pyBUaKVMU3DYsq
        AJJeJbu8T0soeWyAInZJCamj2MFcX8WDPriI3DBZN3ld3ylderdVYblKU6O6nH1p
        iFuesIyPrpXDFxh1AgLNFz3CBgjqob2A700Uqf01zTVapoLFVtdbdpJHL2/z1eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LgJUao
        ZDfmMDST4Fico8GcoLSdgC8hPq3qWNL8zzZfrqQkAvrDtnvUvYDculL5zjgysRAB
        QrdGAS2sI0ulMWdW5gkC5y6r6Jr00OQsh4PPiSAlHb1GR5ojaDbPP/YNCZ0bqVow
        wYj2pNvKSfl3/s8KAYwxLRTgAYNSP2+3T+0tk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A32BC72D3F;
        Tue, 11 Jun 2019 16:48:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D329572D3E;
        Tue, 11 Jun 2019 16:48:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
References: <20190430142556.20921-1-szeder.dev@gmail.com>
        <20190611130320.18499-1-szeder.dev@gmail.com>
        <20190611130320.18499-4-szeder.dev@gmail.com>
Date:   Tue, 11 Jun 2019 13:48:14 -0700
In-Reply-To: <20190611130320.18499-4-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 11 Jun 2019 15:03:19 +0200")
Message-ID: <xmqqy327kfw1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D07C5BC-8C8A-11E9-800F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Make sure that the previously displayed "Rebasing (N/M)" line is
> cleared by using the term_clear_line() helper function added in the
> previous patch.
>
> A couple of other rebase commands print similar messages, e.g.
> "Stopped at <abbrev-oid>... <subject>" for the 'edit' or 'break'
> commands, or the "Successfully rebased and updated <full-ref>." at the
> very end.  These are so long that they practically always overwrite
> that "Rebasing (n/m)" progress line, but let's be prudent, and clear
> the last line before printing these, too.
> ...
> Note that this patch doesn't completely eliminate the possibility of
> similar garbled outputs, ...
> too soon, and it would either flicker or be invisible.

The user of term_clear_line() in this patch always guard themselves
behind "we do not do this if we are producing verbose output," but
the proposed log message does not explain why they need to do so.

Is it because it is so obvious to potential readers?
