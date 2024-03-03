Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6AC43AB5
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709504328; cv=none; b=G3ml0fdYs4Xewl5pAmwXGNHd1zM3V9gPqbQDVGAjKEQhWCS8dQm0k7S7fuhj9LBMYkaZn1NETK034R4dXxsG4vgu/PSiWlJ6aHQoBFNII3z4l+FQKdGoQzWSnUWFyRA1YxSaUZHw4pUZgUbxccjTcQsJz452uhnVVWJ07/dzN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709504328; c=relaxed/simple;
	bh=HfOTyzU2KEHhNs22EkaOPcM5b/07iyKCbsVV2aJ9SeE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHrVUNE3ca+99HoKlJz5WLhh+QXRyHO+tOeNqNW/g+BJHbIOgyDGeE9dkK+9RVru1fT9eb42vCtffJWyJVthar+cbgBzGABjJ52SvzJUKFNX+e5bufFSKmr+oGYPsZgBYmuiNfJCdeRJhct7T5Z9iK6QKcP/pF+9+0jl/IpeDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ud0101IP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ud0101IP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 192D31EE53B;
	Sun,  3 Mar 2024 17:18:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HfOTyzU2KEHhNs22EkaOPcM5b/07iyKCbsVV2a
	J9SeE=; b=ud0101IPsr9R+3W987zePQd1HL2Izm5JReoAVgkOjqMv+1bkrfALyz
	ogDnMKnxT+fgucQKKgyvVS6qVrpSKUh4mN4kpLT+2lsMr8Eq4PrmFzqCmdLOSEHA
	nwkn6X2GF6dqd9gD59zn9ckwApMPH5qKLOjWZsJ+eQ1haGpl/oZ/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 125F01EE53A;
	Sun,  3 Mar 2024 17:18:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FB971EE539;
	Sun,  3 Mar 2024 17:18:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 1/1] clean: further clean-up of implementation around
 "--force"
In-Reply-To: <20240303220600.2491792-2-gitster@pobox.com> (Junio C. Hamano's
	message of "Sun, 3 Mar 2024 14:06:00 -0800")
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
	<20240303220600.2491792-2-gitster@pobox.com>
Date: Sun, 03 Mar 2024 14:18:38 -0800
Message-ID: <xmqq5xy3vu0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC95AEB2-D9AB-11EE-9990-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> @@ -950,13 +950,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>  			     0);
>  
> -	/* Dry run won't remove anything, so requiring force makes no sense */
> -	if (dry_run)
> -		require_force = 0;
> -
> -	if (require_force != 0 && !force && !interactive)
> -		die(_("clean.requireForce is true and neither -f nor -i given:"
> -				  " refusing to clean"));
> +	if (require_force != 0 && !force && !interactive && !dry_run)
> +		die(_("clean.requireForce is true and -f not given: refusing to clean"));
>  
>  	if (force > 1)
>  		rm_flags = 0;

An obvious alternative way to clean-up the logic is to do this
instead:

	if (dry_run || interactive))
		require_force = 0;
 	if (require_force != 0 && !force)
		die(_("clean.requireForce is true and ..."));

But as I wrote, the most important improvement done by Sergey's
patch was to remove the dual meaning of the "force" variable so that
it indicates if the "--force" option was given and nothing else,
while the "require_force" variable indicates if clean.requireForce
was given and nothing else.  From that point of view, the
conditional tweaking done to require_force in the above alternative
makes the code worse, relative to Sergey's patch, and certainly to
its follow up, my patch about "--interactive".
