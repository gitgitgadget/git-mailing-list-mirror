Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F0C1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 17:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfHUR3P (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 13:29:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52910 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfHUR3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 13:29:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4541516D242;
        Wed, 21 Aug 2019 13:29:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sd7xUCIq+oOX
        zd38yXpUL0TrvL8=; b=x4y5qNkIdPzxO0VskG/PQi+a3lBhbExtB3aSGZxKxzrw
        C/V9p2OpP/G2sUHg2N9SaP9WF9+N/TAxS2Hp27etJjW64XqcBQwfmNc37Me6s2ff
        pwufu1Z+69FwOD6g5rxmuanzYOZSl8GInt1a007RN+xSvXQv2ta6KNqQfvWkdbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dP0W5y
        H5iM60/wrowMU7YSo4yipadisyVBOSqrrnBBmSuvSEOixcs+v+mTi++8rH8G5V4w
        74Dz7DFOpPcNGh8eIgplbiMB8awh6UHg6SGG07Td9e1Sr8HTue8nSmE2Itp6es65
        PS6UEQm4g9Kc4Di84WNKzmiaaERGtAAc57iqo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E34716D241;
        Wed, 21 Aug 2019 13:29:13 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A35016D240;
        Wed, 21 Aug 2019 13:29:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
References: <20190821110424.18184-1-szeder.dev@gmail.com>
        <20190821110424.18184-3-szeder.dev@gmail.com>
Date:   Wed, 21 Aug 2019 10:29:11 -0700
In-Reply-To: <20190821110424.18184-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 21 Aug 2019 13:04:24 +0200")
Message-ID: <xmqqtvaas9zs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 310A7A98-C439-11E9-87A7-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> So basically the line-level log computes a full tree diff for each
> commit-parent pair in step (1) to be used for rename detection in step
> (4) in the off chance that an interesting path is missing from the
> parent.

Good explanation.  As we are not supporting swapping of two (or
more) files, we only need rename processing when a path we have been
inspecting disappears, at which point it is worth spending cycles to
see where the path used to be in the parent commit.

> [1] Line-level log's rename following is quite similar to 'git log
>     --follow path', with the notable differences that it does handle
>     multiple paths at once as well, and that it doesn't show the
>     commit performing the rename if it's an exact rename.

Yeah, it's one of the reasons why "log --follow" is not (yet) a
serious "feature" but merely a "checkbox item".

> [2] This slowness might not have been apparent initially, because back
>     when the line-level log feature was introduced rename detection

s/introduced/&,/

>     was not yet enabled by default; 12da1d1f6f (Implement line-history
>     search (git log -L), 2013-03-28) and 5404c116aa (diff: activate
>     diff.renames by default, 2016-02-25).

s/\.$/ are about 3 years apart&/ or something like that to make what
follows the semicolon a full sentence?

