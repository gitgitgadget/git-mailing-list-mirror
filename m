Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E18340A6F
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348124; cv=none; b=lh9C7INVDwH/DfvWaT8/XRCTOxNvdM7cVEZ+yCpuIT27AZiRVMgcK6IUJtIgJQn5u8Kj8f+nPyd15btKfCMGCLr6FbacWym+E40xVhQ0XPD8HYnKbRFjwtK/CZzm5x/3EJxbvmtPh0QxKHKuoeQBc8ycQEcElj+HTVebRzNJQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348124; c=relaxed/simple;
	bh=8rVgNs1oUB4DA3dNNYG3u7nnBHyGsC/w8Z8wv4MVN0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/JwoqTlyBOAiB6DgcNy28jb0gU076p2h8uQxxTTJlVVHvTAPuw9cSIm4Xkj9bMhaZ1LjJUr2L1I8vYJASnHCTM1jz+udFvxGXP1tEykBfAwEt/DyzlBodXX5IRxElJyblECgL76yENkGN7s0j5/Ft4ZupTbf4gGw7LP7isehGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gLfww2QsLzRq1j;
	Thu, 21 May 2026 09:21:51 +0200 (CEST)
Message-ID: <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
Date: Thu, 21 May 2026 09:21:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Kristoffer Haugsbakk
 <code@khaugsbakk.name>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
 <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.05.26 um 18:30 schrieb Siddh Raman Pant:
> A called command may not respond to the initial signal and will get
> stuck in finish_command() -> wait_or_whine().
> 
> So let's add timeout support into the finisher so that if a deadline
> occurs, we can send a force-kill signal.

This is extremely suspicious. A communication protocl with a child
program that requires to kill the child looks like a design error. A
band-aid like this timeout should not be necessary for a well-behaved
child process.

If the (your?) problem is that the child process is actually not
well-behaved, then I suggest to use a middle-man as child process that
behaves well from the point of view of the git process, but can punish
the ill-behaved downstream process when needed.

Please, do not add this infrastructure to core Git, and instead fix the
communication protocol.

> 
> The force-kill signal is in the argument because a program may trap a
> signal, so it is the responsibility of caller to pass the correct kill
> signal.
-- Hannes

