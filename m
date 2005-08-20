From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Call prune-packed from "git prune" as well.
Date: Fri, 19 Aug 2005 21:41:57 -0700
Message-ID: <7vll2xqkx6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 06:43:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6LBN-00053H-5f
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 06:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVHTEmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 00:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVHTEmA
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 00:42:00 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6907 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750711AbVHTEl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 00:41:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820044159.FLXO550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 00:41:59 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add -n (dryrun) flag to git-prune-packed, and call it from "git prune".

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-prune-script |    6 ++++--
 prune-packed.c   |   16 ++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

51890a64eb152fb914d0dd3676f549ab8d8cc49a
diff --git a/git-prune-script b/git-prune-script
--- a/git-prune-script
+++ b/git-prune-script
@@ -3,10 +3,11 @@
 . git-sh-setup-script || die "Not a git archive"
 
 dryrun=
+echo=
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
-    -n) dryrun=echo ;;
+    -n) dryrun=-n echo=echo ;;
     --) break ;;
     -*) echo >&2 "usage: git-prune-script [ -n ] [ heads... ]"; exit 1 ;;
     *)  break ;;
@@ -20,6 +21,7 @@ sed -ne '/unreachable /{
     s|\(..\)|\1/|p
 }' | {
 	cd "$GIT_OBJECT_DIRECTORY" || exit
-	xargs $dryrun rm -f
+	xargs $echo rm -f
 }
 
+git-prune-packed $dryrun
diff --git a/prune-packed.c b/prune-packed.c
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 
-static const char prune_packed_usage[] = "git-prune-packed (no arguments)";
+static const char prune_packed_usage[] =
+"git-prune-packed [-n]";
+
+static int dryrun;
 
 static void prune_dir(int i, DIR *dir, char *pathname, int len)
 {
@@ -18,7 +21,9 @@ static void prune_dir(int i, DIR *dir, c
 		if (!has_sha1_pack(sha1))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
-		if (unlink(pathname) < 0)
+		if (dryrun)
+			printf("rm -f %s\n", pathname);
+		else if (unlink(pathname) < 0)
 			error("unable to unlink %s", pathname);
 	}
 }
@@ -55,8 +60,11 @@ int main(int argc, char **argv)
 		const char *arg = argv[i];
 
 		if (*arg == '-') {
-			/* Handle flags here .. */
-			usage(prune_packed_usage);
+			if (!strcmp(arg, "-n"))
+				dryrun = 1;
+			else
+				usage(prune_packed_usage);
+			continue;
 		}
 		/* Handle arguments here .. */
 		usage(prune_packed_usage);
