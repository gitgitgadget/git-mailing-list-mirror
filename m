Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530551F462
	for <e@80x24.org>; Tue,  4 Jun 2019 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFDTRz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 15:17:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64985 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFDTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 15:17:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D31415DDE0;
        Tue,  4 Jun 2019 15:17:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z7HFEELdLAIktyNbNYY0YdBsYeU=; b=W1GBJp
        VbKp8IYFyN6wXv0G006xL3xRCrOD6MIyjguCmpOKGHRfsQDwxcNIbObwE8lKom4+
        u7rHAzsAmXbqORlzaaaJySLpBFvdxANj0zW9iw9bY4xjLDb4qYUeUQdhqGj63IOy
        8Dqursxq+uZA8YffBU8fmvZBt0T2L04NfOX4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZfhI9LTqXwwvRtjGd4RyLfpIYwx9UhLr
        SJ2XgC1baYw3r4ysBGA2fHnj5/2mxTletcpDJkX4OGOB9/6qTGRhnyk/DCFig3rY
        iuAPtMw0PD5sR7mjdbcGHX08D8mcZAQkEKOcMCG/q61nbFwAh8wbQWolnYnY5xqV
        3mjaJIJsOfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5411415DDDF;
        Tue,  4 Jun 2019 15:17:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7E8F15DDDE;
        Tue,  4 Jun 2019 15:17:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 5/5] fetch: fix regression with transport helpers
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
        <20190604021330.16130-6-felipe.contreras@gmail.com>
Date:   Tue, 04 Jun 2019 12:17:52 -0700
In-Reply-To: <20190604021330.16130-6-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Mon, 3 Jun 2019 21:13:30 -0500")
Message-ID: <xmqqd0jttb1b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73B6800E-86FD-11E9-90EF-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit e198b3a740 changed the behavior of fetch with regards to tags.
> Before, null oids where not ignored, now they are, regardless of whether
> the refs have been explicitly cleared or not.
>
>   e198b3a740 (fetch: replace string-list used as a look-up table with a hashmap)
>
> When using a transport helper the oids can certainly be null. So now
> tags are ignored and fetching them is impossible.
>
> This patch fixes that by having a specific flag that is set only when we
> explicitly want to ignore the refs, restoring the original behavior.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fetch.c           | 5 +++--
>  t/t5801-remote-helpers.sh | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 9dc551551e..f2be50a4a3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -239,6 +239,7 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
>  struct refname_hash_entry {
>  	struct hashmap_entry ent; /* must be the first member */
>  	struct object_id oid;
> +	int ignore;
>  	char refname[FLEX_ARRAY];
>  };
>  
> @@ -289,7 +290,7 @@ static int refname_hash_exists(struct hashmap *map, const char *refname)
>  
>  static void clear_item(struct refname_hash_entry *item)
>  {
> -	oidclr(&item->oid);
> +	item->ignore = 1;
>  }
>  
>  static void find_non_local_tags(const struct ref *refs,
> @@ -374,7 +375,7 @@ static void find_non_local_tags(const struct ref *refs,
>  			BUG("unseen remote ref?");
>  
>  		/* Unless we have already decided to ignore this item... */
> -		if (is_null_oid(&item->oid))
> +		if (item->ignore)
>  			continue;

Yeah, we should have added a bit like this to preserve the
distinction between a NULL pointer for "struct object_id" and oid
that has 0{40} in the old code, which was lost in the conversion.

Thanks for spotting and fixing.
