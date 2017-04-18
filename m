Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9491B1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750763AbdDREzH (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:55:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53782 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750714AbdDREzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:55:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9F1E750F0;
        Tue, 18 Apr 2017 00:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hyXD1Ds9P69/qdNXDkv4Bdh8Is=; b=SONdGg
        v1VdIn7WB38+RGUBfRQ7cxV6M6vSz2XhJkcx6Kb6L0BMtTqtkd/Y78Sxkh5ee5Lw
        hlxfraW+oRD/mS8V1tY4N6IctIDO7p5QX4uJbWAwW0QoL81hbEwENuQ+HfIfb4Pt
        oZknWJwbV3r5Vuq2UQ0jK2uEC+UbjnM0w0Ne0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xLlTDOF8iqeFyhBHtlBEXFLncmMc51Eo
        1Pvfm0q35ANjeYx0TS163SStQLlZv7mR+7PbVuKvdP4bfoPrWj1tD2ozb5bO3IxE
        0a2Fid+3exYjS0vhJ1GOu1f92zgrtaHqvRTOig/ZLIUoZsKGAV2TeCKbausrihUS
        BgREN9MEBqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D101F750EF;
        Tue, 18 Apr 2017 00:55:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4699A750ED;
        Tue, 18 Apr 2017 00:55:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/18] avoid using fixed PATH_MAX buffers for refs
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
        <20170328194629.5ddehsxizajitn3q@sigill.intra.peff.net>
        <xmqq1ssrk1za.fsf@gitster.mtv.corp.google.com>
        <20170418031812.lsi4v5tmxdfuglgo@sigill.intra.peff.net>
Date:   Mon, 17 Apr 2017 21:55:02 -0700
In-Reply-To: <20170418031812.lsi4v5tmxdfuglgo@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 17 Apr 2017 23:18:13 -0400")
Message-ID: <xmqqmvbee2mx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F245BBA-23F3-11E7-9E18-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Apr 16, 2017 at 11:00:25PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/builtin/replace.c b/builtin/replace.c
>> > index f83e7b8fc..065515bab 100644
>> > --- a/builtin/replace.c
>> > +++ b/builtin/replace.c
>> > @@ -93,26 +93,31 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
>> >  static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
>> [...]
>> 
>> Don't we need to strbuf_release(&ref) before leaving this function?
>
> Yes, good catch. Squashable patch is below.
>
> I'm not sure how I missed that one. I double-checked the other hunks in
> the patch and they are all fine.

Heh, I do not know how I missed that one while queuing, and while
advancing the topic to 'next'.  The third time I read over before
merging to 'master' was when I noticed it.

>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 065515bab..ab17668f4 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -120,6 +120,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
>  		if (fn(full_hex, ref.buf, &oid))
>  			had_error = 1;
>  	}
> +	strbuf_release(&ref);
>  	return had_error;
>  }
>  
