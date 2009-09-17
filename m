From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 05:54:48 +0200
Message-ID: <200909170554.49416.chriscool@tuxfamily.org>
References: <20090916035131.3737.33020.chriscool@tuxfamily.org> <20090916041443.3737.63217.chriscool@tuxfamily.org> <7vfxamzqga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 05:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo83v-000535-4e
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 05:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121AbZIQDx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 23:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760122AbZIQDx2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 23:53:28 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45177 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758415AbZIQDx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 23:53:26 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4694D81808F;
	Thu, 17 Sep 2009 05:53:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A7135818085;
	Thu, 17 Sep 2009 05:53:17 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vfxamzqga.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128705>

On Wednesday 16 September 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > From: Stephan Beyer <s-beyer@gmx.net>
> >
> > This option is nearly like "--merge" except that it is
> > safer. The table below show the differences between these
> > options.
> >
> > working index HEAD target         working index HEAD
> >   B      B     A     A   --m-s      B      A     A
> >                          --merge    A      A     A
> >   B      B     A     C   --m-s       (disallowed)
> >                          --merge    C      C     C
> >
> > In this table, A, B and C are some different states of
> > a file. For example the first 2 lines of the table mean
> > that if a file is in state B in the working tree and
> > the index, and in a different state A in HEAD and in
> > the target, then "git reset --merge-safe target" will
> > put the file in state B in the working tree and in
> > state A in the index and HEAD.
>
> At first, I had to spend a few minutes guessing what you meant by
> "target" in the table.  All the other words are well known and do not
> need to be explained, but you can make it even easier to understand by
> updating the sentence before the table, perhaps like:
>
>     When running "git reset --option target" to reset the HEAD to another
>     commit (as a special case "target" could be the same as HEAD), here
>     is what happens to paths in various state.

Ok, I will update the sentence like this.

> As you mentioned in the proposed commit log message of the other entry,
> you have a different behaviour for unmerged case.  Can you add that case
> to the table as well?

The behavior is not different between --merge and --merge-safe, the behavior 
is different between --merge before patch 2/4 and --merge after patch 2/4.
I will add a test case to show this.

> The original use case of Linus's "reset --merge" was:
>
>     $ edit ... ;# you may have some local changes to the work tree
>     $ git merge/pull ...
>     ... (1) it merges cleanly;
>     ... (2) you see conflicts and do not commit, or
>     ... (3) you resolve conflicts and commit, while leaving the earlier
>     ...     modified paths alone.
>     ... In any of the three cases, you inspect the result, and say
>     ... "ah, crap!"
>     ... You want to go back to the state before the merge, i.e.
>     ... target = HEAD^ in (1) or (3) above and target = HEAD in (2).
>     $ git reset --merge $target

I think that Daniel found out that the above "reset --merge" command did not 
worked well in case (2) before patch 2/4.

> Recall that "git merge/pull ..." step does not even touch anything if you
> have a dirty index (i.e. "diff --cached" is non-empty), so any difference
> between the index and HEAD to reset the failed merge away must come from
> the merge itself
>
> Immediately before you run "reset --merge" in the above sequence, you can
> categorize the paths in various states this way:
>
>   work   index  HEAD  how that path got into this state...
>     A      A     A    not involved in this merge.
>     B      A     A    not involved in this merge, originally modified.
>     B      B     A    cleanly merged.
>     B      B     B    cleanly merged (and committed if (1) or (3)).
>     C      U     A    merge left conflicts
>
> where U denotes unmerged path in the index, and C is a file in the work
> tree with conflict markers.  The path had content A in HEAD before the
> start of the merge that you are resetting away.
>
> Note that the target is A in all cases in the above table.
>
> We would want to go back to HEAD == index == target for all of these
> cases, and discarding B in "cleanly merged" entries is absolutely the
> right thing to do.  Clearly, --merge-safe is _not_ designed to work in
> this scenario.

Yes.

> Don't get me wrong.  I am not saying --merge-safe is unsafe nor useless.
>
> I am trying to show a way with an intended use-case (and the mechanical
> notation you and Daniel wrote up, which is very nice to illustrate what
> exactly happens) to explain how --merge works, and more importantly why
> it works that way.
>
> That is because I would like to see an intended use case of this new
> feature in a bigger picture.  With the table, I can see what it does (or
> at least what you wanted it to do), but it does not clearly explain what
> this new mode of operation is good for, in what context it is designed
> to be used, and what problem it intends to solve.  I think you find it
> very clear, by reading my explanation above, what Linus's --merge is
> intended to solve:
>
> 	After a (possibly conflicted) merge modified my index and my work
>         tree, "reset --hard" to the commit before I started the merge
> will discard the local modifications I had in the work tree before the
> merge.  "reset --merge" was invented to let me go back to the state
> before the merge, without discarding such local changes I had before the
> merge.
>
> I want to be able to explain to others what --merge-safe is for in a
> similar way myself before I have it in my tree, and I can't (yet).

I understand, and I think that Stephan designed the "allow_dirty" feature 
(that became --merge-safe in this patch series) because he wanted to let 
the user do a cherry-pick or an improved cherry-pick (or even run the 
sequencer) with a dirty working tree or index without the risk of losing 
some work.

But I think that it can be usefull in case like:

$ "hack something"
$ git commit ...
$ "hack something else"
$ git add "some of the files"
$ "find out previous commit was crap"
$ git reset --merge-safe HEAD^

Here using "--merge-safe" can be usefull because you don't want to lose 
stuff in your current index and work tree.

Best regards,
Christian.
