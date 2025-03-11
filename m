Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC2225764
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737445; cv=none; b=fZiS4IHMXnLw8aoxwfcFf9XfYMXBHpyuTjx0WZZKAW/kBJrLnYVjFaYRTZfFCB76JwlUj+5/edVJ8c9OOXqUrsOAWMs5cVTl2J3WYZSfFeDa6ka/j6AeQdK8q+wObamMhX3QQ5zQTKN/0LtiCkURh6j+rrdxnzl/NckXV2b1wkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737445; c=relaxed/simple;
	bh=NBEIC3+2yHa5wPptk71LCeCj005cyms4/K8rFXEmG4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2BPxyHrHW2M8tIqMrY3CyE0L77VQuq6qqbXYNW6Yuk+D8C+FZMIiozJnmJzdS+aa9aJaDqiY1DVfpHuTAGkt6MXZQdJzaP7/2fuvvqRja8oTnfN/PlGmSt4WfZasDhFbhgb8/I2RgDZoll1AixbhQGGHhzujswe1w5gOOWgDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gmb2hcCI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gmb2hcCI"
Received: (qmail 5915 invoked by uid 109); 11 Mar 2025 23:57:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NBEIC3+2yHa5wPptk71LCeCj005cyms4/K8rFXEmG4c=; b=Gmb2hcCIXxadNl0B77+V2+Zskrbn7diq4tjnshqmEqHTh5VOrvW39/cPfMMdsqh+DAC3Bmf3YZr8T0D/d6JbTrJOtHT0A3sPiYkOsMNcM3c1XtOALUtjdW9XvlLxt2kFj+wZAHCnF7Mt2tW92zC8ho9yxvUVjNDulTRRw8YEbd50C4p3ymRQi339zYeUCI+GA0tJZXe3iuzRurmOHIsTFxu0DMKLRAZzmz0YIL/2KTImu1pSSvMOmrQU0TaN2CH7WsSpOjzh8P7RrZf7d6UljaLTyBfIWxFyKuQoBb7wnMU1VCZF9E0dzu3hkShvHoMO6Uc6p38f+o+9OyL8jFMwqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Mar 2025 23:57:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21069 invoked by uid 111); 11 Mar 2025 23:57:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Mar 2025 19:57:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Mar 2025 19:57:20 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <20250311235720.GA73755@coredump.intra.peff.net>
References: <20250310192829.661692-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>

On Mon, Mar 10, 2025 at 02:28:25PM -0500, Justin Tobler wrote:

> To make machine parsing easier, this series introduces a NUL-delimited
> output mode for git-rev-list(1) via a `-z` option following a suggestion
> from Junio in a previous thread[1]. In this mode, instead of LF, each
> object is delimited with two NUL bytes and any object metadata is
> separated with a single NUL byte. Examples:
> 
>         <oid> NUL NUL
>         <oid> [NUL <path>] NUL NUL
>         ?<oid> [NUL <token>=<value>]... NUL NUL
> 
> In this mode, path and value info are printed as-is without any special
> encoding or truncation.

I think this is a good direction, but I have two compatibility
questions:

  1. What should "git rev-list -z --stdin" do? In most other programs
     with a "-z" option it affects both input and output. I don't
     particularly care about this case myself, but it will be hard to
     change later. So we probably want to decide now.

  2. I was a little surprised that rev-list already takes a "-z" option,
     but it doesn't seem to do anything. I guess it's probably picked up
     via diff_opt_parse(), though (I think) you can't actually trigger a
     diff via rev-list itself. So even though this is a change in
     behavior, probably nobody would have been using it until now?

     If it is possible to see some effect from "-z" now (I didn't dig
     very far), then it may be better to continue to let the diff
     options parser handle it, and simply pick the result out of
     revs.diffopt.line_termination. As your patch 3 is written, I think
     the diff code probably doesn't see it anymore at all.

-Peff
