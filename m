Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE0C4363C
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B534206A1
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qiAWqVS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbgJBQ0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:26:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55827 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBQ0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 12:26:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4E02E16C4;
        Fri,  2 Oct 2020 12:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xkldCn8FaLshsshwb151qlqKZDI=; b=qiAWqV
        S2DWn7x6EDZTXCzZX3SZAOv1slNLikQoDSE7wRNPCaecE+sSTnCb5hqWjz+M4LbH
        ygFg9OGkVeUwVUPs/MK6pdguXpo3k2ds6cWg4Ciuys8n4QuufjTRlPiUTSRdv9mO
        ByF+pfpAYIEltFtxIb8CKbLFsO1wS0gG1UAvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wwZ7A0v0ij/0f7iYCb3o/jWNWBvkPXIM
        FoBAShrwbVwtzz1HsDGpzROFSte2bv6b5urcs2ZatQT2NreP/PRcbud018RWiNLm
        +PynPRLCb/rPF2uhrvnE+6Hv5zrX4u5/O9xR4U+S6WOycUk3KnAUmXFLDxxGiYGi
        gJxPIk9HbyU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDFACE16C3;
        Fri,  2 Oct 2020 12:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2BD8CE16C2;
        Fri,  2 Oct 2020 12:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Oct 2020 09:26:41 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 2 Oct 2020 15:52:43 +0200 (CEST)")
Message-ID: <xmqqtuvca91a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EBB938A-04CC-11EB-9CE2-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I can verify that the multiple calls to `in_merge_bases_many()` lead to a
> problem ...

Is it because it forgets to clear the marks?  I do not think so.
Besides the sample history demonstrated by the failing test were so
small that it didn't need multiple calls, IIRC.  There was a trivial
bug in the function when commit-graph was enabled and there is no
reason to avoid calling the function multiple times, right?

I just wanted to make sure that a "in-merge-bases-many cannot be
called twice" myth does not get etched in the archive.

Thanks for solving the puzzle with Derrick, by the way.  Very much
appreciated.  I was wondering if my CC'ing commit-graph folks were
somehow not reaching the intended recipients.


