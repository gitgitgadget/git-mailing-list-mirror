From: David Kastrup <dak@gnu.org>
Subject: [PATCH 1/2] builtin/blame.c: struct blame_entry does not need a prev link
Date: Wed, 22 Jan 2014 01:20:14 +0100
Message-ID: <1390350015-3040-2-git-send-email-dak@gnu.org>
References: <1390350015-3040-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 01:20:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5lYl-0006ym-3J
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 01:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbaAVAUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 19:20:43 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47886 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaAVAUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 19:20:42 -0500
Received: from localhost ([127.0.0.1]:46928 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5lYf-0007iL-Si; Tue, 21 Jan 2014 19:20:42 -0500
Received: by lola (Postfix, from userid 1000)
	id 8212FE051D; Wed, 22 Jan 2014 01:20:41 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1390350015-3040-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240807>

Signed-off-by: David Kastrup <dak@gnu.org>
---
 builtin/blame.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..2195595 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -197,7 +197,6 @@ static void drop_origin_blob(struct origin *o)
  * scoreboard structure, sorted by the target line number.
  */
 struct blame_entry {
-	struct blame_entry *prev;
 	struct blame_entry *next;
 
 	/* the first line of this group in the final image;
@@ -282,8 +281,6 @@ static void coalesce(struct scoreboard *sb)
 		    ent->s_lno + ent->num_lines == next->s_lno) {
 			ent->num_lines += next->num_lines;
 			ent->next = next->next;
-			if (ent->next)
-				ent->next->prev = ent;
 			origin_decref(next->suspect);
 			free(next);
 			ent->score = 0;
@@ -534,7 +531,7 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
 		prev = ent;
 
 	/* prev, if not NULL, is the last one that is below e */
-	e->prev = prev;
+
 	if (prev) {
 		e->next = prev->next;
 		prev->next = e;
@@ -543,8 +540,6 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
 		e->next = sb->ent;
 		sb->ent = e;
 	}
-	if (e->next)
-		e->next->prev = e;
 }
 
 /*
@@ -555,14 +550,12 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
  */
 static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
 {
-	struct blame_entry *p, *n;
+	struct blame_entry *n;
 
-	p = dst->prev;
 	n = dst->next;
 	origin_incref(src->suspect);
 	origin_decref(dst->suspect);
 	memcpy(dst, src, sizeof(*src));
-	dst->prev = p;
 	dst->next = n;
 	dst->score = 0;
 }
@@ -2502,8 +2495,6 @@ parse_done:
 		ent->suspect = o;
 		ent->s_lno = bottom;
 		ent->next = next;
-		if (next)
-			next->prev = ent;
 		origin_incref(o);
 	}
 	origin_decref(o);
-- 
1.8.3.2
