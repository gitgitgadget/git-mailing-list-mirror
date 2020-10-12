Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA3AC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FCF20776
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWbMzRmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbgJLT35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:29:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63446 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbgJLT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:29:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0D37F8341;
        Mon, 12 Oct 2020 15:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zb/D4FAji0YGMmNKuQ1OQ2NCGbU=; b=QWbMzR
        mnk7V6X3i8ziErMO83IZ5Esw20H2o5Pmw3VdhWCWWpv8LU8kJnDtN8CRR1UOlCtL
        RtxQ2oLvhIuhVhj4S5+dfnPMXQ1Gt4m2DG7lAg3wvOxZGORB8aJ4jVv07RQm6nJ3
        przVknG35dclkSY+FIPiMVA2f/gE4pdcMsX5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N97Sy/0Nb5BqqdDHEOfcluRD6QnH/l+N
        wjNO2bbBGp/8rWybG+Q/Rpwu5VSRr/rV1bJmPpneIZ7J8abp/DCCc6o7Ypq01NGg
        PdeThIjtbVuyVnSNwpG6IlQQt5q1WZ9tMN+G+5z91jVSoY198xjcDJ+XPX8UHxYP
        r6cHBRkv5Ms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D99F1F8340;
        Mon, 12 Oct 2020 15:29:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31F9AF833F;
        Mon, 12 Oct 2020 15:29:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci: make the "skip-if-redundant" check more defensive
References: <pull.748.git.1602451631.gitgitgadget@gmail.com>
        <5c889e487d344efd1a0eb0cb5b717375de450c89.1602451631.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 12:29:52 -0700
In-Reply-To: <5c889e487d344efd1a0eb0cb5b717375de450c89.1602451631.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sun, 11 Oct 2020
        21:27:11 +0000")
Message-ID: <xmqq7drvp7in.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E05ECE6-0CC1-11EB-92C4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Let's be even more defensive by catching all kinds of exceptions,
> logging them as warnings, and continue the run without skipping it
> (after all, if the check fails, we _want_ to continue with the run).

Yeah, looks sensible.
