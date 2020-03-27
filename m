Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB83C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379942071B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkxOnLhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0VdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:33:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgC0VdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:33:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1875555B8;
        Fri, 27 Mar 2020 17:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tDwuxNAyWgbZvH7JcmSGqssQsHc=; b=CkxOnL
        hATANIEyGrBTY+7MU9utZbFuxPWB1Rp7vV7OXa6el8zMBjCaDzE9PAKZfl4T4CsL
        sn1GKWqAT+sYnMcW911zQeqAqck28FgdUHFSsWnGwImvQb5ROucs3MWdADehvm8L
        qnzRg6LhJsuYiPoilxGtSprnzhzL/uHDi3Ai8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KwIU1jWNtxlzexvI6RMdP9dFX/jh7vm5
        KQi2TJM0cnNdcZmCOP6PMozgEhp2QeScYoUjm0S8+Flz0ajJOzvPFQzozkNs8OU2
        mkOwwzbojww1kYVv9sQiDUhIB46ia4fHjm3d/6/mnlkZrRYs29BNMlyLWXygm2xN
        UBczKAaFpxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 379CB555B6;
        Fri, 27 Mar 2020 17:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 046A1555B4;
        Fri, 27 Mar 2020 17:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     "Jan Alexander Steffens \(heftig\)" <jan.steffens@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: git rebase fast-forward fails with abbreviateCommands
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
        <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com>
Date:   Fri, 27 Mar 2020 14:33:02 -0700
In-Reply-To: <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com> (Alban Gruin's
        message of "Fri, 27 Mar 2020 16:46:32 +0100")
Message-ID: <xmqq5zepfppt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89E9DB5A-7072-11EA-AC3D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Three approach to fix this:
>
>  1) add an abbreviation to `noop';  this is the simplest fix, and "n" is
> not taken.
>  2) if a command has no short form, do not abbreviate it;  this is
> trivial to do, and should not break anything.

I think the second is the most sensible.  Thanks.
