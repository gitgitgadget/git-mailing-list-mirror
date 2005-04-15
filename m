From: "Barry Silverman" <barry@disus.com>
Subject: RE: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 19:00:17 -0400
Message-ID: <000701c5420e$e89177b0$6400a8c0@gandalf>
References: <Pine.LNX.4.58.0504151313450.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:57:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMZkM-0004R4-EV
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 00:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVDOXAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDOXAk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:00:40 -0400
Received: from borg.disus.com ([199.243.199.210]:60689 "EHLO borg.disus.com")
	by vger.kernel.org with ESMTP id S262132AbVDOXA1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 19:00:27 -0400
Received: from gandalf (vpn2000c.secdisus.com [199.246.34.122])
	by borg.disus.com (8.11.6/8.11.6) with ESMTP id j3FM0Lf05903;
	Fri, 15 Apr 2005 18:00:21 -0400
To: "'Linus Torvalds'" <torvalds@osdl.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <Pine.LNX.4.58.0504151313450.7211@ppc970.osdl.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The issue I am trying to come to grips with in the current design, is
that the git repository of a number of interrelated projects will soon
become the logical OR of all blobs, commits, and trees in ALL the
projects. 

This will involve horrendous amounts of replication, as developers end
interchanging objects that originated from third parties who are not
party to the merge (and which happen to be in the repository because of
previous merge activity).

It would be really nice if the repositories for each project stay
distinct (and maybe even living on different servers). Merges should the
one of the few points of contact where the state be exchanged between
the repositories.

>> If you don't keep track of the incremental merges, you end up with
one 
>> really _difficult_ merge that may not be mergable at all. Not 
>> automatically, and perhaps not even with help.

No argument from me.... In my example, I didn't intend A2,A3,A4 to be
considered hash's of points where you did a merge - rather they are
hashes of individual points where you did a commit BETWEEN the points
where you merged. A1 and A5 are the "merge points"! 

It makes perfect sense to define some subset of commits as "merge-like"
commits, and only have those copied over from one repository to the
other. You could also only use merge-points in the common ancestor
calculation, and not worry about intermediate commits. 

Only small changes to the existing logic are necessary to do a merge by
"distributing" out the merge algorithm to each repository. This involves
querying each repository, and communicating the results, followed by
copying over only those blob objects necessary for the merge. 

After the merge, you would create a "merge-point commit" record that has
one of the parents pointing to a hash in the other repository!

But the BIG issue with this scheme, is that you will not be replicating
over any of the intermediate commits, trees, or blobs (not really needed
by the merge), but currently being traversed by various plumbing
components.

Hence my question....

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 
Sent: Friday, April 15, 2005 4:31 PM
To: Barry Silverman
Cc: git@vger.kernel.org
Subject: RE: Merge with git-pasky II.


[ I'm cc'ing the git list even though Barry's question wasn't cc'd. 
  Because I think his question is interesting and astute per se, even
  if I disagree with the proposal ]

On Fri, 15 Apr 2005, Barry Silverman wrote:
>
> If git is totally project based, and each commit represents total
state
> of the project, then how important is the intermediate commit
> information between two states. 

You need it in order to do further merges.

> IE, Area maintainer has A1->A2->A3->A4->A5 in a repository with 5
> commits, and 5 comments. And I last synced with A1.
> 
> A few days later I sync again. Couldn't I just pull the "diff-tree A5
> A1" and then commit to my tree just the record A1->A5. Why does MY
> repository need trees A2,A3,A4?

Because that second merge needs the first merge to work well. The first 
merge might have had some small differences that ended up auto-merging
(or 
even needing some manual help from you). The second time you sync, there

migth be some more automatic merging. And so on.

If you don't keep track of the incremental merges, you end up with one 
really _difficult_ merge that may not be mergable at all. Not 
automatically, and perhaps not even with help.

So in order to keep things mergable, you need to not diverge. And the 
intermediate merges are the "anchor-points" for the next merge, keeping 
the divergences minimal. 

I'm personally convinced that one of the reasons CVS is a pain to merge
is 
obviously that it doesn't do a good job of finding parents, but also 
exactly _because_ it makes merges so painful that people wait longer to
do 
them, so you never end up fixing the simple stuff. In contrast, if you
have all these small merges going on all the time, the hope is that 
there's never any really painful nasty "final merge".

So you're right - the small merges do end up cluttering up the revision 
history. But it's a small price to pay if it means that you avoid having

the painful ones.

> Isn't preserving the A1,A2,A3,A4,A5 a legacy of BK, which required all
> the changesets to be loaded in order, and so is a completely "file"
> driven concept? 

Nope. In fact, to some degree git will need this even _more_, since the
git merger is likely to be _weaker_ than BK, and thus more easily
confused.

I do believe that BK has these things for the same reason.

			Linus


