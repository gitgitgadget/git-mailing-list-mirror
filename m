From: Pete Wyckoff <pw@padd.com>
Subject: Re: git p4: any way to avoid rebasing all the time?
Date: Wed, 18 Apr 2012 07:53:01 -0400
Message-ID: <20120418115301.GA24716@padd.com>
References: <CAE5ih7_Fh0XA-XNNvtHnXhYwUvwmmg-Z+y-Mb5Wvra3Y83eFsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:53:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKTRf-0006zP-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 13:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab2DRLxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 07:53:06 -0400
Received: from honk.padd.com ([74.3.171.149]:59105 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab2DRLxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 07:53:05 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 3988820CE;
	Wed, 18 Apr 2012 04:53:04 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5EAE85E917; Wed, 18 Apr 2012 07:53:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAE5ih7_Fh0XA-XNNvtHnXhYwUvwmmg-Z+y-Mb5Wvra3Y83eFsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195860>

luke@diamand.org wrote on Wed, 11 Apr 2012 18:27 +0200:
> Is there a way to get "git p4" to not rebase all the time?
> 
> Right now, git commits get discarded and replaced with new ones with
> the same contents and extra git-p4 metadata embedded in the comment.
> 
> If we put this git-p4 metadata into a git note then we would not need
> to rewrite the commits, and so could perhaps avoid rebasing quite so
> much.

I don't know if it is always true that the change that went from
git to p4 and back is identical to the original git commit.
Things like timestamp and maybe author name?  We have evil
systems that rewrite p4 change descriptions post submit, worse
yet.

You can do funny merges to make it look like you're not rebasing:

  o--o--o   p4/master
         \
          A--B   top

submit:

  o--o--o--A'--B'  p4/master
         \
          A--B   top

merge -s ours, so that M == B' == B.

  o--o--o--A'--B'  p4/master
         \      \
          A--B---M  top

The merge changes nothing, but avoids a rebase for anything that
depended on the original A and B.

> However, if "git p4" won't rewrite commits, then it can't reorder them
> to match the ordering seen from p4.
> 
> So you could end up with git users seeing OLDHEAD,G,P and p4 users
> seeing OLDHEAD,P,G, as there's a race to see who submits against
> OLDHEAD first, which p4 always wins.
> 
> Would this matter (assuming the git and p4 commits are all reasonably
> independent) or is there a way to avoid it?
> 
> Perhaps hook into the pre-receive hook? If the newest p4 changelist is
> not the same as the HEAD of the branch being pushed to, then reject
> the push, just as would happen if the branch could not be
> fast-forwarded in a normal git repo? (Even with this there is still a
> small window of opportunity).

Yes, the race issues are tough.  There is no way in p4 to ensure
a given existing ancestor when submitting.  Closest you can come
is with locking, which is sometimes annoying to other users:

    p4 lock //depot/path/...
    <verify same change number>
    p4 submit
    p4 unlock //depot/path/...

You can lock just the files being submitted, but that doesn't
prevent other non-intersecting changes from sneaking in.

If there is a series of git commits, they can be checked in
atomically on a side branch in p4, and merged.  That doesn't help
your rebase issue, but is a way to keep a series of changes from
being broken up by races at p4.

                -- Pete

> At that point, the "git p4 rebase" command would still be used, but
> would normally be a no-op.
> 
> Or would that result in something far too complicated to have any
> chance of working?
