From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to unpack recent objects?
Date: Thu, 16 Dec 2010 18:12:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012161743530.10437@xanadu.home>
References: <4D0A77A7.9080702@cfl.rr.com>
 <alpine.LFD.2.00.1012161616170.10437@xanadu.home> <4D0A8D83.9080705@cfl.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 00:13:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTN0M-0005Zn-Ca
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 00:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab0LPXMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 18:12:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23305 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0LPXMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 18:12:53 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LDJ0059PN5G3N60@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 16 Dec 2010 18:12:52 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4D0A8D83.9080705@cfl.rr.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163839>

On Thu, 16 Dec 2010, Phillip Susi wrote:

> On 12/16/2010 4:19 PM, Nicolas Pitre wrote:
> > What makes you think that unpacking them will actually make the access 
> > to them faster?  Instead, you should consider _repacking_ them, 
> > ultimately using the --aggressive parameter with the gc command, if you 
> > want faster accesses.
> 
> Because decompressing and undeltifying the objects in the pack file
> takes a fair amount of cpu time.  It seems a waste to do this for the
> same set of objects repeatedly rather than just keeping them loose.

Well, here are a couple implementation details you might not know about:

1) Loose objects are compressed too.  So you gain nothing on that front 
   by keeping objects loose.

2) Delta ordering is so that recent objects, i.e. those belonging to 
   most recent commits, are not delta compressed but rather used as base 
   objects for "older" objects to delta against.  So in practice, the 
   cost of undeltifying objects is pushed towards objects that you're 
   most unlikely to access frequently.

3) Object placement within the pack is also optimized so that 
   objects belonging to recent commits are close together, and walking 
   them creates a linear IO access pattern which is much faster than 
   accessing random individual files as loose objects are.

4) Packed objects take considerably less space than loose ones which 
   makes for much better usage of the file system cache in the operating 
   system.  This largely outweights the cost of undeltifying objects.

5) Git also keeps a cache of most frequently referenced objects when 
   replaying delta chains so deep deltas don't bring exponential costs.

And, in some cases, Git does even pick up the content of an object by 
using its checked out form in the working directory directly instead of 
locating and decompressing the object data.

So you shouldn't have to worry on that front.  Git is not the fastest 
SCM out there just by luck.


Nicolas
