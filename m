From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Show of hands, how many set USE_NSEC
Date: Fri, 8 Aug 2008 10:52:47 -0700
Message-ID: <20080808175247.GH9152@spearce.org>
References: <20080808163455.GE9152@spearce.org> <alpine.DEB.1.00.0808081854120.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080808165718.GG9152@spearce.org> <alpine.LFD.1.10.0808081027590.3462@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWAA-0005NT-0u
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 19:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYHHRwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYHHRwt
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 13:52:49 -0400
Received: from george.spearce.org ([209.20.77.23]:33095 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYHHRws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 13:52:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CD8EE38420; Fri,  8 Aug 2008 17:52:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808081027590.3462@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91700>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 8 Aug 2008, Shawn O. Pearce wrote:
> > 
> > Really I'd just like to scrap the entire DIRC file format and do
> > it over again.  Having the flat namespace is nuts.
> 
> I really disagree, because you have no clue about performance.

Actually, I do have half a clue.  I just haven't convinced you of
that yet.  Something to aspire to.
 
> The flat file format is absolutely _critical_ for performance.
 
I know, I agree.

> The point is, the index file absolutely *HAS* to be a single file in order 
> to perform well in a big project. Otherwise there's no point, and you 
> might as well just use a git "tree" object for everything.

Yes, it _has_ to be a single file, at the root of the directory tree.
I agree with that design decision entirely.

That single file however does not need to be structured internallyy
the way it is.
 
> Now, if you talk about the _sorting_ order (as opposed to the flatness of 
> the file), I could probably agree. The sort order was probably a mistake. 
> That said, we're stuck with it.  You can't change it without changing the 
> tree object format, so it's not just an "local index file" format issue.

I was talking about something like the 'TREE' extension.  If we
used a format such as:

	index_file:: tree
	tree:: entry_count sha1_id record*
	record:: mode pathlen path (tree | file)
	file:: sha1_id ctime mtime ....

And sorted the entries within each tree record by their path (or
path+mode in "Git style") then we wind up with all records in the
index file in the same order they are today, and we don't have the
big redundant path strings like "src/a.c", "src/b.c", "src/c.c".

This may actually create a _smaller_ index file, resulting in a
few less minor page faults as we read it in.

-- 
Shawn.
