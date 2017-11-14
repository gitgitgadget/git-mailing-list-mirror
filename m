Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554CC1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754685AbdKNPEh (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:04:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754561AbdKNPEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 10:04:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E75BB4CB4;
        Tue, 14 Nov 2017 10:04:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bn5Tb9WDiJ9AJ4OURa3dLuvbek=; b=Ko1iiK
        XltiaoXCeljvnJDCrCYT4mu5ekFIBns7tBBBmOR1FK/8uscYE/uVxeJiqT0i2S9F
        sFoqk/eVe7LTRS975+eJE7a4Mom8p1sPHHSncPHwJLZVLjLtlkC5F/xTbLZDfciH
        O55tjXxcMPRVrL/4/IkbZPQjGszrpw/nZC4qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XVEnOc9CXG8BCYUKV0HSEmj4cV6NyX1L
        6bdKGC+sMou36vmKs0tFw/4akIUvv9rFp9xNdKmuXr6iDSyS4025jnSj7gz4BCfH
        qCL1ZyXHnoIF3PKnvLtNEETrKNTaaT3ubCiyXb/wt4/slxQLJU2djtsnVIwSHNfV
        TnZ2955ANgw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05690B4CB2;
        Tue, 14 Nov 2017 10:04:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65472B4CB1;
        Tue, 14 Nov 2017 10:04:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through parallelization
References: <20171109141737.47976-1-benpeart@microsoft.com>
        <20171109141737.47976-2-benpeart@microsoft.com>
        <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
        <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
        <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
        <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
Date:   Wed, 15 Nov 2017 00:04:33 +0900
In-Reply-To: <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com> (Ben Peart's
        message of "Tue, 14 Nov 2017 09:31:03 -0500")
Message-ID: <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2004E80C-C94D-11E7-BD58-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> How about I add the logic to write out a special extension right
> before the SHA1 that contains an offset to the beginning of the
> extensions section.  I will also add the logic in do_read_index() to
> search for and load this special extension if it exists.
>
> This will provide a common framework for any future extension to take
> advantage of if it wants to be loaded/processed before or in parallel
> with the cache entries or other extensions.
>
> For all existing extensions that assume they are loaded _after_ the
> cache entries, in do_read_index() I'll add the logic to use the offset
> (if it exists) to adjust the src_offset and then load them normally.
>
> Given the IEOT extension is just another list of offsets into the
> index to enable out of order processing, I'll add those offsets into
> the same extension so that it is a more generic "table of contents"
> for the entire index.  This enables us to have common/reusable way to
> have random access to _all_ sections in the index while maintaining
> backwards comparability with the existing index formats and code.
>
> These additional offsets will initially only be used to parallelize
> the loading of cache entries and only if the user explicitly enables
> that option but I can think of other interesting uses for them in the
> future.

If we freeze the format of IEOT extension so that we can guarantee
that the very first version of Git that understands IEOT can always
find the beginning of extension section in an index file that was
written by future versions of Git, then I'm all for that plan, but
my impression was that you are planning to make incompatible change
in the future to IEOT, judging from the waythat IEOT records its own
version number in the section and the reader uses it to reject an
unknown one.

With that plan, what I suspect would happen is that a version of Git
that understands another optional extension section that wants to be
findable without scanning the main table and the then-current
version of IEOT would not be able to use an index file written by a
new version of Git that enhances the format of the IEOT extension
bumps its extension version.

And if that is the case I would have to say that I strongly suspect
that you would regret the design decision to mix it into IEOT.  That
is why I keep suggesting that the back pointer extension should be
on its own, minimizing what it does and minimizing the need to be
updated across versions of Git.


