From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/3] Add ref rename support to JGit
Date: Thu, 7 May 2009 08:51:17 -0700
Message-ID: <20090507155117.GS30527@spearce.org>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com> <1241652781-16873-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 07 17:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M25sf-0001Ce-BS
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 17:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759658AbZEGPvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 11:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759156AbZEGPvS
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 11:51:18 -0400
Received: from george.spearce.org ([209.20.77.23]:37615 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642AbZEGPvR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 11:51:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 90743381D0; Thu,  7 May 2009 15:51:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241652781-16873-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118488>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Now refs can be renamed. The intent is that should be safe. Only the named
> refs and associated logs are updated. Any symbolic refs referring to the renames
> branches are unaffected, except HEAD.

See below.  I'm not going to apply as-is, because its really quite
messy, as you stated in the cover letter...
 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> index 87f26bf..a73467a 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
> @@ -148,6 +149,25 @@ synchronized (this) {
>  	}
>  
>  	/**
> +	 * An set of update operations for renaming a ref
> +	 *
> +	 * @param fromRef Old ref name
> +	 * @param toRef New ref name
> +	 * @return a RefUpdate operation to rename a ref
> +	 * @throws IOException
> +	 */
> +	public RenameRefUpdates newRename(String fromRef, String toRef) throws IOException {

This class is not public; none of its methods are public; please
don't mark this public.

> +		refreshPackedRefs();
> +		Ref f = readRefBasic(fromRef, 0);
> +		Ref t = readRefBasic(toRef, 0);
> +		if (t != null)
> +			throw new IOException("Ref rename target exists: " + t.getName());
> +		RefUpdate refUpdateFrom = new RefUpdate(this, f, fileForRef(f.getName()));
> +		RefUpdate refUpdateTo = db.updateRef(toRef);

db.updateRef is just a redirection to this.newUpdate(), which scans
the refs (done above) and then makes a new RefUpdate instance.
Why not just reproduce the three lines that matter and avoid this
messy indirection?

  if (t == null)
    t = new Ref(Ref.Storage.NEW, name, null)
  RefUpdate refUpdateTo = new RefUpdate(this, t, fileForRef(t.getName()));

> @@ -484,8 +512,8 @@ private void lockAndWriteFile(File file, byte[] content) throws IOException {
>  	}
>  
>  	synchronized void removePackedRef(String name) throws IOException {
> -		packedRefs.remove(name);
> -		writePackedRefs();
> +		if (packedRefs.remove(name) != null)
> +			writePackedRefs();
>  	}

How did we get here when Ref.Storage.isPacked() == false?  IMHO this
shouldn't have been invoked if isPacked is false.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
> index a077051..bbf26eb 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
> @@ -58,6 +58,25 @@ static void append(final RefUpdate u, final String msg) throws IOException {
>  		appendOneRecord(oldId, newId, ident, msg, db, u.getName());
>  	}
>  
> +	static boolean renameTo(final Repository db, final RefUpdate from,
> +			final RefUpdate to) throws IOException {

Hmm, this method returns only true, or throws an IOException.
I wonder, why bother returning boolean?  Why not make it void?

> +		final File logdir = new File(db.getDirectory(), Constants.LOGS);
> +		final File reflogFrom = new File(logdir, from.getName());
> +		if (!reflogFrom.exists())
> +			return true;
> +		final File reflogTo = new File(logdir, to.getName());
> +		final File refdirTo = reflogTo.getParentFile();
> +		if (!refdirTo.exists() && !refdirTo.mkdirs()) {
> +			throw new IOException("Cannot create directory " + refdirTo);
> +		}
> +		if (!reflogFrom.renameTo(reflogTo)) {
> +			reflogTo.delete(); // try
> +			throw new IOException("Cannot rename " + reflogFrom + " to "
> +					+ reflogTo);

So if the rename fails, we delete the target and then throw an
exception anyway?  Why delete the target in this case?  I think we
should just fail here.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
> index a9ab73b..8ecccfe 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
> @@ -50,6 +50,100 @@
>   * Updates any locally stored ref.
>   */
>  public class RefUpdate {
> +	/**
> +	 * A RefUpdate combination for renaming a ref
> +	 */
> +	public static class RenameRefUpdates {

I would prefer this to be called "RefRename", and to make it a
top level class in the lib package, rather than a nested class
of RefUpdate.

> +		RenameRefUpdates(final RefUpdate toUpdate, final RefUpdate fromUpdate,
> +				final RefUpdate headUpdate) {
> +			newToUpdate = toUpdate;
> +			oldFromDelete = fromUpdate;

What happened to headUpdate?

> +		}
> +		private RefUpdate newToUpdate;
> +
> +		private RefUpdate oldFromDelete;
> +
> +		private Result renameResult;

Constructor after instance member field decls please.

> +		/**
> +		 * @return the result of the new ref update
> +		 * @throws IOException
> +		 */
> +		public Result rename() throws IOException {
> +			LockFile lockFileFrom = new LockFile(oldFromDelete.looseFile);
> +			boolean lockFrom = lockFileFrom.lock();
> +			if (!lockFrom)
> +				return Result.LOCK_FAILURE;
> +			LockFile lockFileTo = null;
> +			try {
> +				lockFileTo = new LockFile(newToUpdate.looseFile);
> +				boolean lockTo = lockFileTo.lock();
> +				if (!lockTo) {
> +					lockFileFrom.unlock();
> +					return renameResult = Result.LOCK_FAILURE;
> +				}
> +			} catch (IOException e) {
> +				lockFileFrom.unlock();
> +				throw e;
> +			}
> +			LockFile lockFileHEAD = new LockFile(new File(oldFromDelete.db.getRepository().getDirectory(), Constants.HEAD));
> +			boolean renameHEADtoo;
> +			try {
> +				boolean lockHEAD = lockFileHEAD.lock();
> +				renameHEADtoo = oldFromDelete.db.readRef(Constants.HEAD).getName().equals(oldFromDelete.getName());
> +				if (!renameHEADtoo)
> +					lockFileHEAD.unlock();
> +				else {
> +					if (!lockHEAD) {
> +						lockFileFrom.unlock();
> +						lockFileTo.unlock();
> +						return renameResult = Result.LOCK_FAILURE;
> +					}
> +				}
> +			} catch (IOException e) {
> +				lockFileHEAD.unlock();
> +				lockFileFrom.unlock();
> +				lockFileTo.unlock();

I wonder if this code would be easier to follow if we made a
Set<LockFile> as an instace member, and made some utility methods
like:

  private final Set<LockFile> allLocks = new HashSet<LockFile>();

  private boolean takeLock(final LockFile f) {
    if (f.lock()) {
      allLocks.add(f);
      return true;
    }
    return false;
  }

  private void unlock(final LockFile f) {
    f.unlock();
    allLocks.remove(f);
  }

  private void abort() {
    for (final LockFile f : allLocks)
      f.unlock();
  }

Then a lot of this local variable management code might simplify out.

Another approach might be to make LockFile a member of RefUpdate,
and allow the RefUpdate members for oldFromDelete and newToUpdate
to keep track of their associated LockFile for you.  This may clean
up the code related to constructing the store operation.

> +				throw e;
> +			}
> +			try {
> +				UpdateStore toStore = newToUpdate.newUpdateStore();
> +				if (RefLogWriter.renameTo(oldFromDelete.getRepository(), oldFromDelete, newToUpdate)) {
> +					newToUpdate.setNewObjectId(oldFromDelete.getOldObjectId());
> +					newToUpdate.setExpectedOldObjectId(oldFromDelete.getOldObjectId());
> +					newToUpdate.setRefLogMessage("jgit branch: renamed " + oldFromDelete.getName() + " to " + oldFromDelete.getName(), false);

I would prefer if the caller can set the prefix part of the reflog
message ("jgit branch" portion) so we can set it by command.

> +					newToUpdate.result = toStore.store(lockFileTo, Result.RENAMED);
> +					DeleteStore fromStore = oldFromDelete.newDeleteStore();
> +					Result store = fromStore.store(lockFileFrom, Result.RENAMED);
> +					if (renameHEADtoo) {
> +						final byte[] content = Constants.encode("ref: " + newToUpdate.getName() + "\n");
> +						lockFileHEAD.write(content);
> +						synchronized (this) {

What effect could "synchronized (this)" really have here, other
than to waste CPU cycles?  Who else could have a reference to this
RefRenames instance and be able to lock on it?

> @@ -478,6 +578,8 @@ else if (status == Result.FAST_FORWARD)
>  				msg += ": fast forward";
>  			else if (status == Result.NEW)
>  				msg += ": created";
> +			else if (status == Result.RENAMED)
> +				msg += ": renamed";
>  		}

I don't think this is useful.  We probably shouldn't append
status during a rename as the rename method had already done
setRefLogMessage("renamed A to B") earlier.  Doing status here
would yield "renamed A to B: renamed" in the reflog; ugly.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> index 5baa7a0..e704aeb 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -1067,4 +1083,21 @@ public void scanForRepoChanges() throws IOException {
>  		getAllRefs(); // This will look for changes to refs
>  		getIndex(); // This will detect changes in the index
>  	}
> +
> +	/**
> +	 * Writes a symref (e.g. HEAD) to disk
> +	 *
> +	 * @param name
> +	 *            symref name
> +	 * @param target
> +	 *            pointed to ref
> +	 * @throws IOException
> +	 */
> +	public void link(final String name, final String target) throws IOException {
> +		refs.link(name, target);
> +	}

Uhm, isn't this already called writeSymref() ?

> +	void uncacheSymRef(String name) {
> +		refs.uncacheSymRef(name);
> +	}

Why is this in Repository?

-- 
Shawn.
