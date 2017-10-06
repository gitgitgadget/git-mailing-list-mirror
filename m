Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811101FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdJFECX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:02:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61582 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750757AbdJFECP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:02:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 994AF9AFDF;
        Fri,  6 Oct 2017 00:02:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2fukWMqCGuL0Z4bqsMcnj56KfRE=; b=cfL9fH
        GU386OXIiLcNatMn4DZiyBz7vHn7blNs1jG8uC4F6UcyPXeDroG8352T1ZpATx6W
        7XHUTra8CII31Lkt+2xKV5TOXRwUzMP4bcCw/WDrmMDAfrvOZoieggb3XjqVp+uu
        KLVwgVXttCxLCfqlPaSpfkq2onEh9UMK/+8Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LB+n05g5SNJAwqoDWXZrlfsbg++KaOD9
        1XyypIKQF/vdNawsuhwwvha6Twrf7mZjonU0dRtKnja9kuAhNv57ViJKOIo2MOVa
        mp1xYzVqeGoBJKkD448g6EyRFvJj7aTHk3Ywk/QzcVwfin0pRyQ81HI8UkcvlA0A
        VDyNdVFW+0U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90A879AFDD;
        Fri,  6 Oct 2017 00:02:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCAB29AFDC;
        Fri,  6 Oct 2017 00:02:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Subject: Re: [RFC] Reporting index properties
References: <alpine.DEB.2.10.1710051625430.812@alexmv-linux>
        <20171006031303.GB134987@aiede.mtv.corp.google.com>
Date:   Fri, 06 Oct 2017 13:02:12 +0900
In-Reply-To: <20171006031303.GB134987@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 5 Oct 2017 20:13:03 -0700")
Message-ID: <xmqqvajsyldn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22A40D7A-AA4B-11E7-AC5E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Aside: git-update-index(1) says
>
> 	Version 4 is relatively young (first released in 1.8.0 in
> 	October 2012).
>
> My first reaction is to wonder if it is time to introduce a config
> option to use index format version 4 by default, since after 5 years
> it is not relatively young any more.
>
> My second reaction is to notice that the index.version configuration
> already exists.  Probably git-update-index(1) ought to point to it.

Both good points.

> JGit still doesn't support index format 4, so 4 is still not a good
> default for `index.version` for a user that hasn't explicitly
> configured it, but the moment JGit gains that support I think it will
> be. :)

After reading ce_write_entry(), I tend to agree.  v4 is the first
one that loses the alignment padding, which made sense back when we
mmap(2)ed the index file and read from it directly without the
ondisk-vs-incore conversion, but that stopped to be the case several
years ago.

I find it interesting to find that the recently proposed design for
reftable uses the same "common prefix compression from the previous
name" trick, even though index v4 does not have any resync point
like reftable does.
