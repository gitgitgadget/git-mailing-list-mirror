From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] help needed to create a siimple commit
Date: Tue, 3 Feb 2009 07:51:07 -0800
Message-ID: <20090203155107.GU26880@spearce.org>
References: <551f769b0902030307s2a9204cch7967df17c1f2c8a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNZi-00073x-I6
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZBCPvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZBCPvJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:51:09 -0500
Received: from george.spearce.org ([209.20.77.23]:39221 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbZBCPvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:51:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D8A9F38210; Tue,  3 Feb 2009 15:51:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <551f769b0902030307s2a9204cch7967df17c1f2c8a6@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108203>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> I wrote the following unit test to learn how to make a commit
> with JGIT:
> 
> 	public void testASimpleCommit() throws IOException {
> 		
> 		GitIndex index = new GitIndex(db);
> 		index.filemode = Boolean.TRUE;
> 		
> 		File file;
> 		file = writeTrashFile("file1", "file1");
> 		
> 		index.add(trash, file);
> 		index.write();
> 		ObjectId objectId = index.writeTree();
> 		Tree tree = db.mapTree(objectId);
> 		tree.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
> 		
> 		final Commit c1 = new Commit(db);
> 		c1.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
> 		c1.setCommitter(new PersonIdent(jcommitter, 1154236443000L, -4 * 60));
> 		c1.setMessage("A Commit\n");
> 		c1.setTree(tree);
> 		assertEquals(tree.getTreeId(), c1.getTreeId());
> 		c1.commit();

You are missing the final step of updating the HEAD ref with the
commit.  Calling commit() on the Commit object only writes it to
the object database, this is similar to git-commit-tree.

Try adding on the end:

	RefUpdate ru = db.updateRef(Constants.HEAD);
	ru.setRefLogMessage("commit");
	ru.setNewObjectId(c1.getCommitId());
	assertSame(RefUpdate.Result.NEW, ru.update());

If your commit had parents, you might want to do instead:

	ru.setExpectedOldObjectId(oldHEAD);
	assertSame(RefUpdate.Result.FAST_FORWARD, ru.update());

where oldHEAD is the value of HEAD you read and used as the first
parent of the commit.  This ensures that the update method fails
if someone else has updated HEAD since you last read it.

The update method returns a number of different states, usually we
check its result with a switch statement as a number of states are
sometimes permissible in a context.  Sometimes though, you know it
has to be exactly one state, and everything else is a failure.

-- 
Shawn.
