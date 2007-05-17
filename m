From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 16:31:50 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705171618410.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site>
 <20070517010335.GU3141@spearce.org>
 <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
 <Pine.LNX.4.64.0705171143350.6410@racer.site>
 <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
 <20070517200431.GA3079@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu May 17 22:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Homdn-0003d7-Ds
	for gcvg-git@gmane.org; Thu, 17 May 2007 22:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbXEQUby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 16:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbXEQUby
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 16:31:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47048 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbXEQUbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 16:31:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI700A8TD12TI00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 16:31:51 -0400 (EDT)
In-reply-to: <20070517200431.GA3079@efreet.light.src>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47554>

On Thu, 17 May 2007, Jan Hudec wrote:

> On Thu, May 17, 2007 at 10:41:37 -0400, Nicolas Pitre wrote:
> > On Thu, 17 May 2007, Johannes Schindelin wrote:
> > > On Wed, 16 May 2007, Nicolas Pitre wrote:
> > And if you have 1) the permission and 2) the CPU power to execute such a 
> > cgi on the server and obviously 3) the knowledge to set it up properly, 
> > then why aren't you running the Git daemon in the first place?  After 
> > all, they both boil down to running git-pack-objects and sending out the 
> > result.  I don't think such a solution really buys much.
> 
> Yes, it does. I had 2 accounts where I could run CGI, but not separate
> server, at university while I studied and now I can get the same on friend's
> server. Neither of them would probably be ok for serving larger busy git
> repository, but something smaller accessed by several people is OK. I think
> this is quite common for university students.
> 
> Of course your suggestion which moves the logic to client-side is a good one,
> but even the cgi with logic on server side would help in some situations.

You could simply wrap git-bundle within a cgi.  That is certainly easy 
enough.

> > On the other hand, if the client does all the work and provides the 
> > server with a list of ranges within a pack it wants to be sent, then you 
> > simply have zero special setup to perform on the hosting server and you 
> > keep the server load down due to not running pack-objects there.  That, 
> > at least, is different enough from the Git daemon to be worth 
> > considering.  Not only does it provide an advantage to those who cannot 
> > do anything but http out of their segregated network, but it also 
> > provide many advantages on the server side too while the cgi approach 
> > doesn't.
> > 
> > And actually finding out the list of objects the remote has that you 
> > don't have is not that complex.  It could go as follows:
> > 
> > 1) Fetch every .idx files the remote has.
> 
> ... for git it's 1.2 MiB. And that definitely isn't a huge source tree.
> Of course the local side could remember which indices it already saw during
> previous fetch from that location and not re-fetch them.

Right.  The name of the pack/index plus its time stamp can be cached.  
If the remote doesn't repack too often then the overhead would be 
minimal.

> > 2) From those .idx files, keep only a list of objects that are unknown 
> >    locally.  A good starting point for doing this really efficiently is 
> >    the code for git-pack-redundant.
> > 
> > 3) From the .idx files we got in (1), create a reverse index to get each 
> >    object's size in the remote pack.  The code to do this already exists 
> >    in builtin-pack-objects.c.
> > 
> > 4) With the list of missing objects from (2) along with their offset and 
> >    size within a given pack file, fetch those objects from the remote 
> >    server.  Either perform multiple requests in parallel, or as someone 
> >    mentioned already, provide the server with a list of ranges you want 
> >    to be sent.
> 
> Does the git server really have to do so much beyond that?

Yes it does.  The real thing perform a full object reachability walk and 
only the objects that are needed for the wanted branch(es) are sent in a 
custom pack meaning that the data transfer is really optimal.

> > 5) Store the received objects as loose objects locally.  If a given 
> >    object is a delta, verify if its base is available locally, or if it 
> >    is listed amongst those objects to be fetched from the server.  If 
> >    not, add it to the list.  In most cases, delta base objects will be 
> >    objects already listed to be fetched anyway.  To greatly simplify 
> >    things, the loose delta object type from 2 years ago could be revived 
> >    (commit 91d7b8afc2) since a repack will get rid of them.
> > 
> > 6 Repeat (4) and (5) until everything has been fetched.
> 
> Unless I am really seriously missing something, there is no point in
> repeating. For each pack you need to unpack a delta either:
>  - you have it => ok.
>  - you don't have it, but the server does =>
>     but than it's already in the fetch set calculated in 2.
>  - you don't have it and nor does server =>
>     the repository at server is corrupted and you can't fix it.

You're right of course.


Nicolas
