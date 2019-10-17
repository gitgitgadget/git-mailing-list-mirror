Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2721F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 07:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbfJQHPh (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:15:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64818 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJQHPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:15:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CB838A7C0;
        Thu, 17 Oct 2019 03:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RT/dARsSNJqO
        B7itAPcUDjW//3Q=; b=ub1t+3X1a4ePnlunuzzkhew2RCW3DTOr7xceUhpVjQnl
        bmKVvjOfV/vULTeSTAMT+GdQVS+GrsrqeMelX15YZk9Fs7C3JFwo2pXVi9bO2MLN
        6l2c/cINrvTILYgnnEIA9IAl+h/LSUjfgblZl5rkmXLTpTrMpi+6IOEjj5ZBO8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qSYMIs
        Oc6Nj1jaT41+opIvXBO0ZVeMsiqM/ZrIReR9lHqqlc8h4ZO4yz8robaKnF8cw4zb
        2CXvNC/HpB6WXehw2aveMks/JNwN7C4GVDUMl1CYV0OxudkGJ6/1FfIWCe+JZVcu
        dq7uBHEVA1at9sD9FdedOYM55Uufsmd+zSwZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 542FB8A7BF;
        Thu, 17 Oct 2019 03:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E2028A7BB;
        Thu, 17 Oct 2019 03:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git_path(): handle `.lock` files correctly
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
        <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com>
        <20191016110440.GV29845@szeder.dev>
Date:   Thu, 17 Oct 2019 16:15:31 +0900
In-Reply-To: <20191016110440.GV29845@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 16 Oct 2019 13:04:40 +0200")
Message-ID: <xmqqzhhz7sh8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E8AF5D1C-F0AD-11E9-9D39-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> However, I'm not sure what the right path should be in the first
> place, given that each working tree has its own 'logs' directory, but
> only for HEAD's reflog, while everything else goes to the main working
> tree's 'logs' directory.

As all worktrees should share the same view of where 'master' (for
example) branch points at, what commit it was pointing at before,
etc., the reflogs should also be shared for refs.  The exception is
the HEAD where each worktree can point at its own commit (when detached)
or a branch (when not).

The above "should" does not mean "I know the code works that way so
if your git behaves differently your compiler is wrong"; it just
means "that's the logical conclusion of the basic design, and if
your git does not behave that way, we have a bug (or two)".

Thanks.
