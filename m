Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FD149C43
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049516; cv=none; b=cuhTYoMQcu9NY79ESvdWCTZhlyUB1Zozm2VLe7jaQ6HALn6R2zrtyUoj082gOD+yG9B4INgZ117WE6cWGm0lI5hphzaZ9f0GkCnwls6qG2eW749CAF11gdekVdvq4AqWc+yEZ5PRl9HMGLfLm0GWuR+eAiRhaoHKSQIPHunE1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049516; c=relaxed/simple;
	bh=8v0rZ7UkL5i35qcPX+C/zzXUGJ/rqs1Lniwc1VakfsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hy/Xk6h7pUw3JlOkyoV9Dz9x3qxFXFm0Ckaow/rk+D7OlehDyOmm5aIhPdUIaA8xhiM3dWrG3i+B9uiIxqWLbF6+KS8q8iwQd2vpGJLs+rbWAs+Sk70udUyBuARO3JwU0+ePZM4nQGHdRZ+xd88iMOwhg0qCXYaMp/76VnRp1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jmMLZMc9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jmMLZMc9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D35D21182;
	Mon, 10 Jun 2024 15:58:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8v0rZ7UkL5i35qcPX+C/zzXUGJ/rqs1Lniwc1V
	akfsY=; b=jmMLZMc9oQU2RxC3ABWvDL/3vl6YvupWqhVvdjvKevvUe1ElnkvqKm
	ztpEgr0v//do8gODg9PvfdVG1L0xPaiDzFVBFstDaKuP+NRakXO2meO5UnRRMmGS
	WvBVqZQ3JiMn5NRFU5HTQVxmDBH2fFmLPiBA3kMEU8PiFdYwrpvwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 668CF21181;
	Mon, 10 Jun 2024 15:58:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCCF021180;
	Mon, 10 Jun 2024 15:58:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Yuri <yuri@rawbw.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
In-Reply-To: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
	(yuri@rawbw.com's message of "Mon, 10 Jun 2024 11:36:28 -0700")
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
Date: Mon, 10 Jun 2024 12:58:32 -0700
Message-ID: <xmqqwmmw1sev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D14D5920-2763-11EF-8E4F-6488940A682E-77302942!pb-smtp2.pobox.com

Yuri <yuri@rawbw.com> writes:

> NFS sometimes leaves files like .nfsXXXXXXXXXXX which usually means
> that some process that has this file open is alive.

Yes, and from everybody's point of view, including "git", a
directory with such a file is not yet empty.

> "git clean -df ." was supposed to remove the folder where such file is
> located, but it encountered the failure, and silently ignored it and
> succeeded.

So "was supposed to remove" above is not quite correct.  Where did
such a piece of misinformation come from?

