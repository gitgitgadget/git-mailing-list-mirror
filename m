Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D583CDD
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536949; cv=none; b=LKLWt1pC1v9CWi/nLWxbRTNXujnILEtYmgqUJqF1x2CPWeeUyhs6l5LpXZ2VbcvxErghtS224L402J93ZRGUHZsnHz4gRXbRqLo7m+zJOcvyJMnG98ZMRTrnqqYq3qSWlDr22LeSh6HWkKHSA3SryjjYTsWVVBSJnJCXKDVzmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536949; c=relaxed/simple;
	bh=QIrc5YCHUQIJ2/qstzGx3jqAjwfaBWIa0TqoVR60z9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAJvQZdPZuOlPCXFJrTCogepco02JX7+GqT/gWVbm7uUAuU8xExsW/M8NMjcTb8i2tjr/HL0LiYd/jWlIjzmTHr6kXAwFYfgHFkWUMZErlTKyg48/xrBuxWnVBEUf1pwVG07SYfx6Y13WVxZILMnrxLO+wx5MumwpOTJmLKEuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7420 invoked by uid 109); 21 Feb 2024 17:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Feb 2024 17:35:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6158 invoked by uid 111); 21 Feb 2024 17:35:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Feb 2024 12:35:46 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Feb 2024 12:35:45 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Yasushi SHOJI <yasushi.shoji@gmail.com>
Subject: Re: [PATCH 2/2] builtin/show-branch: detect empty reflogs
Message-ID: <20240221173545.GB634809@coredump.intra.peff.net>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <cover.1708509190.git.ps@pks.im>
 <6107efeffa3a9e87ed95f4fe592d9b480887c510.1708509190.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6107efeffa3a9e87ed95f4fe592d9b480887c510.1708509190.git.ps@pks.im>

On Wed, Feb 21, 2024 at 10:56:40AM +0100, Patrick Steinhardt wrote:

> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index b01ec761d2..8837415031 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -785,6 +785,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  			if (read_ref_at(get_main_ref_store(the_repository),
>  					ref, flags, 0, base + i, &oid, &logmsg,
>  					&timestamp, &tz, NULL)) {
> +				if (!i)
> +					die(_("log for %s is empty"), ref);
>  				reflog = i;
>  				break;
>  			}

There's another call to read_ref_at() earlier in the function that does
not check the return code. I think it is OK, though, because it always
passes a timestamp rather than a count, so it never hits the
special-case added by 6436a20284.

But I think this highlights my confusion with the first patch; most of
the time read_ref_at() will print the appropriate message for us and
die, but for this one weird case we have to do it ourselves. It makes
more sense to me for it to behave consistently for an empty reflog,
whether we were looking for branch@{0} or branch@{1}.

-Peff
