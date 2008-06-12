From: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
Subject: Re: git-fast-export bug, commits emmitted in incorrect order
	causing parent data to be lost from commits turning essentially
	linear repo into "islands"
Date: Thu, 12 Jun 2008 16:02:10 +0200
Message-ID: <20080612140210.GE3830@plop>
References: <1213266100.6940.207.camel@gemini> <48510E2E.6090508@viscovery.net> <1213272285.6940.222.camel@gemini> <1213272962.6940.231.camel@gemini> <g2r66q$d3j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 16:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6nOQ-0006L7-64
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 16:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbYFLOCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 10:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYFLOCO
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 10:02:14 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:46223 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYFLOCN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 10:02:13 -0400
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1K6nLq-0002NT-9r
	for git@vger.kernel.org; Thu, 12 Jun 2008 16:00:30 +0200
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1K6nNS-0007wk-3B
	for git@vger.kernel.org; Thu, 12 Jun 2008 16:02:10 +0200
Content-Disposition: inline
In-Reply-To: <g2r66q$d3j$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84755>

On Thu, Jun 12, 2008 at 02:52:40PM +0200, Michael J Gruber wrote:
> Yves Orton venit, vidit, dixit 12.06.2008 14:16:
>> We want a more or less linear repo as the result. This bug with
>> fast-export was the main showstopper in our efforts.  However, I can
>> imagine that this is a problem that many people will want to solve. It
>> would be nice if there was an easier way to do it that what we currently
>> are doing (merging and munging multiple fast-export streams into a
>> single fast-import process). While at this point its probably academic
>> any suggestions as to the Best Way to do this would be very much
>> welcome.
>
> I've done something like this, "stitching" the history of different  
> repos together in order to produce one repo, with each of the  
> constituents in a subdir. What I did was an adaption of
>
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
>
> but as a multistep version:

What we did with Yves was a script doing the following:
- run git fast-export --all (and --topo-order now) on all the repositories
  we wanted to merge and read blocks from them
- pass through all non-commit blocks (munging paths to put the content of
  each repo in its own directory and renumbering marks to avoid clashes)
- keep a list of the next commit sent by fast-export for each repo
- select the oldest commit, and send it through, after stitching in the
  right place (the point being to determine the "right place")

Actually, what we are trying to do is produce a single DAG from 2 or
more DAGs, while making sure that each "internal DAG" is the same.
(I'm pretty sure this is all trivial stuff for graph mathematicians)

Imagine we merged repositories A, B and C in a new repo D, if we replace
all nodes from D coming from B and C by vertexes, we will end up with
the original A graph.

We defined the "right place" as so: when having selected the next commit
to add to our new graph, each of its new parents is defined by "the last
alien child of the original parent" (or the original parent itself).

For example, if our new repository being built looks like:

 --A7--A8--B4--B5--A9--B7
            \
             --B6

In this case, A9 was originally attached to A8, but to avoid unnecessary
branching in the new repo, we didn't attach it to A8, but to B5 (last
alien child of A8, descending the tree in a leftmost manner).

No A node will ever be attached to B6. The next A node originally
attached to A8 will be attached to B5 again, and one originally attached
to A9 will be attached to B7. Like this:

                 --A10
                /
 --A7--A8--B4--B5--A9--B7--A11
            \
             --B6

Now, if we remove all B nodes, we get this:

         --A10
        /
 --A7--A8--A9--A11

which is the original A graph.

Finding the "last alien child" works fine with merges, too.

Of course, some commits from A might end up on an unrelated branch of B,
but all B branches are irrelevant to A anyway! :-)

-- 
 Philippe Bruhat (BooK)

 People are all unique- but some are more unique than others.
                                    (Moral from Groo The Wanderer #22 (Epic))
