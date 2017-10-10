Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFCC2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 12:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbdJJM5F (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 08:57:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57671 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755144AbdJJM5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 08:57:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 811E0B5784;
        Tue, 10 Oct 2017 08:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eE3+6hvFPLCxiGO/Zf8S3UyCWYQ=; b=rPla96
        9V7x+vlnKDDrXh31HQxstg1fY/XOVrwH2DFKuA84MnxMol87xGqFrmKEtoQ0cKHO
        IU6y+pnInwCR24DQOr7zbkgPcwcRMnaSJavKVhgFZ3baf0BKeHKRGPicLZGlrwKl
        Q57GQ8gXPUL1mrHDgvqrfGL1vY1/057SIGdZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=So9hvvs9hZZJPzK3Bq2OXxLTuXSc0i0Z
        dpwy+tHYuH4kqGpKnlWMpv/RFw9A+yqEUWpRS2/W/lBBdYfCMvry/hnXSSbS8je1
        he4iU+aK5JNh9lxwEzQh+4yI03cQz2y3C5AYBEyrYNuUKUCXDwykLGBq8QtKcOhE
        EPZpBQEPDII=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77E68B5783;
        Tue, 10 Oct 2017 08:56:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59FF0B5776;
        Tue, 10 Oct 2017 08:56:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: Re: [PATCH v4 4/4] sha1_name: minimize OID comparisons during disambiguation
References: <20171008184942.69444-1-dstolee@microsoft.com>
        <20171008184942.69444-5-dstolee@microsoft.com>
        <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
        <338aab6a-1181-d740-1bf2-2ac86749a6b2@gmail.com>
        <20171010123634.3hdqxpo6mbl6jhbx@sigill.intra.peff.net>
Date:   Tue, 10 Oct 2017 21:56:38 +0900
In-Reply-To: <20171010123634.3hdqxpo6mbl6jhbx@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 10 Oct 2017 08:36:34 -0400")
Message-ID: <xmqqbmlfp3eh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74E05ACC-ADBA-11E7-89BE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK, I think that makes more sense. But note the p->num_objects thing I
> mentioned. If I do:
>
>   git pack-objects .git/objects/pack/pack </dev/null
>
> then I have a pack with zero objects, which I think we'd similarly want
> to return early from. I.e., I think we need:
>
>   if (p->num_objects)
> 	return;
>
> Technically that also covers open_pack_index() failure, too, but that's
> a subtlety I don't think we should rely on.

True.  I notice that the early part of the two functions look almost
identical.  Do we need error condition handling for the other one,
too?
