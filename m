Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9917555
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726862776; cv=none; b=EZekqQNiUQjrx6U8Sd/zkqnzYxLHDcXGvY7UiYYrYxfwLj7FenvJ3fWoPIZOI6lenrfahwhh0Tc9xONNMybP3A6G3iQTgjKnvZ2PKQ+gUi0xG9bmYiSMK6Xgt6jWwSr7KmC9x79NPQGr87MuZed+N71tNPom32UauaJFZPgmyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726862776; c=relaxed/simple;
	bh=PX/9bNep6B6d7GltSZn/HaWxeyuMA3jpK5ithc1sZhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jz7ldgd95uRkvZXXkGzvZaYVQjWdeuzmtZm7MG9wiYbm9EFSgp1nBxTGtWcHOROqa4T7zLQZuyNN4YSBvMhwnjpRtYgy1c5ioGWLDZwPMVPrZ+f/aNeuHqrsh8Hw/UF6HkOLF9mc5G0jbJKJyXu8wGF9ztojHBp+mpsUmMSYk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DB0mWyUl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DB0mWyUl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A246D18853;
	Fri, 20 Sep 2024 16:06:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PX/9bNep6B6d7GltSZn/HaWxeyuMA3jpK5ithc
	1sZhY=; b=DB0mWyUlVBUC0Lrm+nsY9f7wKStCRjbFSnZkrf1i9lZjPCsGVknQ2+
	pTzYeEfMUQ/XD/6bxtM0pF2ZJtd9hLlofouj1ybLJpaHhMOGlqLFSYEawC2SHrr+
	jFg7gD/7YAqAhxUBi7JG7Err8HeKRu4JUFS1zbLVLxJ8LfB2tSPPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9446418852;
	Fri, 20 Sep 2024 16:06:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE97E1884F;
	Fri, 20 Sep 2024 16:06:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Matt Liberty
 <mliberty@precisioninno.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] submodule status: propagate SIGPIPE
In-Reply-To: <pull.1799.git.1726837642511.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Fri, 20 Sep 2024 13:07:22 +0000")
References: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 13:06:08 -0700
Message-ID: <xmqqfrpuf5u7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7ED1690-778B-11EF-8392-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a46ffd49b34..a8e497ef3c6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -30,6 +30,7 @@
>  #include "advice.h"
>  #include "branch.h"
>  #include "list-objects-filter-options.h"
> +#include <signal.h>

Do we really need this?

As with any other Git built-in that relies on git-compat-util.h to
handle such system-dependencies, direct inclusion of system headers
like this is highly questionable.

