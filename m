From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] refs: improve comments about "reading" argument of
 "resolve_ref"
Date: Tue, 9 Sep 2008 07:10:56 +0200
Message-ID: <20080909071056.2521c510.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 07:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcvSs-0004SH-CI
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 07:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbYIIFHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 01:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbYIIFHZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 01:07:25 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:42058 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbYIIFHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 01:07:25 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id AB66C19776;
	Tue,  9 Sep 2008 07:07:22 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 72BFA1976C;
	Tue,  9 Sep 2008 07:07:22 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95335>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

	Junio wrote:
	> So how about improving the comment that is misleading?

	Ok, let's do that. On top of your patch, I added a comment based
	on your previous email as a function header. Feel free to discard
	it or move it to "cache.h".

	Thanks,
	Christian. 

diff --git a/refs.c b/refs.c
index 39a3b23..d61893b 100644
--- a/refs.c
+++ b/refs.c
@@ -390,6 +390,21 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *re
 	return retval;
 }
 
+/*
+ * resolve_ref: find what a ref points at
+ *
+ * If the "reading" argument is set, this function finds out what _object_
+ * the ref points at. This is called "reading" the ref, and the ref, if it
+ * is not symbolic, has to exist, and if it is symbolic, it has to point at
+ * an existing ref, because the "read" goes through the symref to the ref
+ * it points at.
+ *
+ * Otherwise, the access that is not "reading" does not have to be "writing";
+ * it can be merely checking _where it leads to_. If it is a prelude to
+ * "writing" to the ref, a write to a symref that points at yet-to-be-born
+ * ref will create the real ref pointed by the symref, so such a symref is
+ * not an error.
+ */
 const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
@@ -409,12 +424,15 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		if (--depth < 0)
 			return NULL;
 
-		/* Special case: non-existing file.
-		 * Not having the refs/heads/new-branch is OK
-		 * if we are writing into it, so is .git/HEAD
-		 * that points at refs/heads/master still to be
-		 * born.  It is NOT OK if we are resolving for
-		 * reading.
+		/*
+		 * Special case: non-existing file.
+		 * Not having the refs/heads/new-branch is not OK if
+		 * we are resolving for reading.  But not everybody
+		 * calls this function to learn what object the ref
+		 * points at.  E.g. it can be called to learn what the
+		 * symref points at.  Also if we are writing into it,
+		 * it is Ok for .git/HEAD to point at refs/heads/master
+		 * that does not exist yet.
 		 */
 		if (lstat(path, &st) < 0) {
 			struct ref_list *list = get_packed_refs();
-- 
1.6.0.1.338.g5e95.dirty
