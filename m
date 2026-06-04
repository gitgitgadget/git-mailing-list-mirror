Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423033BB669
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549907; cv=none; b=GDbBs+Ekn45Tq435QbgD3yMWbQZAAczlYB0BeA+O7BGCbCXNaeHrhu5OGVkue3RD+ysmgBxU2qjoWKDg7RzEqmh5IfyLcfGz+iXzV4vkJpyy8jmZEHCKKpzsNDNx99DzZF0s9azuZIfmb5V6dC1/mOk3mNiSY6bL3l/AKwrKHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549907; c=relaxed/simple;
	bh=aMm6Kvmq3oZN4DGAK1QWBVgffZhDTeVa1H6UY9Mqso4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKE2uot2WPTIJkR6IB0puf2pbnKgSvIeeci4NRYAzGUR3yBAvz6S8P2liNDzTjDezk+zngQQfe8beMNhk+TuhuGF1cO6aueGjZk5Pg0wbsfbPdLRSS/8pQFpssOHf33+KwrtG7PefZPDrJxdgpX2b00rnL+1SiTS8blXb59xnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.1.28] (unknown [103.52.208.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 9C5053F123;
	Thu,  4 Jun 2026 07:11:42 +0200 (CEST)
Message-ID: <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
Date: Thu, 4 Jun 2026 14:11:38 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mirror repositories for submodules
To: Junio C Hamano <gitster@pobox.com>,
 Benson Muite <benson_muite@emailplus.org>
Cc: git@vger.kernel.org
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <xmqqcxy7qfgk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 6/4/26 10:09 AM, Junio C Hamano wrote:

> So, no, I do not think a contribution to add mirror repositories as
> alternate submodule sources should be considered for inclusion, as
> it artificially limits usefulness of the feature.  A feature to add
> mirror repositories as alternate sources might be worth considering,
> though.

This is relevant to the Debian use case: we run a git server that 
archives git trees for Debian packages, and ideally the objects on this 
server should be identical to what you get from upstream projects.

This is a big problem for archiving projects that use submodules, 
because we cannot alter the reference URLs.

Cloning from our server will, depending on what upstream uses, either a 
relative URL (which will go to our server, but we have little control 
over what the name part of the repository base URL is going to be), or 
an absolute URL that instructs clients to pull from another place, which 
conflicts with our goal to have a self-contained archive.

The idea posited earlier, to have a "repository identity" that remains 
the same across forks and clones, is somewhat appealing, but the best 
idea I can come up with is generating some kind of repository UUID, and 
adding a symlink -- not a great design because it pollutes outside the repo:

     $ mkdir myproject
     $ cd myproject
     $ git init
     $ ls -l ..
     lrwxrwxrwx 1 simon simon   9 Jun  4 14:05 
12345678-9abc-def0-1234-56789abcdef0.git -> myproject
     drwxrwxr-x 2 simon simon  40 Jun  4 14:04 myproject

On the other hand, this can be used to construct a stable relative 
submodule URL.

Making the symlinks optional would require keeping a list of local 
clones and their UUIDs, and resolving them.

I don't like that design, but as I said it's the best idea I have for now.

I also fully expect that Debian's servers will be used by a lot of 
people outside the project as soon as it becomes a convenient fallback, 
in the same way people are pulling .orig.tar.gz archives from Debian 
mirrors, so we need to make it easy to set up a mirror, to allow this to 
scale.

    Simon
