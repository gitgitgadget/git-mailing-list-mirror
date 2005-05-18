From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 18 May 2005 19:15:56 +0200
Message-ID: <d6ft6v$8eg$1@sea.gmane.org>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <d6dohe$dql$1@sea.gmane.org> <Pine.LNX.4.58.0505180754060.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed May 18 19:20:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYSBp-0006nF-Lk
	for gcvg-git@gmane.org; Wed, 18 May 2005 19:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVERRTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVERRTI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 13:19:08 -0400
Received: from main.gmane.org ([80.91.229.2]:55689 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262169AbVERRS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 13:18:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DYS9o-0006T3-UC
	for git@vger.kernel.org; Wed, 18 May 2005 19:16:32 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 May 2005 19:16:32 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 May 2005 19:16:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0505180754060.18337@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Has anybody tried:
> 
>  4) don't limit yourself to previous-history-objects
> 
> One of the things I liked best about the delta patches was that it is
> history-neutral, and can happily delta an object against any other random
> object, in the same tree, in a future tree, or in a past tree.
> 
> Even without any history at all, there should be a noticeable amount of 
> delta opportunities, as different architectures often end up sharing files 
> that are quite similar, but not exactly the same.
> 
> Now, that's a very expensive thing to do, since it changes the question of
> "which object should I delta against" from O(1) to O(n) (where "n" is tyhe
> total number of objects), and thus the whole deltafication from O(n) to
> O(n**2), but especially together with your "max 10%" rule, you should be
> able to limit your choices very effectively: if you know that your delta
> should be within 10% of the total size, you can limit your "let's try that
> object" search to other objects that are also within 10% of your object.

Yeah, that sounds very interresting *and* very expensive...

Ideally, I'd like to find the set of objects that should *not* be 
deltafied (i.e. the ideal "keyframe" objects), but that would generate 
the maximum number of small, depth-one deltas with the least total size. 
But I can't really see how that could be done in a number of 
deltafications significantly less than the number of atoms in the 
universe. Let me think about that some more, though.

I'd like to try a couple of other approaches anyway:

a) Sort all objects by size. Start by biggest (or smallest), and try to 
get as many max-10%-deltas out of that as possible, stopping the search 
when objects get too small (big) according to some size difference 
limit. Cross already deltafied objects off the list, and continue. Might 
work, and might be fast enough with a sufficiently small size limit.

b) Use the same history-based approach as before, and in addition try to 
deltafy any "new" objects against other new objects and previous ones 
(say one or two commits back) in a given size range. That should catch 
renames, copys of the same template, etc. That shouldn't really affect 
performance, as new files are added comparatively seldom.

> Doing this experiment at least once should be interesting. It may turn out
> that the incremental space savings aren't all that noticeable, and that
> the pure history-based one already finds 90% of all savings, making the
> expensive version not worth it. It would be nice to _know_, though.

I definitely agree. And I also agree that the history-based 
deltafication seems less than pure, from a "git, the object store that 
doesn't really care" point of view.

On the other hand, the history-based thing has its advantages. It takes 
advantage of people's hard work to make patches as small as possible. 
It's fast. And (perhaps more importantly), it's deterministic. The 
"ideal" approach could possibly require every single blob to be 
redeltafied when a new object is added, if we want to stay ideal.

And it could be done at commit-time, thus keeping git's nice promise of 
immutable files, while still keeping size requirements down. And as my 
current method gives roughly an 80% size reduction over "plain git", 
that might (by boring, excessively practical people) be considered 
enough :-)

/dan

