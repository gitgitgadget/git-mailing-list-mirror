From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 14:58:34 -0400
Message-ID: <200504221458.36300.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <200504212016.16729.mason@suse.com> <Pine.LNX.4.58.0504220916060.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 20:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP3I2-0002US-2e
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVDVS6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVDVS6q
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:58:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:37793 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262108AbVDVS6n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 14:58:43 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 63F52160AC87;
	Fri, 22 Apr 2005 20:58:42 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504220916060.2344@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 22 April 2005 12:22, Linus Torvalds wrote:
> On Thu, 21 Apr 2005, Chris Mason wrote:
> > We can sort by the files before reading them in, but even if we order
> > things perfectly, we're spreading the io out too much across the drive.
>
> No we don't.
>
> It's easy to just copy the repository in a way where this just isn't true:
> you sort the objects by how far they are from the current HEAD, and you
> just copy the repository in that order ("furthest" objects first - commits
> last).
>
> That's what I meant by defragmentation - you can actually do this on your
> own, even if your filesystem doesn't support it.

This certainly can help.  Based on some ideas from andrea I made a poor man's 
defrag script last year that was similar.  It worked by copying files into a 
flat dir in the order you expected to read them in, deleting the original, 
then hard linking them into their original name.

Copying in order straight into a new git tree doesn't help much when the 
filesystem is using the subdirectory as a hint to block allocation.  So 
you'll probably have to copy them all into a flat directory and then hard 
link back into the git tree (the flat dir can then be deleted of course).

The problem I see for git is that once you have enough data, it should degrade 
over and over again somewhat quickly.  My own guess is that you'll need to 
run the script at least monthly.  If we're designing the thing now and say 
'wow, that's going to be really slow without help', it doesn't hurt to look 
at alternatives.

I grabbed Ingo's tarball of 28,000 patches since 2.4.0 and applied them all 
into git on ext3 (htree).  It only took ~2.5 hrs to apply.  I did use my  
write-tree patch where you had to give write-tree a list of directories to 
search, but I don't think this helped much since the operation was mostly 
disk write bound.

Anyway, I ended up with a 2.6GB .git directory.  Then I:

rm .git/index
umount ; mount again
time read-tree `tree-id` (24.45s)
time checkout-cache --prefix=../checkout/ -a -f (4m30s)

--prefix is neat ;)

The tree that ended up in checkout was 239456k, giving us an effective io rate 
for checkout-cache of 885k/s.  (this drive gets 24MB/s sequential reads).

I'll have numbers for the packed files later on today.  No, I don't really 
expect the numbers will convince you to implement some kind of packing ;)  
But it's still a good data point to have, and generating them here is just 
poking the box every 2 hours or so.

-chris
