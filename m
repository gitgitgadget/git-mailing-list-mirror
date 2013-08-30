From: Jeff King <peff@peff.net>
Subject: [PATCHv2] has_sha1_file: re-check pack directory before giving up
Date: Fri, 30 Aug 2013 15:14:13 -0400
Message-ID: <20130830191412.GA15584@sigill.intra.peff.net>
References: <20130830011052.GA21895@sigill.intra.peff.net>
 <20130830042801.GA23780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 21:14:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFU9F-0008GT-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 21:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab3H3TOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 15:14:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:48698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173Ab3H3TOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 15:14:16 -0400
Received: (qmail 11582 invoked by uid 102); 30 Aug 2013 19:14:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Aug 2013 14:14:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Aug 2013 15:14:13 -0400
Content-Disposition: inline
In-Reply-To: <20130830042801.GA23780@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233463>

On Fri, Aug 30, 2013 at 12:28:01AM -0400, Jeff King wrote:

> On Thu, Aug 29, 2013 at 09:10:52PM -0400, Jeff King wrote:
> 
> > In the case of git-fsck, which uses the
> > DO_FOR_EACH_INCLUDE_BROKEN flag, this will cause us to
> > erroneously complain that the ref points to an invalid
> > object. But for git-repack, which does not use that flag, we
> > will skip the ref completely!
> 
> Hmm. This is slightly inaccurate. fsck does not use INCLUDE_BROKEN, and
> that is why it recognizes (and prints the warning) the "broken" ref.
> pack-objects would also print a warning, but would dutifully ignore the
> broken ref during the repack.
> 
> So it is actually something like for-each-ref, which _does_ use
> INCLUDE_BROKEN, that behaves differently. And it tends to work, because
> it ends up calling read_sha1_file to find out about the file rather than
> checking has_sha1_file.

Here's a re-roll with a commit message that clarifies the role of
DO_FOR_EACH_INCLUDE_BROKEN. The code is the same, and the diff between
the commit messages is below.

	@@ -34,18 +34,17 @@
	     ref is broken. If has_sha1_file returns the wrong answer, we
	     erroneously will think that the ref is broken.
	     
	-    In the case of git-fsck, which uses the
	-    DO_FOR_EACH_INCLUDE_BROKEN flag, this will cause us to
	-    erroneously complain that the ref points to an invalid
	-    object. But for git-repack, which does not use that flag, we
	-    will skip the ref completely! So not only will we fail to
	-    process the new objects that the ref points to (which is
	-    acceptabale, since the processes are running simultaneously,
	-    and we might well do our whole repack before the other
	-    process updates the ref), but we will not see the ref at
	-    all. Its old objects may be omitted from the pack (and even
	-    lost, if --unpack-unreachable is used with an expiration
	-    time).
	+    For a normal iteration without DO_FOR_EACH_INCLUDE_BROKEN,
	+    this means that the caller does not see the ref at all
	+    (neither the old nor the new value).  So not only will we
	+    fail to see the new value of the ref (which is acceptable,
	+    since we are running simultaneously with the writer, and we
	+    might well read the ref before the writer commits its
	+    write), but we will not see the old value either. For
	+    programs that act on reachability like pack-objects or
	+    prune, this can cause data loss, as we may see the objects
	+    referenced by the original ref value as dangling (and either
	+    omit them from the pack, or delete them via prune).
	     
	     There's no test included here, because the success case is
	     two processes running simultaneously forever. But you can
	@@ -79,7 +78,11 @@
	       # fsck.sh
	       # now run this simultaneously in another terminal; it
	       # repeatedly fscks, looking for us to consider the
	-      # newly-pushed ref broken.
	+      # newly-pushed ref broken. We cannot use for-each-ref
	+      # here, as it uses DO_FOR_EACH_INCLUDE_BROKEN, which
	+      # skips the has_sha1_file check (and if it wants
	+      # more information on the object, it will actually read
	+      # the object, which does the proper two-step lookup)
	       cd parent &&
	       while true; do
	         broken=`git fsck 2>&1 | grep remotes/child`

-- >8 --
Subject: has_sha1_file: re-check pack directory before giving up

When we read a sha1 file, we first look for a packed
version, then a loose version, and then re-check the pack
directory again before concluding that we cannot find it.
This lets us handle a process that is writing to the
repository simultaneously (e.g., receive-pack writing a new
pack followed by a ref update, or git-repack packing
existing loose objects into a new pack).

However, we do not do the same trick with has_sha1_file; we
only check the packed objects once, followed by loose
objects. This means that we might incorrectly report that we
do not have an object, even though we could find it if we
simply re-checked the pack directory.

By itself, this is usually not a big deal. The other process
is running simultaneously, so we may run has_sha1_file
before it writes, anyway. It is a race whether we see the
object or not.  However, we may also see other things
the writing process has done (like updating refs); and in
that case, we must be able to also see the new objects.

For example, imagine we are doing a for_each_ref iteration,
and somebody simultaneously pushes. Receive-pack may write
the pack and update a ref after we have examined the
objects/pack directory, but before the iteration gets to the
updated ref. When we do finally see the updated ref,
for_each_ref will call has_sha1_file to check whether the
ref is broken. If has_sha1_file returns the wrong answer, we
erroneously will think that the ref is broken.

For a normal iteration without DO_FOR_EACH_INCLUDE_BROKEN,
this means that the caller does not see the ref at all
(neither the old nor the new value).  So not only will we
fail to see the new value of the ref (which is acceptable,
since we are running simultaneously with the writer, and we
might well read the ref before the writer commits its
write), but we will not see the old value either. For
programs that act on reachability like pack-objects or
prune, this can cause data loss, as we may see the objects
referenced by the original ref value as dangling (and either
omit them from the pack, or delete them via prune).

There's no test included here, because the success case is
two processes running simultaneously forever. But you can
replicate the issue with:

  # base.sh
  # run this in one terminal; it creates and pushes
  # repeatedly to a repository
  git init parent &&
  (cd parent &&

    # create a base commit that will trigger us looking at
    # the objects/pack directory before we hit the updated ref
    echo content >file &&
    git add file &&
    git commit -m base &&

    # set the unpack limit abnormally low, which
    # lets us simulate full-size pushes using tiny ones
    git config receive.unpackLimit 1
  ) &&
  git clone parent child &&
  cd child &&
  n=0 &&
  while true; do
    echo $n >file && git add file && git commit -m $n &&
    git push origin HEAD:refs/remotes/child/master &&
    n=$(($n + 1))
  done

  # fsck.sh
  # now run this simultaneously in another terminal; it
  # repeatedly fscks, looking for us to consider the
  # newly-pushed ref broken. We cannot use for-each-ref
  # here, as it uses DO_FOR_EACH_INCLUDE_BROKEN, which
  # skips the has_sha1_file check (and if it wants
  # more information on the object, it will actually read
  # the object, which does the proper two-step lookup)
  cd parent &&
  while true; do
    broken=`git fsck 2>&1 | grep remotes/child`
    if test -n "$broken"; then
      echo $broken
      exit 1
    fi
  done

Without this patch, the fsck loop fails within a few seconds
(and almost instantly if the test repository actually has a
large number of refs). With it, the two can run
indefinitely.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index e1b2290..02ebb80 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2640,7 +2640,10 @@ int has_sha1_file(const unsigned char *sha1)
 
 	if (find_pack_entry(sha1, &e))
 		return 1;
-	return has_loose_object(sha1);
+	if (has_loose_object(sha1))
+		return 1;
+	reprepare_packed_git();
+	return find_pack_entry(sha1, &e);
 }
 
 static void check_tree(const void *buf, size_t size)
-- 
1.8.4.2.g87d4a77
