Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D72139A7
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448408; cv=none; b=ajezdMwCYmw37CKS7yilJmRMzRKdFkXThQrh0WDFePvuBHExa5c4UQ1vDz049UhqvGd1Y4iWNONTWcqR/gGHN5UK38e1OtT++AGCMTlhSzrSjgev2u7dtn5/ygqfwbH/YbNSRYdsPjiYJZYPhWiukIF50UWUCrFnJBzwX97Fv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448408; c=relaxed/simple;
	bh=bzbNVEBAShZbpz6eN5oPoEcq/mY3DxQyZbyVop7EHwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktz5Fb8k8ifuQ5wF1ItmmzNcuEGCagHJ9qW0/gaP3KxwvZ3IlZVS5D2VxbtI/6crQBeUNW7nSyi3oJtXBYIYZpMD2C9JmniS88qhn9lnWZUBCroKfdl4Ni703aihjSmqPfkwArIWxFySj3ZqPOP5Iz13f1TsPq3YapcVE6tc+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 472 invoked by uid 109); 27 Jun 2024 00:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Jun 2024 00:33:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26556 invoked by uid 111); 27 Jun 2024 00:33:23 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 20:33:23 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 20:33:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Paul Millar <paul.millar@desy.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag is
 used
Message-ID: <20240627003323.GA1460039@coredump.intra.peff.net>
References: <20240626065223.28154-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
 <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
 <xmqqikxv4t1v.fsf_-_@gitster.g>
 <xmqqcyo33cgu.fsf@gitster.g>
 <bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
 <xmqqsewz1ua5.fsf@gitster.g>
 <f7d0abce-b389-45ae-992a-adbc7ec10d50@gmail.com>
 <xmqq8qyrzgi5.fsf@gitster.g>
 <20240626203415.GA441931@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626203415.GA441931@coredump.intra.peff.net>

On Wed, Jun 26, 2024 at 04:34:17PM -0400, Jeff King wrote:

> >  * What is this thing trying to do?  When run_command() fails, it
> >    wants to leave cp.out open, so that the caller this returns to
> >    can write into it???  That cannot be the case, as cp itself is
> >    internal.  So does this "close(cp.out)" really matter?
> 
> I think it's totally broken. Using cp.out, cp.in, etc, with
> run_command() is a deadlock waiting to happen, since it implies opening
> a pipe, not doing anything with our end, and then doing a waitpid() on
> the child.
> 
> You'd always want to use start_command(), and then do something useful
> with the pipe, and then finish_command(). Arguably run_command() should
> bug if cp.out, etc are non-zero.

Oh, I guess I should have looked at the code. We do indeed BUG() in this
case already, courtesy of c29b3962af (run-command: forbid using
run_command with piped output, 2015-03-22).

So all is well there. This caller is still completely wrong to call
close() though.

-Peff
