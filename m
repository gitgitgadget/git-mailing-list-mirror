From: esr@thyrsus.com (Eric S. Raymond)
Subject: reposurgeon now writes Subversion repositories
Date: Thu, 29 Nov 2012 00:59:45 -0500 (EST)
Message-ID: <20121129055946.2D7B84065F@snark.thyrsus.com>
To: dev@subversion.apache.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 07:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdxAO-0002Hn-NA
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 07:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2K2F7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 00:59:54 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:39859
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab2K2F7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 00:59:53 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 2D7B84065F; Thu, 29 Nov 2012 00:59:45 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210809>

This is something that probably doesn't happen very often -
cross-posting to the Subversion and git dev lists that is on-topic for
both :-).

The repo head version of reposurgeon can now write Subversion
repositories from its common git-import-stream-based representation of
repository histories, as well as reading them in.  This joins full
support for git, hg, and bzr; it means that in theory reposurgeon
could now be used to move revision histories from these systems to
Subversion, as well as the other way around.

(For those of you who have been living under a rock, reposurgeon is a
multi-VCS surgery and conversion tool. Since 2.x it does a more
intelligent job of lifting from Subversion to anything else than any
other tool I know of. Much more at <http://www.catb.org/esr/reposurgeon/>.)

Presently, writing (as opposed to reading) Subversion repos is more of
a stunt than a real production technique, and may always remain so.
It has serious limitations.  I am posting because I think the details
of those limitations will be of some technical interest to both
Subversion and git developers.

Indented paragraphs is the documentation from reposurgeon's manual
page.  I have added some further notes.

  In summary, Subversion repository histories do not round-trip through
  reposurgeon editing. File content changes are preserved but some
  metadata is unavoidably lost.  Furthermore, writing out a DVCS history
  in Subversion also loses significant portions of its metadata.

  Writing a Subversion repository or dump stream discards author
  information, the committer's name, and the hostname part of the commit
  address; only the commit timestamp and the local part of the
  committer's email address are preserved, the latter becoming the
  Subversion author field.  However, reading a Subversion repository and
  writing it out again will preserve the author fields.

Subversion's metadata doesn't have separate author and committer
properties, and doesn't store anything but a Unix user ID as
attribution.  I don't see any way around this.

  Import-stream timestamps have 1-second granularity. The subsecond
  parts of Subversion commit timestamps will be lost on their way through
  reposurgeon.

Unavoidable in moving from Subversion to git import streams, and one
of two places where git's data model requires us to throw away
information.  

However, I think I could preserve this information in a
Subversion-to-Subversion editing scenario by storing the incoming
timestamps as floats and only truncating them on import-stream output,
leaving the subseconds in place for Subversion output.

  Empty directories aren't represented in import streams. Consequently,
  reading and writing Subversion repositories preserves file content,
  but not empty directories.  It is also not guaranteed that after
  editing a Subverson repository that the sequence of directory
  creations and deletions relative to other operations will be
  identical; the only guarantee is that enclosing directories will be
  created before any files in them are.

  When reading a Subversion repository, reposurgeon discards the special
  directory-copy nodes associated with branch creations.  These can't be
  recreated if and when the repository is written back out to
  Subversion; rather, each branch copy node from the original translates
  into a branch creation plus the first set of file modifications on the
  branch.

In theory, I could relax the rules of reposurgeon's internal
representation so that empty directory-creation and deletion nodes are
not discarded at read time but only when outputting a git event stream.

That would bring Subversion repositories closer to round-tripping, but
not get all the way there.  One problem is botched branch copies -
directory copies with cp(1) followed by Subversion add operations.
This is not an uncommon malformation; reposurgeon takes it in stride,
treating these as though they had been real branch copies and
simplifying the backlinks appropriately.

  When reading a Subversion repository, reposurgeon also automatically
  breaks apart mixed-branch commits.

It has to.  These just can't be represented in the import-stream model of
branching.

  Because of the preceding two points, it is not guaranteed that 
  even revision numbers will be stable when a Subversion repository
  is read in and then written out!

So not only can Subversion repos fail to round-trip exactly, in the
presence of lots of branch copies and mixed-branch commits the
relationship between the read-in and written out revision numbers
could get pretty unpredictable.

  Subversion repositories are always written with a standard
  (trunk/tags/branches) layout. Thus, a repository with a nonstandard
  shape that has been analyzed by reposurgeon won't be written out with
  the same shape.

In particular, this means linear Subversion repositories with no trunk
(an organization some smaller projects used to use and might still)
will turn into branchy repos with trunk on the way out.

  Subversion has a concept of "flows"; that is, named segments of
  history corresponding to files or directories that are created when
  the path is added, cloned when the path is copied, and deleted when
  the path is deleted. This information is not preserved in import
  streams or the internal representation that reposurgeon uses.  Thus,
  after editing, the flow boundaries of a Subversion history may be
  arbitrarily changed.

This is me being obsessive about documenting the details.  I think it
is doubtful that most Subversion users even know flows exist.

  Bugs: Presently, writing out a history to a Subversion repository does
  not create mergeinfo properties representing branch merges. It also
  loses all information about lightweight tags (though annotated tags
  are turned into Subversion-style directory copies). These bugs will
  probably be fixed in future reposurgeon releases.

I'm also not sure the present code handles branchiness exactly right.  
My next task is to write a test suite for this new feature.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The Constitution is not neutral. It was designed to take the
government off the backs of the people.
	-- Justice William O. Douglas 
