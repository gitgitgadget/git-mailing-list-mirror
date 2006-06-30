From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] consider previous pack undeltified object state only when
 reusing delta data
Date: Fri, 30 Jun 2006 12:55:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606301132510.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain>
 <7vwtazobkw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606292335190.1213@localhost.localdomain>
 <Pine.LNX.4.63.0606301144450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44A518D6.8040901@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 18:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMHY-0007IB-NN
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 18:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWF3Qzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWF3Qzt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 12:55:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37045 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751174AbWF3Qzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 12:55:48 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1O003E8N0WQ1C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 30 Jun 2006 12:55:45 -0400 (EDT)
In-reply-to: <44A518D6.8040901@op5.se>
X-X-Sender: nico@localhost.localdomain
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22997>

On Fri, 30 Jun 2006, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 29 Jun 2006, Nicolas Pitre wrote:
> > 
> > 
> > > Without this there would never be a chance to improve packing for
> > > previously undeltified objects.
> > 
> > 
> > Earlier this year, I was quite surprised to learn that multiple repackings
> > actually improved packing. Does that patch mean this feature is gone?
> > 
> 
> The patch Linus sent removes that feature. This one re-introduces it.

Not really.

Actually that multiple repacking "feature" was rather an artifact of the 
delta data reuse code and not really by design.  Here's what happened 
before:

Consider the first repack where no delta exists, or "git-repack -a -f" 
where the -f argument makes it ignores existing delta data.  In that 
case all objects are sorted and delta attempted on them within a window.

So to simplify things let's assume objects are numbered from 1 upwards.  
First obj #1 is added to the window.  Obj #2 attempts a delta against 
obj #1.  Obj #3 attempts a delta against objs #2 and #1.  Obj #4 
attempts a delta against objs #3, #2 and #1.  And so on for all object: 
each new object attempts a delta against the last 10 objects (the 
default window size is 10) and the best delta, if any, is kept.

In the end, some objects get deltified, some don't, and a new pack is 
produced.

When repacking without -f to git-repack, then already deltified objects 
are simply copied as is from the existing pack(s) avoiding costly delta 
re-computation.  Still, without Linus' patch, non-deltified objects were 
considered for deltification and deltas attempted on them.

So supposing that objects #1 through #10 were not deltified, and objects 
#11 through #50 were deltified, then those deltified objects were 
skipped over for the purpose of delta matching and therefore object #51 
ended up attempting a delta against objs #1 to 10 instead of #41 to #50 
like in the previous run.  The net effect was similar to a larger window 
for some objects providing more opportunities for successful deltas, and 
therefore a smaller pack.

With Linus' patch those objects already known to be undeltified are, 
too, skipped.  That means that successive git-repack without the -f 
argument are now producing identical packs all the time and the artifact 
above is gone.

I think this is a good thing since now the packing behavior is more 
predictable.  But nothing is lost since if you want to have better 
packing like before you simply have to specify a slightly larger window 
size on the first git-repack.  It'll take a bit more time but running 
git-repack many times also took more time in the end anyway.


Nicolas
