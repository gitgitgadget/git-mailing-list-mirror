Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F67819
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434067; cv=none; b=CwXHAJLtlic4haFDeD7E5yiaeXo258mVSVAqI9WNh7RshHIinCNPcJf4AFYndlxvxxiqKKwMJtrJRaIM4XrqQgEOyHwEhfvTHXbLi3wAiLijIlc4lp5S0ECZ9EXXDPqCHwhbkm37H3oemawP3p0OoFv35T/F7ITmlN4sqsWAYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434067; c=relaxed/simple;
	bh=ZtYDj1oK3gP2ZXSOoKpbhb1aHC8nw3FSrA2xteZDD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv+RviKzQaXiJBo6rFRaBiyyTqIU2x5lYZvV4/N/j7lzPowuaALwIYWkoKoI+h83QHmI1v8AJjCFGz171MqvHZzz67kKa5amUsMvirlfLtEINBYXYBBNBSgGFwnKqvZ83UXdU/XVxG2relU7aGiE2WGIXYMKcdbUBCEBAM5gqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25429 invoked by uid 109); 26 Jun 2024 20:34:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:34:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24997 invoked by uid 111); 26 Jun 2024 20:34:16 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:34:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:34:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Paul Millar <paul.millar@desy.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag is
 used
Message-ID: <20240626203415.GA441931@coredump.intra.peff.net>
References: <xmqq34p1813n.fsf@gitster.g>
 <20240626065223.28154-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
 <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
 <xmqqikxv4t1v.fsf_-_@gitster.g>
 <xmqqcyo33cgu.fsf@gitster.g>
 <bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
 <xmqqsewz1ua5.fsf@gitster.g>
 <f7d0abce-b389-45ae-992a-adbc7ec10d50@gmail.com>
 <xmqq8qyrzgi5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qyrzgi5.fsf@gitster.g>

On Wed, Jun 26, 2024 at 11:49:22AM -0700, Junio C Hamano wrote:

> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
> 
> > On 26/06/24 23:05, Junio C Hamano wrote:
> >> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
> >> 
> >>> To me, this looks much better.  child_process_clear's name already
> >>> suggests that is sort of like a destructor, so it makes sense to
> >>> re-initialize everything here.  I even wonder why it was not that way to
> >>> begin with.  I suppose no callers are assuming that it only clears args
> >>> and env though?
> >> 
> >> I guess that validating that supposition is a prerequisite to
> >> declare the change as "much better" and "makes sense".
> >
> > OK.  I found one: at the end of submodule.c:push_submodule()
> >
> > 	if (...) {
> > 		...some setup...
> > 		if (run_command(&cp))
> > 			return 0;
> > 		close(cp.out);
> > 	}
> 
> This is curious.
> 
>  * What is this thing trying to do?  When run_command() fails, it
>    wants to leave cp.out open, so that the caller this returns to
>    can write into it???  That cannot be the case, as cp itself is
>    internal.  So does this "close(cp.out)" really matter?

I think it's totally broken. Using cp.out, cp.in, etc, with
run_command() is a deadlock waiting to happen, since it implies opening
a pipe, not doing anything with our end, and then doing a waitpid() on
the child.

You'd always want to use start_command(), and then do something useful
with the pipe, and then finish_command(). Arguably run_command() should
bug if cp.out, etc are non-zero.

In this case the code leaves cp.out as 0, so we are not asking for a
pipe. That is good, and we are not subject to any race/deadlock. But
then...what is the cleanup trying to do? This will always just close(0),
the parent's stdin. That is certainly surprising, but I guess nobody
ever noticed because git-push does not usually read from its stdin.

So I think the close() is superfluous and should be deleted. It goes all
the way back to eb21c732d6 (push: teach --recurse-submodules the
on-demand option, 2012-03-29). I guess at one point the author thought
we'd read output from a pipe (rather than letting it just go to the
parent's stdout) and this was leftover?

>  * Even though we are running child_process_clear() to release the
>    resources in run_command() we are not closing the file descriptor
>    cp.out in the child_process_clear() and force the caller to close
>    it instead.  An open file descriptor is a resource, and a file
>    descriptor opened but forgotten is considered a leak.  I wonder
>    if child_process_clear() should be closing the file descriptor,
>    at least the ones it opened or dup2()ed.

Usually the caller will have handled this already (since it cares about
exactly _when_ to close), so we'd end up double-closing in most cases.
This is sometimes harmless (you'll get EBADF), but is a problem if the
descriptor was assigned to something else in the meantime.

In most cases callers shouldn't be using child_process_clear() at all
after start_command(), etc. Either:

  - start_command() failed, in which case it cleans up everything
    already (both in the struct and any pipes it opened)

  - we succeeded in starting the command, in which case
    child_process_clear() is insufficient. You need to actually
    finish_command() to avoid leaking the pid.

  - after finish_command(), the struct has been cleaned already. You do
    need to close pipes in the caller, but you'd have to do so before
    calling finish_command() anyway, to avoid the deadlock.

You really only need to call child_process_clear() yourself when you set
up a struct but didn't actually start the process. And from a quick skim
over the grep results, it looks like that's how it's used.

-Peff
