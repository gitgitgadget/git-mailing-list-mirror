From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC] How read versions of a specific object
Date: Tue, 6 Jan 2009 20:04:17 -0800
Message-ID: <20090107040417.GA10790@spearce.org>
References: <7bfdc29a0901061944x454a9t1d01e6744f08cf78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 05:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKPfr-0008NA-Kp
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 05:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbZAGEET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 23:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZAGEET
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 23:04:19 -0500
Received: from george.spearce.org ([209.20.77.23]:51007 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbZAGEES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 23:04:18 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EB5A738210; Wed,  7 Jan 2009 04:04:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0901061944x454a9t1d01e6744f08cf78@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104752>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> I am trying to read all or n-th version of an object. Currently to do
> this I am using the following piece of code, which has to walk to
> every commit is present and from there prepare a set of its object id,
> it is definitely expensive if the commit history is huge, is there a
> faster/better way to achieve it?

Not really. You can more efficiently use JGit and reduce some of
the overheads, but that's about it.

> for (int i = 0; i < App.OBJECT_COUNT;
>             ++i) {
>             ObjectWalk objectWalk = new ObjectWalk(repo);

Don't use ObjectWalk, use a RevWalk.  You don't need it to keep
track of tree or blob identities.  The ObjectWalk code has more
overhead to do that bookkeeping.

>                     Commit revision = repo.mapCommit(revObject.getId());
>                     Tree versionTree = repo.mapTree(revision.getTreeId());
>                     if (versionTree.existsBlob(isbn)) {
>                         revisions.add(versionTree.findBlobMember(isbn).getId());

Use a TreeWalk to do this.  Its quicker because it doesn't
have to parse as much data to come up with the same result.

More specifically there's a static factory method that sets up for
a path limited walk and returns the TreeWalk pointing at that entry.

You can use the fact that RevWalk.next() returns a RevCommit to get
you the RevTree, which is the tree you need to give to the TreeWalk
constructor (its the root level tree of the commit).


But if App.OBJECT_COUNT is quite large and covers most of your
objects, you are probably better off using a loop over the commits
and diff'ing against the ancestor:

	final HashMap<String, Set<ObjectId>> versions = ...;
	final RevWalk rw = new RevWalk(repo);
	final TreeWalk tw = new TreeWalk(repo);
	rw.markStart(rw.parseCommit(repo.parse(HEAD)));
	tw.setFilter(TreeFilter.ANY_DIFF);

	RevCommit c;
	while ((c = rw.next()) != null) {
		final ObjectId[] p = new ObjectId[c.getParentCount() + 1];
		for (int i = 0; i < c.getParentCount(); i++) {
			rw.parse(c.getParent(i));
			p[i] = c.getParent(i).getTree();
		}
		final int me = p.length -1;
		p[me] = c.getTree();
		tw.reset(p);
		while (tw.next()) {
			if (tw.getFileMode(me).getObjectType() == Constants.OBJ_BLOB) {
				// This path was modified relative to the ancestor(s).
				//
				String s = tw.getPathString();
				Set<ObjectId> i = versions.get(s);
				if (i == null)
					versions.put(s, i = new HashSet<ObjectId>());
				i.add(tw.getObjectId(me));
			}

			if (tw.isSubtree()) {
				// make sure we recurse into modified directories
				tw.enterSubtree();
			}
		}
	}

-- 
Shawn.
