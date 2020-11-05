Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6281FC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02AB2078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m82G5dT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgKEVsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:48:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53096 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEVsc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:48:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73A0E9167B;
        Thu,  5 Nov 2020 16:48:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ub49GpARSvF4B1GIrwCxvPyEh5g=; b=m82G5d
        T7JUZSEcUtdDwSmf5oHXj9qYkGfpWFG75MulxI8reVaraKdsX0NM3iR65X2TvqFJ
        JSGNVXn9fS42ccZ454osJ28BZSn/7sqWE8miBFT98t4OgoYcxpAFqLLq3jbGD55U
        0KDLnSEuVS/5VcPalRcdCXpgsVIclieoJKhx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XlA0FYqcYPjlFBMbsGz6FILMUdEnY2r/
        2uQWU8hGxg1F0d1OJobwzpj7nVP8c2dAxLIYivbqdDsIRgIUj5FLbJS2k4hX/mBM
        re7g72L3rXZHXsdbkx0OK9cYC3z/Vpcq9iS5q3AKMXPrD8wqi9FyuK4hj6qAzEsy
        x0tAl1301ak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BAB39167A;
        Thu,  5 Nov 2020 16:48:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED88B91677;
        Thu,  5 Nov 2020 16:48:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [RFC PATCH 0/8] speed up 'make clean'
References: <e1d218bb-7658-565e-0931-2411efbb561c@ramsayjones.plus.com>
Date:   Thu, 05 Nov 2020 13:48:29 -0800
In-Reply-To: <e1d218bb-7658-565e-0931-2411efbb561c@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 5 Nov 2020 21:01:08 +0000")
Message-ID: <xmqq361niifm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4861850-1FB0-11EB-BCAF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> [Yes, 'cd Documentation; make clean all' will be slower that a doing
> separate 'make clean; make', but the extra 10s, or so, will be swamped
> by the documentation build time! ;-) ]

Hmph, the "all" part in "make clean all" needs the information we
read from these generated files, and time must be spent to generate
them whether "make clean all" or "make clean; make all" is used.  In
the latter, we may not generate and read them in the first phase,
but the second one "make all" would need to do so anyway.  So I am
puzzled why "make clean all" needs to be slower---don't we generate
and read them only once in either case?

