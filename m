Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C001662E8
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325391; cv=none; b=X9zqqI5DeGQMPEAA8wfsNkgMfnaw9VV2Sj0QYIgNyTvnLis4Q7IOpbPDsRe2/5iD91m8G5C6w+Ub0Og0DHGetGgeBF143J331t+wQAnEZdnysGa3sFkhID/qxLLmAaQjvSlRe1934ZBbpUDhPhgDsVOKMo0C230GH4hESvI74pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325391; c=relaxed/simple;
	bh=0PpCm6kekQmwVO37vbdOLnr1Wwe2w5gUXcm9efZn8a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0bmo/yX4XgX4cesB6pNyG4RxPTjjB4RghrdoLkL/imotgdvCGimTY2ilFlpNOS33MUSsbiGVIYzOzMw26Lvm/Fd9Ek8nFEeDYgMYTeqf3+brOG1r6EugSXlko/ezfyzsgsUe6GC9NbhR2JYw4SPr0pbP2TL4EbnCuLqLZCvyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27912 invoked by uid 109); 30 Jul 2024 07:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jul 2024 07:43:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8566 invoked by uid 111); 30 Jul 2024 07:43:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2024 03:43:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jul 2024 03:43:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] safe.directory: normalize the configured path
Message-ID: <20240730074307.GB562212@coredump.intra.peff.net>
References: <20240723021900.388020-1-gitster@pobox.com>
 <20240720220915.2933266-1-gitster@pobox.com>
 <20240730011004.4030246-1-gitster@pobox.com>
 <20240730011004.4030246-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730011004.4030246-3-gitster@pobox.com>

On Mon, Jul 29, 2024 at 06:10:03PM -0700, Junio C Hamano wrote:

> @@ -1236,14 +1236,43 @@ static int safe_directory_cb(const char *key, const char *value,
>  
>  		if (!git_config_pathname(&allowed, key, value)) {
>  			const char *check = allowed ? allowed : value;
> -			if (ends_with(check, "/*")) {
> -				size_t len = strlen(check);
> -				if (!fspathncmp(check, data->path, len - 1))

BTW, one oddity I noticed in the existing code:

Under what circumstances will "allowed" be NULL in that ternary? I think
if git_config_pathname() returns non-zero, then we called
interpolate_path(). It can return NULL, but in that case
git_config_pathname() will die(). We might change that later, but then
I'd expect it to return non-zero. So I suspect the whole "check"
variable could just be dropped in favor of using "allowed".

Obviously not new in your patch, but maybe worth fixing while in the
area? I think it comes from an evil merge in b8bdb2f283 (Merge branch
'jc/safe-directory-leading-path', 2024-06-12).

-Peff
