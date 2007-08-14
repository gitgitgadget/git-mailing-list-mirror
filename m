From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Tue, 14 Aug 2007 01:57:04 -0400
Message-ID: <9e4733910708132257xfa7e1b5md77198c7ed80488d@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <9e4733910708132110u6cdf5e6bg10417317c70b82f1@mail.gmail.com>
	 <20070814051321.GG27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKpP1-000667-BP
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 07:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763007AbXHNF5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 01:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761441AbXHNF5I
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 01:57:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:50341 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761244AbXHNF5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 01:57:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2070882wah
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 22:57:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FEWcBeIe7gd6hC+oH6uR4+hrNTBTL5biWbcO+HwySxEw2nb3GZd85EOeCxVR/A1s/WI2ZeuHmC2QKdtLC2etR2kwvTvhDDiXtDPm9Tu6J0TOrqqa/UnV8FlF4lVdQBMRxIPXRD+EmkvLkmR9eVjx3ublqtIN55RkVKW7/noW090=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c4lnV7hZTH7D4CR5ixU5aPJ/g2u5MPuPF+BjzHiv3Fv2J4Tj6aFlgyj5+jrO6E2aLWZ+aNbso8k6Yhr4FwaKYvD25v0mbxnMIdj7FfAq/7wvaqiT3sw2eh5T+XB25b16NgiOkC+Sk54TrXC7gAczpfpBwC0ejqkCQ5gfcxoZf+s=
Received: by 10.115.17.1 with SMTP id u1mr3727239wai.1187071024363;
        Mon, 13 Aug 2007 22:57:04 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Mon, 13 Aug 2007 22:57:04 -0700 (PDT)
In-Reply-To: <20070814051321.GG27913@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55811>

On 8/14/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:

> One could probably argue that the defaults for 64b are too small;
> perhaps they should be closer to 4G/24G seeing as how the 64b address
> space is so huge that we're unlikely to run into issues with being
> able to use >24G of virtual address at once.

We've got 24,000GB of address space to play with. Why not set them
64G/512GB and forget about them for a decade?


> > I haven't measured it but I suspect the OS calls for moving the
> > windows are are quite slow on a relative basis since they have to
> > rewrite a bunch of page tables.
>
> Maybe.  Add a call to pack_report() at the end of the program you
> are interested in and run it.  We keep track of how often we move
> windows around; you may find that we don't move them often enough
> (or at all) to cause problems here.  Or just run it under strace
> and watch mmap() activity, filtering out the uninteresting bits.
>
> > Why is the window so small on 32b? I
> > thought we were up to about a 1GB packfile before running out of
> > address space with Mozilla. Shouldn't the window simply be set as
> > large as possible on 32b, this size being a function of the available
> > address space, not the amount of physical memory?
>
> Because programs need to malloc() stuff to work.  And we need
> stack space.  And we need to let the runtime linker mmap() in the
> shared libraries we are linked to.  All in all we do get tight in
> some 32b cases.  The above defaults for 32b were chosen based on
> the Linux kernel repository (its under 256M) and based on some
> (crude) performance testing on Linux (which seemed to say the
> 32M packedGitWindowSize wasn't really hurting us).  They were
> basically set to give us maximum address space for working heap
> and yet not have a negative impact on one of our (at the time)
> largest user groups.

Kernel is barely under 256M.

Do we need two limits, could we just start with the big one and assign
first packfile fully to it, then start dividing it up dynamically as
more pack files are opened?

core.packedGitLimit
core.packedGitWindowSize

The real question is, what's the access pattern into the windows? If
it is random then the windows get moved around continuously. If is it
more or less sequential the windows will hardly get moved at all.


Of course multi-threading the diff computation is going to do far more
for me than playing with the window size.


> In particular repack (aka git-pack-objects) is a real memory pig,
> especially now with its various caches.  The more address space we
> can let it use in a 32b case the better off we probably are.
>
> If someone can show that increasing these 32b defaults is the
> right thing to do even in very large repositories, *especially*
> with something really brutal like `git-blame` on a very busy file or
> `git repack -f -a` then please submit a patch to boost them.  ;-)
>
> --
> Shawn.
>


-- 
Jon Smirl
jonsmirl@gmail.com
