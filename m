From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: Re: overly smart rebase - bug or feature?
Date: Tue, 11 Nov 2008 02:36:49 +0300
Message-ID: <20081110233649.GI6799@sun.com>
References: <20081110212333.GU6799@sun.com>
 <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Roman.Shaposhnick@Sun.COM, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgLX-0005iE-9i
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbYKJXhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYKJXhQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:37:16 -0500
Received: from gmp-eb-inf-1.sun.com ([192.18.6.21]:37949 "EHLO
	gmp-eb-inf-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYKJXhO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:37:14 -0500
Received: from fe-emea-09.sun.com (gmp-eb-lb-2-fe3.eu.sun.com [192.18.6.12])
	by gmp-eb-inf-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id mAANbCiB028320
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 23:37:12 GMT
Received: from conversion-daemon.fe-emea-09.sun.com by fe-emea-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0KA500F015GUCT00@fe-emea-09.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Mon,
 10 Nov 2008 23:37:12 +0000 (GMT)
Received: from localhost ([129.159.126.120])
 by fe-emea-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0KA5006C55LYSJ40@fe-emea-09.sun.com>; Mon,
 10 Nov 2008 23:37:11 +0000 (GMT)
In-reply-to: <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
Mail-followup-to: Junio C Hamano <gitster@pobox.com>,
 Roman.Shaposhnick@Sun.COM, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100593>

On Mon, Nov 10, 2008 at 03:14:42PM -0800, Junio C Hamano wrote:
> Fedor Sergeev <Fedor.Sergeev@Sun.COM> writes:
> 
> > I have recently hit a behavior which might well be a feature, 
> > but it was very surprising (in a bad sense) to me.
> 
> It is a feature misfiring.
> 
> Rebase is essentially a repeated cherry-pick, and a cherry-pick of commit

But cherry-pick does fail, as shown in my original mail!

> A on top of commit B is done by a simplified 3-way merge between A and B
> using the parent of A as the common ancestor.
> 
>      A                          A'
>     /                          /
>    A^... pseudo history ...---B

Well, my history is exactly that, not pseudo (and I dont quite follow your reasoning
yet to understand whether this is important or not):

   A   B
    \ /
     A^

A^ *is* a common ancestor of both A and B.

> 
> When your history has renamed Makefile to Makefile2 (thereby losing
> Makefile)

My history did not rename Makefile.
There were three identical Makefiles (in A^)
After that one was deleted (in B).
On alternative branch it was edited (in A).

If I do *merge* A into B then it fails.
If I do *cherry-pick* A into B then it fails.
If I do *rebase* A onto B then it succeeds.

> while transition from A^ to A modified Makefile, the difference
> between A^ to A that is applied to B to produce A' contains only the
> change about Makefile (and does not talk about the unchangedness of
> Makefile1 nor Makefile2 --- in fact, when A' is created, the machinery
> does not even know if A^ and A had Makefile1 or Makefile2).
> 
> When applying the change to Makefile, it notices that B does not have
> Makefile, but there is a path that is _identical_ to the preimage your
> change applies to (namely, Makefile2).  To support people who rename
> Makefile to Makefile2 in the history that led to B

There was no rename. There was a copy in initial commit (and you cant say if it
was Makefile copied into Makefile2 or vice verse).
I dont believe it should really be called "rename", even if one of the copies was killed later.

>, rebase (actually the
> underlying "am -3" it calls is where this rename detection smart lies)
> applies the changes to the "renamed" path.

In this given case both Makefile1 and Makefile2 were absolutely equal. 
If rebase chose to edit Makefile2 why didnt it change Makefile1?

> 
> You might be able to work this around by forcing rebase not to use the
> simplified 3-way merge, by saying "rebase -m".

Yeah, it worked.
...
CONFLICT (delete/modify): Makefile deleted in master and modified in HEAD~0. Version HEAD~0 of Makefile left in tree.
...

Though it does make me wonder why *simplified* 3-way merge is smarter than git merge ;)))

best regards,
  Fedor..
