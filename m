From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] diff --cc: integer overflow given a 2GB-or-larger file
Date: Tue, 27 Feb 2007 00:11:35 +0100
Message-ID: <87vehopl94.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 00:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLp0O-0006Kr-3w
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 00:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161392AbXBZXLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 18:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161395AbXBZXLh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 18:11:37 -0500
Received: from mx.meyering.net ([82.230.74.64]:35495 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161392AbXBZXLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 18:11:37 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id BB94D26636; Tue, 27 Feb 2007 00:11:35 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40672>

Few of us use git to compare or even version-control 2GB files,
but when we do, we'll want it to work.

Reading a recent patch, I noticed two lines like this:

   int len = st.st_size;

Instead of "int", that should be "size_t".  Otherwise, in the
non-symlink case, with 64-bit size_t, if the file's size is 2GB,
the following xmalloc will fail:

   result = xmalloc(len + 1);

trying to allocate 2^64 - 2^31 + 1 bytes (assuming sign-extension
in the int-to-size_t promotion).  And even if it didn't fail, the
subsequent "result[len] = 0;" would be equivalent to an unpleasant
"result[-2147483648] = 0;"

The other nearby "int"-declared size variable, sz, should also be of
type size_t, for the same reason.  If sz ever wraps around and becomes
negative, xread will corrupt memory _before_ the "result" buffer.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 combine-diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 6b7c6be..044633d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -684,7 +684,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			goto deleted_file;
 
 		if (S_ISLNK(st.st_mode)) {
-			int len = st.st_size;
+			size_t len = st.st_size;
 			result_size = len;
 			result = xmalloc(len + 1);
 			if (result_size != readlink(elem->path, result, len)) {
@@ -697,8 +697,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		}
 		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
 			 !fstat(fd, &st)) {
-			int len = st.st_size;
-			int sz = 0;
+			size_t len = st.st_size;
+			size_t sz = 0;
 
 			elem->mode = canon_mode(st.st_mode);
 			result_size = len;
-- 
1.5.0.1.226.g7bd59
