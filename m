From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Tue, 14 Aug 2007 00:10:31 -0400
Message-ID: <9e4733910708132110u6cdf5e6bg10417317c70b82f1@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 06:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKnjz-0002Ks-7q
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 06:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbXHNEKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 00:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbXHNEKd
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 00:10:33 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:26068 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbXHNEKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 00:10:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1337279rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 21:10:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M9TD9iwrB7cQ3JKFWSqTC5Mjw+9L/JjLWbPp9CIeumUV3Z640YnxxEh6Yr8bSZDKd7Z6jWNsOp3be7gjU9E1LF5e0xIDLeCvNA7qW5xeZreTUS3OhNGk9NN+kkFnKdf0RmVRWoyltjkPZVGgdHGGgYGWminIaVJpKI90CfLp3mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yti9vx1QLSdBUYr9d8x7ll5b7pPyjNL9gjvlanPE94PVmXIRe8HvYwIPsnl99tibV/fBfop20w1YyibvcHjQJRcVCHipCRiUiC7Sy6YfJTT9dE+gk5MyU4/0VJSRjzoAvWq5Q5Azn6/2i1JOPn1buTsf5LQpaMJnPkyRpasTTyo=
Received: by 10.115.110.6 with SMTP id n6mr1666487wam.1187064631121;
        Mon, 13 Aug 2007 21:10:31 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Mon, 13 Aug 2007 21:10:31 -0700 (PDT)
In-Reply-To: <20070814031236.GC27913@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55803>

On 8/13/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > On 32b there's windowing code for accessing the packfile since we can
> > run out of address space, does this code get turned off for 64b?
>
> The windowing code you are talking about defaults as follows:
>
>   Parameter                  32b      64b
>   -----------------------------------------
>   core.packedGitWindowSize    32M     1G
>   core.packedGitLimit        256M     8G
>
> So I doubt you are having issues with the windowing code on a 64b
> system, unless your repository is just *huge*.  I did not think that
> anyone had a Git repository that exceeded 8G, though the window
> size of 1G might be a tad too small if there are many packfiles
> and they are each larger than 1G.

Why use windows on 64b? Default core.packedGitWindowSize equal to
core.packedGitLimit

I haven't measured it but I suspect the OS calls for moving the
windows are are quite slow on a relative basis since they have to
rewrite a bunch of page tables. Why is the window so small on 32b? I
thought we were up to about a 1GB packfile before running out of
address space with Mozilla. Shouldn't the window simply be set as
large as possible on 32b, this size being a function of the available
address space, not the amount of physical memory?


> > > * On the other hand, we could run all try_delta operations for one object
> > >   parallel. This way, we would need not very much more memory, but
> > >   require more synchronization (and more complex code).
> >
> > This solution was my first thought too. Use the main thread to get
> > everything needed for the object into RAM, then multi-thread the
> > compute bound, in-memory delta search operation. Shared CPU caches
> > might make this very fast.
>
> I have been thinking about doing this, especially now that the
> default window size is much larger.  I think the default is up as
> high as 50, which means we'd keep that shiny new UltraSPARC T2 busy.
> Not that I have one...  so anyone from Sun is welcome to send me
> one if they want.  ;-)
>
> I'm not sure its that complex to run all try_delta calls of the
> current window in parallel.  Might be a simple enough change that
> its actually worth the extra complexity, especially with these
> multi-core systems being so readily available.  Repacking is the
> most CPU intensive operation Git performs, and the one that is also
> the easiest to make parallel.
>
> Maybe someone else will beat me to it, but if not I might give such
> a patch a shot in a few weeks.

I'll test it. But my assignment this week is to figure out how to
program the BestComm DMA engine in a PowerPC chip. It's oh so much fun
trying to figure out how to program these "engines" that ASIC
designers love to build and never fully document.

>
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
