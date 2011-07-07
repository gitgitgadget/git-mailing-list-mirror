From: Jeff King <peff@peff.net>
Subject: Re: Redoing a merge for a particular file
Date: Thu, 7 Jul 2011 18:41:15 -0400
Message-ID: <20110707224114.GA23273@sigill.intra.peff.net>
References: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:41:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QexG7-00011k-2J
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 00:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1GGWlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 18:41:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57315
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab1GGWlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 18:41:17 -0400
Received: (qmail 3308 invoked by uid 107); 7 Jul 2011 22:41:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 18:41:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 18:41:15 -0400
Content-Disposition: inline
In-Reply-To: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176786>

On Fri, Jul 08, 2011 at 10:24:10AM +1200, Chris Packham wrote:

> I'm in the middle of merging to branches and I've screwed up my manual
> merge, I've also got rerere enabled and I can't seem to get back into
> a state to trigger git mergetool again.
> 
>   $ git merge topic
>   ...
>   $ git mergetool
>   $ make
>   error: foo.c ... oops screwed up that merge.
> 
> The merge wasn't too painful so I don't mind starting again.
> 
>   $ git reset --hard HEAD^
>   HEAD is now at 59c6097 ...
>   $ git merge topic
>   Auto-merging foo.c
>   CONFLICT (content): Merge conflict in foo.c
>   Auto-merging bar.c
>   CONFLICT (content): bar.c
>   Auto-merging otherfile1.c
>   Auto-merging otherfile2.c
>   Auto-merging otherfile3.c
>   Resolved 'foo.c' using previous resolution.
>   Resolved 'bar.c' using previous resolution.
>   Automatic merge failed; fix conflicts and then commit the result.
>   $ git mergetool
>   No files need merging
> 
> So rerere has remembered the bad resolution of foo.c.  But even if I
> run 'git rerere clear' and repeat the above sequence I get the same
> result.

I think you actually want "rerere forget". Like:

  $ git reset --hard HEAD^
  $ git merge topic
  $ git rerere forget foo.c

Although it is slightly more complicated if you have set
rerere.autoupdate, since it will have cleared the index of any notion
that the path was conflicted. In that case you can then follow the
"rerere forget" with:

  $ git reset --hard
  $ git merge topic

to retry again.

But it doesn't look like you have autoupdate on, from the output above
(it would say "Staged 'foo.c'" instead of "Resolved 'foo.c", I believe).

> I seem to remember something like this coming up before.
> Wasn't there an option added to checkout to allow us to recreate the
> pre-merge state?
> 
>   $ git checkout --merge foo.c
>   $ git mergetool
>   No files need merging

If you have rerere.autoupdate on, then it will have updated the index,
and the path will not appear unmerged. You can use the trick above to
get past it.

If you aren't using rerere.autoupdate (and haven't updated the index
yourself), you shouldn't even need the "git checkout --merge" line. It
just updates the working tree with the conflicted content, but mergetool
will operate directly on the original versions contained in the index,
anyway.

>   $ git status
>   # On branch master
>   # Your branch is behind 'origin/master' by 1 commit, and can be
> fast-forwarded.
>   #
>   # Changes to be committed:
>   ....
>   # Unmerged paths:
>   #   (use "git add/rm <file>..." as appropriate to mark resolution)
>   #
>   #	both modified:      foo.c
>   #
> 
> foo.c now does have conflict markers in it so I think it's crying out
> to be re-merged I just can't convince mergetool to do it. Am I doing
> something wrong?

Hmm. That does seem like "git checkout --merge" did the right thing, but
that "mergetool" is wrong for not accepting it (it _should_ just be
looking at what's in the index to find unmerged paths).

Ahh. It is probably the fault of bb0a484 (mergetool: Skip autoresolved
paths, 2010-08-17), which checks with rerere to avoid resolved paths. So
I think:

  $ git rerere forget foo.c
  $ git mergetool

would do what you want.

-Peff
