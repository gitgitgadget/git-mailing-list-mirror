From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 21 Jul 2011 08:43:51 -0400
Message-ID: <20110721124351.25143.qmail@science.horizon.com>
References: <alpine.DEB.2.02.1107202119440.5355@asgard.lang.hm>
Cc: anthonyvdgent@gmail.com, git@vger.kernel.org, hordp@cisco.com,
	linux@horizon.com, nico@fluxnic.net, torvalds@linux-foundation.org
To: david@lang.hm, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jul 21 14:44:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjsbe-0000Pg-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 14:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1GUMnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 08:43:53 -0400
Received: from science.horizon.com ([71.41.210.146]:28642 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752518Ab1GUMnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 08:43:53 -0400
Received: (qmail 25144 invoked by uid 1000); 21 Jul 2011 08:43:51 -0400
In-Reply-To: <alpine.DEB.2.02.1107202119440.5355@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On <david@lang.hm> wrote:
> On Wed, 20 Jul 2011, Shawn Pearce wrote:
>> If the algorithm is always "gen(A) = max(gen(P) for each parent_of(A))
>> + 1" then it doesn't matter who merged what commits, the same commit
>> appears at the same part of the graph relative to all of its
>> ancestors, and therefore always has the same generation number. This
>> is true whether or not the commit contains the generation number.

> I have to think about this more, but I'm wondering about cases where the 
> same result ia achieved via different methods, something along the lines 
> of one person developing something with _many_ commits (creating a large 
> generation number) that one person merges far sooner than another, causing 
> the commits that they do after the merge to have much larger generation 
> numbers than someone making the same changes, but doing the merge later

Can't happen.  Using the basic algorithm as Shawn described, the
generation number is defined uniquely by the ancestor DAG.

The generation number is the length of the longest path to a
root (zero-ancestor) commit through the DAG.

If you look at past discussion, several people have thought it was
okay to bake into the commit precsiely because it can be computed
once and will never change.

However, git does have some ability to amend the history DAG after
it's been written, using grafts and replace objects.  These can
change generation numbers, presisely because they change the DAG.

> something like
> 
>    C9
>     \
> C2 - C10 - C11 - C12
> 
> vs
>                  C9
>                    \
> C2 - C3 - C4 - C5 - C10
>
> where the C10-12 in the first set and C3-5 in the second set are
> completely unrelated to what's done in C9 and C12 in the first set
> and C10 in the second set are identical trees.

The generation numbers in the above are as follows:
First example:
	C2 = C9 = 0
	C10 = 1 = max(C2, C9) + 1
	C11 = 2 = C10 + 1
	C12 = 3 = C11 + 1

Second example:
	C2 = C9 = 0
	C3 = 1 = C2 + 1
	C4 = 2 = C2 + 1
	C5 = 3 = C4 + 1
	C10 = 4 = max(C5, C9) + 1

Now, the history pruning works fine if the "+1" is replaced my any other
non-zero increment, but it's not clear why you'd bother.
