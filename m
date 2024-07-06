Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7846B80
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720303810; cv=none; b=bw9ylhikqK3gkRyChyp8XQaod88bmooIUB3rBo+QZjg30gEYV2FO2BMdzAmAvduMhkhEzQz8svp0HjJ9zGnwLmyF4dp8EW+xO0CZ7HZ/tE2ywLayoZGZ55WQURy9lt2N9IEBKIwWt/4xWzQB9GGr1mrQCt8w6mClRAJ56HH97lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720303810; c=relaxed/simple;
	bh=BAY1c73NmEC6bbxosZu35FSn3VPoDinKoM232RKdUe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lPqkafLydwSn0DY6Wf2AaGvYziRLxd/A4rfF18K7CAGYcn+wzo+Te0m4fb8PNSk31pQDg+p5Pcu5oKvLhua8GEHh9aIEj1vp6jBJS6hCmUP3F1HFzPevAChLT84FuF/zbT/dWqzxxuCqXmJd0jlYstqEDtJzuLxbFSxmOKwtFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wEbtsWA0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wEbtsWA0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3D911CB5A;
	Sat,  6 Jul 2024 18:10:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BAY1c73NmEC6bbxosZu35FSn3VPoDinKoM232R
	KdUe0=; b=wEbtsWA00Csna16cYlUhCC0LO6+qlW5Lyq65pDGLA/Hp92pItL6ZoH
	3HAUnirKtQCjEZ4dmk9vO//IuP8Oox7kJMcI80YN6T3pdb5gE3ctQU5fuQc4QpLR
	4Rvf4ZHS/AjExbR5DSpMQN1+RvGx05jL5Dj9mpDgFTvZgm5uLzs/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A60601CB58;
	Sat,  6 Jul 2024 18:10:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E785F1CB54;
	Sat,  6 Jul 2024 18:10:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com>,
  git@vger.kernel.org
Subject: Re: git diff-tree do not honor diff.orderfile config
In-Reply-To: <Zohf7LzaRHaG9vX6@nand.local> (Taylor Blau's message of "Fri, 5
	Jul 2024 17:04:44 -0400")
References: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
	<Zohf7LzaRHaG9vX6@nand.local>
Date: Sat, 06 Jul 2024 15:10:00 -0700
Message-ID: <xmqqy16ematj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E524B00-3BE4-11EF-8AAF-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> So I suppose the question is whether supporting -O from diff-tree is
> sensible. If it is, then reading the diff.orderFile configuration option
> is a no-brainer. But if it isn't, then we should probably not make a bad
> situation worse by adding support for it.

If plumbing commands paid attention to the end-user configuration,
they will not serve as a reliable building blocks for script
writers.  The would instead change their behaviour in a way not
expected by script writers.

On the other hand, we do want to give script writers an option to
utilize power of the underlying machinery.  If they want to specify
a particular order of paths in the output, they are welcome to feed
an orderfile via the command line and that is why we have an option.

Supporting "-O <orderfile>" and ignoring "diff.orderfile" are both
very sensible thing for the plumbing commands and it is the result
of deliberate design.

Thanks.
