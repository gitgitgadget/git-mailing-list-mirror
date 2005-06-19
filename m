From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 20:15:02 +1000
Message-ID: <2cfc403205061903155a6090db@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <2cfc403205061817181e4d6d5e@mail.gmail.com>
	 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jun 19 12:10:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djwkd-0004oQ-OD
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 12:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVFSKP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 06:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVFSKP1
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 06:15:27 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:49095 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262149AbVFSKPD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 06:15:03 -0400
Received: by rproxy.gmail.com with SMTP id i8so373520rne
        for <git@vger.kernel.org>; Sun, 19 Jun 2005 03:15:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BR8yVDcW3CHJlnP0SMfNVotUgkfPh4vv8zXLUiAJYHLmfVQrOTshQ89NbiPvU0kH2BUziwmininiYZFx2zSHxm+gNZ/hFMFZcTEWFNTT3Rqjg1x5cH3kv+I/wSsz+3tqs1E215vHI9wtSYqLgSyt70kicw0iJ5+RDfSuvdDz2bo=
Received: by 10.38.88.14 with SMTP id l14mr1778257rnb;
        Sun, 19 Jun 2005 03:15:02 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 19 Jun 2005 03:15:02 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

FWIW, I accept that Linus' bisection algorithm does have better worst
case performance (in terms of number of build/test iterations) on at
least some examples than the literal middle bisection algorithm and
that the "literal middle" bisection algorithm has degenerate cases
which mean that its performance is sometimes worse than O(log 2 N).

I don't actually have a good feel for what the actual bound on Linus'
algorithm is, but I'll measure it on the 2.6 kernel and post the
results.

Regards,

jon.

On 6/19/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Sat, 18 Jun 2005, Linus Torvalds wrote:
> >
> > Now, I say "roughly", because there may not _be_ any commit that exactly
> > bisects the case. For a trivial case, let's say that we know that 'A' is
> > bad, and 'B' is good, but the graph in between them looks like this:
> 
> Let's make a different case, just to make it even more obvious.
> 
> Let's say that the graph is
> 
> 
>         A
>        / \
>       a1  b1
>       |   |
>       a2  b2
>       |   |
>       a3  b3
>       |   |
>       a4  b4
>       |   |
>       a5  b5
>       |   |
>       a6  b6
>       |   |
>       a7  b7
>       |   |
>       a8  b8
>       |   |
>       a9  b9
>        \ /
>         B
> 
> and we know that "A" is bad, and "B" is good, but we don't know which of
> a1-a9/b1-b9 are buggy.
> 
> Where do we start testing?
> 
> We start testing at either 'a1' or 'b1', because those are the two values
> that bisect the list either into the "a1-a9" series, or the "b1-b9"
> series. Any other starting point would be a bug.
> 
> Or, let's say that the graph is
> 
>         A
>        / \
>       |   b1
>       |   |
>       |   b2
>       |   |
>       |   b3
>       |   |
>       a1  b4
>       |   |
>       a2  b5
>       |   |
>       a3  b6
>       |   |
>       |   b7
>       |   |
>       |   b8
>       |   |
>       |   b9
>        \ /
>         B
> 
> 
> and in this case the right place to pick is 'b4', because that's the one
> that reaches 6 commits (b4-b9), while it leaves 6 commits unreachable
> (a1-a3, b1-b3): that's a perfect bisection, and now it's totally
> unambiguous (in the previous case a1 and b1 were equally good choices, in
> this case there is only one valid choice).
> 
> It gets more interesting when you have intermediate merges:
> 
>         A
>        / \
>       |   b1
>       |   |
>       |   b2
>       |   |
>       |   b3
>       |   |
>       a1  b4
>       |   |
>       a2  b5
>       | / |
>       a3  b6
>       |   |
>       |   b7
>       |   |
>       |   b8
>       |   |
>       |   b9
>        \ /
>         B
> 
> The above graph _looks_ very similar, but now the right place to bisect is
> 'b5', because that reaches six commits (a3 + b5-b9), and again there are
> six commits unreachable (a1-a2 + b1-b4). Again, this is unambiguous -
> there is one clearly superior choice.
> 
> The current --bisect algorithm may not always pick that best choice: I
> think I should subtract one from the total number of commits, since right
> now it counts the "good" commit too, ie 'A'. But I think it's at most
> off-by-one.
> 
> The bigger problem is that the algorithm is something like O(N^3) in cost
> - albeit with a fairly cheap constant factor. In other words, it might not
> be worthwhile bisecting three years worth of development with it, and you
> migth be better off starting with a rougher half-way-point algorithm
> ("let's try some release a year and a half ago first").
> 
> The performance problem seems to really be pretty theoretical: I can
> bisect the developemnt from 2.6.12-rc2 to current head in 0.59 seconds, so
> it's not like it's horribly slow for something like a couple of months
> worth of development.
> 
>                         Linus
> 


-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
