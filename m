From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: name pack files after trailer hash
Date: Thu, 5 Dec 2013 15:28:07 -0500
Message-ID: <20131205202807.GA19042@sigill.intra.peff.net>
References: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com>
 <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VofWx-0005VR-7n
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab3LEU2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 15:28:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:51182 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751947Ab3LEU2J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 15:28:09 -0500
Received: (qmail 32162 invoked by uid 102); 5 Dec 2013 20:28:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 14:28:08 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 15:28:07 -0500
Content-Disposition: inline
In-Reply-To: <20131205160418.GA27869@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238909>

On Thu, Dec 05, 2013 at 11:04:18AM -0500, Jeff King wrote:

> > Yes. And this is why the packfile name algorithm is horribly flawed. I
> > keep saying we should change it to name the pack using the last 20
> > bytes of the file but ... nobody has written the patch for that?  :-)
> 
> Totally agree. I think we could also get rid of the horrible hacks in
> repack where we pack to a tempfile, then have to do another tempfile
> dance (which is not atomic!) to move the same-named packfile out of the
> way. If the name were based on the content, we could just throw away our
> new pack if one of the same name is already there (just like we do for
> loose objects).
> 
> I haven't looked at making such a patch, but I think it shouldn't be too
> complicated. My big worry would be weird fallouts from some hidden part
> of the code that we don't realize is depending on the current naming
> scheme. :)

So here's the first part, that actually changes the name. It passes the
test suite, so it must be good, right? And just look at that diffstat.

This actually applies on top of e74435a (sha1write: make buffer
const-correct, 2013-10-24), which is on another topic. Since the sha1
parameter to write_idx_file is no longer used as both an in- and out-
parameter (yuck), we can make it const.

The second half would be to simplify git-repack. The current behavior is
to replace the old packfile with a tricky rename dance. Which is still
correct, but overly complicated. We should be able to just drop the new
packfile, since we know the bytes are identical (or rename the new one
over the old, though I think keeping the old is probably kinder to the
disk cache, especially if another process already has it mmap'd).

-- >8 --
Subject: pack-objects: name pack files after trailer hash

Our current scheme for naming packfiles is to calculate the
sha1 hash of the sorted list of objects contained in the
packfile. This gives us a unique name, so we are reasonably
sure that two packs with the same name will contain the same
objects.

It does not, however, tell us that two such packs have the
exact same bytes. This makes things awkward if we repack the
same set of objects. Due to run-to-run variations, the bytes
may not be identical (e.g., changed zlib or git versions,
different source object reuse due to new packs in the
repository, or even different deltas due to races during a
multi-threaded delta search).

In theory, this could be helpful to a program that cares
that the packfile contains a certain set of objects, but
does not care about the particular representation. In
practice, no part of git makes use of that, and in many
cases it is potentially harmful. For example, if a dumb http
client fetches the .idx file, it must be sure to get the
exact .pack that matches it. Similarly, a partial transfer
of a .pack file cannot be safely resumed, as the actual
bytes may have changed.  This could also affect a local
client which opened the .idx and .pack files, closes the
.pack file (due to memory or file descriptor limits), and
then re-opens a changed packfile.

In all of these cases, git can detect the problem, as we
have the sha1 of the bytes themselves in the pack trailer
(which we verify on transfer), and the .idx file references
the trailer from the matching packfile. But it would be
simpler and more efficient to actually get the correct
bytes, rather than noticing the problem and having to
restart the operation.

This patch simply uses the pack trailer sha1 as the pack
name. It should be similarly unique, but covers the exact
representation of the objects. Other parts of git should not
care, as the pack name is returned by pack-objects and is
essentially opaque.

One test needs to be updated, because it actually corrupts a
pack and expects that re-packing the corrupted bytes will
use the same name. It won't anymore, but we can easily just
use the name that pack-objects hands back.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-write.c          | 8 +-------
 pack.h                | 2 +-
 t/t5302-pack-index.sh | 4 ++--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index ca9e63b..ddc174e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -44,14 +44,13 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
-			   unsigned char *sha1)
+			   const unsigned char *sha1)
 {
 	struct sha1file *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
 	off_t last_obj_offset = 0;
 	uint32_t array[256];
 	int i, fd;
-	git_SHA_CTX ctx;
 	uint32_t index_version;
 
 	if (nr_objects) {
@@ -114,9 +113,6 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 	sha1write(f, array, 256 * 4);
 
-	/* compute the SHA1 hash of sorted object names. */
-	git_SHA1_Init(&ctx);
-
 	/*
 	 * Write the actual SHA1 entries..
 	 */
@@ -128,7 +124,6 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			sha1write(f, &offset, 4);
 		}
 		sha1write(f, obj->sha1, 20);
-		git_SHA1_Update(&ctx, obj->sha1, 20);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && !hashcmp(list[-2]->sha1, obj->sha1)))
 			die("The same object %s appears twice in the pack",
@@ -178,7 +173,6 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	sha1write(f, sha1, 20);
 	sha1close(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
 			    ? CSUM_CLOSE : CSUM_FSYNC));
-	git_SHA1_Final(sha1, &ctx);
 	return index_name;
 }
 
diff --git a/pack.h b/pack.h
index aa6ee7d..12d9516 100644
--- a/pack.h
+++ b/pack.h
@@ -76,7 +76,7 @@ struct pack_idx_entry {
 struct progress;
 typedef int (*verify_fn)(const unsigned char*, enum object_type, unsigned long, void*, int*);
 
-extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, unsigned char *sha1);
+extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uint32_t);
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index fe82025..4bbb718 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -174,11 +174,11 @@ test_expect_success \
 test_expect_success \
     '[index v1] 5) pack-objects happily reuses corrupted data' \
     'pack4=$(git pack-objects test-4 <obj-list) &&
-     test -f "test-4-${pack1}.pack"'
+     test -f "test-4-${pack4}.pack"'
 
 test_expect_success \
     '[index v1] 6) newly created pack is BAD !' \
-    'test_must_fail git verify-pack -v "test-4-${pack1}.pack"'
+    'test_must_fail git verify-pack -v "test-4-${pack4}.pack"'
 
 test_expect_success \
     '[index v2] 1) stream pack to repository' \
-- 
1.8.5.524.g6743da6
