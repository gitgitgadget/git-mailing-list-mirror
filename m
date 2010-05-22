From: Jeff King <peff@peff.net>
Subject: [PATCH] remove over-eager caching in sha1_file_name
Date: Sat, 22 May 2010 02:59:42 -0400
Message-ID: <20100522065942.GB11335@coredump.intra.peff.net>
References: <19441.8259.634019.348195@winooski.ccs.neu.edu>
 <20100522054852.GB29118@coredump.intra.peff.net>
 <20100522064308.GA11335@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 09:05:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFily-0004Qk-HI
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 09:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab0EVG7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 02:59:47 -0400
Received: from peff.net ([208.65.91.99]:36787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab0EVG7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 02:59:46 -0400
Received: (qmail 5697 invoked by uid 107); 22 May 2010 06:59:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 22 May 2010 02:59:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 May 2010 02:59:42 -0400
Content-Disposition: inline
In-Reply-To: <20100522064308.GA11335@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147509>

On Sat, May 22, 2010 at 02:43:08AM -0400, Jeff King wrote:

> This patch takes the minimalist fix. It retains the caching,
> but checks the validity of our object directory against the
> one cached in environment.c, which adds only a single
> function call and a pointer comparison to the fast path.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> As I noted above, this is the minimal fix. I think it would be more
> readable, though, to simply remove this caching layer altogether and use
> a static buffer. I suspect the original was just trying to avoid the
> slow getenv() call, which is no longer an issue now. We can probably
> afford an snprintf. I'll post that patch shortly.

Actually, thinking on it more, micro-optimizing this is really
pointless. I was thinking that it would get called a lot, so we need to
care. But the next step is almost certainly to open, mmap, and zlib
decompress the resulting object, which is way more expensive.

So here it is with caching ripped out. More readable and more robust,
and I'm sure we can afford an extra strlen() and memcpy() on each object
lookup.

-- >8 --
Subject: [PATCH] remove over-eager caching in sha1_file_name

This function takes a sha1 and produces a loose object
filename. It caches the location of the object directory so
that it can fill the sha1 information directly without
allocating a new buffer (and in its original incarnation,
without calling getenv(), though these days we cache that
with the code in environment.c).

This cached base directory can become stale, however, if in
a single process git changes the location of the object
directory (e.g., by running setup_work_tree, which will
chdir to the new worktree).

In most cases this isn't a problem, because we tend to set
up the git repository location and do any chdir()s before
actually looking up any objects, so the first lookup will
cache the correct location. In the case of reset --hard,
however, we do something like:

  1. look up the commit object

  2. notice we are doing --hard, run setup_work_tree

  3. look up the tree object to reset

Step (3) fails because our cache object directory value is
bogus.

This patch simply removes the caching. We use a static
buffer instead of allocating one each time (the original
version treated the malloc'd buffer as a static, so there is
no change in calling semantics).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d8e61a6..e42ef96 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -102,20 +102,22 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
  */
 char *sha1_file_name(const unsigned char *sha1)
 {
-	static char *name, *base;
+	static char buf[PATH_MAX];
+	const char *objdir;
+	int len;
 
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
-		int len = strlen(sha1_file_directory);
-		base = xmalloc(len + 60);
-		memcpy(base, sha1_file_directory, len);
-		memset(base+len, 0, 60);
-		base[len] = '/';
-		base[len+3] = '/';
-		name = base + len + 1;
-	}
-	fill_sha1_path(name, sha1);
-	return base;
+	objdir = get_object_directory();
+	len = strlen(objdir);
+
+	/* '/' + sha1(2) + '/' + sha1(38) + '\0' */
+	if (len + 43 > PATH_MAX)
+		die("insanely long object directory %s", objdir);
+	memcpy(buf, objdir, len);
+	buf[len] = '/';
+	buf[len+3] = '/';
+	buf[len+42] = '\0';
+	fill_sha1_path(buf + len + 1, sha1);
+	return buf;
 }
 
 static char *sha1_get_pack_name(const unsigned char *sha1,
-- 
1.7.1.227.ge187a.dirty
