From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] patch-id
Date: Thu, 8 Oct 2009 09:28:05 -0700
Message-ID: <20091008162805.GE9261@spearce.org>
References: <4AC136CC.8040300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 18:33:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvvvA-0000vI-FX
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 18:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbZJHQ2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758550AbZJHQ2n
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 12:28:43 -0400
Received: from george.spearce.org ([209.20.77.23]:51870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZJHQ2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 12:28:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A75B2381FE; Thu,  8 Oct 2009 16:28:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AC136CC.8040300@codeaurora.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129699>

Nasser Grainawi <nasser@codeaurora.org> wrote:
> I'm trying to add a public getPatchId method to the jgit Patch class [...]
>
> It seems Patch does some statistical number gathering, but at no point does
> it store a 'slimmed-down' version of a patch.

It parses the patch to create FileHeader objects, one for each
file mentioned in the script.  Within each FileHeader there is a
HunkHeader object, one for each hunk present in the patch.  Within
each HunkHeader there is an EditList composed of Edit instances;
each Edit instance denotes a contiguous line range within that hunk.

Edit instances come in one of 3 forms:

  INSERT:  a run of + lines with no - lines
  DELETE:  a run of - lines with no + lines
  REPLACE: a mixture of - and + lines

and their type is actually determined by the line numbers attached
to them.  A INSERT has the same starting and ending line number on
the A side, but on the B side the ending line number is at least
one higher than the starting number.  DELETE is the reverse, and
REPLACE has both ending numbers higher than the starting number.

IIRC Edit uses 0 based offsets, so line 3 is actually position 2.

These HunkHeader and Edit instances are only available on a text
patch, binary patches use a different representation for the
binary delta.  Combined diff patches (--cc format) also lack these
HunkHeader/Edit instances as we don't have a generic n-way patch
parser yet.

> I had the idea to just iterate
> over the FileHeader's and get the byte buffer of each, but I don't think
> those buffers have the parsed data.

The HunkHeader and Edit instances really don't have the actual
line data available to them, they only have the line numbers.
To generate a patch ID you'd need to get the line data too.

Worse, IIRC the patch ID generation in C git favors a 3 line context.

In theory you could modify FileHeader or HunkHeader to produce
a RawText that uses the underlying byte[] returned by getBuffer()
as the backing store, but create a specialized IntList which has the
actual file line numbers mapped to the positions in the patch script.
To do that you'd need to re-walk the patch, like the toEditList()
method in HunkHeader does.

Given that RawText you could feed it through something like
DiffFormatter to create a patch with 3 lines of context, and hash
the relevant bits.

But... that seems like a lot of work.

Also, there is a class in Gerrit Code Review called EditList (not
to be confused with JGit's EditList class!) that really should be
moved back over to JGit.  It has some useful routines for walking
through a patch as a series of iterations.

> Short of that, suggestions for how to go about acquiring/storing a parsed
> representation of the data with maximal existing code re-use would be
> appreciated.

I'm coming up short on suggestions right now.  I'm not seeing an
easy path to this without writing a bit of code.  I think you really
just need to walk the patch... :-\

-- 
Shawn.
