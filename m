Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72B33D51A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565265; cv=none; b=YwWbsp941jl59u//3n4bYX2mnzREIFby1iHdZ0Bf66ZNVVbM7qdRLxtzAhhlFxMe8Ylf8ZZVwF17FRUO4186UGSIJ3j/XYgplf7BG3IRUJnZHqKafV/9E3UblxNU77WeDHtvC0H4SAlIlYJxar7WDGYedYZlHNYiIubajOEC/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565265; c=relaxed/simple;
	bh=q7+xGXCocjaGNSiSNiz5CA+M/gxkm5fakydv5Cu/oRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYEdeMjkqcUeO8qk79aX944ynmPMk12VwBC3WLnUhhZKZNQppC/9ItrMpsRhMaUuEHqul5xu1pTXlLE+sLzyYZiiOnXI30YyYQ41AmopGrazU4bvzB2xgKX1ThJou4MzKjR+LT1px6FdrCaiNpkUSM0EF+YrooKKAiB4MzDd9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.1.28] (unknown [103.52.208.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id CCAE83F202;
	Thu,  4 Jun 2026 11:27:39 +0200 (CEST)
Message-ID: <fa075b7a-96f6-4fd9-ae94-30ddf323f759@hogyros.de>
Date: Thu, 4 Jun 2026 18:27:31 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mirror repositories for submodules
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Benson Muite <benson_muite@emailplus.org>, git@vger.kernel.org
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
 <20260604061605.GA3194609@coredump.intra.peff.net>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260604061605.GA3194609@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/4/26 3:16 PM, Jeff King wrote:

> Here's a thought experiment. What if you put the UUID into a URL, like:
>    repoid://123456789.git

Yes, that's the idea, except I would want to use a relative URL, like

     ../123456789.git

This could solve the "naive cloning" problem, because it creates an 
expectation that the submodules can be found on the same server, or in a 
nearby path.

I'm aware that this is *also* bad for decentralization, because it makes 
it easier to use one of the big forges where the repositories for 
often-used submodules are are already likely to be present, but it plays 
into our use case, where we want to share the repositories for 
often-used subprojects.

> Now, all of that said, do we still need uuids at all? If the canonical
> submodule name is https://github.com/git/git.git, then anybody can just
> rewrite that locally in the same way using url.*.insteadOf config.

Yes, but we'd then need a mechanism for a server to indicate "for 
cloning, you should use these 'insteadOf' settings, which is a massive 
can of worms from a security standpoint.

I also don't think these canonical URLs can ever be stable if they refer 
to infrastructure that is not under the control of the maintainer -- it 
would tie the project identity to the hosting provider, and increase the 
inertia to overcome for moves (such as the current exodus from github 
and gitlab towards codeberg).

> Which makes me wonder if I am missing something about the original
> request that started this thread. But it sounds to me like it is just
> asking for the existing URL-rewriting feature.

The original mail has a similar problem as we do in Debian, and as my 
employer has: CI jobs should exclusively talk to in-house 
infrastructure, because continuously cloning repositories for each build 
is bad for the environment.

The common goal is that a naive clone should get submodules from a local 
server, ideally without us having to write some tool to make an initial 
checkout, enumerate submodules, create insteadOf settings, clone first 
layer of submodules, enumerate second layer, ...

    Simon
