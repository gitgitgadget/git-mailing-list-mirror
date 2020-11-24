Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2AC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B05C20715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x5J3UwTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbgKXVsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:48:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50233 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgKXVsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:48:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86BB19C6B8;
        Tue, 24 Nov 2020 16:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qTH3jTkQ6MgdqazyzhGM7J2dV+c=; b=x5J3Uw
        TQJCJNNZ+9rZP5btdqV0B40Xn+HPWthnylzaBLZXyqDTHzXq+imunYw0hMtlbv4G
        J7pEK8Yw8Gh2NgQnMbx8VdX3wrKe1CKOx04w8Z/4r9j+uX/Vf9iIEEAyiZfJtue5
        Dx5nFtuWXB1PY6Tr+bMroDIaiCzEeavSbXcNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ysxy3E5XA+EpIqNci5ntDtt+QqSz34G0
        HV966m0nQnlIxF7nHjDdCy32Q1x66IcTyJlgvDRg8JyVrq9IepiL8eFo3Mnj7LIC
        n7h50ApEp5Gc3cGwKChuVqJrodbfW4S1hwzUOqlwTIDHoU/PCiH3oXNVDANFOeZi
        cgi86BZco34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F0F79C6B7;
        Tue, 24 Nov 2020 16:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F06C9C6B6;
        Tue, 24 Nov 2020 16:48:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
        <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
        <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com>
Date:   Tue, 24 Nov 2020 13:48:11 -0800
In-Reply-To: <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com> (Derrick
        Stolee's message of "Tue, 24 Nov 2020 12:22:40 -0500")
Message-ID: <xmqqim9uifz8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFB267D0-2E9E-11EB-B935-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The reason to use RUN_SETUP_GENTLY was probably due to some thought
> of modifying the background maintenance schedule without being in a
> Git repository. However, we currently run the [un]register logic
> inside of the stop|start subcommands, so a GIT_DIR is required there,
> too.

Meaning all the operations we currently support requires to be done
in a repository?  If so, that may be acceptable.

When a new operation that does not require to be in a repository is
added, or when an existing operation is updated not to require to be
in a repository, reverting the change and then checking in the
implementation of each operation if we are in a repository instead
should be easy enough---it pretty much should amount to Rafael's
patch, right?

But then, being prepared for that future already is also OK, so I
can go either way.  Please figure it out between you ;-)

Thanks, all.
