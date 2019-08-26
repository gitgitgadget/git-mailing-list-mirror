Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C341F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfHZSGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:06:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64324 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbfHZSGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:06:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CEF173F35;
        Mon, 26 Aug 2019 14:06:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TRXHFfxXrBF3jucoOMDwTX2PdA4=; b=ZAPWWI
        RHyJS1Lj/K4OFiScu/oLcmZSyZP9lorQqrGOw/eCoMCbWp9poZ6w3xuC7eIwyLif
        cFouBqrpmV4klcbYwL4273ozi+EFetHDXgz+0e/BI8RH7h7jfBCrFEkjwC2HfzAQ
        p4PyuiYeRE5COsLJWUeSzCyO3pMktTrco4lJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZoJzuQ7IS6eNvPzP8yVT0xCuE93DoQYx
        jGhGXkfm56xAakhfl0umPmwBarHjbIpv/dWGPJNJ0tWcIH1brANMQEKSIKs2kK3N
        N+tz6pbHXEga2IPoCdWSi8yxzJyoStBnbGOaoyys2SEpW9mTS1rSXL0/HX/gt2w3
        okQjB60McOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5505E73F31;
        Mon, 26 Aug 2019 14:06:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E7FE73F2C;
        Mon, 26 Aug 2019 14:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] packfile: free packed_git memory when closing object store
References: <20190826024508.8444-1-mh@glandium.org>
Date:   Mon, 26 Aug 2019 11:06:29 -0700
In-Reply-To: <20190826024508.8444-1-mh@glandium.org> (Mike Hommey's message of
        "Mon, 26 Aug 2019 11:45:08 +0900")
Message-ID: <xmqqftlnhkd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BAA8E9C-C82C-11E9-B7F9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  packfile.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> Note, I'm not sure this is the right place to do it.

I do not think this patch is complete, given that o->packed_git
still has a non-NULL pointer.  IIRC, close_pack() was written for
the explicit purpose of releasing resources while allowing us to
reopen with open_packed_git() on it, so with the current
arrangement, after releasing the resources held for this object
store and doing something else, you should be able to come back to
this object store and work in it again---this patch makes it harder
if not impossible to do so.

I _think_ the patch is OK if you assigned NULL to o->packed_git,
after making sure that the intention of all the callers of
close_object_store() is to declare that this object store will not
be accessed any longer during the lifetime of the process, and write
it down as the contract between the callers and this function in a
comment perhaps in packfile.h where the function is declared.

Thanks.

> diff --git a/packfile.c b/packfile.c
> index fc43a6c52c..b0cb84adda 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -339,13 +339,16 @@ void close_pack(struct packed_git *p)
>  
>  void close_object_store(struct raw_object_store *o)
>  {
> -	struct packed_git *p;
> +	struct packed_git *p = o->packed_git;
>  
> -	for (p = o->packed_git; p; p = p->next)
> +	while (p) {
> +		struct packed_git *current = p;
>  		if (p->do_not_close)
>  			BUG("want to close pack marked 'do-not-close'");
> -		else
> -			close_pack(p);
> +		close_pack(p);
> +		p = p->next;
> +		free(current);
> +	}
>  
>  	if (o->multi_pack_index) {
>  		close_midx(o->multi_pack_index);
