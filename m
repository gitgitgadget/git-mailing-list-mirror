From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Fri, 05 Feb 2010 15:51:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002051539080.1681@xanadu.home>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:51:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdV9N-00066i-2v
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab0BEUvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:51:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19925 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab0BEUvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:51:09 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXD00K32Z97DS01@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Feb 2010 15:51:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139085>

On Fri, 5 Feb 2010, Jon Nelson wrote:

> [Using git 1.6.4.2]
> 
> In one repo I have (136G objects directory, fully packed) I'm having
> some trouble.
> I've run git-gc --prune=now, git repack -Adf, and so on a half-dozen
> times and each time I do so it gets bigger, not smaller.

Please tell us more.

> Setting that aside for the moment, however, I've run into a stranger problem.
> 
> So I use "git verify-pack -v > gvp.out" and "sort -k3nr < gvp.out |
> head -n 20" to find the top 20 largest blobs.
> So I have a blob, b32c3d8e8e24d8d3035cf52f606c2873315fe2b8, and now I
> want to know what tree (or trees) it is in, so I try this:
> 
> 
> for i in $( git branch -a | sed -e 's/\*//g' | grep -v branch ); do if
> git ls-tree -l -r -t $i | grep
> b32c3d8e8e24d8d3035cf52f606c2873315fe2b8 > /dev/null; then echo $i;
> fi; done
> 
> The results: no branch or tree appears to contain that blob.

What you did above is simply to list trees that are reachable from the 
_heads_ of your branches.  If the blob belongs to a commit which isn't 
the latest revision of any of your branches then you won't see it like 
that.

> So I tried a different approach:
> 
> for i in $( grep tree gvp.out  | awk '{ print $1 }' ); do if git
> ls-tree $i | grep b32c3d8e8e24d8d3035cf52f606c2873315fe2b8 >
> /dev/null; then echo $i; fi ; done
> 
> This time, I find (at least) one tree
> (d813af1537358496ca34958bbff08b87590607bf) with the blob.
> But which branches might that tree appear in? None.
> 
> For each branch, I ran "git ls-tree -l -r -t" and saved the output in
> a file (one per branch).
> Then I grepped each file for the tree (
> (d813af1537358496ca34958bbff08b87590607bf) - no luck.
> I grepped each file for the blob (b32...) - no luck.
> 
> The results seem to suggest that I have packed trees which reference
> blobs, but that the trees themselves are not referenced in any branch
> and therefore I would expect that they would be pruned.

NO.  If those trees and blobs are stil there then they do get 
referenced.  But not from the latest commit on any of your branches.  
You need to dig further down in history to find a commit that actually 
references that blob/tree.  One easy method is to do:

	git log --raw --all

and within the pager ('less' by default) simply search for "b32c3d8".


Nicolas
