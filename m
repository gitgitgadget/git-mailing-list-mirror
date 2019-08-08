Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975B21F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfHHTjT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:39:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52003 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389995AbfHHTjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:39:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 633B116C41F;
        Thu,  8 Aug 2019 15:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8IREEMtiivEnAag55p0rcKQ1SZY=; b=SiX9em
        V3wVgFmJtTiLxtfC2w4urzv6uEAoiNPv20KI8f0uDm1Q0mQJVy+gmSR2ilhjbTiL
        ugJqq2rRLDDTQGNIglCak3ZVBF3/Dphkr2W+HZYZ/cM8Bz1CBPFc+HZFGQzEcOLd
        Az2Tdopzrh638qzbQE9qcYR44DmmE0rW7k3ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pqdGyc95/kTdaHOnN3OA+X7BjS4YJQEN
        jGbgitzQuXf2D1qQIdFeHR0oG2bBcy9Gtew4iYhThEXNxVuiM3fb12vUFee1szfZ
        kgZPcDlu13Q9LTpoWkC/RophhGiXWQIgBXjsl7C73fG1F+Ppd0XGX2rXz4jsV1v9
        Zi+MuwcxuMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A85D16C41E;
        Thu,  8 Aug 2019 15:39:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BADA816C41D;
        Thu,  8 Aug 2019 15:39:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] delete multiple tags in a single transaction
References: <20190808035935.30023-1-phil.hord@gmail.com>
Date:   Thu, 08 Aug 2019 12:39:10 -0700
In-Reply-To: <20190808035935.30023-1-phil.hord@gmail.com> (Phil Hord's message
        of "Wed, 7 Aug 2019 20:59:35 -0700")
Message-ID: <xmqq4l2rfnvl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 325153EC-BA14-11E9-93B9-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> From: Phil Hord <phil.hord@gmail.com>
>
> 'git tag -d' accepts one or more tag refs to delete, but each deletion
> is done by calling `delete_ref` on each argv. This is painfully slow
> when removing from packed refs. Use delete_refs instead so all the
> removals can be done inside a single transaction with a single write.
>
> I have a repo with 24,000 tags, most of which are not useful to any
> developers. Having this many refs slows down many operations that
> would otherwise be very fast. Removing these tags when they've been
> accidentally fetched again takes about 30 minutes using delete_ref.
>
>     git tag -l feature/* | xargs git tag -d
>
> Removing the same tags using delete_refs takes less than 5 seconds.

Makes sense.  As mentioned elsewhere in the thread already,
a batched update-ref would open the packed-refs ony once because
everything is done in a single transaction, so presumably a pipeline
like this

	git tag -l feature/* | 
	sed -e 's|^|delete refs/tags/|' |
	git update-ref --stdin

may work well, and "git tag -d" that gets these refs on the command
line should be capable of doing the same.

> -static int delete_tag(const char *name, const char *ref,
> -		      const struct object_id *oid, const void *cb_data)
> +struct tag_args {
> +	char *oid_abbrev;
> +	char *refname;
> +};
> +
> +static int make_string_list(const char *name, const char *ref,
> +			    const struct object_id *oid, void *cb_data)

Please think about a few more minutes before naming a function like
this, and make it a habit for your future patches.

We can see that the callback is used to insert more strings into a
string list, but the type (i.e. string_list) used to represent the
set is not all that important.  What is more important is why you
are building that set for, and saying what is in the set (as opposed
to saying that the container happens to be a string_list) would be a
good first step.

I presume that you are enumerating the tags to be deleted, together
with the data necessary for you to report the deletion of the tags?

>  {
> -	if (delete_ref(NULL, ref, oid, 0))
> -		return 1;
> -	printf(_("Deleted tag '%s' (was %s)\n"), name,
> -	       find_unique_abbrev(oid, DEFAULT_ABBREV));
> +	struct string_list *ref_list = cb_data;
> +	struct tag_args *info = xmalloc(sizeof(struct tag_args));
> +
> +	string_list_append(ref_list, ref);
> +
> +	info->oid_abbrev = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
> +	info->refname = xstrdup(name);
> +	ref_list->items[ref_list->nr - 1].util = info;
>  	return 0;
>  }
>  
> +static int delete_tags(const char **argv)
> +{
> +	int result;
> +	struct string_list ref_list = STRING_LIST_INIT_DUP;
> +	struct string_list_item *ref_list_item;
> +
> +	result = for_each_tag_name(argv, make_string_list, (void *) &ref_list);
> +	if (!result)
> +		result = delete_refs(NULL, &ref_list, REF_NO_DEREF);
> +
> +	for_each_string_list_item(ref_list_item, &ref_list) {
> +		struct tag_args * info = ref_list_item->util;
> +		if (!result)
> +			printf(_("Deleted tag '%s' (was %s)\n"), info->refname,
> +				info->oid_abbrev);
> +		free(info->oid_abbrev);
> +		free(info->refname);
> +		free(info);

It is not performance critical, but info->refname is computable from
ref_list_item->string, isn't it?  I am just wondering if we can do
this without having to allocate the .util field for each of 20,000
tags.  We still need to remember oid (or oid_abbrev, but if I were
writing this, I'd record the full oid in .util and make the code
that prints call find_unique_abbrev() on it), so I guess we cannot
really leave .util NULL.

> +	}
> +	string_list_clear(&ref_list, 0);
> +	return result;

We used to return the returned value from for_each_tag_name() that
repeatedly called delete_tag().  

Now we return value from delete_refs().  Are our caller(s) OK with
the values that may come back from that function?  Can delete_refs()
return a value that is not appropriate to be returned from
cmd_tag(), for example a negative value?

> +}
> +
>  static int verify_tag(const char *name, const char *ref,
> -		      const struct object_id *oid, const void *cb_data)
> +		      const struct object_id *oid, void *cb_data)
>  {
>  	int flags;
>  	const struct ref_format *format = cb_data;
> @@ -511,7 +543,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (filter.merge_commit)
>  		die(_("--merged and --no-merged options are only allowed in list mode"));
>  	if (cmdmode == 'd')
> -		return for_each_tag_name(argv, delete_tag, NULL);
> +		return delete_tags(argv);

Thanks.
