Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B353816
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324195; cv=none; b=UPMjZbLR6uERE0oPuOmdhj07QOKk5EC7A/vkUqlDjPP/XcCkKzNgmsv5kU6HH9qpK5IjHso2xGLSsLJludxTc2YGgo4iE3Hmmvvi+F5eK/Rzww7veuxPAhFB7HVTYYNWj8Cd+m7WwFogjdJJzUMLtMDq3KmEy8DYQW/iqyBjwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324195; c=relaxed/simple;
	bh=II97xGlPIR7arjZInKlUuBPTJl/VbPdZfJBXlvNCKTQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SfSUYwDOdMPwx4XUFv4PJ+qGGlc9jVZbLXrAM8XcKy/V4zC00MnOmPyMydGWmMzQMLiiQ5Koy/qqGIG7GN8+e3wem30tofrpSAJiqFXYl4JGRPLtNzXRH2h0MRyRYCKqeNmD/SERrZhCOSYxNXiUcNFQgj66VCJXrwPkonNdVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D//fMxPh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D//fMxPh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CBD382267F;
	Tue, 21 May 2024 16:43:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=II97xGlPIR7arjZInKlUuBPTJl/VbPdZfJBXlv
	NCKTQ=; b=D//fMxPhIxkzbsLy3Lstl58UGKDZDIKRhW5/fpggIPnUC9CsxOzEfK
	e7FgcmtEAcUW6EK3Rdffs3f2ztMntkVJLP7XH/sN+EgvZ5hMNQbJws9bPEJaTqc7
	Xj+SHYdMHxvv0kxPuP7sCjE0tHEXai70N08GhMGRqFrkpaz5Gxntw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C40EC2267E;
	Tue, 21 May 2024 16:43:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 367A12267D;
	Tue, 21 May 2024 16:43:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 12/12] Revert "fetch/clone: detect dubious ownership of
 local repositories"
In-Reply-To: <20240521195659.870714-13-gitster@pobox.com> (Junio C. Hamano's
	message of "Tue, 21 May 2024 12:56:58 -0700")
References: <20240521195659.870714-1-gitster@pobox.com>
	<20240521195659.870714-13-gitster@pobox.com>
Date: Tue, 21 May 2024 13:43:11 -0700
Message-ID: <xmqq34qaaobk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD7B9F26-17B2-11EF-BE2F-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> This partially reverts f4aa8c8b (fetch/clone: detect dubious
> ownership of local repositories, 2024-04-10) that broke typical
> read-only use cases (e.g. by git-daemon serving fetches and clones)
> where "nobody" who has no write permission serves repositories owned
> by others.  The function to die upon seeing dubious ownership is
> still kept, as there are other users of it, but calls to it from the
> generic repository discovery code path, which triggered in cases far
> wider than originally intended (i.e. to stop local clones), have
> been removed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I am inclined to propose dropping this step, actually.

cf. https://lore.kernel.org/git/xmqq7cfmaofl.fsf@gitster.g/
