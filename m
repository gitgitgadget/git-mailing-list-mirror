Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7B2566
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497188; cv=none; b=d3EYGYmdeqEjnsDgNM6LBsrgkltsYAK5lbySG1NP6YzvGMp53DmxpkboNWwtkthFkzVOxl6noSCBRsg8Q37v+FU+PtieDWAIcqISjbUy9Kpwn25wpw4MvNF1W4xdRu44XwEuHfBOTT2PcdtDTXRy4j9cqhjmn5G2ae3Aj6vCLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497188; c=relaxed/simple;
	bh=LvpCJLxK//yrrIeY+Zz5qVeGqFy3FTysZFyrFdAtAig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzaTmcWQTfQJ6+/9mvfU6jUyYmIuYsWzb5KnCxgLoeYArpWS2Nt9Ab0Z9o01H9duy2btZFRF5SgZXbJXEg/iCpy7dtMVOXjmzJ3mQiSBUE3gkBSKcCcBZwv+LCNyBPmZQglHkvd0HFydt6DgbbqI2KjLI2R9BpQKdA0LHwFHVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21925 invoked by uid 109); 4 Jun 2024 10:33:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:33:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18708 invoked by uid 111); 4 Jun 2024 10:33:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:33:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:33:05 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
Message-ID: <20240604103305.GB1781455@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
 <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>

On Tue, Jun 04, 2024 at 11:05:15AM +0100, Phillip Wood wrote:

> Hi Rubén
> 
> On 03/06/2024 21:38, Rubén Justo wrote:
> > In 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
> > 2015-08-04), t/test-terminal.perl learned to connect the child process'
> > stdin to a pty.  It works well for what was intended: satisfying an
> > `isatty(STDIN_FILENO)` check.
> > 
> > However, the fork introduced, that copies the stdin to the child
> > process, does not always manage to send all the information.
> 
> I think the problem maybe to do with the use of File::Copy, not with the
> fork. The man page for the copy function says
> 
>     Note  that  passing  in  files  as  handles  instead  of  names may
>     lead to loss of information on some operating systems; it is
>     recommended that you use file names whenever possible.
> 
> Rather than adding a new flag to work around a bug in our script it might be
> better to try and fix the bug by using a loop that reads blocks of data from
> the source and writes them to the destination instead of calling copy.

I don't think I've seen missing data. But do note that the test_terminal
stdin handling is racy:

  https://lore.kernel.org/git/20190520125016.GA13474@sigill.intra.peff.net/

IMHO we should consider getting rid of it entirely. I think the only
thing that uses it is t4153 (AFAICT it is luckily not racy because it
does not actually read stdin, but only checks isatty).

-Peff
