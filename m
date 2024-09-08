Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A721C01
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832534; cv=none; b=B85AUR6qg+XtTociwVw8DVy3b5r1SmHOEnW6jbrloHcwcSuvPNJBj7jhqttZyBWxFyaHsLh7EAy9je4O6Z6tWfy+Q+QjUJhSDVcH8xeYNvzhqCpHnqtfn9WW741/BFRoWJiIC3qipMoUdcNpKcYn6V5Ay7LqOS6UPFDzpcRgilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832534; c=relaxed/simple;
	bh=hr2ledxbTjaDbD+Ut680ckdWC66rQKOxSPUZJMdjdLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eyrfrm3V5IDn5TKS+LhoRAdN8rlgwqwu0ACxRpZJiyadsxFkIKyfiNMUiq3tIbUCMowJLbL9D6fwDLl8ONVNsTIM0xteqxmMVBshzdH983YPganUDabUH7+aQXsOFh0lilNIJhPH+qTewgXkdx5KL5jzMufgPMqZHd70HDPwGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=syd7Mia4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="syd7Mia4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 091FF1C20E;
	Sun,  8 Sep 2024 17:55:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hr2ledxbTjaDbD+Ut680ckdWC66rQKOxSPUZJM
	djdLI=; b=syd7Mia4xak/gk1cDuKTLvZBfZv6nE+pTLdExcfCh8e9OHRe/j6Rs4
	LnOBQuND/oGvC1yBi4gWCwbx+rOGiwtvam3t7kzK2OkLS1sl1KLCJWVfFoWmov2O
	x2p0dBRce0i7puiz64lDNCzrnbRqGnQcR0JiURBfYNt6H1qG5tNO0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 004711C20D;
	Sun,  8 Sep 2024 17:55:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CEF71C20C;
	Sun,  8 Sep 2024 17:55:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Brian Lyles <brianmlyles@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase: apply and cleanup autostash when rebase
 fails to start
In-Reply-To: <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Mon, 02 Sep 2024 15:12:59 +0000")
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
	<pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>
Date: Sun, 08 Sep 2024 14:55:30 -0700
Message-ID: <xmqqr09tvmi5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 114D0FE2-6E2D-11EF-9A5F-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Thanks to Junio and Patrick for their comments on V1. I've updated the
>     commit message to correct the typos found by Patrick and added an
>     explanation of why it is safe to remove the state directory.

Any other comments, or are we all happy with this iteration?

Thanks.
