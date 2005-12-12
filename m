From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] diff-delta.c: allow delta with empty blob.
Date: Mon, 12 Dec 2005 12:40:19 -0800
Message-ID: <7vacf6hwwc.fsf@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 21:43:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EluTD-0000Ls-V5
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 21:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVLLUkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 15:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVLLUkW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 15:40:22 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17640 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751104AbVLLUkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 15:40:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212203842.DBZG17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 15:38:42 -0500
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1134404990.5928.4.camel@localhost.localdomain> (Darrin
	Thompson's message of "Mon, 12 Dec 2005 11:29:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13536>

Delta computation with an empty blob used to punt and returned NULL.
This commit allows creation with empty blob; all combination of
empty->empty, empty->something, and something->empty are allowed.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Darrin Thompson <darrint@progeny.com> writes:

 > $ git-diff-files -B
 > Segmentation fault

 > Could someone confirm that this exists on more recent git heads and fix
 > if needed?

 Could you try this patch?  It is marked as 2/2 but 1/2 is a
 test script to reproduce the problem with the current code,
 which this patch is supposed to fix, and this should be the
 only fix you need.

 delta.h      |    4 ++--
 diff-delta.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

1e4d6f6618abb72e3948419d113a6f2f14c83ebc
diff --git a/delta.h b/delta.h
index 31d1820..c6a4763 100644
--- a/delta.h
+++ b/delta.h
@@ -9,8 +9,8 @@ extern void *patch_delta(void *src_buf, 
 			 void *delta_buf, unsigned long delta_size,
 			 unsigned long *dst_size);
 
-/* the smallest possible delta size is 4 bytes */
-#define DELTA_SIZE_MIN	4
+/* the smallest possible delta size is 2 bytes (empty to empty) */
+#define DELTA_SIZE_MIN	2
 
 /*
  * This must be called twice on the delta data buffer, first to get the
diff --git a/diff-delta.c b/diff-delta.c
index b2ae7b5..cf50138 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -213,7 +213,7 @@ void *diff_delta(void *from_buf, unsigne
 	bdrecord_t *brec;
 	bdfile_t bdf;
 
-	if (!from_size || !to_size || delta_prepare(from_buf, from_size, &bdf))
+	if (delta_prepare(from_buf, from_size, &bdf))
 		return NULL;
 	
 	outpos = 0;
-- 
0.99.9.GIT
