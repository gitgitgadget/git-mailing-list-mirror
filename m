From: Jeff King <peff@peff.net>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 05:34:52 -0500
Message-ID: <20111114103451.GA10847@sigill.intra.peff.net>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Simon Brenner <olsner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 11:35:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPtsT-0004IL-TF
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 11:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab1KNKe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 05:34:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40970
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab1KNKe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 05:34:56 -0500
Received: (qmail 27945 invoked by uid 107); 14 Nov 2011 10:35:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 05:35:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 05:34:52 -0500
Content-Disposition: inline
In-Reply-To: <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185373>

On Mon, Nov 14, 2011 at 09:48:07AM +0100, Simon Brenner wrote:

> On Mon, Nov 14, 2011 at 7:06 AM, Miles Bader <miles@gnu.org> wrote:
> > It might be nice to have a mechanism where new objects would update
> > the _alternate_ rather than the object-store in the tree where the
> > command was run... then you could easily have a bunch of trees using a
> > central object store without needing to update the central store
> > occasionally by hand (and do gc in its "clients")...
> 
> This sounds like a nice way forward: replace/extend the current
> alternates system with support for a shared object store that is
> "intelligently" shared so that it can be gc:d based on all refs from
> all referring repositories. I imagine it would be something very much
> like a bare repository - except it wouldn't have any refs of its own,
> just a list of other repositories it should search for refs when
> GC:ing.

Yes, I think that is sensible. I'm not sure there is even any core git
code to be written. I think a wrapper that does the following would
probably work:

  1. Make new repo groups. E.g.:

       $ git share init foo

     which would be implemented something like:

       ROOT=$HOME/.git-share
       git init --bare $ROOT/$1

  2. Add a repo to a group.

       $ git share add foo

     implemented as:

       echo $ROOT/$1/objects >>.git/objects/info/alternates
       git --git-dir=$ROOT/$1 config --add share.child $PWD

  3. Compact a group.

       $ git share compact foo

     implemented as:

       # delete any existing refs
       git for-each-ref --format='%(refname)' | xargs git update-ref -d

       # now make new refs for each child
       n=1
       for dir in `git config --all share.child`; do
              if ! test -d $dir; then
                      echo >&2 "warning: $dir went away"
                      continue
              fi
              git fetch $dir refs/*:refs/$1/*
              n=$(($n + 1))
       done

       # and then repack/prune
       git repack -ad

       # and then gc each child, dropping anything in the share
       for dir in `git config --all share.child`; do
              git --git-dir=$dir gc
       done

I'm sure I'm missing a corner case or two, and of course there are
quoting issues and error handling missing. But the point is, I don't
think there's a real reason that the UI can't wrap the existing
mechanism, creating a momentary list of refs and pruning based on that.

One issue with this scheme (or most similar schemes) is that child repos
are uniquely identified by their directory name. In the absence of
alternates, it's perfectly reasonable to do:

  git init; hack hack hack; commit commit commit
  cd .. ; mv project new-project-name

but here it would break the shared repo's link to the child (which is
not just inconvenient, but dangerous, as we will not respect its refs
when pruning). Probably the "warning" above should actually error out
and force the user to say "yes, I deleted this child" or "no, I moved it
here".

You could try to be clever with assigning each child a UUID, but then
you have to resort to grepping the filesystem for the UUID to detect a
move. Which is complex and still not foolproof (i.e., if you don't find
it, is it because the repo was deleted, or because it got moved
somewhere that we didn't look?).

-Peff
