From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-reset and clones
Date: Fri, 17 Mar 2006 12:39:19 -0800
Message-ID: <7vslpgztzc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
	<7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
	<1142623141.17536.225.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paul@hibernia.jakma.org, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 17 21:39:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKLjI-0004p6-V9
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 21:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWCQUjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 15:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWCQUjW
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 15:39:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54249 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932175AbWCQUjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 15:39:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317203524.BVGZ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Mar 2006 15:35:24 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1142623141.17536.225.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Fri, 17 Mar 2006 13:19:02 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17669>

Jon Loeliger <jdl@freescale.com> writes:

>> ...  On your current
>> branch, this creates a merge commit between A and B (your
>> current HEAD), taking the tree object from B.
>> 
>>                  o---o---o---A
>>                 /             \
>>     ---o---o---o---o---o---B---M
>
> Can you explain a bit more why the "ours" strategy
> comes into play here?  I _think_ I understand, but
> I'd like to hear a bit more explanation, please.
> How is this different from just merging in A directly?

>> You want to keep the contents of the cleaned-up HEAD, so that is
>> why you are taking the tree from B.
>
> And the "ours" strategy effectively says, "Favor the B
> side of things when pulling in the A parts", right?

Yes, it is stronger than that.  "ours" says: "the tree from our
head commit B *is* the resulting tree -- whatever we are merging
into us does not matter".

>>   With this commit M, you are
>> telling the outside world that it is OK if they start from a
>> commit on the now-recovered side branch.
>
> This is mystical to me.  How is the "A" (ie, side branch)
> now in a "recovered" state?

Although their effects are superseded (B^{tree} == M^{tree}),
they are still in the ancestry chain.

To a downstream person who were lucky enough not to have made
commits on A yet, next pull from you would have involved merging
B and A.

If the upstream did not do the magic "ours" merge, the git-fetch
step would refuse to update the remote tracking branch head, so
the downstream person needs to force the fetch.  After forcing
the fetch, the merge would have involved resolving the conflicts
coming from 3-way merge in this:

                  o---o---o---A---N
                 /               /  
     ---o---o---o---o---o---B---'

Because the forked track leading to B was either to fix mistakes
or clean things up the upstream originally did in the track
leading to A, the commits on the tracks leading to A and B from
their fork point are almost guaranteed to have conflicting
changes, and resolution of that conflict is forced on the
downstream person.  Worse yet, from this point on, since the
upstream discarded the track that contains A, the branch
downstream person has will _never_ converge to upstream branch,
even though the downstream person did _no_ development of his
own in the meantime.  This is *B*A*D*.

If there is a magic "ours" merge, the downstream person's
repository records A as the last tip on the tracking branch, and
git-fetch sees the updated head M is a descendant of it, so it
simply fast-forwards:

                  o---o---o---A
                 /             \
     ---o---o---o---o---o---B---M


Now, if the downstream was unlucky and have commits based on A,
the story is a bit different, but the principles are the same.

Without the "ours" merge M, you will get this:

                  o---o---o---A---X---N
                 /                   /  
     ---o---o---o---o---o---B-------'

When creating the merge N, even if the change between A and X
(i.e. the downstream's own work) does not touch the paths that
differ between A and B, the downstream is forced to resolve
conflicts between A and B. This is unnecessary burden for him.
The upstream should have cleaned up his own mess.

With the "ours" merge M, you will get this:


                  o---o---o---A---X---N
                 /             \     /
     ---o---o---o---o---o---B---M---'

The downstream does not need to worry about the conflicts
between A and B.  It has been already resolved at M.
Especially, if the change between A and X does not touch the
paths that differ in A and B, conflict resolution would be
purely about his own work.

In either case, since the downstream has his own development,
the heads of their branches never converge until the upstream
buys his changes (i.e. pull from the downstream that has "N"
commit), but that is not a problem but a feature and does not
have anything to do with this "oops, rewound by mistake" issue.
