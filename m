From: Jeff King <peff@peff.net>
Subject: [PATCH] has_sha1_file: re-check pack directory before giving up
Date: Thu, 29 Aug 2013 21:10:53 -0400
Message-ID: <20130830011052.GA21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 03:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFDEq-0002AA-7n
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 03:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab3H3BK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 21:10:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41706 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab3H3BKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 21:10:55 -0400
Received: (qmail 24804 invoked by uid 102); 30 Aug 2013 01:10:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Aug 2013 20:10:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Aug 2013 21:10:53 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233385>

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

In the case of git-fsck, which uses the
DO_FOR_EACH_INCLUDE_BROKEN flag, this will cause us to
erroneously complain that the ref points to an invalid
object. But for git-repack, which does not use that flag, we
will skip the ref completely! So not only will we fail to
process the new objects that the ref points to (which is
acceptabale, since the processes are running simultaneously,
and we might well do our whole repack before the other
process updates the ref), but we will not see the ref at
all. Its old objects may be omitted from the pack (and even
lost, if --unpack-unreachable is used with an expiration
time).

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
  # newly-pushed ref broken.
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
I observed this being triggered in practice on a repository with a large
number of refs. Clients complained of refs being reported as bogus by
the server and being omitted (because of upload-pack missing the ref in
the advertisement), and git-fsck would randomly report breakages (that
would then go away if run again). I didn't observe any object loss as I
theorized above, but I'm pretty sure it's possible (ironically, _not_
the new objects, because they will be newer than the prune time, but the
old objects they are based on).

Note that this works against the optimization in b495697 (fetch-pack:
avoid repeatedly re-scanning pack directory, 2013-01-26), which uses
has_sha1_file specifically to avoid the re-scan. But it is much more
important to be correct here, so I'd like to start with this fix. For
the use case in b495697, we can have a "quick but occasionally wrong"
version.

 sha1_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8e27db1..06784fb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2925,7 +2925,10 @@ int has_sha1_file(const unsigned char *sha1)
 
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
