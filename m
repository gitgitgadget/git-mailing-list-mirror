From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Request For Help/Directions
Date: Mon, 10 Aug 2009 08:23:08 -0700
Message-ID: <20090810152308.GQ1033@spearce.org>
References: <ed88cb980907312015q5eb89bf3k73b6664c4f3cbcfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Douglas Campos <douglas@theros.info>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:23:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWiU-0004Dw-7l
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbZHJPXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbZHJPXI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:23:08 -0400
Received: from george.spearce.org ([209.20.77.23]:36043 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZHJPXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:23:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B469A381FD; Mon, 10 Aug 2009 15:23:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ed88cb980907312015q5eb89bf3k73b6664c4f3cbcfd@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125462>

Douglas Campos <douglas@theros.info> wrote:
> I'm interested in helping with the implementation, can someone gimme
> little directions?
> 
> I was thinking on implement "git checkout <file>" functionality.
> 
> Any tips?
> 
> PS: I'm reading the testcases & code to find directions, but got
> struck at some deprecated types (GitIndex -> DirCache).

Sorry for the late reply, things tend to get lost in my inbox.

GitIndex vs. DirCache... that's an ugly issue at the momement in the
code base.  I really want to move to DirCache because it tends to
be quicker at reading and writing the index out, plus it honors the
'TREE' extension, at least some of the time.  But its API is said
to be harder to work with, and I can't disagree with that, using the
DirCacheBuilder vs. DirCacheEditor to make updates is horribly ugly.

FWIW, DirCacheBuilder is really meant to be used inside of a
TreeWalk, alongside other iterators, like a FileTreeIterator.

In theory, you should be able to create a 3 way TreeWalk between:

 1) DirCacheBuilderIterator
 2) FileTreeIterator
 3) CanonicalTreeParser

where 1 represents the current state of the .git/index file,
2 represents the current state of the working directory, and 3
represents the tree you are performing the checkout from.

IIRC you could attach a TreeFilter.ANY_DIFF to this TreeWalk and
only have it stop where there are differences between the 3 trees.
Though with a FileTreeIterator ANY_DIFF is probably a bad idea,
as the SHA-1 isn't readily available in a FileTreeIterator and
that is one of the things ANY_DIFF relies upon.  Instead you'd
need to write your own TreeFilter to check stat data between 1-2,
and SHA-1 data between 2-3.

At a difference point, you then need to apply the basic 3-way merge
logic to determine if you should checkout the file in 3 to 1 and 2,
or if you should abort because the file in 2 (the working tree)
differs and needs to be merged.

A really good reason for using the TreeWalk is it has a subclass
called NameConflictTreeWalk that knows how to heal around
directory/file conflicts (aka D/F conflicts) and reports both D/F
paths under a single entry, so that the merge alogrithm can attempt
to deal with D->F or F->D type changes.

But a good chunk of this is pie-in-the-sky.  I've built these APIs
with this in mind... but haven't gotten as far as actually putting
the implementation into practice.

-- 
Shawn.
