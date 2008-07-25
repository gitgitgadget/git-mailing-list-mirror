From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-reset: Let -q hush "locally modified" messages
Date: Fri, 25 Jul 2008 22:49:08 +0200
Message-ID: <1217018948-32475-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Carlos Rica <jasampler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 22:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMUF1-00011m-Oi
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 22:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbYGYUtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbYGYUtT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 16:49:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:38542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750827AbYGYUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 16:49:18 -0400
Received: (qmail invoked by alias); 25 Jul 2008 20:49:17 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp067) with SMTP; 25 Jul 2008 22:49:17 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+iPp4cUFaiZj9lJoqHzWIsqrM18vyy6HgVjx4WnQ
	3sjI3YOQDGDStD
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMUDs-0008SN-Qb; Fri, 25 Jul 2008 22:49:08 +0200
X-Mailer: git-send-email 1.6.0.rc0.49.g3d2ce
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90113>

git reset -q makes reset more quiet, but "locally modified" messages are
still shown.  This patch makes them disappear, too.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Hi,

I don't know if this was actually a bug or a feature.
I considered this a bug, so here's a patch.

Regards,
  Stephan


 builtin-reset.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 4d246c3..c24c219 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -85,7 +85,7 @@ static void print_new_head_line(struct commit *commit)
 		printf("\n");
 }
 
-static int update_index_refresh(int fd, struct lock_file *index_lock)
+static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
 {
 	int result;
 
@@ -96,7 +96,8 @@ static int update_index_refresh(int fd, struct lock_file *index_lock)
 
 	if (read_cache() < 0)
 		return error("Could not read index");
-	result = refresh_cache(REFRESH_SAY_CHANGED) ? 1 : 0;
+
+	result = refresh_cache(flags) ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
@@ -128,7 +129,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 }
 
 static int read_from_tree(const char *prefix, const char **argv,
-		unsigned char *tree_sha1)
+		unsigned char *tree_sha1, int refresh_flags)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd, index_was_discarded = 0;
@@ -152,7 +153,7 @@ static int read_from_tree(const char *prefix, const char **argv,
 	if (!index_was_discarded)
 		/* The index is still clobbered from do_diff_cache() */
 		discard_cache();
-	return update_index_refresh(index_fd, lock);
+	return update_index_refresh(index_fd, lock, refresh_flags);
 }
 
 static void prepend_reflog_action(const char *action, char *buf, size_t size)
@@ -246,7 +247,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		else if (reset_type != NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
-		return read_from_tree(prefix, argv + i, sha1);
+		return read_from_tree(prefix, argv + i, sha1,
+				quiet ? REFRESH_QUIET : REFRESH_SAY_CHANGED);
 	}
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
@@ -286,7 +288,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	case SOFT: /* Nothing else to do. */
 		break;
 	case MIXED: /* Report what has not been updated. */
-		update_index_refresh(0, NULL);
+		update_index_refresh(0, NULL,
+				quiet ? REFRESH_QUIET : REFRESH_SAY_CHANGED);
 		break;
 	}
 
-- 
1.6.0.rc0.49.g3d2ce
