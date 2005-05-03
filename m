From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 12:35:31 -0400
Message-ID: <200505031235.31984.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505030724.57827.mason@suse.com> <Pine.LNX.4.61.0505031153550.32767@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:31:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT0HK-0002cB-FZ
	for gcvg-git@gmane.org; Tue, 03 May 2005 18:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVECQf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 12:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVECQf5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 12:35:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38102 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261307AbVECQfg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 12:35:36 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2CADB9ED9;
	Tue,  3 May 2005 18:35:35 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 72005150906; Tue,  3 May 2005 18:35:34 +0200 (CEST)
To: "C. Scott Ananian" <cscott@cscott.net>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.61.0505031153550.32767@cag.csail.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 03 May 2005 11:57, C. Scott Ananian wrote:
> On Tue, 3 May 2005, Chris Mason wrote:
> > your delta generator later this week.  Some quick and dirty space numbers
> > to show why we need to pack the files together:
>
> Are you accurately accounting for the cost of the extra hard/soft links
> your scheme requires?  Ie the directories get larger, lookups take
> slightly longer, etc.  Also access to a given file takes longer, and the
> deltas are referring to *other* packed files which *also* take longer to
> decompress and access...

My patch doesn't create any extra directory entries because the file for the 
packed file is unlinked after all the hard links are made.  Even if I kept 
the packed file directory entry, I'd adding one directory entry and saving an 
average 6-7 inodes per commit.

>
> How much better does delta-fication do, compared to just packing?

The best case for just packing is to pack the blobs, trees and commits all 
into one object.  Doing all three brought the tree down from 2.5GB to 1.57GB.  

The delta patch does pack trees together, but not into the same file as the 
blobs, and commits are not packed at all.  This is just because it is a pain 
to carry those changes around; it'll be easy to do later.

With the delta patch, the tree is around 900MB, I estimate packing the commits 
and trees into the blob files would save another 200MB.

Because space savings is so tightly coupled with packing ratios, a script to 
repack blobs, trees and commits from multiple commits will give much better 
compression.  Right now  the patch does not delta trees or commits, but it 
might make sense to delta the trees via the repacking script.

-chris
