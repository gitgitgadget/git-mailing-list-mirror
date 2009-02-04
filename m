From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] help needed to create a siimple commit
Date: Wed, 4 Feb 2009 09:07:29 -0800
Message-ID: <20090204170729.GB26880@spearce.org>
References: <551f769b0902030307s2a9204cch7967df17c1f2c8a6@mail.gmail.com> <20090203155107.GU26880@spearce.org> <551f769b0902040810o6b45008fgcc1ef70108b3d90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlFC-0001Sb-3t
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbZBDRHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbZBDRHb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:07:31 -0500
Received: from george.spearce.org ([209.20.77.23]:47385 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbZBDRHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:07:30 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1A31A38210; Wed,  4 Feb 2009 17:07:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <551f769b0902040810o6b45008fgcc1ef70108b3d90@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108395>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> 		final Commit commit = new Commit(db);
> 		commit.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
> 		commit.setCommitter(new PersonIdent(jcommitter, 1154236443000L, -4 * 60));
> 		commit.setMessage(commitMessage);
> 		commit.setTree(tree);

FWIW, its faster to use setTreeId().  Then you don't need to use
mapTree to read the tree object into memory.  This is an older area
of the Commit class API, before we understood how important it was
to avoid processing unnecessary data.  :-)

> 		assertEquals(tree.getTreeId(), commit.getTreeId());
> 		commit.commit();
> 		
> 		ObjectWriter writer = new ObjectWriter(db);
> 		commit.setCommitId(writer.writeCommit(commit));

Uh, commit.commit() is doing the same work as the above two lines,
so these above two lines are a no-op as the object already exists
in the object database.
 
> 		Ref oldHEAD = db.getAllRefs().get(Constants.HEAD);
> 		final RefUpdate ru = db.updateRef(Constants.HEAD);
> 		ru.setNewObjectId(commit.getCommitId());
> 		ru.setRefLogMessage(commitMessage, false);
> 
> 		if (oldHEAD != null) {
> 			// commit has parents
> 			ru.setExpectedOldObjectId(oldHEAD.getObjectId());
> 			assertSame(RefUpdate.Result.FAST_FORWARD, ru.update());

This fails because the commit has no parents, but you asked
for a fast-forward update.  Since HEAD already has a commit,
and the new commit isn't a super-set of the existing HEAD, and
RefUpdate.isForceUpdate() is false, the update is being rejected.

If you really mean to replace the commit, e.g. commit --amend,
you need to ru.setForceUpdate(true).

If you really mean to fast-forward the commit, e.g. just make
a new commit on top of the existing commits, you need to do
the read to get oldHEAD *before* you call commit.commit()
above, and use:

  commit.setParents(new Object[]{ oldHEAD.getObjectId() })

to set the current commit as the first parent of the new commit,
so the new commit is really a superset of the old one.

Again, back to the basic DAG in Git... JGit is just a library with
the building blocks necessary to manipulate the DAG.  Its up to
the appliction to create the new nodes correctly for its needs,
and to make the right requests to RefUpdate.  The RefUpdate API is
designed to help the application enforce CAS semantics, to avoid
race conditions and other ugly surprises.

-- 
Shawn.
