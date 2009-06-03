From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 08/10] Add ref rename support to JGit
Date: Wed, 3 Jun 2009 09:43:30 -0700
Message-ID: <20090603164330.GI3355@spearce.org>
References: <20090520221651.GR30527@spearce.org> <1243462137-24133-1-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-2-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-3-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-4-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-5-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-6-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-7-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-8-git-send-email-robin.rosenberg@dewire.com> <1243462137-24133-9-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBtYx-0003K7-Hm
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 18:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbZFCQna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbZFCQn3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 12:43:29 -0400
Received: from george.spearce.org ([209.20.77.23]:51402 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbZFCQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 12:43:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F3B79381D1; Wed,  3 Jun 2009 16:43:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1243462137-24133-9-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120619>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Now refs can be renamed. The intent is that should be safe. Only the named
> refs and associated logs are updated. Any symbolic refs referring to the renames
> branches are unaffected, except HEAD, which is updated if the branch it refers
> to is being renamed.
...
> +//	public void testRenameBranchCannotLockAFileHEADisToLockHead() throws IOException {
> +//		an example following the rename failure pattern, but this one is ok!
> +//		tryRenameWhenLocked("HEAD", "refs/heads/b", "refs/heads/new/name",
> +//				"refs/heads/new/name");
> +//	}

Commented out test case?  Eh?

> +//	public void testRenameBranchCannotLockAFileHEADisOtherLockHead() throws IOException {
> +//		an example following the rename failure pattern, but this one is ok!
> +//		tryRenameWhenLocked("HEAD", "refs/heads/b", "refs/heads/new/name",
> +//				"refs/heads/a");
> +//	}

Ditto.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
...
> +	RefRename newRename(String fromRef, String toRef) throws IOException {
> +		refreshPackedRefs();
> +		Ref f = readRefBasic(fromRef, 0);
> +		Ref t = readRefBasic(toRef, 0);
> +		if (t != null)
> +			throw new IOException("Ref rename target exists: " + t.getName());

NAK, I'd prefer to have the RefRename return successfully,
but when we try to execute it, it has a result that fails with
RefUpdate.REJECTED.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
...
> +	static void renameTo(final Repository db, final RefUpdate from,
> +			final RefUpdate to) throws IOException {
> +		final File logdir = new File(db.getDirectory(), Constants.LOGS);
> +		final File reflogFrom = new File(logdir, from.getName());
> +		if (!reflogFrom.exists())
> +			return;
> +		final File reflogTo = new File(logdir, to.getName());
> +		final File reflogToDir = reflogTo.getParentFile();
> +		File tmp = new File(logdir,"tmp-renamed-log");
> +		tmp.delete(); // if any exists

That's not thread safe.  Most of the rest of JGit is actually
thread safe.  I think we should be here too.  We should use
a temporary file name inside logdir, one that isn't a legal
ref name at all.  Maybe:

  File tmp = File.createTempFile("tmp..renamed", "-log", logdir);
  if (!reflogFrom.renameTo(tmp)) {
    tmp.delete();
    if (!reflogFrom.renameTo(tmp))
      throw new IOException....
  }

> +		if (!reflogToDir.exists() && !reflogToDir.mkdirs()) {
> +			throw new IOException("Cannot create directory " + reflogToDir);
> +		}
> +		if (!tmp.renameTo(reflogTo)) {
> +			throw new IOException("Cannot rename (" + tmp + ")" + reflogFrom
> +					+ " to " + reflogTo);
> +		}

If we fail here, should we attempt to put the tmp log file back
into the old name?  Or leave it orphaned under the tmp file?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
...
> +	public Result rename() throws IOException {
> +		Ref oldRef = oldFromDelete.db.readRef(Constants.HEAD);
> +		boolean renameHEADtoo = oldRef != null
> +				&& oldRef.getName().equals(oldFromDelete.getName());
> +		try {
> +			Repository db = oldFromDelete.getRepository();

Style nit: Hoist to top of method, so oldRef init can use it.

> +			RefLogWriter.renameTo(db, oldFromDelete,
> +					newToUpdate);

Style nit: This fits on one line.

> +			newToUpdate.setRefLogMessage(null, false);
> +			RefUpdate tmpUpdateRef = oldFromDelete.db.getRepository().updateRef(
> +					"RENAMED-REF");

Like the log, this isn't thread safe.

> +			if (renameHEADtoo) {
> +				try {
> +					oldFromDelete.db.link(Constants.HEAD, "RENAMED-REF");
> +				} catch (IOException e) {
> +					RefLogWriter.renameTo(db,
> +							newToUpdate, oldFromDelete);
> +					return renameResult = Result.LOCK_FAILURE;
> +				}
> +			}
> +			tmpUpdateRef.setNewObjectId(oldFromDelete.getOldObjectId());

We should also do:

  oldFromDelete.setExpectedOldObjectId(oldFromDelete.getOldObjectId())

so that if the old ref was modified between the time we read it
and the time we delete it, we fail on the delete, and don't whack
a ref that was modified by another thread.

> +			RefLogWriter.append(this, "jgit branch: renamed "

I think this should just be "renamed: $old to $new".

> +					+ db.shortenRefName(oldFromDelete.getName()) + " to "
> +					+ db.shortenRefName(newToUpdate.getName()));
> +			return renameResult = Result.RENAMED;
> +		} catch (RuntimeException e) {
> +			throw e;

What's the point of this catch block?

> +		} catch (IOException e) {
> +			System.err.println(e);

Please don't print to System.err from such a low level method.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
...
> +		/**
> +		 * The ref was renamed from another name
> +		 * <p>
> +		 */
> +		RENAMED

Is a new state really necessary?  Can't we use NEW on success?
After all, the dst is now created.

>  	}
>  
>  	/** Repository the ref is stored in. */
> -	private final RefDatabase db;
> +	final RefDatabase db;

I wonder if this shouldn't just be a public accessor method; we expose
getRepository() on other application visible objects like RevWalk.
  
>  	/** Location of the loose file holding the value of this ref. */
> -	private final File looseFile;
> +	final File looseFile;

I don't see this used outside of the class, is it still necessary?

>  	/** Result of the update operation. */
> -	private Result result = Result.NOT_ATTEMPTED;
> +	Result result = Result.NOT_ATTEMPTED;

Ditto.
  
> +	static void deleteEmptyDir(File dir, int depth) {
> +		for (; depth > 0 && dir != null; depth--) {
> +			if (dir.exists() && !dir.delete())

Why bother with a stat() call, just to do an rmdir()?

> -	private static int count(final String s, final char c) {
> +	static int count(final String s, final char c) {

Since all callers pass '/', maybe we should just change this to
use '/' as a constant in the loop and remove the char c parameter?
I think that would fix the nasty line wrapping in RefLogWriter too.

-- 
Shawn.
