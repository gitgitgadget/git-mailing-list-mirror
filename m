From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Sat, 28 Apr 2012 12:42:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1204281151290.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <20120417220838.GB10797@sigill.intra.peff.net>
 <7vr4vmm29z.fsf@alter.siamese.dyndns.org>
 <20120417221849.GA11936@sigill.intra.peff.net>
 <7vmx6am1h9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 18:42:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOAjB-0007sf-J2
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 18:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab2D1Qm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 12:42:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62905 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab2D1Qm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 12:42:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3700IIU7QQZI40@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 28 Apr 2012 12:42:27 -0400 (EDT)
In-reply-to: <7vmx6am1h9.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196496>

[ coming late to this thread -- thanks to peff who pulled my attention ]

On Tue, 17 Apr 2012, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Apr 17, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:
> >
> >> > How many cores are there on this box? Have you tried setting
> >> > pack.windowMemory to (12 / # of cores) or thereabouts?
> >> 
> >> Hrm, from the end-user's point of view, it appears that pack.windowMemory
> >> ought to mean the total without having to worry about the division of it
> >> across threads (which the implementation should be responsible for).
> >
> > Agreed. I had to look in the code to check which it meant. I'm not sure
> > we can change it without regressing existing users, though.
> 
> This is a tangent, but I noticed that the canned settings for "aggressive"
> use an arbitrarily hardcoded value of depth=250 and window=250 (tweakable
> with gc.aggressiveWindow).
> 
> Even though a shallower depth does cause base candidates with too long a
> chain hanging to be evicted prematurely while it is still in window and
> will lead to smaller memory consumption, I do not think the value of
> "depth" affects the pack-time memory consumption too much.  But the
> runtime performance of the resulting pack may not be great (in the worst
> case you would have to undelta 249 times to get to the object data).  We
> may want to loosen it a bit.

I think people are having misconceptions about the definition of the 
word "aggressive".

This option is, well, aggressive.  By definition this is not meant to be 
"nice".  This is not meant to be fast, or light on memory usage, etc.  
This means "achieve as much damage you can" to reduce the pack size.

If people are using it every night then they must be masochists, or 
attracted by violence, or getting a bit too casual with word 
definitions.

So if being --aggressive hurts, then don't do it.

If people want a loosened version, it would be more appropriate to 
introduce a --mild, or --bold, or --disruptive option.  In the same 
vain, an --insane option could even be introduced to go even further 
than --aggressive.

This being said, this is no excuse for regressions though.  If git is 
eating up much more memory than it used to, provided with the same 
repository and repacking parameters than before, then this certainly 
needs fixing.  But making --aggressive less so is not a fix.

> Also it might make sense to make the window size a bit more flexible
> depending on the nature of your history (you would get bigger benefit with
> larger window when your history has fine grained commits; if there are not
> many few-liner commits, larger window may not help you that much).

How do you detect the history nature of a repository?  That's the hard 
part.  Because it should be auto detected as most users won't make a good 
guess for the best parameter value to use.

Anyway, I think that the window size in terms of objects is a bad 
parameter.  Historically that is the first thing we implemented. But the 
window _memory_ usage is probably a better setting to use.  The delta 
search cost is directly proportional to the amount of data to process 
and that can be controlled with --window-memory, with the ability to 
scale up and down the number of objects in the window.  Keeping the 
number of objects constant makes memory usage totally random since this 
depends on the repository content, and the computing cost to process it 
is highly unpredictable. This is very counter-intuitive for users.

Right now the window is limited by default to 10 objects, and window 
memory usage is unlimited.  This could be reworked so object number, 
while still being limited to avoid pathological cases, could be much 
higher, and the window memory usage always limited by default.  That 
default memory usage could be scaled according to the available 
resources on the system.  But if the user wants to play with this, then 
using a memory usage parameter is much easier to understand with more 
directly observable system load influence.


Nicolas
