From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 20:09:36 +0100
Message-ID: <1113505776.12012.210.camel@baythorne.infradead.org>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:07:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9fd-0004uT-LJ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDNTJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDNTJy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:09:54 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:39311 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261589AbVDNTJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:09:38 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DM9ia-0000Z6-PK; Thu, 14 Apr 2005 20:09:36 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 11:11 -0700, Linus Torvalds wrote:
> So, you really need to think of git as a filesystem. You can then 
> implement an SCM _on_top_of_it_, which means that your second suggestion 
> is not only acceptable, it really is the _only_ way to handle this in git:
> 
> > So a commit involving a rename would look something like this...
> > 
> > 	tree 82ba574c85e9a2e4652419c88244e9dd1bfa8baa
> > 	parent bb95843a5a0f397270819462812735ee29796fb4
> > 	rename foo.c bar.c
> > 	author David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
> > 	committer David Woodhouse <dwmw2@hades.cambridge.redhat.com> 1113499881 +0100
> > 	Rename foo.c to bar.c and s/foo_/bar_/g
> 
> Except I want that empty line in there, and I want it in the "free-form"  
> section. The "rename" part really isn't part of the git header. It's not 
> what git tracks, it was tracked by an SCM system on top of git.

Note that not only may you have a _set_ of renames, but you'll also have
a _different_ set of renames for each parent. Consider the
representation of a merge where a file was called 'foo' in one parent,
'bar' in the other, and we called it 'foobar' in the resulting tree.

That's the main reason I wanted the renames in with the parent
information -- so it's <parent><rename><rename><...><parent><rename>...

I see your point though and I can't be bothered to argue for the sake of
the slight efficiency benefit we might gain from doing it that way. The
implementation details really aren't that interesting right now.

Let us assume, however, that we have this information somehow stored in
each commit object. It's perfectly sufficient from the POV of the 
'git revtool' which I've been poking at; is it good enough for merges?

Consider a simple case: A branch is taken, file foo.c is renamed to
bar.c, and now we're trying to merge that branch back into the head,
which has moved on. 

We can't just take 'bar.c' as a new file -- we have to track it all the
way back to its inception, and notice that it actually shares a common
ancestor with 'foo.c' in the other parent of the merge.

How feasible, and how computationally expensive, is that task going to
be? Especially given that there may be _many_ new files that we need to
attempt to tie up with their partners, across many potential renames. 

One option for optimising this, if we really need to, might be to track
the file back to its _first_ ancestor and use that as an identification.
The SCM could store that identifier in the blob itself, or we could
consider it an 'inode number' and store it in git's tree objects.

If we can avoid that, however, it would be nice. How feasible is the
merge going to be without it?

-- 
dwmw2


