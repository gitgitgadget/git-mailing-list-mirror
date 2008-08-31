From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Sun, 31 Aug 2008 15:57:17 +0200
Message-ID: <20080831135717.GA25984@blimp.local>
References: <20080828171533.GA6024@blimp.local> <20080828212722.GF6439@steel.home> <237967ef0808290758p2bd1de55idcb9ad9150389b2b@mail.gmail.com> <81b0412b0808300312h53605ac8p2d60784ca2178a0@mail.gmail.com> <237967ef0808300333t2cd4e354xd461f7bfead40f4c@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 15:59:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZnRh-0007qH-9d
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbYHaN5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 09:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756907AbYHaN5U
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 09:57:20 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:33783 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843AbYHaN5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 09:57:19 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f4EPXSQ==
Received: from tigra.home (Faf6f.f.strato-dslnet.de [195.4.175.111])
	by post.webmailer.de (fruni mo50) (RZmta 16.47)
	with ESMTP id z00c9ek7V8usfI ; Sun, 31 Aug 2008 15:57:18 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id DC8B1277AE;
	Sun, 31 Aug 2008 15:57:17 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id C0FDF36D1D; Sun, 31 Aug 2008 15:57:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <237967ef0808300333t2cd4e354xd461f7bfead40f4c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94483>

Mikael Magnusson, Sat, Aug 30, 2008 12:33:26 +0200:
> 2008/8/30 Alex Riesen <raa.lkml@gmail.com>:
> > 2008/8/29 Mikael Magnusson <mikachu@gmail.com>:
> >> I merged the branch in pu into next, which I think should work, but I get
> >> these segfaults for some commands... I tried running in gdb but even with
> >
> > Can't reproduce in master, will try with next later, am busy right now, sorry.
> >
> >> -g3 I only get nonsense backtraces, not sure why.
> >
> > Remove -O2 from CFLAGS:
> >
> >  $ make CFLAGS="-O0 -ggdb"
> 
> Hm, I only had CFLAGS set in the env, maybe that's not enough, or maybe it

The make variables set in Makefile take precedence over the variables
with same names in environment (see make(1), "-e" option).

> was that I had it set to -gdwarf-2 -g3 instead of -ggdb3. At any rate, I got
> this now:
> 
> % git fotch
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xa7ce56c0 (LWP 13043)]
> 0x41b61490 in ?? () from /lib/libc.so.6
> (gdb) bt
> #0  0x41b61490 in ?? () from /lib/libc.so.6
> #1  0x41b634b0 in realloc () from /lib/libc.so.6
> #2  0x41b62fdb in malloc () from /lib/libc.so.6
> #3  0x080f63e6 in xmalloc (size=24) at wrapper.c:20
> #4  0x080f6471 in xmemdupz (data=0x816a44f, len=23) at wrapper.c:45
> #5  0x080f64e9 in xstrndup (str=0x816a44f "refs/remotes/origin/man",
> len=23) at wrapper.c:54
> #6  0x080dc05c in parse_refspec_internal (nr_refspec=6,
> refspec=0x816a010, fetch=1, verify=0)
>     at remote.c:505

Looks like heap corruption. See that patch I sent today.
