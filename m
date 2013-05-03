From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Fri, 3 May 2013 17:21:44 -0400
Message-ID: <20130503212144.GA17698@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 03 23:21:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYNQO-0003A8-7H
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 23:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763549Ab3ECVVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 17:21:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:41764 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab3ECVVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 17:21:47 -0400
Received: (qmail 16601 invoked by uid 102); 3 May 2013 21:22:04 -0000
Received: from c-98-244-78-62.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.78.62)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 May 2013 16:22:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2013 17:21:44 -0400
Content-Disposition: inline
In-Reply-To: <20130503083847.GA16542@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223322>

On Fri, May 03, 2013 at 04:38:47AM -0400, Jeff King wrote:

> For reference, here's a script that demonstrates the problem during
> enumeration (sometimes for-each-ref fails to realize that
> refs/heads/master exists at all):
> 
>   # run this in one terminal
>   git init repo &&
>   cd repo &&
>   git commit --allow-empty -m foo &&
>   base=`git rev-parse HEAD` &&
>   while true; do
>     # this re-creates the loose ref in .git/refs/heads/master
>     git update-ref refs/heads/master $base &&

It turns out this is wrong. Git is smart enough not to bother writing
out the loose ref if it isn't changing. So the script as I showed it
actually ends up in a state with _neither_ the packed-refs file nor the
loose ref for an instant.

The correct script looks like this (it just flips between two objects):

  git init -q repo &&
  cd repo &&
  git commit -q --allow-empty -m one &&
  one=`git rev-parse HEAD` &&
  git commit -q --allow-empty -m two &&
  two=`git rev-parse HEAD` &&
  sha1=$one &&
  while true; do
    # this re-creates the loose ref in .git/refs/heads/master
    if test "$sha1" = "$one"; then
      sha1=$two
    else
      sha1=$one
    fi &&
    git update-ref refs/heads/master $sha1 &&

    # we can remove packed-refs safely, as we know that
    # its only value is now stale. Real git would not do
    # this, but we are simulating the case that "master"
    # simply wasn't included in the last packed-refs file.
    rm -f .git/packed-refs &&

    # and now we repack, which will create an up-to-date
    # packed-refs file, and then delete the loose ref
    git pack-refs --all --prune
  done

And a racy lookup check could look like this:

  cd repo &&
  while true; do
    ref=`git rev-parse --verify master`
    echo "==> $ref"
    test -z "$ref" && break
  done

it doesn't know which of the two flipping refs it will get on any given
invocation, but it should never see nothing. It should get one or the
other. With stock git, running these two looks for me simultaneously
typically causes a failure in the second one within about 15 seconds.
The (messy, not ready for application) patch below fixes it (at least I
let it run for 30 minutes without a problem).

The fix is actually two-fold:

  1. Re-load the packed-refs file after each loose object lookup
     failure. This is made more palatable by using stat() to avoid
     re-reading the file in the common case that it wasn't updated.

  2. The loose ref reading itself is actually not atomic. We call
     lstat() on the ref to find out whether it exists (and whether it is
     a symlink). If we get ENOENT, we fall back to finding the loose
     ref.  If it does exist and is a regular file, we proceed to open()
     it. But if the ref gets packed and pruned in the interim, our open
     will fail and we just return NULL to say "oops, I guess it doesn't
     exist". We want the same fallback-to-packed behavior we would get
     if the lstat failed.

     We could potentially do the same when we readlink() a symbolic
     link, but I don't think it is necessary. We do not pack symbolic
     refs, so if readlink gets ENOENT, it's OK to say "nope, the ref
     does not exist".

This doesn't cover the for_each_ref enumeration case at all, which
should still fail.  I'll try to look at that next.

---
diff --git a/refs.c b/refs.c
index de2d8eb..45a7ee6 100644
--- a/refs.c
+++ b/refs.c
@@ -708,6 +708,7 @@ static struct ref_cache {
 	struct ref_cache *next;
 	struct ref_entry *loose;
 	struct ref_entry *packed;
+	struct stat packed_validity;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
 } *ref_cache;
@@ -717,6 +718,7 @@ static void clear_packed_ref_cache(struct ref_cache *refs)
 	if (refs->packed) {
 		free_ref_entry(refs->packed);
 		refs->packed = NULL;
+		memset(&refs->packed_validity, 0, sizeof(refs->packed_validity));
 	}
 }
 
@@ -876,19 +878,57 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	}
 }
 
+/*
+ * Returns 1 if the cached stat information matches the
+ * current state of the file, and 0 otherwise. This should
+ * probably be refactored to share code with ce_match_stat_basic,
+ * which has platform-specific knobs for which fields to respect.
+ */
+static int check_stat_validity(const struct stat *old, const char *fn)
+{
+	static struct stat null;
+	struct stat cur;
+
+	if (stat(fn, &cur))
+		return errno == ENOENT && !memcmp(old, &null, sizeof(null));
+	return cur.st_ino == old->st_ino &&
+	       cur.st_size == old->st_size &&
+	       cur.st_mtime == old->st_mtime;
+}
+
+/*
+ * Call fstat, but zero out the stat structure if for whatever
+ * reason we can't get an answer.
+ */
+static int safe_fstat(int fd, struct stat *out)
+{
+	int r = fstat(fd, out);
+	if (r)
+		memset(out, 0, sizeof(*out));
+	return r;
+}
+
 static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 {
+	const char *packed_refs_file;
+
+	if (*refs->name)
+		packed_refs_file = git_path_submodule(refs->name, "packed-refs");
+	else
+		packed_refs_file = git_path("packed-refs");
+
+	if (refs->packed &&
+	    !check_stat_validity(&refs->packed_validity, packed_refs_file))
+		clear_packed_ref_cache(refs);
+
 	if (!refs->packed) {
-		const char *packed_refs_file;
 		FILE *f;
 
 		refs->packed = create_dir_entry(refs, "", 0, 0);
-		if (*refs->name)
-			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
-		else
-			packed_refs_file = git_path("packed-refs");
+
 		f = fopen(packed_refs_file, "r");
 		if (f) {
+			safe_fstat(fileno(f), &refs->packed_validity);
 			read_packed_refs(f, get_ref_dir(refs->packed));
 			fclose(f);
 		}
@@ -1108,6 +1148,13 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		git_snpath(path, sizeof(path), "%s", refname);
 
 		if (lstat(path, &st) < 0) {
+			/*
+			 * this lets us reuse this code path
+			 * for later syscall failures; it should
+			 * almost certainly just get factored out into a
+			 * function though
+			 */
+fallback_to_packed:
 			if (errno != ENOENT)
 				return NULL;
 			/*
@@ -1156,7 +1203,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		 */
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
-			return NULL;
+			goto fallback_to_packed;
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		close(fd);
 		if (len < 0)
