From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 12:12:04 -0500
Message-ID: <9e4733910712120912l342350f2i1f190c45730108f2@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
	 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>
	 <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>
	 <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
	 <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
	 <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, gcc@gcc.gnu.org,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:13:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2V8M-0000wo-57
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 18:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693AbXLLRMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbXLLRMM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 12:12:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:2351 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996AbXLLRMK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 12:12:10 -0500
Received: by wa-out-1112.google.com with SMTP id v27so512058wah.23
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/klSS5IWVjQS+ZHGI74guJZTsfhqaTTfppJB3G+fLLY=;
        b=M5/AzKzzkbXyqgqCmZ6WbvzigC+0ZbIByItGwUWGUd+Edm8cJA9vp6TgFwkgxIR5rZmenkE8sUV5G/opxxY7zDTZIIGtJQJkQCu6WOkSUUnsWqVhZSknxo8e294U2biJ31gc5QbVQyhr94ofbyTZ910tv0vm92ZBNLsaDZFPh60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DAe8CpUv/u1ReXa1L3bYZGg3g4iZArNEO2CQUousSzSkeHMKkbvUkI9r7+5cCwgjIEoCzF60zq20IpZgz1l4mHrn2QhzTBugPQoKr4Fmephh/AG8Bn4OHXya00raguXhKK5Y/SWTLTpkWveuerDT8IbtxYm70uVgF+r9PHzBGa0=
Received: by 10.114.111.1 with SMTP id j1mr1006994wac.138.1197479530127;
        Wed, 12 Dec 2007 09:12:10 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Wed, 12 Dec 2007 09:12:04 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68075>

On 12/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Wed, 12 Dec 2007, Nicolas Pitre wrote:
> >
> > So... my conclusion is that the glibc allocator has fragmentation issues
> > with this work load, given the notable difference with the Google
> > allocator, which itself might not be completely immune to fragmentation
> > issues of its own.
>
> Yes.
>
> Note that delta following involves patterns something like
>
>    allocate (small) space for delta
>    for i in (1..depth) {
>         allocate large space for base
>         allocate large space for result
>         .. apply delta ..
>         free large space for base
>         free small space for delta
>    }

Is it hard to hack up something that statically allocates a big block
of memory per thread for these two and then just reuses it?
   allocate (small) space for delta
   allocate large space for base

The alternating between long term and short term allocations
definitely aggravates fragmentation.

>
> so if you have some stupid heap algorithm that doesn't try to merge and
> re-use free'd spaces very aggressively (because that takes CPU time!), you
> might have memory usage be horribly inflated by the heap having all those
> holes for all the objects that got free'd in the chain that don't get
> aggressively re-used.
>
> Threaded memory allocators then make this worse by probably using totally
> different heaps for different threads (in order to avoid locking), so they
> will *all* have the fragmentation issue.
>
> And if you *really* want to cause trouble for a memory allocator, what you
> should try to do is to allocate the memory in one thread, and free it in
> another, and then things can really explode (the freeing thread notices
> that the allocation is not in its thread-local heap, so instead of really
> freeing it, it puts it on a separate list of areas to be freed later by
> the original thread when it needs memory - or worse, it adds it to the
> local thread list, and makes it effectively totally impossible to then
> ever merge different free'd allocations ever again because the freed
> things will be on different heap lists!).
>
> I'm not saying that particular case happens in git, I'm just saying that
> it's not unheard of. And with the delta cache and the object lookup, it's
> not at _all_ impossible that we hit the "allocate in one thread, free in
> another" case!
>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
