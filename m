From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] C version of git-count-objects, second try
Date: Thu, 27 Apr 2006 16:07:18 +0200
Message-ID: <20060427140718.GA19993@brainysmurf.cs.umu.se>
References: <20060427101254.GA22769@peppar.cs.umu.se> <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net, mwelinder@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 27 16:07:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ79j-0000KO-MB
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 16:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWD0OH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 10:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWD0OH3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 10:07:29 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:55186 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S965056AbWD0OH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 10:07:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 726CB2B9F;
	Thu, 27 Apr 2006 16:07:27 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23259-01-17; Thu, 27 Apr 2006 16:07:19 +0200 (MEST)
Received: from brainysmurf.cs.umu.se (brainysmurf.cs.umu.se [130.239.89.21])
	by mail.cs.umu.se (Postfix) with ESMTP id 39EAA2BA3;
	Thu, 27 Apr 2006 16:07:19 +0200 (MEST)
Received: by brainysmurf.cs.umu.se (Postfix, from userid 12006)
	id 5D8DC73C; Thu, 27 Apr 2006 16:07:18 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19235>

On Thu, Apr 27, 2006 at 09:23:47AM -0400, Nicolas Pitre wrote:
> On Thu, 27 Apr 2006, Peter Hagervall wrote:
> 
> > Answering the call Linus made[1], sort of, but for a completely
> > different program.
> > 
> > Anyway, it ought to be at least as portable as the shell script, and a
> > whole lot faster, however much that matters.
> > 
> [...]
> > +	for (i = 0; i < 16; i++) {
> > +		subdir[0] = hex_digits[i];
> > +		for (j = 0; j < 16; j++) {
> > +			subdir[1] = hex_digits[j];
> > +			if (access(subdir, R_OK | X_OK))
> > +				continue;
> > +			chdir(subdir);
> > +			if (!(dp = opendir("."))) {
> > +				error("can't open subdir %s", subdir);
> > +				continue;
> > +			}
> 
> Looks like you're missing a chdir(".."); there.
> 

Thanks, I overlooked that one (and the race condition pointed out by
Morten). Anyway, fixed those now, and removed an unused array.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

---

 Makefile             |    5 ++-
 count-objects.c      |   55 +++++++++++++++++++++++++++++++++++++
 git-count-objects.sh |   31 --------------------
 3 files changed, 58 insertions(+), 33 deletions(-)


diff --git a/Makefile b/Makefile
index 8ce27a6..53e7591 100644
--- a/Makefile
+++ b/Makefile
@@ -115,7 +115,7 @@ ### --- END CONFIGURATION SECTION ---
 SCRIPT_SH = \
 	git-add.sh git-bisect.sh git-branch.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
-	git-count-objects.sh git-diff.sh git-fetch.sh \
+	git-diff.sh git-fetch.sh \
 	git-format-patch.sh git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-prune.sh git-pull.sh git-push.sh git-rebase.sh \
@@ -165,7 +165,8 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
+	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
+	git-count-objects$X
 
 BUILT_INS = git-log$X
 
diff --git a/count-objects.c b/count-objects.c
new file mode 100644
index 0000000..beaa4d9
--- /dev/null
+++ b/count-objects.c
@@ -0,0 +1,55 @@
+#include "cache.h"
+#include "git-compat-util.h"
+
+static int numobjects, numblocks;
+static const char hex_digits[] = "0123456789abcdef";
+
+void count_objects(void)
+{
+	char subdir[3];
+	int i, j;
+	struct stat statbuf;
+	struct dirent *dirp;
+	DIR *dp;
+	subdir[2] = '\0';
+	for (i = 0; i < 16; i++) {
+		subdir[0] = hex_digits[i];
+		for (j = 0; j < 16; j++) {
+			subdir[1] = hex_digits[j];
+			if (chdir(subdir))
+				continue;
+			if (!(dp = opendir("."))) {
+				error("can't open subdir %s", subdir);
+				chdir("..");
+				continue;
+			}
+			while ((dirp = readdir(dp))) {
+				if (!strcmp(dirp->d_name, ".") ||
+					!strcmp(dirp->d_name, ".."))
+					continue;
+				if (lstat(dirp->d_name, &statbuf)) {
+					error("can't stat file %s", dirp->d_name);
+					continue;
+				}
+				numblocks += statbuf.st_blocks;
+				numobjects++;
+			}
+			closedir(dp);
+			chdir("..");
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	setup_git_directory();
+
+	if (chdir(".git/objects"))
+		die("%s", strerror(errno));
+
+	count_objects();
+
+	printf("%d objects, %d kilobytes\n", numobjects, numblocks / 2);
+
+	return 0;
+}
diff --git a/git-count-objects.sh b/git-count-objects.sh
deleted file mode 100755
index 40c58ef..0000000
--- a/git-count-objects.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
-
-dc </dev/null 2>/dev/null || {
-	# This is not a real DC at all -- it just knows how
-	# this script feeds DC and does the computation itself.
-	dc () {
-		while read a b
-		do
-			case $a,$b in
-			0,)	acc=0 ;;
-			*,+)	acc=$(($acc + $a)) ;;
-			p,)	echo "$acc" ;;
-			esac
-		done
-	}
-}
-
-echo $(find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l) objects, \
-$({
-    echo 0
-    # "no-such" is to help Darwin folks by not using xargs -r.
-    find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null |
-    xargs du -k "$GIT_DIR/objects/no-such" 2>/dev/null |
-    sed -e 's/[ 	].*/ +/'
-    echo p
-} | dc) kilobytes
