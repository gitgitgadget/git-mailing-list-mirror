From: David Kastrup <dak@gnu.org>
Subject: [PATCH 2/2] Eliminate same_suspect function in builtin/blame.c
Date: Wed, 22 Jan 2014 01:20:15 +0100
Message-ID: <1390350015-3040-3-git-send-email-dak@gnu.org>
References: <1390350015-3040-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 01:20:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5lYl-0006ym-L9
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 01:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaAVAUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 19:20:44 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47887 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbaAVAUn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 19:20:43 -0500
Received: from localhost ([127.0.0.1]:46929 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5lYg-0007iO-FM; Tue, 21 Jan 2014 19:20:42 -0500
Received: by lola (Postfix, from userid 1000)
	id 1B20BE051E; Wed, 22 Jan 2014 01:20:42 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1390350015-3040-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240808>

Since the origin pointers are "interned" and reference-counted, comparing
the pointers rather than the content is enough.  The only uninterned
origins are cached values kept in commit->util, but same_suspect is not
called on them.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 builtin/blame.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 2195595..ead6148 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -255,15 +255,6 @@ struct scoreboard {
 	int *lineno;
 };
 
-static inline int same_suspect(struct origin *a, struct origin *b)
-{
-	if (a == b)
-		return 1;
-	if (a->commit != b->commit)
-		return 0;
-	return !strcmp(a->path, b->path);
-}
-
 static void sanity_check_refcnt(struct scoreboard *);
 
 /*
@@ -276,7 +267,7 @@ static void coalesce(struct scoreboard *sb)
 	struct blame_entry *ent, *next;
 
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
-		if (same_suspect(ent->suspect, next->suspect) &&
+		if (ent->suspect == next->suspect &&
 		    ent->guilty == next->guilty &&
 		    ent->s_lno + ent->num_lines == next->s_lno) {
 			ent->num_lines += next->num_lines;
@@ -735,7 +726,7 @@ static int find_last_in_target(struct scoreboard *sb, struct origin *target)
 	int last_in_target = -1;
 
 	for (e = sb->ent; e; e = e->next) {
-		if (e->guilty || !same_suspect(e->suspect, target))
+		if (e->guilty || e->suspect != target)
 			continue;
 		if (last_in_target < e->s_lno + e->num_lines)
 			last_in_target = e->s_lno + e->num_lines;
@@ -755,7 +746,7 @@ static void blame_chunk(struct scoreboard *sb,
 	struct blame_entry *e;
 
 	for (e = sb->ent; e; e = e->next) {
-		if (e->guilty || !same_suspect(e->suspect, target))
+		if (e->guilty || e->suspect != target)
 			continue;
 		if (same <= e->s_lno)
 			continue;
@@ -985,7 +976,7 @@ static int find_move_in_parent(struct scoreboard *sb,
 	while (made_progress) {
 		made_progress = 0;
 		for (e = sb->ent; e; e = e->next) {
-			if (e->guilty || !same_suspect(e->suspect, target) ||
+			if (e->guilty || e->suspect != target ||
 			    ent_score(sb, e) < blame_move_score)
 				continue;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
@@ -1020,14 +1011,14 @@ static struct blame_list *setup_blame_list(struct scoreboard *sb,
 
 	for (e = sb->ent, num_ents = 0; e; e = e->next)
 		if (!e->scanned && !e->guilty &&
-		    same_suspect(e->suspect, target) &&
+		    e->suspect == target &&
 		    min_score < ent_score(sb, e))
 			num_ents++;
 	if (num_ents) {
 		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
 		for (e = sb->ent, i = 0; e; e = e->next)
 			if (!e->scanned && !e->guilty &&
-			    same_suspect(e->suspect, target) &&
+			    e->suspect == target &&
 			    min_score < ent_score(sb, e))
 				blame_list[i++].ent = e;
 	}
@@ -1171,7 +1162,7 @@ static void pass_whole_blame(struct scoreboard *sb,
 		origin->file.ptr = NULL;
 	}
 	for (e = sb->ent; e; e = e->next) {
-		if (!same_suspect(e->suspect, origin))
+		if (e->suspect != origin)
 			continue;
 		origin_incref(porigin);
 		origin_decref(e->suspect);
@@ -1560,7 +1551,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
-			if (same_suspect(ent->suspect, suspect))
+			if (ent->suspect == suspect)
 				found_guilty_entry(ent);
 		origin_decref(suspect);
 
-- 
1.8.3.2
