Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448315A874
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873541; cv=none; b=aaz9CKRbW/hWZBmCxZ/+ZPNAjxO/3wh7+SDpMutak+OItbFgDsuvusVrvwX/FvQdnkxDPXUmLZQYMBFxN1s9i4aDCP6f2GlaXnaMrMFh88TBR0AHvfc5K6nbOGpcbFzo4XMyjD4RbOVqWxH48MVRzcUnwEkY6AsdXSf31X+3dok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873541; c=relaxed/simple;
	bh=t4bg5StNOwsZqwIbdMjVnbeqttQDSgc79zdmEUoFy7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpAIGNjY6Ggn4KGhAR5dcKcOeh6TD+EfFTjD3CShEZknbnQaVaYUKZx++oxP5LpvZBsVjljmTtD1Uh0m2WxdHx2m5flu+VsELZEV3joTBd7nSIa9qoQpCF3G+Gnn8LKSqISgUWj749PvxAKbdFEscYiI+MhCst6LWz5yfq6xM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WFLlWr3P; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFLlWr3P"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F9C624302;
	Mon,  5 Aug 2024 11:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t4bg5StNOwsZqwIbdMjVnbeqttQDSgc79zdmEU
	oFy7A=; b=WFLlWr3PeVlEH2acYyw/JhQMzfiSc4iFmHvRW9nkspVMnB60gwTqdX
	xPBUaeEaO9lmOaVYKHJW67ylV5A0lFg8WMc/cc5fyFyeJ2+lZm1aXFj2tjETBPJE
	wE+trA9GFflBNZ5NSXwK8ST9lrHBOrRXfXrHWYb5K9Oc7YLwLRcjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 858BE24301;
	Mon,  5 Aug 2024 11:58:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFD84242FF;
	Mon,  5 Aug 2024 11:58:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sven Strickroth via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sven Strickroth <email@cs-ware.de>
Subject: Re: [PATCH v2] refs/files: prevent memory leak by freeing
 packed_ref_store
In-Reply-To: <ZrC0sbxnCONqnPPI@tanuki> (Patrick Steinhardt's message of "Mon,
	5 Aug 2024 13:17:05 +0200")
References: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>
	<pull.1757.v2.git.git.1722851612505.gitgitgadget@gmail.com>
	<ZrC0sbxnCONqnPPI@tanuki>
Date: Mon, 05 Aug 2024 08:58:56 -0700
Message-ID: <xmqqmslr3qrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FC2422E-5343-11EF-B99D-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 05, 2024 at 09:53:32AM +0000, Sven Strickroth via GitGitGadget wrote:
>> From: Sven Strickroth <email@cs-ware.de>
>> 
>> This complements 64a6dd8ffc (refs: implement removal of ref storages,
>> 2024-06-06).
>> 
>> Signed-off-by: Sven Strickroth <email@cs-ware.de>
>
> Thanks, this version looks good to me!

Thanks, both.
