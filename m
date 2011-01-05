From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Wed, 5 Jan 2011 23:28:11 +0000 (UTC)
Message-ID: <loom.20110105T222915-261@post.gmane.org>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 06 00:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pacmc-00025N-MS
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab1AEX2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 18:28:36 -0500
Received: from lo.gmane.org ([80.91.229.12]:33453 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab1AEX2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 18:28:36 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PacmO-0001yx-1x
	for git@vger.kernel.org; Thu, 06 Jan 2011 00:28:32 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 00:28:32 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 00:28:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.7.62 Version/11.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164608>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> I've been analyzing bittorrent protocol and come up with this. The
> last idea about a similar thing [1], gittorrent, was given by Nicolas.
> This keeps close to that idea (i.e the transfer protocol must be around git
> objects, not file chunks) with a bit difference.
>
> The idea is to transfer a chain of objects (trees or blobs), including
> base object and delta chain. Objects are chained in according to
> worktree layout, e.g. all objects of path/to/any/blob will form a
> chain, from a commit tip down to the root commits. Chains can have
> gaps, and don't need to start from commit tip. The transfer is
> resumable because if a delta chain is corrupt at some point, we can
> just request another chain from where it stops. Base object is
> obviously resumable.

I may be talking nonsense, please bare with me.

I'm not sure if it works well, since chains defined this way change over time. 
I may request commits A and B while declaring to possess commits C and D. One 
server may be ahead of A, so should it send me more data or repack the chain so 
that the non-requested versions get excluded? At the same time the server may 
be missing B and posses only some ancestors of it. Should it send me only a 
part of the chain or should I better ask a different server?

Moreover, in case a directory gets renamed, the content may get transfered 
needlessly. This is probably no big problem.

I haven't read the whole other thread yet, but what about going the other way 
round? Use a single commit as a chain, create deltas assuming that all 
ancestors are already available. The packs may arrive out of order, so the 
decompression may have to wait. The number of commits may be one order of 
magnitude larger than the the number of paths (there are currently 2254 paths 
and 24235 commits in git.git), so grouping consequent commits into one larger 
pack may be useful.

The advantage is that the packs stays stable over time, you may create them 
using the most aggressive and time-consuming settings and store them forever. 
You could create packs for single commits, packs for non-overlapping 
consecutive pairs of them, for non-overlapping pairs of pairs, etc. I mean with 
commits numbered 0, 1, 2, ... create packs [0,1], [2,3], ..., [0,3], [4,7], 
etc. The reason for this is obviously to allow reading groups of commits from 
different servers so that they fit together (similar to Buddy memory 
allocation). Of course, there are things like branches bringing chaos in this 
simple scheme, but I'm sure this can be solved somehow.

Another problem is the client requesting commits A and B while declaring to 
possess commits C and D. When both C and D are ancestors of either A or B, you 
can ignore it (as you assume this while packing, anyway). The other case is 
less probable, unless e.g. C is the master and A is a developing branch. 
Currently. I've no idea how to optimize this and whether this could be 
important.

I see no disadvantage when compared to path-based chains, but am probably 
overlooking something obvious.
