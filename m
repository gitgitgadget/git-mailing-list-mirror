From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Tue, 01 May 2012 13:17:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205011259200.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:17:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGhM-0006Gv-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640Ab2EARRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:17:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28103 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab2EARRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:17:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3C0063QTCFNZ81@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2012 13:17:03 -0400 (EDT)
In-reply-to: <20120501162806.GA15614@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196704>

On Tue, 1 May 2012, Jeff King wrote:

> On Sun, Apr 29, 2012 at 09:53:31AM -0400, Nicolas Pitre wrote:
> 
> > But my remark was related to the fact that you need to double the 
> > affected resources to gain marginal improvements at some point.  This is 
> > true about computing hardware too: eventually you need way more gates 
> > and spend much more $$$ to gain some performance, and the added 
> > performance is never linear with the spending.
> 
> Right, I agree with that. The trick is just finding the right spot on
> that curve for each repo to maximize the reward/effort ratio.

Absolutely, at least for the default settings.  However this is not what 
--aggressive is meant to be.

> > >   1. Should we bump our default window size? The numbers above show that
> > >      typical repos would benefit from jumping to 20 or even 40.
> > 
> > I think this might be a good indication that the number of objects is a 
> > bad metric to size the window, as I mentioned previously.
> > 
> > Given that you have the test repos already, could you re-run it with 
> > --window=1000 and play with --window-memory instead?  I would be curious 
> > to see if this provides more predictable results.
> 
> It doesn't help. The git.git repo does well with about a 1m window
> limit. linux-2.6 is somewhere between 1m and 2m. But the phpmyadmin repo
> wants more like 16m. So it runs into the same issue as using object
> counts.
> 
> But it's much, much worse than that. Here are the actual numbers (same
> format as before; left-hand column is either window size (if no unit) or
> window-memory limit (if k/m unit), followed by resulting pack size, its
> percentage of baseline --window=10 pack, the user CPU time and finally
> its percentage of the baseline):
> [...]

Ouch!  Well... so much for good theory.  I'm still really surprised and 
disappointed as I didn't expect such damage at all.

However, this is possibly a good baseline to determine a default value 
for window-memory though.  Given your number, we clearly see that good 
packing can be achieved with relatively little memory and therefore it 
might be a good idea not to leave this parameter unbounded by default in 
order to catch potential pathological cases.  Maybe 64M would be a good 
default value?  Having a repack process eating up more than 16GB of RAM 
because its RAM usage is unbounded is certainly not nice.

> > Maybe we could look at the size reduction within the delta search loop.  
> > If the reduction quickly diminishes as tested objects are further away 
> > from the target one then the window doesn't have to be very large, 
> > whereas if the reduction remains more or less constant then it might be 
> > worth searching further.  That could be used to dynamically size the 
> > window at run time.
> 
> I really like the idea of dynamically sizing the window based on what we
> find. If it works. I don't think there's any reason you couldn't have 50
> absolutely terrible delta candidates followed by one really amazing
> delta candidate. But maybe in practice the window tends to get
> progressively worse due to the heuristics, and outliers are unlikely. I
> guess we'd have to experiment.

Yes.  The idea is to continue searching if results are not progressively 
becoming worse fast enough.  Coming up with a good way to infer that is 
far from obvious though.


Nicolas
