From: Jeff King <peff@peff.net>
Subject: Re: Seeing git history of file including merge changes
Date: Wed, 9 Sep 2015 05:04:27 -0400
Message-ID: <20150909090427.GA21892@sigill.intra.peff.net>
References: <CA++fsGE-R1XpHxAVRZvOEAAwNr1XdTudGbwE4GYvg-E5L9kqEQ@mail.gmail.com>
 <CA++fsGHPEMhfENx-35=_9_k7mH98TU8NkHO0pYLC2aSxUKWvyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dov Grobgeld <dov.grobgeld@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 11:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZbJC-0005XG-KN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 11:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbIIJEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 05:04:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:56640 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751441AbbIIJEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 05:04:30 -0400
Received: (qmail 7166 invoked by uid 102); 9 Sep 2015 09:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Sep 2015 04:04:30 -0500
Received: (qmail 29629 invoked by uid 107); 9 Sep 2015 09:04:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Sep 2015 05:04:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2015 05:04:27 -0400
Content-Disposition: inline
In-Reply-To: <CA++fsGHPEMhfENx-35=_9_k7mH98TU8NkHO0pYLC2aSxUKWvyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277539>

On Wed, Sep 09, 2015 at 11:26:47AM +0300, Dov Grobgeld wrote:

> The file was changed in commit B and the changes were undone in commit M.
> 
> My problem is how to view the changes to the file between a specific
> commit, e.g. B and another commit in its "downstream", e.g. H.
> 
> If you do
> 
>     git log -u B..H
> 
> you won't see any changes, as the changes due to M are suppressed. You
> can see potential changes by doing:
> 
>     git log -u --full-history B..H
> 
> which will show you that there was a merge commit, but it still won't
> show you the diff between B and M.
> 
> So is there a way of seeing all changes made to a file including those
> made by a merge commit?

Try adding "-m". Normally for merges we show nothing, or the combined
diff. In the latter case, we consider a file which matches one of its
parents to be an uninteresting change. From the perspective of walking
back through history, as git-log does, it is impossible to know whether
B made a change that was thrown away in the merge, or whether A made a
change that we kept. You can only know the answer by walking further
back to the merge-base.

Using "-m" will show you the individual diff against each parent. But
since it is limited by the pathspec, it will show you only the diff
against "B" in this case, which is what you want.  Using this recipe to
recreate your setup:

    # a boring history with a file...
    git init
    echo base >file
    git add file
    git commit -m base
    
    # and some other commits...
    echo foo >unrelated
    git add unrelated
    git commit -m unrelated
    
    # meanwhile, somebody forked from us and changed the file...
    git checkout -b other HEAD^
    echo change >>file && git commit -am change
    
    # now let's merge it in, undoing the change
    git checkout master
    git merge --no-commit other
    echo base >file
    git add file
    git commit -m merged

I get:

    $ git log -p -m --full-history file
    commit a279eccbb7cbb806dceff4591a1d4be74b060645 (from 36d29fbf1caf762ef2d78e484bfc1287a9df7603)
    Merge: 2d1e518 36d29fb
    Author: Jeff King <peff@peff.net>
    Date:   Wed Sep 9 04:47:26 2015 -0400
    
        merged
    
    diff --git a/file b/file
    index 09025f9..df967b9 100644
    --- a/file
    +++ b/file
    @@ -1,2 +1 @@
     base
    -change

    [...and so on, showing "change" and "base" as you'd expect]

That's pretty good, though if you had other merges in your log output, I
expect "-m" would be messy and confusing there.

So I think what you _really_ want is to recompute the original merge and
show something more clever. There is an old topic, tr/remerge-diff,
which tried to do this. Its output looks the same as what is above, but
it would probably do a better job of not making all of the _other_
merges look ugly.

Unfortunately, development stalled on the topic, and it is nowhere close
to being merged. I can dig up pointers if you'd like to play with it.

-Peff
