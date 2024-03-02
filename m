Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBF1DFED
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397113; cv=none; b=uvKT/WgV9zWPASfRmNp+rMHvXyNCIH8W5XRKCTvyL8gSXlzTLNXkoO1BVRKWsnZMgmQZ/c9riRhWI9Hhvw6tnu0tKJJEugQUfJbBy0ZXRUX+o5kA69cHPjP53GjNmRPk99skpEPKwz/3N1nzoUK/hz1FCT7TMM3pigv4sevOg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397113; c=relaxed/simple;
	bh=DZCyMjDoifGl9bb7leuVPVCLZM5E5bCbA+hU9vUk544=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pO2QwJBE/dUHbgIzxhufLipgxV6I4GjuogX8h0aD+6ww8adH5bJ/rMI261+LprDf285bjdg/VcTrFjeAiqKNYuZHb0MNPgSiGFYsgeWc4y8FhD76TRZUVnWZYTdjQ7xExs+vdVDGMG//BFTPcRpKFZXYtv0zaAg43ox5p+rcCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k4d6ZDxa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k4d6ZDxa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6CA61E0E3D;
	Sat,  2 Mar 2024 11:31:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DZCyMjDoifGl9bb7leuVPVCLZM5E5bCbA+hU9v
	Uk544=; b=k4d6ZDxaEnBVKGg2sAgFeCK5NytCRjq4Vx53qvmvmS1h9xKisL1z+y
	mM2Nrhv/PyIjWKWR7s6+pzCFV86ODLZMfbF1Vom4PiHBbFLEUC0IfobJJbNtUtbL
	jXQqF5RVqePdqLhDTAgGliNjCkTNB0EmM5WF0ltYGBRXqaUbrQaHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD79D1E0E3C;
	Sat,  2 Mar 2024 11:31:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46A001E0E3B;
	Sat,  2 Mar 2024 11:31:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
In-Reply-To: <875xy76qe1.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	29 Feb 2024 22:07:18 +0300")
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
Date: Sat, 02 Mar 2024 08:31:48 -0800
Message-ID: <xmqqv864zjbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E4E4FBA-D8B2-11EE-B1B4-25B3960A682E-77302942!pb-smtp2.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> What -n actually does in addition to its documented behavior is
> ignoring of configuration variable clean.requireForce, that makes
> sense provided -n prevents files removal anyway.

There is another thing I noticed.

This part to get rid of "config_set" does make sense.

>  	git_config(git_clean_config, NULL);
> -	if (force < 0)
> -		force = 0;
> -	else
> -		config_set = 1;

We used to think "force" variable is the master switch to do
anything , and requireForce configuration was a way to flip its
default to 0 (so that you need to set it to 1 again from the command
line).  This separates "force" (which can only given via the command
line) and "require_force" (which controls when the "force" is used)
and makes the logic simpler.

>  	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
>  			     0);

However.

> -	if (!interactive && !dry_run && !force) {
> -		if (config_set)
> -			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
> +	/* Dry run won't remove anything, so requiring force makes no sense */
> +	if(dry_run)
> +		require_force = 0;

I am not sure if this is making things inconsistent.

Dry run will be harmless, and we can be lenient and not require
force.  But below, we do not require force when going interactive,
either.  So we could instead add

	if (dry_run || interactive)
		require_force = 0;

above, drop the "&& !interactive" from the guard for the
clean.requireForce block.

Or we can go the opposite way.  We do not have to tweak
require_force at all based on other conditions.  Instead we can
update the guard below to check "!force && !interactive && !dry_run"
before entering the clean.requireForce block, no?

But the code after this patch makes me feel that it is somewhere in
the middle between these two optimum places.

Another thing.  Stepping back and thinking _why_ the code can treat
dry_run and interactive the same way (either to make them drop
require_force above, or neither of them contributes to the value of
require_force), if we are dropping "you didn't give me --dry-run" in
the error message below, we should also drop "you didn't give me
--interactive, either" as well, when complaining about the lack of
"--force".

One possible objection I can think of against doing so is that it
might not be so obvious why "interactive" does not have to require
"force" (even though it is clearly obvious to me).  But if that were
the objection, then to somebody else "dry-run does not have to
require force" may equally not be so obvious (at least it wasn't so
obvious to me during the last round of this discussion).

So I can live without the "drop 'nor -i'" part I suggested in the
above.  We would not drop "nor -i" and add "nor --dry-run" back to
the message instead.

So from that angle, the message after this patch makes me feel that
it is somewhere in the middle between two more sensible places.

> +	if (!force && !interactive) {
> +		if (require_force > 0)
> +			die(_("clean.requireForce set to true and neither -f, nor -i given; "
> +				  "refusing to clean"));
> +		else if (require_force < 0)
> +			die(_("clean.requireForce defaults to true and neither -f, nor -i given; "
>  				  "refusing to clean"));
> -		else
> -			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
> -				  " refusing to clean"));
>  	}
>  
>  	if (force > 1)
>
> base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
