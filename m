From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Method invokes inefficient Number constructor;
	use static valueOf instead
Date: Thu, 19 Mar 2009 08:49:58 -0700
Message-ID: <20090319154958.GP23521@spearce.org>
References: <49C20D13.2050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 16:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkKWo-0000d8-72
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZCSPuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbZCSPuA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:50:00 -0400
Received: from george.spearce.org ([209.20.77.23]:60513 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZCSPuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:50:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5BD6938221; Thu, 19 Mar 2009 15:49:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49C20D13.2050908@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113785>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> From FindBugs:
> Using new Integer(int) is guaranteed to always result in a new object
> whereas Integer.valueOf(int) allows caching of values to be done by the
> compiler, class library, or JVM. Using of cached values avoids object
> allocation and the code will be faster.

Ah, yes.

> Values between -128 and 127 are guaranteed to have corresponding cached
> instances [...]
...
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
> index e0e4855..04ef59d 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
> @@ -383,7 +383,7 @@ private void resolveDeltas(final ProgressMonitor progress)
>  	private void resolveDeltas(final PackedObjectInfo oe) throws IOException {
>  		final int oldCRC = oe.getCRC();
>  		if (baseById.containsKey(oe)
> -				|| baseByPos.containsKey(new Long(oe.getOffset())))
> +				|| baseByPos.containsKey(Long.valueOf(oe.getOffset())))

Why I box with new Long() over Long.valueOf():

 The standard only requires -128..127 to be cached.  A JRE can
 cache value outside of this range if it chooses, but long has a
 huge range, its unlikely to cache much beyond this required region.

 Most pack files are in the 10 MB...100+ MB range.  Most objects
 take more than 100 bytes in a pack, even compressed delta encoded.
 Thus any object after the first is going to have its offset outside
 of the cached range.

 In other words, why waste the CPU cycles on the "cached range
 bounds check" when I'm always going to fail and allocate.  I might
 as well just allocate

 These sections of code are rather performance critical for the
 indexing phase of a pack receive, on either side of a connection.
 I need to shave even more instructions out of the critical paths,
 as its not fast enough as-is.  Using new Long() is quicker than
 using Long.valueOf(), so new Long() it is.

> @@ -448,7 +448,7 @@ private void resolveDeltas(final long pos, final int oldCRC, int type,
>  	private void resolveChildDeltas(final long pos, int type, byte[] data,
>  			PackedObjectInfo oe) throws IOException {
>  		final ArrayList<UnresolvedDelta> a = baseById.remove(oe);
> -		final ArrayList<UnresolvedDelta> b = baseByPos.remove(new Long(pos));
> +		final ArrayList<UnresolvedDelta> b = baseByPos.remove(Long.valueOf(pos));
>  		int ai = 0, bi = 0;
>  		if (a != null && b != null) {
>  			while (ai < a.size() && bi < b.size()) {
> @@ -679,7 +679,7 @@ private void indexOneObject() throws IOException {
>  				ofs <<= 7;
>  				ofs += (c & 127);
>  			}
> -			final Long base = new Long(pos - ofs);
> +			final Long base = Long.valueOf(pos - ofs);
>  			ArrayList<UnresolvedDelta> r = baseByPos.get(base);

See above for why these two hunks allocate rather than use valueOf()
or even the implicit compiler produced auto-boxing (which uses
valueOf).

But your first hunk (which I snipped) is fine to apply.

-- 
Shawn.
