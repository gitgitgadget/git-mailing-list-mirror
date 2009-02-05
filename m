From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Questions about binary right shifting
Date: Thu, 5 Feb 2009 07:21:08 -0800
Message-ID: <20090205152108.GE26880@spearce.org>
References: <498AF9B1.1060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV63q-0003oS-Ju
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 16:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbZBEPVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZBEPVK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 10:21:10 -0500
Received: from george.spearce.org ([209.20.77.23]:48876 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZBEPVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 10:21:09 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id A41F338210; Thu,  5 Feb 2009 15:21:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <498AF9B1.1060200@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108569>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> I can see in the code that the signed right shifting is used.
> Could it be a problem? Or do we manipulate only positive numbers?

Heh.  We shouldn't ever be dealing with a case where there are more
than 1 billion files in the index, and thus we should never see
the expression "low + high" wrap negative, and then try to divide
by 2 here.

Binary search on a 1 billion file index would hurt, badly.  I'm not
sure what project even has 1 billion source files to checkout
on disk.  Isn't that easily a 4 TB filesystem just for the ext2
inodes of the working tree files?  :-)

Oh, and we can't even have an index with 1 billion entries in it
anyway.  DirCache.readFrom allocates a byte[] of entryCnt * 62.
So our largest number of files permitted is 34,636,833, due to
the limit on byte[] maxing out at 2 GB.  Thus high below cannot
ever be larger than 34 million, and we can't wrap.

This is also true in the Tree class, where we have the entire tree
data stream in a byte[].  Each entry needs at least 23 bytes, but
more if you include some sort of unique file name.  That really puts
a limit on the number of unique names to the point that we cannot
have entries.length so large that the binary search would overflow.

Anyway, if you tie this up into a patch with a message I'll apply,
but I don't care enough to write the message myself given how
unlikely this is.  We'd have to overhaul other code anyway before
we start to run into problems with these search functions.


> diff --git a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
> index 8eb4022..d70eca0 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/dircache/DirCache.java
> @@ -577,7 +577,7 @@ int findEntry(final byte[] p, final int pLen) {
>  		int low = 0;
>  		int high = entryCnt;
>  		do {
> -			int mid = (low + high) >> 1;
> +			int mid = (low + high) >>> 1;
>  			final int cmp = cmp(p, pLen, sortedEntries[mid]);
>  			if (cmp < 0)
>  				high = mid;
> 
> And could we used right shifting to optimize a division per 2?
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
> index 0ecd04d..ff9e666 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Tree.java
> @@ -136,7 +136,7 @@ private static final int binarySearch(final TreeEntry[] entries,
>  		int high = entries.length;
>  		int low = 0;
>  		do {
> -			final int mid = (low + high) / 2;
> +			final int mid = (low + high) >>> 1;
>  			final int cmp = compareNames(entries[mid].getNameUTF8(), nameUTF8,
>  					nameStart, nameEnd, TreeEntry.lastChar(entries[mid]), nameUTF8last);
>  			if (cmp < 0)
> 
> Yann

-- 
Shawn.
