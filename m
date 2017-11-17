Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D818202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 02:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755529AbdKQCOQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 21:14:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63319 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754930AbdKQCOP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 21:14:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB3DB9B7D;
        Thu, 16 Nov 2017 21:14:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j2MUQtOb74lNYQavbuyUCXi7S3A=; b=gHWHJy
        xUPplwYm+D6uQmht44AYYw5IfQtHcH8trB8j/xuJx+AhhxFmH5hprfR5dwcLxiiC
        unFUGscD41LMN91UzYoSUmj+MOsnGrLajP+ldAfMg/HbtfZiqVrNk3NHlr/EWpN/
        zInDSB5PPhFr/i4yZDWr3zsQvrjocrodtyscA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IWQrvihi40V4ou9e9u/Zv09Ah/2loKyy
        U2ql2nigDvfyX5y4/Y7ztDUo90msn9Nvs95CRfkiYA0p6ETcHyI1K4TA5IOQEyEd
        3f5Q1G4FuO6zVS7rjCu4o9EZ/Cg1IKGHjlaqD7Y8IcoWPvXcBefVq0y/wuR+fsDc
        Px1lg9DOfyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C613BB9B7C;
        Thu, 16 Nov 2017 21:14:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BEC8B9B7A;
        Thu, 16 Nov 2017 21:14:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 4/6] list-objects: filter objects in traverse_commit_list
References: <20171116180743.61353-1-git@jeffhostetler.com>
        <20171116180743.61353-5-git@jeffhostetler.com>
        <20171116122133.4cc718414579c1a5a682174b@google.com>
        <bdf75d90-570d-8cf0-886a-2c5c9cdba1c1@jeffhostetler.com>
        <20171116215725.k44e3alk2lq6bbwu@sigill.intra.peff.net>
Date:   Fri, 17 Nov 2017 11:14:13 +0900
In-Reply-To: <20171116215725.k44e3alk2lq6bbwu@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Nov 2017 16:57:26 -0500")
Message-ID: <xmqqh8tttzwq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01DA2FB2-CB3D-11E7-BC73-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Those encodings don't necessarily need to be the same, because they're
> about transport. Inside each process we'd have the raw bytes, and encode
> them as appropriate to whatever sub-program we're going to pass to (or
> not at all if we skip the shell for sub-processes, which is usually a
> good idea).

Yes, I share the same feeling.  It does not help that the series
defines its own notion of arg_needs_armor() and uses it to set a
field called requires_armor that is not yet used, the definition of
"armor"ing being each byte getting encoded as two hexadecimal digits
without any sign (which makes me wonder what a receiver of
"deadbeef" would do---did it receive an armored string or a plain
one???).  I do not understand why these strings are not passed as
opaque sequences of bytes and instead converted at this low a layer.





