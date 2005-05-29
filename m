From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] diff: consolidate various calls into diffcore.
Date: Sun, 29 May 2005 16:56:13 -0700
Message-ID: <7v64x1h9ia.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:54:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXbZ-0002aN-Mb
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVE2X4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVE2X4d
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:56:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18608 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261469AbVE2X4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:56:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529235614.ZFCE1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 19:56:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 16:41:25 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The three diff-* brothers had a sequence of calls into diffcore
that were almost identical.  Introduce a new diffcore_std()
function that takes all the necessary arguments to consolidate
it.  This will make later enhancements and changing the order of
diffcore application simpler.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c |    9 +++------
diff-files.c |    9 +++------
diff-tree.c  |    7 +++----
diff.c       |   12 ++++++++++++
diff.h       |    4 ++++
5 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -240,12 +240,9 @@ int main(int argc, const char **argv)
 		die("unable to read tree object %s", tree_name);
 
 	ret = diff_cache(active_cache, active_nr);
-	if (pathspec)
-		diffcore_pathspec(pathspec);
-	if (detect_rename)
-		diffcore_rename(detect_rename, diff_score_opt);
-	if (pickaxe)
-		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	diffcore_std(pathspec,
+		     detect_rename, diff_score_opt,
+		     pickaxe, pickaxe_opts);
 	diff_flush(diff_output_format, 1);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -116,12 +116,9 @@ int main(int argc, const char **argv)
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
 	}
-	if (1 < argc)
-		diffcore_pathspec(argv + 1);
-	if (detect_rename)
-		diffcore_rename(detect_rename, diff_score_opt);
-	if (pickaxe)
-		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	diffcore_std(argv + 1,
+		     detect_rename, diff_score_opt,
+		     pickaxe, pickaxe_opts);
 	diff_flush(diff_output_format, 1);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -261,10 +261,9 @@ static void call_diff_setup(void)
 
 static int call_diff_flush(void)
 {
-	if (detect_rename)
-		diffcore_rename(detect_rename, diff_score_opt);
-	if (pickaxe)
-		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	diffcore_std(0,
+		     detect_rename, diff_score_opt,
+		     pickaxe, pickaxe_opts);
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -887,6 +887,18 @@ void diff_flush(int diff_output_style, i
 	q->nr = q->alloc = 0;
 }
 
+void diffcore_std(const char **paths,
+		  int detect_rename, int rename_score,
+		  const char *pickaxe, int pickaxe_opts)
+{
+	if (paths && paths[0])
+		diffcore_pathspec(paths);
+	if (detect_rename)
+		diffcore_rename(detect_rename, rename_score);
+	if (pickaxe)
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
+}
+
 void diff_addremove(int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *base, const char *path)
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -43,6 +43,10 @@ extern void diffcore_pickaxe(const char 
 
 extern void diffcore_pathspec(const char **pathspec);
 
+extern void diffcore_std(const char **paths,
+			 int detect_rename, int rename_score,
+			 const char *pickaxe, int pickaxe_opts);
+
 extern int diff_queue_is_empty(void);
 
 #define DIFF_FORMAT_HUMAN	0

