Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AD3815E6
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774647597; cv=none; b=rs06mJgCNX4NIYBu+jzIC5y27dFj/q462I15k5lduckf7KpRfhSgE3ASiyBsMN/lIZplgJ5YMowAaXlOqiuJAn6K/D+AGxdiMfPUGCBuuq3HWvbMxozJ6KrnNcFLGktj+YLAnaU2nMKoEhhmH9BvNVACN5omTr80D9ewO5VBxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774647597; c=relaxed/simple;
	bh=KihAbNzcMq2oCq70hAEDFThW9AknaEMYMtnmI+shtHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUCPkFbW+SAxhBz0JnpYJ+PhMXd1UcQ64tLntfXa3Bl4Gqr9qS3TkXCEL4ZMoNCJ7t1q3/qEsdQ33eeskrjJmzWFeqAoAQqiawHmmuJAyRtQP3EIJ7ME8hMQ7OuPrd9qvkwkzX2OBDfGjyk+yEA4HyCBBu226UI0pm3MuDNAcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ma10dbT/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ma10dbT/"
Received: (qmail 171067 invoked by uid 106); 27 Mar 2026 21:39:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KihAbNzcMq2oCq70hAEDFThW9AknaEMYMtnmI+shtHg=; b=Ma10dbT//v9TreaVEkiMDgdIbUTXTH0v/D7BxvBKSqSKbqTpGrk+FQH2d+QwABp6sPFBRWU3IbunvAK5qu5fyVdlw37wJO1Q+0g8QFDIw/hHqeeEAe+XBd86K/PGipC5rAQM5OGyV4nVLqTDvCpipSD7ExxbyVY5yphd3tdqrJzz5eENy8f9nE5Zre1CAj9nO75EkPHf27EHzMGcUTeuYxO8t35IXWiBaixGTP6ErjaSMif+wjKEx653lt45EpQBYe9ceKs0K+dxXyw15w8dHEK2UcdCe9B8S4koHlNcFjulTH5wLWjYXTh5m/Gpxgi8ythNv9sGZAk13/ApD2TM5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Mar 2026 21:39:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 239721 invoked by uid 111); 27 Mar 2026 21:39:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2026 17:39:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Mar 2026 17:39:54 -0400
From: Jeff King <peff@peff.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: git@vger.kernel.org, Li Linchao <lilinchao@oschina.cn>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] connect: Add transport->remote->name to git_connect()
Message-ID: <20260327213954.GB598533@coredump.intra.peff.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <20260326233739.2911354-3-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326233739.2911354-3-wesleys@opperschaap.net>

On Thu, Mar 26, 2026 at 07:37:37PM -0400, Wesley Schwengle wrote:

> To support `remote.$name.sshIdentityFile', and `remote.$name.sshOpts' for
> connecting to various remotes I need to pass around the remote down to
> git_connect. This commit introduces the `remote_name' and sprinkles all
> call sites to pass `NULL'. This is a non-breaking forward change

My gut feeling is here is that this is going to be the wrong level for
reading config, because it's too low and too coarse. If we ever want to
have a command-line option for overriding config, like "git fetch
--ssh-identity-file=foo", then how can the higher level git-fetch code
pass down that single item?

I.e., I think the ideal form of this would be that we pass around an
ssh_options_context struct, high-level commands fill in that struct
based on command-line options or config (including remote-specific
ones), and then we act on it at the lowest level when spawning ssh.


All that said, my first thought here is that most of what this series
does is already possible with ssh config. It looks like that has already
been suggested elsewhere in the thread, so I'll go read that before
commenting further.

-Peff
