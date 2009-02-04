From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [JGIT] help needed to create a siimple commit
Date: Wed, 4 Feb 2009 17:10:48 +0100
Message-ID: <551f769b0902040810o6b45008fgcc1ef70108b3d90@mail.gmail.com>
References: <551f769b0902030307s2a9204cch7967df17c1f2c8a6@mail.gmail.com>
	 <20090203155107.GU26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 17:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkMM-0001i0-7t
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbZBDQKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755006AbZBDQKw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:10:52 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:44300 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbZBDQKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:10:50 -0500
Received: by fxm13 with SMTP id 13so3187557fxm.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6C4C+CXrqyRWIWBeKV8oQS6CjyVWYbtdr/zC6QUo88M=;
        b=ojAHZNdOBvXr43BVI8YW5bGFYUShUzWUJnUcCKZII3xp6+wgsluTpF+2xqUfZXaA2b
         ZFVqlFQ2JE8IaJszZyL6vz1wVmA+2z3tb/n+sww/ciskRwXyMR95TFtCu9ZMlYdDuWU0
         Rl7OUahydmoSSwU2MK4ot/5ye+hk4645cqGiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cC5UBGKG/O479fmqTaOnJV2jiYaeBdAFuFkaGU+fXqHCyoKZI+3xPDV4aCMhn5oblg
         xoSdXCqv/kipAGQwhAcfXaOSbGBT+flk31+0SitZlG2wnxsjsRTxfUXPTOcf0ejlBQNI
         47s7tL+jA7BqIFgWmI+OvLNMiDsGcg5vZIP4k=
Received: by 10.181.153.12 with SMTP id f12mr516741bko.132.1233763848691; Wed, 
	04 Feb 2009 08:10:48 -0800 (PST)
In-Reply-To: <20090203155107.GU26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108389>

2009/2/3 Shawn O. Pearce <spearce@spearce.org>:
> You are missing the final step of updating the HEAD ref with the
> commit.  Calling commit() on the Commit object only writes it to
> the object database, this is similar to git-commit-tree.
>
> Try adding on the end:
>
>        RefUpdate ru = db.updateRef(Constants.HEAD);
>        ru.setRefLogMessage("commit");
>        ru.setNewObjectId(c1.getCommitId());
>        assertSame(RefUpdate.Result.NEW, ru.update());
>
> If your commit had parents, you might want to do instead:
>
>        ru.setExpectedOldObjectId(oldHEAD);
>        assertSame(RefUpdate.Result.FAST_FORWARD, ru.update());
>
> where oldHEAD is the value of HEAD you read and used as the first
> parent of the commit.  This ensures that the update method fails
> if someone else has updated HEAD since you last read it.
>
> The update method returns a number of different states, usually we
> check its result with a switch statement as a number of states are
> sometimes permissible in a context.  Sometimes though, you know it
> has to be exactly one state, and everything else is a failure.
>
I updated my simple test like this:

package org.spearce.jgit.lib;

import java.io.File;
import java.io.IOException;

public class CommitTest extends RepositoryTestCase {

	public void testASimpleCommit() throws IOException {
		
		recursiveDelete(trash_git, false, null, true);
		db = new Repository(trash_git);
		db.create();

		GitIndex index = new GitIndex(db);
		index.filemode = Boolean.TRUE;
		
		commitIndex(index, "commit 1");

		File file1 = writeTrashFile("file1", "file1");
		index.add(trash, file1);
		
		commitIndex(index, "commit 2");

	}
	
	private void commitIndex(GitIndex index, String commitMessage) throws
IOException {
		index.write();
		ObjectId objectId = index.writeTree();
		Tree tree = db.mapTree(objectId);
		final Commit commit = new Commit(db);
		commit.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
		commit.setCommitter(new PersonIdent(jcommitter, 1154236443000L, -4 * 60));
		commit.setMessage(commitMessage);
		commit.setTree(tree);
		assertEquals(tree.getTreeId(), commit.getTreeId());
		commit.commit();
		
		ObjectWriter writer = new ObjectWriter(db);
		commit.setCommitId(writer.writeCommit(commit));

		Ref oldHEAD = db.getAllRefs().get(Constants.HEAD);
		final RefUpdate ru = db.updateRef(Constants.HEAD);
		ru.setNewObjectId(commit.getCommitId());
		ru.setRefLogMessage(commitMessage, false);

		if (oldHEAD != null) {
			// commit has parents
			ru.setExpectedOldObjectId(oldHEAD.getObjectId());
			assertSame(RefUpdate.Result.FAST_FORWARD, ru.update());
		} else {
			// commit has no parents
			assertSame(RefUpdate.Result.NEW, ru.update());
		}
		

	}
}

The first commit "with an empty workspace" is ok. I can see the commit
in the log.
The second commit fails, with ru.update() = REJECTED.

I tried different combination, without success.

If someone could tell me, what I am doing wrong...

Yann
