From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/6] Add ref rename support to JGit
Date: Wed, 20 May 2009 15:16:51 -0700
Message-ID: <20090520221651.GR30527@spearce.org>
References: <20090507155117.GS30527@spearce.org> <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com> <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com> <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 21 00:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6u5r-0007mX-4L
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 00:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbZETWQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbZETWQu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 18:16:50 -0400
Received: from george.spearce.org ([209.20.77.23]:46356 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZETWQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 18:16:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6E13A381FD; Wed, 20 May 2009 22:16:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1242774798-23639-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119638>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Now refs can be renamed. The intent is that should be safe. Only the named
> refs and associated logs are updated. Any symbolic refs referring to the renames
> branches are unaffected, except HEAD.
...
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
> index a077051..2efa12d 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
> @@ -58,6 +58,24 @@ static void append(final RefUpdate u, final String msg) throws IOException {
>  		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
>  	}
>  
> +	static void renameTo(final Repository db, final RefUpdate from,
> +			final RefUpdate to) throws IOException {
> +		final File logdir = new File(db.getDirectory(), Constants.LOGS);
> +		final File reflogFrom = new File(logdir, from.getName());
> +		if (!reflogFrom.exists())
> +			return;
> +		final File reflogTo = new File(logdir, to.getName());
> +		final File refdirTo = reflogTo.getParentFile();
> +		if (!refdirTo.exists() && !refdirTo.mkdirs()) {
> +			throw new IOException("Cannot create directory " + refdirTo);
> +		}
> +		if (!reflogFrom.renameTo(reflogTo)) {

What happens if from = "refs/heads/a" and to = "refs/heads/a/b" ?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
> new file mode 100644
> index 0000000..4ea9cfa
> --- /dev/null
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
> @@ -0,0 +1,101 @@
> +package org.spearce.jgit.lib;

Copyright header?

> +
> +import java.io.File;
> +import java.io.IOException;
> +import java.util.ArrayList;
> +import java.util.List;
> +
> +import org.spearce.jgit.lib.RefUpdate.DeleteStore;
> +import org.spearce.jgit.lib.RefUpdate.Result;
> +import org.spearce.jgit.lib.RefUpdate.UpdateStore;
> +
> +/**
> + * A RefUpdate combination for renaming a ref
> + */
> +public class RefRename {
> +	private RefUpdate newToUpdate;
> +
> +	private RefUpdate oldFromDelete;
> +
> +	private Result renameResult;
> +
> +	RefRename(final RefUpdate toUpdate, final RefUpdate fromUpdate) {
> +		newToUpdate = toUpdate;
> +		oldFromDelete = fromUpdate;
> +	}
> +
> +	/**
> +	 * @return result of rename operation
> +	 */
> +	public Result getResult() {
> +		return renameResult;
> +	}
> +
> +	/**
> +	 * @return the result of the new ref update
> +	 * @throws IOException
> +	 */
> +	public Result rename() throws IOException {
> +		List<LockFile> lockFiles = new ArrayList<LockFile>();
> +		LockFile lockFileFrom = new LockFile(oldFromDelete.looseFile);
> +		LockFile lockFileTo = new LockFile(newToUpdate.looseFile);
> +		LockFile lockFileHEAD = new LockFile(new File(oldFromDelete.db
> +				.getRepository().getDirectory(), Constants.HEAD));
> +		lockFiles.add(lockFileTo);
> +		lockFiles.add(lockFileFrom);
> +		lockFiles.add(lockFileHEAD);
> +		try {
> +			for (LockFile l : lockFiles) {
> +				if (!l.lock()) {
> +					unlock(lockFiles);
> +					return Result.LOCK_FAILURE;
> +				}
> +			}
> +		} catch (RuntimeException e) {
> +			unlock(lockFiles);
> +			throw e;
> +		} catch (IOException e) {
> +			unlock(lockFiles);
> +			throw e;
> +		}
> +		boolean renameHEADtoo = oldFromDelete.db.readRef(Constants.HEAD)
> +				.getName().equals(oldFromDelete.getName());
> +		try {
> +			UpdateStore toStore = newToUpdate.newUpdateStore();
> +			RefLogWriter.renameTo(oldFromDelete.getRepository(), oldFromDelete,
> +					newToUpdate);
> +			newToUpdate.setNewObjectId(oldFromDelete.getOldObjectId());
> +			newToUpdate.setExpectedOldObjectId(oldFromDelete.getOldObjectId());

The dst ref can't expect its current value to be the src ref's
current value, the dst ref shouldn't exist, right?  So I'm not sure
how your code is working with this particular assignment occurring
in it.  Shouldn't the update store be failing over the compare on
expected old id?

I think we always want

  newToUpdate.setExpectedOldObjectId(ObjectId.zeroId())

as the JavaDoc for that method says zeroId should be used if the
ref isn't supposed to exist, which should be the case for the
destination side of a rename.

Ooooh.  I see.  Here UpdateStore is bypassing the CAS check, as
it runs inside of the RefUpdate.update() method, before the Store
instance is constructed.

Post taking the LockFile successfully we need to validate that

  ObjectId.zeroId().equals(db.idOf(newToUpdate.getName()))

is still true, otherwise it means someone else created the
destination ref and we're about to overwrite it.

> +			newToUpdate.setRefLogMessage("jgit branch: renamed "
> +					+ oldFromDelete.getName() + " to "
> +					+ oldFromDelete.getName(), false);

Typo, you meant newToUpdate here in the 2nd case.

-- 
Shawn.
