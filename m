Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF80C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB4C206C3
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 18:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e7zpwGHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgFDSHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:07:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64417 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgFDSHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 14:07:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05F436DFD8;
        Thu,  4 Jun 2020 14:07:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yUbQ9OsXlYRGkCHc40GuFWZZpfw=; b=e7zpwG
        HCdatj6CuyolkF84LdL+oysZd1cxM+oH7My/ICp8nvj6Fn7+Am+9gHQzn4gFoRop
        VSvigEJZD4zPhglhZ9FBlHpxwOXObV2Tmh1ECw1cJ1hILQyYn+HtmnlbT3Q7Q7uN
        40I8jvwDyyGjxecpyjbOFPWYF/fscf4aclDsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SOnnwqfXilLoPX9vUTnOowRmX9NyzBsz
        wwO0c1S/hhEA/BFaMrohvp2OSjGNVoYYta/CWPi1BciXd+QYBdGAHgxKDNVlZmC+
        x0tuORBFjSwLkkdxeKSn7Br2jQdmHz0DMuXxB4bv+IfvjYPf/0zi/13OTTrb7k8X
        5zJxotySnqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDAAB6DFD7;
        Thu,  4 Jun 2020 14:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C7E66DFD6;
        Thu,  4 Jun 2020 14:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 00/13] upload-pack: use 'struct upload_pack_data' thoroughly, part 2
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
        <20200604175450.17385-1-chriscool@tuxfamily.org>
Date:   Thu, 04 Jun 2020 11:07:17 -0700
In-Reply-To: <20200604175450.17385-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 4 Jun 2020 19:54:37 +0200")
Message-ID: <xmqq7dwmpuwa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A768468-A68E-11EA-A66C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This patch series is the second part of an effort to move all static
> variables in 'upload-pack.c' into 'struct upload_pack_data'.
>
> It is based on 'cc/upload-pack-data' which contains "part 1" of this
> effort. (See also: https://lore.kernel.org/git/20200515100454.14486-1-chriscool@tuxfamily.org/)
>
> A part 3 will follow with the rest of the patches needed to get rid of
> the static variables left after this patch series.
>
> Thanks to Peff for his review of the first and second versions of this
> part 2:
>
> V1: https://lore.kernel.org/git/20200527164742.23067-1-chriscool@tuxfamily.org/
> V2: https://lore.kernel.org/git/20200602041657.7132-1-chriscool@tuxfamily.org/
>
> Thanks to Jonathan Tan for his review of V2 too.
>
> Compared to V2 the changes are the following:
>
>   - patch 01/13 integrates Jonathan's commit message improvement
>
>   - patch 07/13 integrates Jonathan's fixup patch which makes
>     multi_ack enum values all-caps and fixes a spacing issue (2 spaces
>     between "enum" and "{")

Thanks, all.

I notice that enumeration constants for "enum multi_ack" have been
upcased; I do not think it matters too much either way.  A situation
that strongly favours upper case is when the enum is the result of
converting from C preprocessor macros that were spelled with upper
case, but this is not one of those.

> There is a lot of noise in the range-diff with V2, because V3 contains
> Peff's 'Acked-by:' and Junio's 'Signed-off-by', but here it is:

Would it work as a "trick" to fetch what has been queued in 'pu' and
compare against that lets you avoid such a "noise", I wonder?  If it
works well, it would have an added benefit of having the
publically-known commit object names on the left hand side
(e.g. instead of e5c31f30ec, you'd see d293806610 as the patch 1
from the second iteration) of the range-diff.

>  1:  e5c31f30ec !  1:  12f8a9c953 upload-pack: actually use some upload_pack_data bitfields
