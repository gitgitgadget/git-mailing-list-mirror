From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git in next is broken
Date: Thu, 12 Nov 2009 23:50:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911122345450.16711@xanadu.home>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home>
 <4AFC8960.9090808@lsrfire.ath.cx>
 <alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 13 05:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8o7C-00076b-PR
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 05:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbZKMEuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 23:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755611AbZKMEuS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 23:50:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8206 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbZKMEuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 23:50:17 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KT100CJC6RYNIB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Nov 2009 23:50:22 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132815>

On Thu, 12 Nov 2009, Julian Phillips wrote:

> On Thu, 12 Nov 2009, Ren? Scharfe wrote:
> 
> > Nicolas Pitre schrieb:
> > > Simply issuing a "git fetch" in my copy of git.git makes glibc complain
> > > with this:
> > > 
> > > *** glibc detected *** git: corrupted double-linked list:
> > > 0x0000000000974180 ***
> > > 
> > > The gdb backtrace is:
> > > 
> > > (gdb) bt
> > > #0  0x0000003c76632f05 in raise () from /lib64/libc.so.6
> > > #1  0x0000003c76634a73 in abort () from /lib64/libc.so.6
> > > #2  0x0000003c76672438 in __libc_message () from /lib64/libc.so.6
> > > #3  0x0000003c76677ec8 in malloc_printerr () from /lib64/libc.so.6
> > > #4  0x0000003c7667a23e in _int_free () from /lib64/libc.so.6
> > > #5  0x0000003c7667a486 in free () from /lib64/libc.so.6
> > > #6  0x0000000000493f3f in ref_remove_duplicates (ref_map=0x7562b0)
> > >     at remote.c:756
> > > #7  0x0000000000424afc in get_ref_map () at builtin-fetch.c:165
> > > #8  do_fetch () at builtin-fetch.c:644
> > > #9  cmd_fetch (argc=<value optimized out>, argv=0x7fffffffe6a0,
> > >     prefix=<value optimized out>) at builtin-fetch.c:754
> > > #10 0x0000000000403d83 in run_builtin () at git.c:251
> > > #11 handle_internal_command (argc=1, argv=0x7fffffffe6a0) at git.c:396
> > > #12 0x0000000000403f2d in run_argv () at git.c:438
> > > #13 main (argc=1, argv=0x7fffffffe6a0) at git.c:509
> > > 
> > > Bisection reveals the following culprit:
> > > 
> > > commit 73cf0822b2a4ffa7ad559d1f0772e39718fc7776
> > > Author: Julian Phillips <julian@quantumfyre.co.uk>
> > > Date:   Sun Oct 25 21:28:11 2009 +0000
> > > 
> > >     remote: Make ref_remove_duplicates faster for large numbers of refs
> > 
> > Can't reproduce because I don't know how to create duplicate refs, but does
> > the following help?

Nope.

> > remote.c |    2 ++
> > 1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/remote.c b/remote.c
> > index 4f9f0cc..10cc985 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
> > 			prev->next = ref_map->next;
> > 			free(ref_map->peer_ref);
> > 			free(ref_map);
> > +			ref_map = next;
> 
> You don't need this line (this is taken care of in the for(...)).
> 
> > +			continue;
> 
> Ack. This one however, you do need.  Good catch.

Without the "ref_map = next" there is no change: glibc still complains 
about corruption and abort the execution.  With the "ref_map = next" 
then git simply segfaults.

I simply have zero time to investigate the issue myself now 
unfortunately.


Nicolas
