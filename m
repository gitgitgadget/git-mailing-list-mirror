Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2E1CE0A1
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954723; cv=none; b=AEkk+fHy5EToAPPf+My4H1yrI1hlO+I1jexuHa5pevTmO/Z7Gw1A17hT+TuD2+NjKxXZW3Uv7R553QdYcEVTKRxD2gI0qRxF9vc5RBhpo0m37AO3x5MgeH/n1gBihY7k6PlTJkvoKwVSv2SrdTeUUI/vSA0mFMWdmsgA2p2WxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954723; c=relaxed/simple;
	bh=K2UB1AfzTHBTvwY0YZotkdSW8dk4fQ//hkWfUOfTj+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt6FAaUm5ISMsTljVFCD1NFSRfDm//2szezxFI6VXnuF+ZCLB5eXumdiPjEIsLdQM6Td5nDq/R7IsRU3yblp4CnKI2vNRWRO+9ffgcf06W/3hVCARRan94H/8020Vo6k9/l5K3A5+UhLsOL/rRQuE/ghCX0B6BMuX3qo4FkjRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8539 invoked by uid 109); 2 Jul 2024 21:11:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 21:11:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28838 invoked by uid 111); 2 Jul 2024 21:11:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jul 2024 17:11:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jul 2024 17:11:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: avoid showing false negotiation errors
Message-ID: <20240702211151.GA120950@coredump.intra.peff.net>
References: <xmqqo77fr2h0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo77fr2h0.fsf@gitster.g>

On Tue, Jul 02, 2024 at 12:57:47PM -0700, Junio C Hamano wrote:

> When "git push" is configured to use the push negotiation, a push of
> deletion of a branch (without pushing anything else) may end up not
> having anything to negotiate for the common ancestor discovery.
> 
> In such a case, we end up making an internal invocation of "git
> fetch --negotiate-only" without any "--negotiate-tip" parameters
> that stops the negotiate-only fetch from being run, which by itself
> is not a bad thing (one fewer round-trip), but the end-user sees a
> "fatal: --negotiate-only needs one or more --negotiation-tip=*"
> message that the user cannot act upon.
> 
> Teach "git push" to notice the situation and omit performing the
> negotiate-only fetch to begin with.  One fewer process spawned, one
> fewer "alarming" message given the user.

Makes sense.

> @@ -427,17 +427,26 @@ static void get_commons_through_negotiation(const char *url,
>  	struct child_process child = CHILD_PROCESS_INIT;
>  	const struct ref *ref;
>  	int len = the_hash_algo->hexsz + 1; /* hash + NL */
> +	int nr_negotiation_tip = 0;
>  
>  	child.git_cmd = 1;
>  	child.no_stdin = 1;
>  	child.out = -1;
>  	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!is_null_oid(&ref->new_oid))
> -			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> +		if (!is_null_oid(&ref->new_oid)) {
> +			strvec_pushf(&child.args, "--negotiation-tip=%s",
> +				     oid_to_hex(&ref->new_oid));
> +			nr_negotiation_tip++;
> +		}
>  	}
>  	strvec_push(&child.args, url);
>  
> +	if (!nr_negotiation_tip) {
> +		child_process_clear(&child);
> +		return;
> +	}

OK, this works as advertised. "nr_negotiation_tip" is really a boolean
here, as we never care about the actual count. I'd probably have written
it as "have_negotiation_tip = 1", but I don't think there is any real
reason to prefer one over the other.

And we can't just check for a non-NULL remote_refs, since we are looking
for non-deletions.

> diff --git c/t/t5516-fetch-push.sh w/t/t5516-fetch-push.sh
> index 2e7c0e1648..a3f18404d9 100755
> --- c/t/t5516-fetch-push.sh
> +++ w/t/t5516-fetch-push.sh
> @@ -230,6 +230,17 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
>  	test_grep "push negotiation failed" err
>  '
>  
> +test_expect_success 'push deletion with negotiation' '
> +	mk_empty testrepo &&
> +	git push testrepo $the_first_commit:refs/heads/master &&
> +	git ls-remote testrepo >ls-remote &&
> +	git -c push.negotiate=1 push testrepo \
> +		:master $the_first_commit:refs/heads/next 2>errors-2 &&
> +	test_grep ! "negotiate-only needs one or " errors-2 &&
> +	git -c push.negotiate=1 push testrepo :next 2>errors-1 &&
> +	test_grep ! "negotiate-only needs one or " errors-1
> +'

The test mostly makes sense, though is the ls-remote bit leftover
debugging cruft?

-Peff
