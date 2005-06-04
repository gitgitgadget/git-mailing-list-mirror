From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff.c: locate_size_cache() fix.
Date: Fri, 03 Jun 2005 23:02:23 -0700
Message-ID: <7vekbik6c0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 08:00:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeRhE-0003tY-4X
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 07:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFDGCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 02:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFDGCo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 02:02:44 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:19953 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261251AbVFDGC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 02:02:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604060225.GUVB20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Jun 2005 02:02:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes two bugs.

 - declaration of auto variable "cmp" was preceeded by a
   statement, causing compilation error on real C compilers;
   noticed and patch given by Yoichi Yuasa.

 - the function's calling convention was overloading its size
   parameter to mean "largest possible value means do not add
   entry", which was a bad taste.  Brought up during a
   discussion with Peter Baudis.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -236,6 +236,7 @@ static struct sha1_size_cache {
 static int sha1_size_cache_nr, sha1_size_cache_alloc;
 
 static struct sha1_size_cache *locate_size_cache(unsigned char *sha1,
+						 int find_only,
 						 unsigned long size)
 {
 	int first, last;
@@ -244,9 +245,9 @@ static struct sha1_size_cache *locate_si
 	first = 0;
 	last = sha1_size_cache_nr;
 	while (last > first) {
-		int next = (last + first) >> 1;
+		int cmp, next = (last + first) >> 1;
 		e = sha1_size_cache[next];
-		int cmp = memcmp(e->sha1, sha1, 20);
+		cmp = memcmp(e->sha1, sha1, 20);
 		if (!cmp)
 			return e;
 		if (cmp < 0) {
@@ -256,7 +257,7 @@ static struct sha1_size_cache *locate_si
 		first = next+1;
 	}
 	/* not found */
-	if (size == UINT_MAX)
+	if (find_only)
 		return NULL;
 	/* insert to make it at "first" */
 	if (sha1_size_cache_alloc <= sha1_size_cache_nr) {
@@ -337,13 +338,13 @@ int diff_populate_filespec(struct diff_f
 		struct sha1_size_cache *e;
 
 		if (size_only) {
-			e = locate_size_cache(s->sha1, UINT_MAX);
+			e = locate_size_cache(s->sha1, 1, 0);
 			if (e) {
 				s->size = e->size;
 				return 0;
 			}
 			if (!sha1_file_size(s->sha1, &s->size))
-				locate_size_cache(s->sha1, s->size);
+				locate_size_cache(s->sha1, 0, s->size);
 		}
 		else {
 			s->data = read_sha1_file(s->sha1, type, &s->size);
------------

