Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867915686F
	for <git@vger.kernel.org>; Thu,  2 May 2024 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684139; cv=none; b=D3HP157i/VQrS95cYb76oaaw5zOhJzYepKH5bt7kLPfXatQ6C0GCMf777RIOxQX02GiL7QS3pejV/l70T/c6wqGjjvytlXX0XDdMW8TFdTXomnBZvtOcu2T6Z4ocs5Qc//mmaen8+VZp83xENceWhmGzLhJvu/trpRQB68eNDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684139; c=relaxed/simple;
	bh=KfJkqZIKqEP6sT7kaVoEgi6xV5+GMMwIF72Jbtm8sKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emd+lNU28/Ixov2XhtoSsrVyKUvNai1b+QMk3dF/2VigmqoN0eYVepsI1SDWsLWELUziILTPtMH1oDGWGPqYHDZSBPhLHLnKXtduFX/wigesJFq/AO4AyIDj1ySZ3+YJv8emcnYnrXvZEy9e5ChyRMz1k3mvCaKiOuqdxDSpTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t6DO0SFc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t6DO0SFc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8733432482;
	Thu,  2 May 2024 17:08:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KfJkqZIKqEP6sT7kaVoEgi6xV5+GMMwIF72Jbt
	m8sKM=; b=t6DO0SFcIBBL8+ioTOd7+NVWpY6N/3m5GGVSMPnf2Awul4IlkLfOKr
	aN963X9zkHhNvFtAWcu3aBu5LAHQJa4/lDdEjxLwsOYWgD+i5gkE3fg7x/UhEeHM
	sLn61CA50MjkwXStviOJcv9ffkniTiMYhwbEsswLctdB4bumC8E5k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EAC032481;
	Thu,  2 May 2024 17:08:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E15D032480;
	Thu,  2 May 2024 17:08:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>,  Dhruva
 Krishnamurthy <dhruvakm@gmail.com>,  John Cai <johncai86@gmail.com>,
  git@vger.kernel.org
Subject: Re: using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git
 2.42
In-Reply-To: <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 2 May 2024 12:01:15 -0700")
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
	<20240501220030.GA1442509@coredump.intra.peff.net>
	<ZjLfcCxjLq4o7hpw@nand.local> <ZjPOd83r+tkmsv3o@nand.local>
	<xmqqfrv0ds7f.fsf@gitster.g> <ZjPTlrMdpI+jXxyW@nand.local>
	<CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
Date: Thu, 02 May 2024 14:08:51 -0700
Message-ID: <xmqqbk5ndiqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2DF6937C-08C8-11EF-8388-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> I could be misunderstanding the original intent of John's patch (the
>> commit message there isn't clear whether the change was intended to
>> target just check-attr or all of Git). But my hope is that it was the
>> former, which this patch preserves.
>>
>
> From the series [1] it becomes more clear that the intention was to
> target all commands.
>
> [1]: https://lore.kernel.org/git/pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com/

True.  

We could drop [1/2] from the series in the meantime to make it a
GitLab installation specific issue where they explicitly use
attr.tree to point at HEAD ;-) That is not solving anything for
those who set attr.tree (in a sense, they are buying the feature
with overhead of reading attributes from the named tree), but at
least for most people who are used to seeing the bare repository
ignoring the attributes, it would be an improvement to drop the
"bare repositories the tree of the HEAD commit is used to look up
attributes files by default" half from the series.

