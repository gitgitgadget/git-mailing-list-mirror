From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rewriting boundary parents when path-limiting
Date: Tue, 19 Feb 2008 09:41:05 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802190921460.7833@woody.linux-foundation.org>
References: <18358.53933.747911.449078@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:42:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRWTn-0005O4-Sx
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 18:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYBSRlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 12:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbYBSRlc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 12:41:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55999 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752217AbYBSRlb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 12:41:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1JHf6ON030580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Feb 2008 09:41:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1JHf5RP024374;
	Tue, 19 Feb 2008 09:41:05 -0800
In-Reply-To: <18358.53933.747911.449078@cargo.ozlabs.ibm.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.741 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74440>



On Sat, 16 Feb 2008, Paul Mackerras wrote:
>
> When using both path and commit limiting, git log --parents --boundary
> rewrites the parents that are actually in the graph but doesn't
> rewrite the parents on the boundary, that is, the boundary parents may
> be commits that don't modify any of the specified paths.  I'm
> wondering if there is a way to get the boundary parents rewritten too.

Hmm. Right now we never rewrite uninteresting parents. The reason is 
rather simple: we simply haven't followed the chain down uninteresting 
commits!

Changing that is pretty hard. The thing is, we do the commit range 
limiting mostly separately from the commit parent simplification: one 
happens while actually walking the commits, the other one happens 
after-the-fact when you do the "simplify_commit()" thing.

In addition to that problem (which is likely solvable: we do actually do 
a lot of the groundwork for the later simplification stage during the 
first stage, so we might be able to just move more of that logic up), we 
actually explicitly do *not* simplify uninteresting commits, ie we have:

        if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
                /* Even if a merge with an uninteresting
                 * side branch brought the entire change
                 * we are interested in, we do not want
                 * to lose the other branches of this
                 * merge, so we just keep going.
                 */
                pp = &parent->next;
                continue;
        }

in there, where the comment says it all: we literally *avoid* simplifying 
uninteresting parents, and if the commit itself is uninteresting, we go 
even further, and don't even compare the trees at all! (See the big 
comment in revision.c: add_parents_to_list, and note how it checks for the 
UNINTERESTING bit and returns early without even calling 
try_to_simplify_commit() for such a commit).

So right now, not only is the code not really organized for what you ask, 
it actually explicitly tries to avoid doing what you ask. 

That said, I'm not sure either of these problems are really impossible (or 
even hard) issues to avoid.

We could simply move the "try_to_simplify_commit()" call up, and remove 
some of the code that explicitly avoids simplifying negative commits. But 
the logic on when to stop even traversing the list is fundamentally pretty 
hard, and that might require splitting up UNINTERESTING into two separate 
bits: a "fairly uninteresting" bit (which means that it is negative) and a 
"_really_ uninteresting bit" (which means that not only was it negtive, 
but it also changed the tree, so the parents of this commit are *really* 
not interesting any more, even after simplification).

Then the "can we stop traversing the tree" code would have to look at the 
"really uninteresting" bit rather than just the regular uninteresting one.

Quite frankly, I suspect it's not worth it, and maybe you just shouldn't 
do that optimization and limit the commits in other ways instead (ie you 
might try to limit them *numerically* instead of by using negative 
commits, and do one first run with the number of commits limited to <n>, 
and then if that wasn't enough to re-connect the trees, you do the whole 
thing)


		Linus
