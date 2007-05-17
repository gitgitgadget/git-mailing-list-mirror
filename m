From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 10:41:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site>
 <20070517010335.GU3141@spearce.org>
 <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
 <Pine.LNX.4.64.0705171143350.6410@racer.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_bpIVa2094NTWivM6RPlWKw)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 17 16:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HohAq-0006wE-Eu
	for gcvg-git@gmane.org; Thu, 17 May 2007 16:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbXEQOll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbXEQOll
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 10:41:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43900 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXEQOlk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 10:41:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI6004SGWTDSK40@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 10:41:38 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0705171143350.6410@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47527>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_bpIVa2094NTWivM6RPlWKw)
Content-type: TEXT/PLAIN; charset=iso-8859-15
Content-transfer-encoding: 8BIT

On Thu, 17 May 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 16 May 2007, Nicolas Pitre wrote:
> 
> > Still... I wonder if this could be actually workable.  A typical daily 
> > update on the Linux kernel repository might consist of a couple hundreds 
> > or a few tousands objects.  This could still be faster to fetch parts of 
> > a pack than the whole pack if the size difference is above a certain 
> > treshold.  It is certainly not worse than fetching loose objects.
> > 
> > Things would be pretty horrid if you think of fetching a commit object, 
> > parsing it to find out what tree object to fetch, then parse that tree 
> > object to find out what other objects to fetch, and so on.
> > 
> > But if you only take the approach of fetching the pack index files, 
> > finding out about the objects that the remote has that are not available 
> > locally, and then fetching all those objects from within pack files 
> > without even looking at them (except for deltas), then it should be 
> > possible to issue a couple requests in parallel and possibly have decent 
> > performances.  And if it turns out that more than, say, 70% of a 
> > particular pack is to be fetched (you can determine that up front), then 
> > it might be decided to fetch the whole pack.
> > 
> > There is no way to sensibly keep those objects packed on the receiving 
> > end of course, but storing them as loose objects and repacking them 
> > afterwards should be just fine.
> > 
> > Of course you'll get objects from branches in the remote repository you 
> > might not be interested in, but that's a price to pay for such a hack.  
> > On average the overhead shouldn't be that big anyway if branches within 
> > a repository are somewhat related.
> > 
> > I think this is something worth experimenting.
> 
> I am a bit wary about that, because it is so complex. IMHO a cgi which 
> gets, say, up to a hundred refs (maybe something like ref~0, ref~1, ref~2, 
> ref~4, ref~8, ref~16, ... for the refs), and then makes a bundle for that 
> case on the fly, is easier to do.

And if you have 1) the permission and 2) the CPU power to execute such a 
cgi on the server and obviously 3) the knowledge to set it up properly, 
then why aren't you running the Git daemon in the first place?  After 
all, they both boil down to running git-pack-objects and sending out the 
result.  I don't think such a solution really buys much.

On the other hand, if the client does all the work and provides the 
server with a list of ranges within a pack it wants to be sent, then you 
simply have zero special setup to perform on the hosting server and you 
keep the server load down due to not running pack-objects there.  That, 
at least, is different enough from the Git daemon to be worth 
considering.  Not only does it provide an advantage to those who cannot 
do anything but http out of their segregated network, but it also 
provide many advantages on the server side too while the cgi approach 
doesn't.

And actually finding out the list of objects the remote has that you 
don't have is not that complex.  It could go as follows:

1) Fetch every .idx files the remote has.

2) From those .idx files, keep only a list of objects that are unknown 
   locally.  A good starting point for doing this really efficiently is 
   the code for git-pack-redundant.

3) From the .idx files we got in (1), create a reverse index to get each 
   object's size in the remote pack.  The code to do this already exists 
   in builtin-pack-objects.c.

4) With the list of missing objects from (2) along with their offset and 
   size within a given pack file, fetch those objects from the remote 
   server.  Either perform multiple requests in parallel, or as someone 
   mentioned already, provide the server with a list of ranges you want 
   to be sent.

5) Store the received objects as loose objects locally.  If a given 
   object is a delta, verify if its base is available locally, or if it 
   is listed amongst those objects to be fetched from the server.  If 
   not, add it to the list.  In most cases, delta base objects will be 
   objects already listed to be fetched anyway.  To greatly simplify 
   things, the loose delta object type from 2 years ago could be revived 
   (commit 91d7b8afc2) since a repack will get rid of them.

6 Repeat (4) and (5) until everything has been fetched.

7) Run git-pack-objects with the list of fetched objects.

Et voilà.  Oh, and of course update your local refs from the remote's.

Actually there is nothing really complex in the above operations. And 
with this the server side remains really simple with no special setup 
nor extra load beyond the simple serving of file content.


Nicolas

--Boundary_(ID_bpIVa2094NTWivM6RPlWKw)--
