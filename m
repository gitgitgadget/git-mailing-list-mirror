From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Optionally tell show-diff to show only named files
Date: Sat, 16 Apr 2005 16:15:00 -0700
Message-ID: <7vy8bi48ln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwSH-0003C4-Hd
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDPXPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDPXPk
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:15:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5369 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261188AbVDPXP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 19:15:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416231501.QSK18934.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 19:15:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

SCMs have ways to say "I want diff only this particular file",
or "I want diff files under this directory".  This patch teaches
show-diff to do something similar.  Without command line
arguments, it still examines everything in the dircache as
before.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

show-diff.c:  5f3d4699566843a5448260e5da286ed65d90e397
--- show-diff.c
+++ show-diff.c	2005-04-16 16:07:07.000000000 -0700
@@ -55,6 +55,23 @@
 	}
 }
 
+static const char *show_diff_usage = "show-diff [-s] [-q] [paths...]";
+
+static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
+{
+	int i;
+	int namelen = ce_namelen(ce);
+	for (i = 0; i < cnt; i++) {
+		int speclen = strlen(spec[i]);
+		if (! strncmp(spec[i], ce->name, speclen) &&
+		    speclen <= namelen &&
+		    (ce->name[speclen] == 0 ||
+		     ce->name[speclen] == '/'))
+			return 1;
+	}
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int silent = 0;
@@ -62,18 +79,19 @@
 	int entries = read_cache();
 	int i;
 
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "-s")) {
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "-s"))
 			silent_on_nonexisting_files = silent = 1;
-			continue;
-		}
-		if (!strcmp(argv[i], "-q")) {
+		else if (!strcmp(argv[1], "-q"))
 			silent_on_nonexisting_files = 1;
-			continue;
-		}
-		usage("show-diff [-s] [-q]");
+		else
+			usage(show_diff_usage);
+		argv++; argc--;
 	}
 
+	/* At this point, if argc == 1, then we are doing everything.
+	 * Otherwise argv[1] .. argv[argc-1] have the explicit paths.
+	 */
 	if (entries < 0) {
 		perror("read_cache");
 		exit(1);
@@ -86,6 +104,10 @@
 		char type[20];
 		void *new;
 
+		if (1 <argc &&
+		    ! matches_pathspec(ce, argv+1, argc-1))
+			continue;
+
 		if (stat(ce->name, &st) < 0) {
 			if (errno == ENOENT && silent_on_nonexisting_files)
 				continue;


