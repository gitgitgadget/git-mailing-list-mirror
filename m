From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: Do not free the wrong buffer when we convert the data for writeout
Date: Thu, 22 Mar 2007 13:31:49 -0700
Message-ID: <7virctt3yi.fsf_-_@assigned-by-dhcp.cox.net>
References: <200702281036.30539.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
	<200703210956.50018.litvinov2004@gmail.com>
	<200703211024.04740.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:32:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUTx8-0003G4-Kp
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 21:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXCVUbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934222AbXCVUbv
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 16:31:51 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:44877 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbXCVUbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 16:31:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322203150.WKAT28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Mar 2007 16:31:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dwXp1W0031kojtg0000000; Thu, 22 Mar 2007 16:31:49 -0400
In-Reply-To: <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 22 Mar 2007 09:48:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42877>

When we write out the result of patch application, we sometimes
need to munge the data (e.g. under core.autocrlf).  After doing
so, what we should free is the temporary buffer that holds the
converted data returned from convert_to_working_tree(), not the
original one.

This patch also moves the call to open() up in the function, as
the caller expects us to fail cheaply if leading directories
need to be created (and then the caller creates them and calls
us again).  For that calling pattern, attempting conversion
before opening the file adds unnecessary overhead.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Linus Torvalds <torvalds@linux-foundation.org> writes:

  > In "try_create_file()", we do:
  >
  > 	...
  >         if (convert_to_working_tree(path, &nbuf, &nsize)) {
  >                 free((char *) buf);
  >                 buf = nbuf;
  >                 size = nsize;
  >         }
  > 	...
  >
  > but the thing is, the *caller* still uses the old "buf/nsize", so when you 
  > free it, the caller will now use the free'd data structure, and if it gets 
  > re-used by - for example - the zlib deflate() buffers, you'll get a 
  > corrupt object (if it gets re-used *before*, you'll get the *wrong* 
  > object!). Exactly Alexander's patterns.
  >
  > Alexander - sorry for all the trouble, this was definitely our bad.

  I concur.  Sorry for this, Alexander.

  git-apply in general is quite leaky (e.g. it never frees a
  finished patch, and freeing a patch is quite difficult as some
  strings like filenames are shared without refcounting), but
  this part deals with a large amount of data and I would rather
  not add a new one.

 builtin-apply.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index dfa1716..27a182b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2355,7 +2355,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
-	int fd;
+	int fd, converted;
 	char *nbuf;
 	unsigned long nsize;
 
@@ -2364,17 +2364,18 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 		 * terminated.
 		 */
 		return symlink(buf, path);
+
+	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
+	if (fd < 0)
+		return -1;
+
 	nsize = size;
 	nbuf = (char *) buf;
-	if (convert_to_working_tree(path, &nbuf, &nsize)) {
-		free((char *) buf);
+	converted = convert_to_working_tree(path, &nbuf, &nsize);
+	if (converted) {
 		buf = nbuf;
 		size = nsize;
 	}
-
-	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
-	if (fd < 0)
-		return -1;
 	while (size) {
 		int written = xwrite(fd, buf, size);
 		if (written < 0)
@@ -2386,6 +2387,8 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	}
 	if (close(fd) < 0)
 		die("closing file %s: %s", path, strerror(errno));
+	if (converted)
+		free(nbuf);
 	return 0;
 }
 
