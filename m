Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457335F5E9
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630194; cv=none; b=ilJzzPGrBrJ2YAEc0rGeLJjCxD9pb75cVJWR+z9jaO40YsysL2EBAcjndM6EDGimvYGgG2kNbVazjliVVE49AM8jyc5wYpz3NSbK16EREwfL53ukjuIt+BTxxfLuYc5klujmrnnUOGKizAs7v9SqnM1k5DqwHA/OVML4B6OOx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630194; c=relaxed/simple;
	bh=uOmYjoSO6ug2oUwT2bkD7hRACWvjB4SS/Sl1mSGzR4U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iFppkiwrXo2iireooKiabVCZa5Ayv1VsCFGEYEWEO0hS9TD6/18e2sQcNvj5pgmTKRPfStPUMyyJvXYqbg3XJ3kch3AIh22ruIuhY8AYgu4/z5jR/3J4H+ZgN7sbFcCbKDeutrc5FVFhkxM3/Uhdw71ZCn/KQlKyn53EvVwpbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fj67T54ccz9tfK;
	Fri, 27 Mar 2026 17:49:41 +0100 (CET)
Message-ID: <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
Date: Fri, 27 Mar 2026 12:49:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wesley <wesleys@opperschaap.net>
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org> <xmqqbjg9mex2.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbjg9mex2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 12:10, Junio C Hamano wrote:

> I somehow thought that this practice is so widespread that it was
> one of the few first things any new people learn to do, but perhaps
> we do not have a good documentation coverage?

As said before it is weird thing to configure a global ssh configuration
just for git transport. It doesn't make much sense.

The problem with ssh_config usage is that you need to change your ssh 
config, which is machine global, not just git. And not portable across 
teams with configurations committed to git. Myrepos is a good example of 
this. My former employer had this and I know the Perl metacpan project 
also uses mysrepos. Changing every URL dynamically in committed configs 
isn't really a nice ask.

The alternative is using core.sshCommand to inject the correct keys, but 
you must apply logic there when you have multiple accounts or forges. 
Which is what I initially did with a zsh-scripts.
Which is why I ported that logic to git itself, I thought it would be 
beneficial to have an easy way to maintain sshIdentityFile settings.

In addition, for core.sshCommand to work you must use the full openssh 
command rather than just adding some options to it. Which is an added 
benefit of the proposed changes.

This change makes key selection possible without too much trouble on the 
users side with hacks to ssh_config. You can just tell git to use an 
identity based on the remote. Solve a git identify problem in the git 
config, fix the problem in the correct domain. We also store email 
credentials in gitconfigs, why would an ssh identify file be treated 
different?

> In any case, I do not think these network/transport specific
> configuration would hardly belong to "core".

I'm happy to move it elsewhere, as said, I chose core because 
core.sshCommand. As for the name: "ssh" or "transport", I'm not certain 
what is the best option is.

Cheers,
Wesley

-- 
Wesley

Why not both?
