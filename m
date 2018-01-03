Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52DD1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeACUt7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751098AbeACUtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 776FED0BEA;
        Wed,  3 Jan 2018 15:49:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KqhaeUrlbSz5PLho/IsWo4Z+xbY=; b=Jt7k/Y
        ALGZ97g0+oTBbp3heg/Q4z+DkGXj1kHTK0XpDn6vwBDX/ywRCpSWxye/ficfFu7Q
        0VCEOt99TMs+DWhgcu4+G9SVnSg8rFW4JzCZ/3bYrljptq7N8r3kIwqtdTPBPvI/
        m5dilkFbNYLEtZSWnJ/+gLq2NHbh6N/OIc7l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NiadgtNw46P55USnJ8sfWXllkThcfTuA
        ZbIzagoZ6cPMWX6lS2T1s308ewI6c5FYhrhcSHQo9/cLZEuEIZwdtx+yK6C87+Ps
        YUB8ysAltOwY0Bawf57f33PJOKKXYTa+l3t97iqvOO3pyYPN6nktZKrAqvIwzAoj
        UUEYxgUoIxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65B21D0BE9;
        Wed,  3 Jan 2018 15:49:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCACFD0BE8;
        Wed,  3 Jan 2018 15:49:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCHv3 0/5] Fix --recurse-submodules for submodule worktree changes
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
        <20180103011226.160185-1-sbeller@google.com>
Date:   Wed, 03 Jan 2018 12:49:42 -0800
In-Reply-To: <20180103011226.160185-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 2 Jan 2018 17:12:21 -0800")
Message-ID: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A073999C-F0C7-11E7-9ADD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Thanks Junio for review of this series!
> The only change in this version of the series is
>
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2140,7 +2140,7 @@ int oneway_merge(const struct cache_entry * const *src,
>                                 update |= CE_UPDATE;
>                 }
>                 if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
> -                   !verify_uptodate(old, o))
> +                   o->update && !verify_uptodate(old, o))
>                         update |= CE_UPDATE;
>                 add_entry(o, old, update, 0);
>

Sounds OK.  

I wonder why o->update is not at the very beginning of the &&-chain,
though.  After all, the one above this addition begins with o->reset
&& o->update *not* because of the performance concern, but primarily
due to logic flow.  I.e. "if we are resetting and updating the
working tree, then..." comes first before saying "we may need to
flip CE_UPDATE bit in update variable if the file in the working
tree is not up to date and it is within a narrow checkout area".

Of course, because verify_uptodate() is rather expensive, checking
o->update before that makes sense from micro-optimization's point of
view, too.

So after thinking aloud like the above, I am reasonably sure that
you want to check o->update as the very first thing in this new if
statement.

> v2:
> I dropped the patch to `same()` as I realized we only need to fix the
> oneway_merge function, the others (two, three way merge) are fine as
> they have the checks already in place.

This is a bit flawed argument, no?  Checking working tree paths
unconditionally in same(), which does not even know if we are
touching the working tree paths, is broken.  Unless "they have the
checks already in place" refers to checks that bypasses calls to
same() when we are not touching working tree paths, that is, but
obviously that is not what is going on.

Will queue.  Thanks for working on this.


