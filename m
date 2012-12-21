From: Jeff King <peff@peff.net>
Subject: [PATCH] refs: do not use cached refs in repack_without_ref
Date: Fri, 21 Dec 2012 03:04:49 -0500
Message-ID: <20121221080449.GA21741@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 09:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlxbd-00053U-2i
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 09:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab2LUIEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 03:04:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60499 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab2LUIEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 03:04:51 -0500
Received: (qmail 20696 invoked by uid 107); 21 Dec 2012 08:05:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Dec 2012 03:05:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Dec 2012 03:04:49 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211956>

When we delete a ref that is packed, we rewrite the whole
packed-refs file and simply omit the ref that no longer
exists. However, we base the rewrite on whatever happens to
be in our refs cache, not what is necessarily on disk. That
opens us up to a race condition if another process is
simultaneously packing the refs, as we will overwrite their
newly-made pack-refs file with our potentially stale data,
losing commits.

You can demonstrate the race like this:

  # setup some repositories
  git init --bare parent &&
  (cd parent && git config core.logallrefupdates true) &&
  git clone parent child &&
  (cd child && git commit --allow-empty -m base)

  # in one terminal, repack the refs repeatedly
  cd parent &&
  while true; do
	git pack-refs --all
  done

  # in another terminal, simultaneously push updates to
  # master, and create and delete an unrelated ref
  cd child &&
  while true; do
	git push origin HEAD:newbranch &&
	git commit --allow-empty -m foo
	us=`git rev-parse master` &&
	git push origin master &&
	git push origin :newbranch &&
	them=`git --git-dir=../parent rev-parse master` &&
	if test "$them" != "$us"; then
		echo >&2 "$them" != "$us"
		exit 1
	fi
  done

In many cases the two processes will conflict over locking
the packed-refs file, and the deletion of newbranch will
simply fail.  But eventually you will hit the race, which
happens like this:

  1. We push a new commit to master. It is already packed
     (from the looping pack-refs call). We write the new
     value (let us call it B) to $GIT_DIR/refs/heads/master,
     but the old value (call it A) remains in the
     packed-refs file.

  2. We push the deletion of newbranch, spawning a
     receive-pack process. Receive-pack advertises all refs
     to the client, causing it to iterate over each ref; it
     caches the packed refs in memory, which points at the
     stale value A.

  3. Meanwhile, a separate pack-refs process is running. It
     runs to completion, updating the packed-refs file to
     point master at B, and deleting $GIT_DIR/refs/heads/master
     which also pointed at B.

  4. Back in the receive-pack process, we get the
     instruction to delete :newbranch. We take a lock on
     packed-refs (which works, as the other pack-refs
     process has already finished). We then rewrite the
     contents using the cached refs, which contain the stale
     value A.

The resulting packed-refs file points master once again at
A. The loose ref which would override it to point at B was
deleted (rightfully) in step 3. As a result, master now
points at A. The only trace that B ever existed in the
parent is in the reflog: the final entry will show master
moving from A to B, even though the ref still points at A
(so you can detect this race after the fact, because the
next reflog entry will move from A to C).

We can fix this by invalidating the packed-refs cache after
we have taken the lock. This means that we will re-read the
packed-refs file, and since we have the lock, we will be
sure that what we read will be atomically up-to-date when we
write (it may be out of date with respect to loose refs, but
that is OK, as loose refs take precedence).

Signed-off-by: Jeff King <peff@peff.net>
---
We actually see this in practice on GitHub, though it is relatively
rare (I've been chasing reports for a while, and in a very busy repo, it
can happen every couple of weeks; this is probably due to the fact that
we run "git gc" very frequently).

There are a few other interesting races in this code that this does not
fix:

  1. We check to see whether the ref is packed based on the cached data.
     That means that in the following sequence:

       a. receive-pack starts, caches packed refs; master is not packed

       b. meanwhile, pack-refs runs and packs master

       c. receive-pack deletes the loose ref for master (which might be
          a no-op if the pack-refs from (b) got there first). It checks
          its cached packed-refs and sees that there is nothing to
          delete.

     We end up leaving the entry in packed-refs. In other words, the
     deletion does not actually delete anything, but it still returns
     success.

     We could fix this by scanning the list of packed refs only after
     we've acquired the lock. The downside is that this would increase
     lock contention on packed-refs.lock. Right now, two deletions may
     conflict if they are deletions of packed refs. With this change,
     any two deletions might conflict, packed or not.

     If we work under the assumption that deletions are relatively rare,
     this is probably OK. And if you tend to keep your refs packed, it
     would not make any difference. It would have an impact on repos
     which do not pack refs, and which have frequent simultaneous
     deletions.

  2. The delete_ref function first deletes the loose ref, then rewrites
     the packed-refs file. This means that for a moment, the ref may
     appear to have rewound to whatever was in the packed-refs file, and
     the reader has no way of knowing.

     This is not a huge deal, but I think it could be fixed by swapping
     the ordering. However, I think that would open us up to the reverse
     race from above: we delete from packed-refs, then before we delete
     the loose ref, a pack-refs process repacks it. Our deletion looks
     successful, but the ref remains afterwards.

I fixed just the race I did because it does not (as far as I can tell)
have any downsides. And it is way more severe (the other ones are "a
deleted ref might come back", whereas the fixed one will actually lose
commits).

 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6cec1c8..541fec2 100644
--- a/refs.c
+++ b/refs.c
@@ -1744,7 +1744,8 @@ static int repack_without_ref(const char *refname)
 static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
-	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
+	struct ref_cache *refs = get_ref_cache(NULL);
+	struct ref_dir *packed = get_packed_refs(refs);
 	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
@@ -1753,6 +1754,8 @@ static int repack_without_ref(const char *refname)
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
 	}
+	clear_packed_ref_cache(refs);
+	packed = get_packed_refs(refs);
 	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
 	return commit_lock_file(&packlock);
 }
-- 
1.8.1.rc2.6.g05591da
