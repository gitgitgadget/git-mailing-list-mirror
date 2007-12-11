From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 13:57:22 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111349270.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
 <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>
 <9e4733910712111043h6a361996x740f4dba3d742da5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_L/QTZKROBiW6TBaoSOrJhg)"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AIg-0000r9-9g
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXLKS53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbXLKS53
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:57:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21182 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLKS52 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:57:28 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW003L7FBOLYV0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 13:57:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712111043h6a361996x740f4dba3d742da5@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67903>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_L/QTZKROBiW6TBaoSOrJhg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 11 Dec 2007, Jon Smirl wrote:

> This makes sense. Those runs that blew up to 4.5GB were a combination
> of this effect and fragmentation in the gcc allocator.

I disagree.  This is insane.

> Google allocator appears to be much better at controlling fragmentation.

Indeed.  And if fragmentation is indeed wasting half of Git's memory 
usage then we'll have to come with a custom memory allocator.

> Is there a reasonable scheme to force the chains to only be loaded
> once and then shared between worker threads? The memory blow up
> appears to be directly correlated with chain length.

No.  That would be the equivalent of holding each revision of all files 
uncompressed all at once in memory.

> > That said, I suspect there are a few things fighting you:
> >
> >  - threading is hard. I haven't looked a lot at the changes Nico did to do
> >    a threaded object packer, but what I've seen does not convince me it is
> >    correct. The "trg_entry" accesses are *mostly* protected with
> >    "cache_lock", but nothing else really seems to be, so quite frankly, I
> >    wouldn't trust the threaded version very much. It's off by default, and
> >    for a good reason, I think.
> >
> >    For example: the packing code does this:
> >
> >         if (!src->data) {
> >                 read_lock();
> >                 src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
> >                 read_unlock();
> >                 ...
> >
> >    and that's racy. If two threads come in at roughly the same time and
> >    see a NULL src->data, theÿ́'ll both get the lock, and they'll both
> >    (serially) try to fill it in. It will all *work*, but one of them will
> >    have done unnecessary work, and one of them will have their result
> >    thrown away and leaked.
> 
> That may account for the threaded version needing an extra 20 minutes
> CPU time.  An extra 12% of CPU seems like too much overhead for
> threading. Just letting a couple of those long chain compressions be
> done twice

No it may not.  This theory is wrong as explained before.

> >
> >    Are you hitting issues like this? I dunno. The object sorting means
> >    that different threads normally shouldn't look at the same objects (not
> >    even the sources), so probably not, but basically, I wouldn't trust the
> >    threading 100%. It needs work, and it needs to stay off by default.
> >
> >  - you're working on a problem that isn't really even worth optimizing
> >    that much. The *normal* case is to re-use old deltas, which makes all
> >    of the issues you are fighting basically go away (because you only have
> >    a few _incremental_ objects that need deltaing).
> 
> I agree, this problem only occurs when people import giant
> repositories. But every time someone hits these problems they declare
> git to be screwed up and proceed to thrash it in their blogs.

It's not only for repack.  Someone just reported git-blame being 
unusable too due to insane memory usage, which I suspect is due to the 
same issue.


Nicolas

--Boundary_(ID_L/QTZKROBiW6TBaoSOrJhg)--
