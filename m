From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Mon, 10 Dec 2007 12:06:39 -0500
Message-ID: <9e4733910712100906g6794e326qf18da4be146f3667@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
	 <9e4733910712092030j5cf7dfdcrb3a003fbce391422@mail.gmail.com>
	 <9e4733910712092123r6987c3edua74a15890ae45a3d@mail.gmail.com>
	 <9e4733910712092159s24cf5a7cx4610f797f61b1de5@mail.gmail.com>
	 <9e4733910712092206o40e0c748s3796b95f637bf2b3@mail.gmail.com>
	 <alpine.LFD.0.99999.0712101104320.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 18:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1m62-0001Il-7R
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 18:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXLJRGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 12:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbXLJRGo
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 12:06:44 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:54397 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbXLJRGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 12:06:44 -0500
Received: by nz-out-0506.google.com with SMTP id s18so899837nze
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=n/7pg/U/M05YLYI/t9CjcUmhO4EVLZBSOhUSJojMCgo=;
        b=ECJBEyhosae16AwEkx4KAPGz2FSlEsvsHlCaO0ZCjSvg7afq+JHqk/lLYQIzham/uIOhEp02SkeI2hvuZ7m8BrWw2+381FTlA0jJbiHnT7tNzoYW7t+yfdjxod6a0sS8cVoPy4r73CTn2Z5+baYu2Vk5q7pA5rnCrGJzqCuFtOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+2RSPGBAAP9tQODSg/vhWn114lPCDxwI4CrliYaZrdaDLwnwVlRibEPxznD2oOwkpfd2mUewUoMPyx6sYMU+OV6fgdYIF4LVXpq6q9l417Al3J+gy5Z0XwYkh9yE0XY180yFSW6ujlyHwDlAHvtQ5KopnzCfPvKCNiD+5KJn7k=
Received: by 10.115.54.1 with SMTP id g1mr547365wak.1197306399471;
        Mon, 10 Dec 2007 09:06:39 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 09:06:39 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712101104320.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67738>

On 12/10/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 10 Dec 2007, Jon Smirl wrote:
>
> > On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > I just deleted the section looking for identical hashes.
> > >
> > > +                       while (sub_size && list[0]->hash &&
> > > +                              list[0]->hash == list[-1]->hash) {
> > > +                               list++;
> > > +                               sub_size--;
> > > +                       }
> > >
> > > Doing that allows the long chains to be split over the cores.
> > >
> > > My last 5% of objects is taking over 50% of the total CPU time in the
> > > repack. I think these objects are the ones from that 103,817 entry
> > > chain. It is also causing the explosion in RAM consumption.
> > >
> > > At the end I can only do 20 objects per clock second on four cores. It
> > > takes 30 clock minutes (120 CPU minutes) to do the last 3% of objects.
> >
> > It's all in create_delta...
>
> Here you're mixing two different hashes with no relation what so ever
> with each other.
>
> The hash in create_delta corresponds to chunk of data in a reference
> buffer that we try to match in a source buffer.
>
> The hash in the code above has to do with the file names the
> corresponding objects are coming from.

So can we change this loop to exit after a max of window_size * 10 or
something like that iterations? Without capping it the threads become
way unbalanced in the end. In the gcc case one thread is continuing
30+ minutes past the others exiting.

> And again, both hash uses are deterministic i.e. they will be the same
> when repacking with -f regardless if the source pack is the 2.1GB or the
> 300MB one, so they may not explain the huge performance and memory usage
> discrepency you see between those two packs.

There is a correlation here but I don't know what it is. The memory
blow up occurs near the end of repacking. At the same time I move from
processing hundreds of objects per second to just a few per second.
And the threads are getting unbalanced.

I did notice that when I removed the above loop and evened things out
memory consumption did not spike as bad as it previously did. I maxed
out at 3GB instead of 4.5GB.

Linus suggested memory fragmentation could be a culprit. Evening the
threads out changed the allocation pattern. It is possible that it
avoided a fragmentation problem. It is also possible that evening
things out split the work so that less memory needed to be allocated.

Don't hold any of these numbers to be gospel. I am using the machine
for other things while I run these tests and there may be
interactions.

>
> The code that do get influenced by the source pack, though, is all
> concentrated in sha1_file.c.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
