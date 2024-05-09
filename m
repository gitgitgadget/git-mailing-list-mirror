Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDF16F850
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271798; cv=none; b=OMbFoi0+JZCIwBR+Md/NA5Ib04NUy3FoOEYTdWuQrKVL6oV+QmGoGMrDMbCmnjBJaNO8NARMSQzbcNT+ZSYh53h5VAM1m9prQ5WV9TjAOphsFtFQDS+AGAu65j2Ephm9s+aP0KhG6vr+NAuz3cw3hbG33rGlgq/LDFAWGkz7omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271798; c=relaxed/simple;
	bh=BK3+zDoZ8wOYmkEMYUdXiW/3zP0ZXxyzaMbtvA3jBRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PqbaIKV39CIaVUmLUeiH6SfuA6ZdyR3lWkqxCsQQ8Ea063a2hpWwNChF2+w5TVjCxtbwsFLJvsKvzk8gbpUyfrd2I6YW2q4mxUmaQwX8Ql+SKzlywHFHc8enIH266dDhNmpJdoQwQ6vbMAokgUbw3t15Z/h1m8Xz5HMNwjh/h7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CAWoWZ0m; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CAWoWZ0m"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E1742289D;
	Thu,  9 May 2024 12:23:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BK3+zDoZ8wOYmkEMYUdXiW/3zP0ZXxyzaMbtvA
	3jBRk=; b=CAWoWZ0mub6BaEouFgUTMdbEvz6OldCmHjqWl0Dh6ED4yfU2Nvov6i
	QfRcx88loiuQ0Z136RTLRLj3REIpOtkuutz/8nTAOud0QZpoLVhAIGgj3nv/R++x
	vyfIuBQ/1SVk9kVlfFBTOCJipxHQp/Yvf0VaGcje0u4gKkndU2Tao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 954102289C;
	Thu,  9 May 2024 12:23:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B2AB2289B;
	Thu,  9 May 2024 12:23:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org
Subject: Re: bug: git config --global --unset doesn't unset configs in
 corner case
In-Reply-To: <20240509021352.se4u7ajaolveyyjf@glandium.org> (Mike Hommey's
	message of "Thu, 9 May 2024 11:13:52 +0900")
References: <20240509021352.se4u7ajaolveyyjf@glandium.org>
Date: Thu, 09 May 2024 09:23:13 -0700
Message-ID: <xmqqmsozuf7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6FE20ACA-0E20-11EF-9AFA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Mike Hommey <mh@glandium.org> writes:

> When both ~/.gitconfig and ~/.config/git/config exist, git will read
> both. But when using `git config --global --unset`, it will only touch
> the first one. So unsetting config items from ~/.config/git/config is
> not possible from the command line when ~/.gitconfig exists.

Interesting observation of an understandable behaviour.

I think the original intent of limiting the writing to just one was
to avoid having both files in the first place.  When both do exist
already, I am not sure what the right behaviour on the write side
should be.  We could special case "--unset-all" and remove from
both, but "--unset" is to remove just one, so when the reading side
reads from both, it becomes "which one to remove"?

Comments from those who are more familiar with the "git config" are
certainly appreciated.

Thanks.

