From: Jeff King <peff@peff.net>
Subject: [PATCH] fix over-eager caching in sha1_file_name
Date: Sat, 22 May 2010 02:43:08 -0400
Message-ID: <20100522064308.GA11335@coredump.intra.peff.net>
References: <19441.8259.634019.348195@winooski.ccs.neu.edu>
 <20100522054852.GB29118@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 08:43:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFiQY-0006fL-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 08:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0EVGnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 02:43:13 -0400
Received: from peff.net ([208.65.91.99]:46004 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab0EVGnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 02:43:12 -0400
Received: (qmail 5637 invoked by uid 107); 22 May 2010 06:43:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 22 May 2010 02:43:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 May 2010 02:43:08 -0400
Content-Disposition: inline
In-Reply-To: <20100522054852.GB29118@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147508>

On Sat, May 22, 2010 at 01:48:52AM -0400, Jeff King wrote:

> I would have thought that worked, assuming you were in /some/dir. And
> oddly, _some_ stuff works. I tried:
> 
>   mkdir repo && cd repo && git init
>   echo content >file && git add . && git commit -m file
>   git archive --format=tar --prefix=work/ HEAD | tar -C .. -xf -
> 
> to create the situation. Running
> 
>   cd repo
>   git --work-tree=$PWD/../work diff-files
>   git --work-tree=$PWD/../work diff
> 
> works as expected (the first one notices stat-dirtiness, and the second
> shows an empty diff). But then I get:
> 
>   $ git --work-tree=$PWD/../work reset --hard
>   fatal: unable to read tree ea394696ee1f7f5b55ca0d97d37748933cf39095
> 
> So there is clearly a bug. I'll investigate.

Ugh. This code dates back to the first two weeks of git, but didn't
become a bug until sometime in the intervening 5 years. See below for
the explanation and fix.

-- >8 --
Subject: [PATCH] fix over-eager caching in sha1_file_name

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

This patch takes the minimalist fix. It retains the caching,
but checks the validity of our object directory against the
one cached in environment.c, which adds only a single
function call and a pointer comparison to the fast path.

Signed-off-by: Jeff King <peff@peff.net>
---
As I noted above, this is the minimal fix. I think it would be more
readable, though, to simply remove this caching layer altogether and use
a static buffer. I suspect the original was just trying to avoid the
slow getenv() call, which is no longer an issue now. We can probably
afford an snprintf. I'll post that patch shortly.

 sha1_file.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d8e61a6..f047b3c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -103,10 +103,12 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 char *sha1_file_name(const unsigned char *sha1)
 {
 	static char *name, *base;
+	static const char *sha1_file_directory;
 
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
+	if (!base || sha1_file_directory != get_object_directory()) {
+		sha1_file_directory = get_object_directory();
 		int len = strlen(sha1_file_directory);
+		free(base);
 		base = xmalloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
 		memset(base+len, 0, 60);
-- 
1.7.1.352.gb63a7.dirty
