From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 12:23:02 -0400
Message-ID: <200504211223.03479.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 18:23:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOeRU-0004cd-VQ
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDUQ0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVDUQ0P
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:26:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:35236 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261502AbVDUQXI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:23:08 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9759D92C5;
	Thu, 21 Apr 2005 18:23:06 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 2B5701482F7; Thu, 21 Apr 2005 18:23:06 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 21 April 2005 11:41, Linus Torvalds wrote:
> On Thu, 21 Apr 2005, Chris Mason wrote:
> > There have been a few threads on making git more space efficient, and
> > eventually someone mentions tiny files and space fragmentation.  Now that
> > git object names are decoupled from their compression, it's easier to
> > consider a a variety of compression algorithms.  I whipped up a really
> > silly "pack files together" compression.
>
> Careful.
>
> This is something that needs history to tell whether it's effective. In
> particular, if one file changes and another one does not, your packed
> archive now ends up being a new blob, so while you "saved space" by having
> just one blob for the object, in reality you didn't save any space at all
> because with the <x> files changing, you just guaranteed that the packed
> blob changes <x> times more often.

The packed blob lives in git but never makes it into a tree.  Lets say that I 
have a packed blob with files "a, b, c", and another packed blob with files 
"x, y, z".  Someone changes files, b and z and then runs update-cache b z.

Now we have 2 unchanged packed blobs: "a, b, c", "x, y, z",  and one new 
packed blob: "b_new, z_new".  This means that in order for the packing to 
help, we have to change more then one file at a time.  That's why it would be 
good to have update-cache include the write-tree and commit-tree.

>
> See? Your "packing in space" ends up also resulting in "packing in time",
> and you didn't actually win anything.
>
> (If you did a good job of packing, you hopefully didn't _lose_ anything
> either - you needed 1:<x> number of objects that took 1:<x> the space if
> the packing ended up perfect - but since you needed <x> times more of
> these objects unless they all change together, you end up with exactly the
> same space usage).
>
> So the argument is: you can't lose with the method, and you _can_ win.
> Right?
>
> Wrong. You most definitely _can_ lose: you end up having to optimize for
> one particular filesystem blocking size, and you'll lose on any other
> filesystem. And you'll lose on the special filesystem of "network
> traffic", which is byte-granular.
>
The patch does have one extra directory entry (for the packed blob), but from 
a network point of view roughly the same number of bytes should be copied.  
The hardlinks won't play nice with rsync though, soft links might be better.

packing isn't just about filesystem block sizes, it's about locality.  All the 
hashing means pretty much every access in git is random.  With packing we can 
at least try to put a single changeset together on disk.  Right now it 
doesn't matter much, but when the git tree is 6GB in two years we'll feel the 
pain.

> I don't want to pee on peoples parades, and I'm all for gathering numbers,
> but the thing is, the current git isn't actually all that bad, and I
> guarantee that it's hard to make it better without using delta
> representation. And the current thing is really really simple.
>

Grin, if I thought you wanted the patch I might have tried to pretty it up a 
little.  The point is that all the discussions about ways to make git use 
less space end up stuck in "but wait, that'll make a bunch of tiny files and 
filesystems aren't good at that".  So I believe some kind of packing is a 
required building block for any kind of delta storage.

-chris
