From: Nicolas Pitre <nico@cam.org>
Subject: Re: Better value for chunk_size when threaded
Date: Thu, 06 Dec 2007 22:25:01 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712062139170.555@xanadu.home>
References: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com>
 <alpine.LFD.0.99999.0712062014060.555@xanadu.home>
 <9e4733910712061737o50a9a5f1ldccdf943bb19319f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 04:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0TqA-0008G4-4f
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 04:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbXLGDZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbXLGDZE
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 22:25:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11691 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbXLGDZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 22:25:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSN00BK2THPRR30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 22:25:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712061737o50a9a5f1ldccdf943bb19319f@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67371>

On Thu, 6 Dec 2007, Jon Smirl wrote:

> On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Thu, 6 Dec 2007, Jon Smirl wrote:
> >
> > > I tried some various ideas out for chunk_size and the best strategy I
> > > found was to simply set it to a constant. How does 20,000 work on
> > > other CPUs?
> >
> > That depends on the object size.  If you have a repo with big objects
> > but only 1000 of them for example, then the constant doesn't work.
> 
> How about defaulting it to 20,000 and allowing an override? It's not
> fatal if we guess wrong, we just want to most common cases to work out
> of the box. 20,000 is definitely better than the current window *
> 1000.

Sure.

... But I think this can be made much better than that with no guessing 
at all.

Say you have 4 threads.  then let's divide the whole object list into 4 
big segments and feed those to each thread.

One thread will always finish before the others.  The idea is to find 
the active thread with the largest amount of remaining objects to 
process at that point, and steal half of them and give that to the 
thread that just finished.  Repeat for each thread that completes its 
segment until everything is done.


Nicolas
