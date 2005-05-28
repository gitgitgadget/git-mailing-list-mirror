From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Diff: two fixes.
Date: Sat, 28 May 2005 12:22:38 -0700
Message-ID: <7vr7frrw8x.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 21:21:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc6rD-0007sO-H1
	for gcvg-git@gmane.org; Sat, 28 May 2005 21:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVE1TWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 15:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVE1TWn
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 15:22:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21228 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261192AbVE1TWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 15:22:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528192238.FAAZ7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 15:22:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 28 May 2005 03:11:19 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The count-delta routine sometimes overcounted the copied source
material which resulted in unsigned int wraparound.

The latest diff-cache (uncached) fix to eliminate empty diffs
from the output revealed that is_exact_match() was not careful
enough, which resulted in a sanity check routine triggering when
a file is added to an index.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

count-delta.c |    3 +++
diff.c        |    3 +++
2 files changed, 6 insertions(+)

diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -88,5 +88,8 @@ unsigned long count_delta(void *delta_bu
 	/* delete size is what was _not_ copied from source.
 	 * edit size is that and literal additions.
 	 */
+	if (src_size + added_literal < copied_from_source)
+		/* we ended up overcounting and underflowed */
+		return 0;
 	return (src_size - copied_from_source) + added_literal;
 }
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -689,6 +689,9 @@ int is_exact_match(struct diff_filespec 
 	if (src->sha1_valid && dst->sha1_valid &&
 	    !memcmp(src->sha1, dst->sha1, 20))
 		return 1;
+	/* if either is invalid they cannot match */
+	if (!DIFF_FILE_VALID(src) || !DIFF_FILE_VALID(dst))
+		return 0;
 	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
 		return 0;
 	if (src->size != dst->size)
------------------------------------------------

