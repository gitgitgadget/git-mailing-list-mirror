Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DEC5B5B8
	for <git@vger.kernel.org>; Thu, 23 May 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455063; cv=none; b=FAeVO5+hjVm6gS7kmEts6mhdPwZ2Nn25LWgTzwxd/5cc6yPu3C8y99+0jEhgqNM//NRUvXJp6sNdk6DkPGDiCRbqzz7OD7TyzJ9N+7jQC4pLDGT8DE2ekAfOJKj4+W5pF7SDiaSxy9f7wOu0icOOi+bN3dQ7f3OBd5bUIqgbXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455063; c=relaxed/simple;
	bh=58QXtCBDaugxCi1jMO78tmEmsPRauAT3eHCwOomgOUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUU0hBMW8T/O/BMt9D/r6hDGDmbMmxT59xSr978V28JzRzYChvx4DzhjStt4fjzQ3oSI6H4A8l7BcVCRmTNzGmvDut1ICzp64qyp1C2hcig7ahLRqQAGifyQoAy7n+ZQS2TnP143NuGFjEUh7rVT6ff4LoNbJbHfzjbyrb6bpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31011 invoked by uid 109); 23 May 2024 09:04:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 09:04:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28396 invoked by uid 111); 23 May 2024 09:04:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 05:04:24 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 05:04:19 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Pawe=C5=82_Bogus=C5=82awski?= <pawel.boguslawski@ib.pl>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Cloning does not work on available download bandwidth changes
Message-ID: <20240523090419.GB1306938@coredump.intra.peff.net>
References: <ed79092c-c37d-4e4c-aae9-af68cd8c20a0@ib.pl>
 <Zk5pDZ1gTcyrGfUk@tapette.crustytoothpaste.net>
 <293afb32-99b1-4562-b339-7862698ef00f@ib.pl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <293afb32-99b1-4562-b339-7862698ef00f@ib.pl>

On Thu, May 23, 2024 at 12:58:27AM +0200, Paweł Bogusławski wrote:

> Try to run
> 
> git clone https://github.com/googleapis/google-api-go-client
> 
> and limit interface speed somehow i.e.
> 
> tc qdisc add dev eth0 root handle 1: htb default 12
> tc class add dev eth0 parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
> tc qdisc add dev eth0 parent 1:12 netem delay 1000ms
> 
> and after a while restore speed with i.e.
> 
> tc qdisc del dev eth0 parent 1:12 netem delay 1000ms
> 
> I tried this in Debian 11 and  git 2.30.2 died with:
> 
> error: 5723 bytes of body are still expected MiB | 920.00 KiB/s
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: index-pack failed

I did run it a few times. It usually succeeds, but sometimes fails. When
it does fail, it does so in "slow" mode, without speeding back up. And
I see one message from before your "error:" line, which is a report that
curl reported that the connection dropped (curl is shuttling data back
from the server in the form of "packet lines", each of which is prefixed
with its expected size; the "N bytes of body are still expected" is just
that parser seeing a truncated response from curl).

But I don't think any of this is due to what Git is doing on the client
side. From the client view, the server sends a TCP RST (which I observed
with wireshark), and the connection drops. I'd suspect the drop is not
even from the application level on the server side, but rather that
something in the network path was mad about the delayed packets (or
possibly the spam of duplicated TCP acks that I sometimes saw).

So I really think this is a network issue, and not a Git issue in
particular. It's possible that the networking stack that github.com uses
is more picky about the things I mentioned above. But again, not a Git
issue.

-Peff
