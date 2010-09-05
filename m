From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 01/15] README-sparse-clone: Add a basic writeup of my ideas for sparse clones
Date: Sat,  4 Sep 2010 18:13:53 -0600
Message-ID: <1283645647-1891-2-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2sE-00008z-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab0IEANF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52689 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab0IEAMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:12:52 -0400
Received: by pvg2 with SMTP id 2so1002177pvg.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LutHCAgpSal20rEuhnZXzXfBxgjrAmy1S8XfD/fatI0=;
        b=x8bdZINr9wIQykgU6AiERzeFUhUq2lhpPWtVmUL+Egmy/n+8Ne3DAlSYKu+ql2AEN2
         t9WQTxyIEJX9X4eTSXZxT5YGPtiipwCqluNOwF3froghslSFQ+eRBQIV+ciTx+zqsvGV
         15Fozqh+51iN2E0LEawRZ/tnWd65DH3uqWhkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pQ4I6NPfUKLWKBezU6a+l5rpWn9NoGgrY1acsCuAQnw0lhkFovlcedVto6D4vndk8c
         59jrHhqnbFwPxWZDKYRWSgHCpiS7KHI2rxs1+iBRLvnvZs2PR7yunaggLnffVMsjSWHa
         2XQJ1Jk3Xo5ok23n43naeBw4sRvYqOu+m4Iso=
Received: by 10.114.111.14 with SMTP id j14mr1263902wac.123.1283645571793;
        Sat, 04 Sep 2010 17:12:51 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.12.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:12:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155404>

This write-up just has basic ideas, strategies, notes of what needs to be
done, etc.  It needs to be pruned, cleaned up, corrected as I learn more,
moved elsewhere, etc.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 README-sparse-clone |  283 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 283 insertions(+), 0 deletions(-)
 create mode 100644 README-sparse-clone

diff --git a/README-sparse-clone b/README-sparse-clone
new file mode 100644
index 0000000..cfeeef3
--- /dev/null
+++ b/README-sparse-clone
@@ -0,0 +1,283 @@
+This is my set of notes on implementing sparse clones, which I define
+as a clone where not all blob, tree, or commit objects are downloaded.
+This includes sparseness both relative to span of directories and
+depth of history.
+
+(Note: This project has work-in-progress patches -- no promises about
+quality, speed of implementation, promises not to rebase, etc. etc.)
+
+*** Summary ***
+
+  Basic Idea:
+    0) Only relevant blobs, trees, and commits (+ ancestry) are downloaded.
+  User View:
+    U1) A user controls sparseness by passing rev-list arguments to clone.
+    U2) "Densifying" a sparse clone can be done (with new rev-list arguments)
+    U3) Cloning-from/fetching-from/pushing-to sparse clones is supported.
+    U4) Operations that need unavailable data simply error out
+    U5) Old style shallow clones (--depth argument to clone) are obsolete
+    U6) Miscellaneous notes
+  Internals:
+    I1) The limiting rev-list arguments passed to clone are stored.
+    I2) All revision-walking operations automatically use the limiting args.
+    I3) The index only contains paths matching the sparse limits
+    I4) Loading a missing commit results in a fake commit being created
+    I5) In sparse clones, a special merge strategy must be used
+    I6) Miscellaneous notes
+
+*** Basic Idea ***
+
+0) Only relevant blobs, trees, and commits (+ ancestry) are downloaded.
+
+Only the relevant blobs, trees, and commits are downloaded.
+Irrelevant blobs and trees are left out entirely (see items I2 & I3
+for how we avoid accessing these).
+
+To ensure minimum necessary connectivity, we also download basic
+information from otherwise excluded commits
+  * parents of these commits
+  * trees matching the specified sparse path(s)
+but, for security and space reasons, do not download
+  * author
+  * author date
+  * committer
+  * committer date
+  * log message
+Such commits are still considered "missing" (see item I4 for more
+details about how we handle "missing" commits).
+
+Tags/branches are downloaded if specified (or, if no branch/tag is
+specified, all tags/branches are downloaded).
+
+Security note: No modifications are done to existing trees, meaning
+that sparse clones will download the name of "irrelevant" blobs/trees
+with their type, mode, and sha1sum if (and only if) such blobs/trees
+are siblings of a relevant blob/tree.  It is assumed that such
+information is okay to be transmitted and need not remain private; if
+such information does need to remain private, an alternate mechanism
+involving rewriting commits will be necessary (such as git-subtree).
+
+*** User View ***
+
+U1) A user controls sparseness by passing rev-list arguments to clone.
+
+This allows a user to control sparseness both in terms of span of
+content (files/directories) and depth of history.  It can also be used
+to limit to a subset of refs (cloning just one or two branches instead
+of all branches and tags).  For example,
+  $ git clone ssh://repo.git dst -- Documentation/
+  $ git clone ssh://repo.git dst master~6..master
+  $ git clone ssh://repo.git dst -3
+(Note that the destination argument becomes mandatory for those doing
+a sparse clone in order to disambiguate it from rev-list options.)
+
+This method also means users don't need much training to learn how to
+use sparse clones -- they just use syntax they've already learned with
+log, and clone will pass this info on to upload-pack.
+
+There is a difference due to inclusive revision specifications
+(master, master~6, v4.15.6) vs. exclusive ones (-3, ^master,
+^master~6).  Inclusive revisions must be branch or tag names
+(e.g. stable or v1.8, but not master~6 or v4.18.2~1 or sha1sum or
+:/<search string>)[1].  "HEAD --all"
+are assumed if no inclusive revisions are specified.  (Note: Avery
+seems to suggest always assuming "HEAD --all", at least at first.)
+
+[1] This limitation on inclusive revisions could be relaxed in the
+future for specifications derived from branch names, as long as each
+branch has no more than one associated derived revision specification.
+For example, master~6 would mean to clone a copy of the master branch
+on the remote side, excluding the last 6 commits, so that you start
+out "6 commits behind" the remote.  Obviously, it wouldn't make sense
+to have both "master^1" and "master^2" specified, since we then
+wouldn't know where master should point in the clone.
+
+U2) "Densifying" a sparse clone can be done (with new rev-list arguments)
+
+One can fetch a new pack, replace the original limiting rev-list args
+with the new choice (see item I1), and update the working copy to
+reflect the changes.  As users wouldn't expect a "fetch" or a "merge"
+to un-sparsify a checkout, there's a special operation for performing
+all three operations.
+
+[First cut will be to just redownload everything, instead of just the
+necessary data.  I'm thinking it won't be a common operation, and it
+could always be improved later.]
+
+U3) Cloning-from/fetching-from/pushing-to sparse clones is supported.
+
+This allows people who need to operate on a subset of the repository
+(e.g. translators, technical writers, etc.) to collaborate on that
+subset.  I think one simple rule should enable this:
+
+  * The receiving repository specifies the limiting rev-list arguments
+    to use (if the sending repository does not have the relevant data,
+    it will naturally error out)
+
+By having the receving side specify the limiting rev-list arguments,
+it ensures that any data it receives fulfills its needs.  The sending
+side then uses this information when creating a pack to determine the
+necessary objects to send, ignoring anything outside the paths/ranges
+specified in those limits.  If the sending side is a sparse clone that
+does not have the necessary data specified by the receiver, then
+pack-objects will hit a nasty low-level missing object error, aborting
+the operation.  In the future, we could maybe add a nicer error
+message.
+
+One special case:
+  * When cloning a repository, if the user did not specify any
+    limiting rev-list arguments, use those from the repository being
+    cloned.  (Don't require the user to type out all the paths every
+    time; e.g. 'git clone URL DEST -- PATH1 PATH2 PATH3 PATH4...')
+
+U4) Operations that need unavailable data simply error out
+
+Although no normal git command should be disabled entirely, there will
+be cases when some git commands cannot function without more data.
+
+Examples:
+  * merge, cherry-pick, rebase (if unavailable files needed)
+  * upload-pack (if more data requested than available in a sparse clone)
+
+Merge, cherry-pick, and rebase deserve special consideration to
+operate in sparse clones (see item I5), since merge strategies
+normally require full trees.
+
+U5) Old style shallow clones (--depth argument to clone) are obsolete
+
+Since one can pass "-3" to get a "shallow" clone, old-style shallow
+clones are obsolete.  New style shallow/sparse clones will also be
+more capable, since one can
+  * exclude based on commit (e.g. ^master~10) in addition to depth
+  * clone/push/pull from/to shallow clones
+
+What to do with old style shallow clones?  Probably deprecate them,
+make the --depth argument to clone print an error message suggesting
+the new syntax, and then gut the related code at some point in the
+future.
+
+U6) Miscellaneous notes
+  * fsck & status should print a notice when working on a sparse clone
+  * paths in limiting rev-list args *must* follow '--' (current or
+    future remote repo may be bare, meaning setup_revisions will
+    complain about nonexistent paths specified without a preceding
+    '--').  Having all paths folow a '--' will also make it easier to
+    find them and pass them on to diff machinery (see item I2).
+  * notes hierarchy may also need to be made sparse in a way that only
+    notes pointing downloaded objects should be downloaded.  This
+    implies missing blobs/trees, and maybe even "missing" commits.
+    But how do I avoid traversing the wrong notes on the client side?
+    Ouch.  Maybe just include all notes?  Or exclude all notes?
+
+*** Internals ***
+
+I1) The limiting rev-list arguments passed to clone are stored.
+
+However, relative arguments such as "-3" or "^master~6" first need to
+be translated into one or more exclude ranges written as "^<sha1>".
+
+I2) All revision-walking operations automatically use the limiting args.
+
+This should be a simple code change, and would enable rev-list, log,
+diff (which also uses the revision walking machinery), etc. to avoid
+missing blobs/trees/commits and thus enable them to work with sparse
+clones.  fsck would take a bit more work, since it doesn't use the
+setup_revisions() and revision.h walking machinery, but shouldn't be
+too bad (I hope).
+
+Also, the pathspecs (or the diff options they generate) are available
+easily for operations that need them (see I3).
+
+I3) The index only contains paths matching the sparse limits
+
+Since not all trees are downloaded, not all files can even be
+referenced in the index.  Further, in some cases, the only thing that
+can be referenced is a tree rather than a file.  We only want paths
+matching the relevant sparse limits to be included in the index.  This
+means two things:
+  * When extracting entries from trees into the index, the sparse limits
+    need to be taken into consideration
+  * Whenever writing trees, using the index is no longer sufficient.
+    Instead, the files in the index are used to record
+    sha1sums/modes/filenames for paths within the sparse limits, and
+    another tree (typically from HEAD) is used to record
+    sha1sums/modes/filenames/types for paths outside the sparse
+    limits.
+
+Note that writing trees from the index can occur with commit, merge,
+checkout (-m), revert/cherry-pick --no-commit, and write-tree.  All
+need to be updated to either provide a relevant tree or error out when
+run from a sparse clone.
+
+I4) Loading a missing commit results in a fake commit being created
+
+Fake commits have correct parentage and an appropriate (sparse) tree
+(since those pieces of information are available), but blank author &
+committer, 0 for times & timezones, and a commit log message such as
+the following:
+  This commit is missing from this sparse clone.  You can use the
+  densify command to download missing commits and files.
+
+This allows the following to work:
+  * git commit (which needs tree/file sha1sums that were not modified,
+    though if a given tree is unmodified, no subtree/subfile sha1s are
+    needed)
+  * tags & branches (which can correctly point at missing commits)
+  * git show (with a branch/tag/commit)
+  * git prune (missing objects correctly reference their parent(s))
+  * git fsck (missing commits still referenced)
+
+Extra notes:
+  * Stored in a file using multiple lines of: <commit> <tree> <parent1> ...
+  * Only referenced when git would otherwise die
+
+I5) In sparse clones, a special merge strategy must be used
+
+Most merge strategies work at the file/content level.  Since many
+files and even whole trees will be unavailable, a special strategy
+that works with tree-level items is necessary.  It should only perform
+trivial merges when forced to operate at the tree-level (modified on
+at most one side of history, and probably no rename handling at least
+at first).  When such trivial merges are not possible, it should fail
+with a helpful error message noting the needed tree contents.
+
+For non-missing blobs, standard merge strategies may be used.
+
+I6) Miscellaneous notes
+  * thin-packs: git pack-objects needs to be told to only delta
+    against objects that match the sparse limits, otherwise the
+    receiving side will not be able to use the resulting pack.
+
+----------------------------------------------------------------------
+
+Testcases needed:
+  * basics:        checkout, status, diff, log (w/ options!), add, commit
+  * extras:        blame, apply, bisect, branch, tag, grep, reset
+  * maintainence:  fsck, prune, gc/repack, verify-pack
+  * plumbing:      {read,write,ls,commit,merge,tar,diff}-tree, mktree
+  * direct:        cat-file, show (esp. missing obj. or tag/branch of such)
+  * merge strat.:  merge, cherry-pick/revert, rebase
+  * communication: pull, push, fetch, clone, bundle, archive
+  * protocols:     http, ssh, git, rsync
+  * rewrite:       filter-branch, fast-{export, import}
+  * notes:         ?
+
+  General:
+    'clone NON-BARE-REPO dst PATHS' should fail (needs double dash)!
+    git rev-list master should show subset of available commits
+  Keep Index sparse:
+    git add <path> for <path> not in git_sparse_pathspec should error out
+    update-index on <path> not in git_sparse_pathspec should error out
+  Sparse Index Handling:
+    merge into branch yet to be born, revert
+    checkout -m  (to real branch, from valid or yet-to-be born branch)
+
+  Major TODOs:
+    * fetch
+    * push
+    * don't pass revlist arguments on command line to upload pack; use protocol
+    * densify command
+    * missing commits
+    * fix thin packs to only delta against objects within sparse limits
+    * lots more testcases
+    * cleanup FIXMEs
-- 
1.7.2.2.140.gd06af
