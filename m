From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fetch --prune: Repair branchname DF conflicts
Date: Wed, 18 Dec 2013 13:54:15 -0800
Message-ID: <xmqq4n65hlko.fsf@gitster.dls.corp.google.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
	<1387401776-30994-3-git-send-email-jackerran@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 22:54:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtP4b-0004Hb-C1
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab3LRVyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:54:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54988 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354Ab3LRVyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:54:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65B4C5A448;
	Wed, 18 Dec 2013 16:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7FjsRlZTM4NJtGpOjag0sJdzks=; b=h85MIT
	nMI9huQPkfI5xDrrV6BPk9zGfG6HE+od/85ZfhsOj8K1xx9sxNowTeKTy2B21LZB
	uBKoRzrqti+fXyfhdVLwOyDpHXOO+vKa9pIWwpMiOayxk5y4Mn8nTXzBoRQcppjN
	sq4GKSgPpA81n3nhT4f9hmRmKhbTrLAMQBMSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQKuWgvnjHksWbzlTROg0fVSnsUIPtjy
	jT3HeoHtWqpMjdS7dEF2TmIAvsH66VEiIyA7uZL4zL06riYVixAyVCxhRMXMo+nZ
	aAg+r5+ywGmssDUskEwRRXraArytuFZvY4mq8hHbsFUdc7+2TVVHzQKKoyEl2rGK
	e4W36faONfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C1015A447;
	Wed, 18 Dec 2013 16:54:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DF845A444;
	Wed, 18 Dec 2013 16:54:18 -0500 (EST)
In-Reply-To: <1387401776-30994-3-git-send-email-jackerran@gmail.com> (Tom
	Miller's message of "Wed, 18 Dec 2013 15:22:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1C4C882-682E-11E3-9B85-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239493>

Tom Miller <jackerran@gmail.com> writes:

> When a branchname DF conflict occurs during a fetch,

You may have started with a specific case in which you want to
change the behaviour of current Git, so it may be clear what you
meant by "branchname DF conflict", but that is true for nobody other
than you who will read this log message.  Introducing new lingo is
OK as long as it is necessary, but in a case like this, where you
have to describe what situation you are trying to address anyway,
I do not think you need to add a new word to our vocabulary.

	When we have a remote-tracking branch frotz/nitfol from a
	previous fetch, and the upstream now has branch frotz, we
	used to fail to remove frotz/nitfol and recreate frotz with
	"git fetch --prune" from the upstream.

or something like that?

But what should happen when we do not give --prune to "git fetch" in
such a situation?  Should it fail, because we still have frotz/nitfol
and we cannot create frotz without losing it?

> --prune should
> be able to fix it. When fetching with --prune, the fetching process
> happens before pruning causing the branchname DF conflict to persist
> and report an error. This patch prunes before fetching, thus
> correcting DF conflicts during a fetch.
>
> Signed-off-by: Tom Miller <jackerran@gmail.com>
> Tested-by: Thomas Rast <tr@thomasrast.ch>

I wasn't following previous threads closely (was there a previous
thread???); has this iteration been already tested by trast?

> ---
>  builtin/fetch.c  | 10 +++++-----
>  t/t5510-fetch.sh | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e50b697..845c687 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -868,11 +868,6 @@ static int do_fetch(struct transport *transport,
>  
>  	if (tags == TAGS_DEFAULT && autotags)
>  		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
> -	if (fetch_refs(transport, ref_map)) {
> -		free_refs(ref_map);
> -		retcode = 1;
> -		goto cleanup;
> -	}
>  	if (prune) {
>  		/*
>  		 * We only prune based on refspecs specified
> @@ -888,6 +883,11 @@ static int do_fetch(struct transport *transport,
>  				   transport->url);
>  		}
>  	}
> +	if (fetch_refs(transport, ref_map)) {
> +		free_refs(ref_map);
> +		retcode = 1;
> +		goto cleanup;
> +	}
>  	free_refs(ref_map);
>  
>  	/* if neither --no-tags nor --tags was specified, do automated tag
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 5d4581d..a981125 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -614,4 +614,18 @@ test_expect_success 'all boundary commits are excluded' '
>  	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
>  '
>  
> +test_expect_success 'branchname D/F conflict resolved by --prune' '
> +	git branch dir/file &&
> +	git clone . prune-df-conflict &&
> +	git branch -D dir/file &&
> +	git branch dir &&
> +	(
> +		cd prune-df-conflict &&
> +		git fetch --prune &&
> +		git rev-parse origin/dir >../actual
> +	) &&
> +	git rev-parse dir >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
