Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D16206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbcGHWyK (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:54:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756135AbcGHWyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:54:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A22A2CF4E;
	Fri,  8 Jul 2016 18:54:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tpoWlUf4gWhcF0Thus0Q7JBt4i4=; b=BHWIOL
	/QwdjMLdqgLECLET8wSgBXmw1sh5b+rBrW8CUdWU/8AL+7rBhKKQvUOq5zQYQzMv
	beNV0cF5kh2MRmV0GE8Kw3AkHAUqodwGmuzkC4lBHcX4FPPsjbErpuoikfTghUKi
	RlS2vgQO1fUyc2z7PaSYX+3trgEurKWumWwrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cS9Jr30uTMQq8IQQotlhGcsNDOVss9Y4
	pOWjCdaTGa+8+YJ3QoUZqb//Q09E+3rWRE1b7468UUksPjW+4EdGsap3ZZ7uGIBu
	LQb1IEPrWsBA03OXaa11Hfr328N9Md62XubEXOHIHwhIOr9cwYtEHDYo/NYH/Uf+
	qngqKJxdI70=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 732F42CF4D;
	Fri,  8 Jul 2016 18:54:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F04B52CF4C;
	Fri,  8 Jul 2016 18:54:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nicolas Cornu <nicolac76@gmail.com>
Cc:	git@vger.kernel.org, Nicolas Cornu <nicolac76@yahoo.fr>
Subject: Re: [PATCH/RFC] archive: allow archiving of reachable sha1
References: <20160708223250.18238-1-nicolac76@yahoo.fr>
Date:	Fri, 08 Jul 2016 15:54:04 -0700
In-Reply-To: <20160708223250.18238-1-nicolac76@yahoo.fr> (Nicolas Cornu's
	message of "Sat, 9 Jul 2016 00:32:50 +0200")
Message-ID: <xmqq7fcvlp0z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF7A388C-455E-11E6-AF17-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Cornu <nicolac76@gmail.com> writes:

> Remotely specify a tree-ish by a sha1 is now valid even if
> uploadarchive.allowunreachable is false only if this sha1 is reachable
> from a branch or a tag reference. We consider those last one to be
> public.
>
> Signed-off-by: Nicolas Cornu <nicolac76@yahoo.fr>
> ---
> Do you think this patch is too much "computationnally expensive"?

Yes.

> Maybe we need an option to disable such a a feature.

No, you need an option to enable it while keeping it disabled by
default.

> +static int is_reachable(const char *refname, const struct object_id *oid, int flags, void *cb_data)
> +{
> +	const unsigned char *sha1 = (unsigned char *)cb_data;
> +	return in_merge_bases(lookup_commit(sha1), lookup_commit(oid->hash));
> +}

So this checks if the tip of a ref (i.e. lookup_commit(oid->hash))
can reach the commit in cb_data, i.e. what the caller had in
oid.hash below.

>  static void parse_treeish_arg(const char **argv,
>  		struct archiver_args *ar_args, const char *prefix,
>  		int remote)
> @@ -364,8 +370,13 @@ static void parse_treeish_arg(const char **argv,
>  		const char *colon = strchrnul(name, ':');
>  		int refnamelen = colon - name;
>  
> -		if (!dwim_ref(name, refnamelen, oid.hash, &ref))
> -			die("no such ref: %.*s", refnamelen, name);
> +		if (!dwim_ref(name, refnamelen, oid.hash, &ref)) {
> +			if (get_sha1(name, oid.hash))
> +				die("Not a valid object name");
> +			if (!for_each_branch_ref(&is_reachable, oid.hash) &&
> +			    !for_each_tag_ref(&is_reachable, oid.hash))
> +				die("no such ref: %.*s", refnamelen, name);
> +		}
>  		free(ref);
>  	}


> +		if (!dwim_ref(name, refnamelen, oid.hash, &ref)) {
> +			if (get_sha1(name, oid.hash))
> +				die("Not a valid object name");
> +			if (!for_each_branch_ref(&is_reachable, oid.hash) &&
> +			    !for_each_tag_ref(&is_reachable, oid.hash))
> +				die("no such ref: %.*s", refnamelen, name);

Isn't this making the check unnecessarily expensive by requiring the
traversal to determine the ancestry down to the same oid.hash to
happen repeatedly?  A repository may have quite a many tags, some
very old ones, and traversing down to these old tags from the
requested commit in order to prove that the commit cannot be reached
by these tags (hence these tags cannot be an excuse for you to
serve the commit) would be expensive.

I suspect that it would be better to collect the objects at the tips
in an array using for_each_*_ref(), and do the check by using a
single call to in_merge_bases_many() instead, which would require
only one traversal?  Granted, it would still dig down to the common
ancestor between the asked commit and these old tags, i.e. one
near-full walk of the history, but at least you won't be making a
multiple such near-full walks of the history.

I also suspect that in_merge_bases_many() could be further optimized
if it turns out to be necessary by teaching paint_down_to_common()
an option to stop early, but that would be a second step of the
optimization.

> +		}
>  		free(ref);
>  	}
