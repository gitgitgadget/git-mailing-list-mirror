From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Sat, 28 Apr 2012 12:56:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1204281243370.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 18:56:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOAwf-00030Y-TX
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 18:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2D1Q4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 12:56:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11897 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab2D1Q4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 12:56:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M370070W8DZUZ70@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 28 Apr 2012 12:56:24 -0400 (EDT)
In-reply-to: <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196497>

On Tue, 17 Apr 2012, Jay Soffian wrote:

> On Tue, Apr 17, 2012 at 12:16 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> > This has worked fine on repos large and small. However, starting a
> > couple days ago git started running out of memory on a relatively
> > modest repo[*] while repacking on a Linux box with 12GB memory (+ 12GB
> > swap). I am able to gc the repo by either removing --aggressive or
> > .keep'ing the oldest pack.
> 
> Experimentally, setting pack.windowMemory = 256m keeps git memory
> usage < 4.5 GB during an aggressive repack.

How many threads are used?  As mentioned elsewhere, the memory usage 
parameter should probably be made global rather than per thread, 
especially with the ever growing number of CPU cores in a system.  But 
this also pauses a balancing problem for optimally distributing memory 
between threads.

> Ironically I end up with a slightly worse pack (63115590 bytes vs
> 61518628 bytes) than not using --aggressive. I assume this is because
> pack-objects found a better delta chain during the previous aggressive
> repack when windowMemory was not set.

Exact.  When reusing delta data, you inherit the quality of the repack 
run that created them in the first place.

> > 1) If --aggressive does not generally provide a benefit, should it be
> > made a no-op?

Absolutely not.  It does provide benefits, but it comes with a cost in 
resources.  If you don't pay that cost then results won't be there.

> I guess I'll revise this question: perhaps --aggressive should be
> better explained/discouraged. I found a message from Jeff last month
> and stole his words for this patch:
> 
> <snip>
> diff --git i/Documentation/git-gc.txt w/Documentation/git-gc.txt
> index 815afcb922..ca5bf8b51e 100644
> --- i/Documentation/git-gc.txt
> +++ w/Documentation/git-gc.txt
> @@ -37,9 +37,8 @@ OPTIONS
>  	Usually 'git gc' runs very quickly while providing good disk
>  	space utilization and performance.  This option will cause
>  	'git gc' to more aggressively optimize the repository at the expense
> -	of taking much more time.  The effects of this optimization are
> -	persistent, so this option only needs to be used occasionally; every
> -	few hundred changesets or so.
> +	of taking much more time and potentially using greater memory. This

Scratch "potentially" here. It definitely uses more memory.

> +	option is rarely needed. See Repacking below.
> 
>  --auto::
>  	With this option, 'git gc' checks whether any housekeeping is
> @@ -138,6 +137,39 @@ If you are expecting some objects to be collected
> and they aren't, check
>  all of those locations and decide whether it makes sense in your case to
>  remove those references.
> 
> +Repacking
> +---------
> +
> +Under the covers 'git gc' calls several commands to optimize the repository.
> +The most significant of these with respect to repository size and general
> +performance is linkgit:git-repack[1]. There are basically three levels of
> +'gc' with respect to repacking:
> +
> + 1. `git gc --auto`; if there are too many loose objects (`gc.auto`), they
> +    all go into a new incremental pack. If there are already too many
> +    packs (`gc.autopacklimit`), all of the existing packs are re-packed
> +    together.
> +
> +    Making an incremental pack is by far the fastest because the speed is
> +    independent of the existing repository history. If git packs
> +    everything together, it should be more or less the same as (2).
> +
> + 2. `git gc`; this packs everything into a single pack. It uses default
> +    window and depth parameters, but importantly, it reuses existing
> +    deltas. Doing so makes the delta compression phase much faster, and it
> +    often makes the writing phase faster (because for older objects, git
> +    is primarily streaming them right out of the existing pack). On a big
> +    repository though, this does do a lot of I/O, because git has to
> +    rewrite the whole pack.
> +
> + 3. `git gc --aggressive`; this is often much slower than (2) because git
> +    throws out all of the existing deltas and recomputes them from
> +    scratch. It uses a higher window parameter meaning it will spend
> +    more time computing, and it may end up with a smaller pack. However,
> +    unless the repository is known to have initially been poorly packed,
> +    this option is not needed and will just cause git to perform
> +    extra work.
> +
>  HOOKS
>  -----
> 
> @@ -147,6 +179,7 @@ linkgit:githooks[5] for more information.
> 
>  SEE ALSO
>  --------
> +linkgit:git-pack-refs[1]
>  linkgit:git-prune[1]
>  linkgit:git-reflog[1]
>  linkgit:git-repack[1]
> </snip>
> 
> Thoughts?

FWIW, Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
