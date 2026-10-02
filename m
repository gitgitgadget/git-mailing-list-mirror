Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0732D7C7
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790909398; cv=none; b=ZG1yGO31DAm8li6JueOYWXHnf8AIvDBhrURyVVjZMqw989kxTHntZgwrkzFxNGHo5Vd9JGgqklaPBPg4Gmyek62u0n0baosK2EU3e9B4xgfyrrX6oaH1vJC6l1n8rLUVaUvmVy5MICGOdbA+OLgZqQYzI4+Kk3OWOF70r6P3//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790909398; c=relaxed/simple;
	bh=gNvKH8VdxNkxUdydCyOSJH/yqKYEs3kI3M2Tjj5uQfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S/FKmEgebODABWZ85k0jvkztiaKFrGx3/pb3K4cnWSUbQa8DOj3NJ6Vdg/0aZSoetLhk3GxKI94SVCdvOBbl62BrlmB/p70+caOPO6YtB+BWgC97FUgaeUjfqn1g+TW7Ir4JeOR5BH3v6jO0BRozndF0xZNUQzqEBXwzsHt6xQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.92] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id EA6D33F202;
	Fri,  2 Oct 2026 04:49:39 +0200 (CEST)
Message-ID: <f5859438-f91d-46d2-b80c-25d63937ed7c@hogyros.de>
Date: Fri, 2 Oct 2026 11:49:26 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-rebase-walk
To: Alejandro Colomar <alx@kernel.org>, git@vger.kernel.org
References: <ar5KL4_IKXYbx3Sb@debian>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <ar5KL4_IKXYbx3Sb@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/1/26 8:58 PM, Alejandro Colomar wrote:

> I use this little command to apply iterative rebases, which are easier
> to handle when there are large conflicts.  Are you interested in it?

I use something similar:

[alias]
         slowrebase = "!bash -c 'for i in $(git rev-list --reverse $(git 
merge-base HEAD @{u})..@{u}); do git rebase $i || break; done'"
         slowrebasemerges = "!bash -c 'for i in $(git rev-list --merges 
--reverse $(git merge-base HEAD @{u})..@{u}); do git rebase $i || break; 
done'"

Alas, this breaks down with merges, and it is slow, so I've been 
thinking about only listing those revisions that modify the same files 
as the branch being rebased, and their immediate predecessors -- the 
latter because the rebase should apply cleanly there.

I wonder if it would make sense to have a rebase-bisect (bisect-rebase?) 
command that finds the first commit that the branch cannot be cleanly 
rebased onto, optionally with a test command to see if there are 
semantic conflicts.

So given

     A --- B --- C --- D --- E --- F (main)
       \
         a --- b --- c (feature)

I'd like to be able to use "git bisect rebase main -x 'make check'" to 
attempt rebasing onto D first, and continue on to B or E, depending on 
whether the merge goes cleanly and "make check" succeeds, maybe with an 
option to try F first if the resolution is trivial.

    Simon
