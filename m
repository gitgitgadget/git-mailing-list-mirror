Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E876EC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69D020738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N/XWBwfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404776AbgFXQGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:06:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57980 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404525AbgFXQGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:06:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ECEC604B4;
        Wed, 24 Jun 2020 12:06:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E/8i+NdPvxIsBE1A57VXqk7CQdY=; b=N/XWBw
        fdaemxdDjr11PyOJrRFWg1HBReija+hXjfk9/j/VzVW3zOuKSdKHXfGkUVskNcNZ
        NjuEd4oHpFi3xeFiqLH6qnyc5HDduFUVbeSGEbIH4yMSpzCogqwFD5qbGW+ZTIE6
        psNj3PSdqfsZNuQtrdIOWZSEa7f1haBYJ0Sew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LLEQvXv5PzlK9oHoxOLd+iTgu/+pRFfb
        d9yNRfsZhGa/FrKoRkuaRf1GY4VNPgrWAWrGyQk8ARLSeK4/YS3nRv+FdZz2EWO9
        00mr4rSTx8TSWjJDmi0cg3haIA6f735Zvn4VJoSInqkTCiK6t0zidyxGmP6FrLBX
        sA7faKMWAP4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26699604B3;
        Wed, 24 Jun 2020 12:06:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B90E604B2;
        Wed, 24 Jun 2020 12:06:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: reallocate TOPO_WALK object flags
References: <29f8b1fc-fac7-12c6-4bfe-28aed7e709c3@web.de>
        <8e5b6b9f-a778-7b20-2c67-2d5d8ff0d8a0@gmail.com>
Date:   Wed, 24 Jun 2020 09:06:28 -0700
In-Reply-To: <8e5b6b9f-a778-7b20-2c67-2d5d8ff0d8a0@gmail.com> (Derrick
        Stolee's message of "Wed, 24 Jun 2020 09:51:01 -0400")
Message-ID: <xmqq8sgc8n3v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A976CBC4-B634-11EA-93D8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> @@ -79,7 +79,7 @@ struct object_array {
>>   * builtin/show-branch.c:    0-------------------------------------------26
>
> The only collision is here in builtin/show-branch.c, and when I added
> the TOPO_WALK_* bits, I didn't understand that these bits were
> sufficiently independent from the topo-walk logic that we could add
> collisions here.

The show-branch subcommand does its own walking without using any of
the usual revision machinery, and uses a bit per starting point (so
the number of starting points is limited by the wordsize), so it
should be safe.

It would be wonderful if the bits used by it can be moved to a slab
so that it can work from more starting points, or deprecate the
subcommand altogether.  With better visualization tools (including
"log --graph --oneline"), I suspect that it outlived its usefulness.

