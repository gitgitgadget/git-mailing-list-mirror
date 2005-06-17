From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] support incremental cvs2git-ing
Date: Fri, 17 Jun 2005 18:26:57 +0200
Message-ID: <20050617162657.GG9986MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050610193519.GA28628@lumumba.luc.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 17 18:33:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjJlJ-0000JN-RA
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 18:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVFQQhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVFQQhX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 12:37:23 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:10182 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262014AbVFQQgy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2005 12:36:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id EBB444BE7D
	for <git@vger.kernel.org>; Fri, 17 Jun 2005 18:36:52 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 62C374BE75
	for <git@vger.kernel.org>; Fri, 17 Jun 2005 18:36:51 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 52A2E4C2C5
	for <git@vger.kernel.org>; Fri, 17 Jun 2005 18:36:51 +0200 (CEST)
Received: (qmail 5270 invoked by uid 500); 17 Jun 2005 16:26:57 -0000
To: Panagiotis Issaris <takis@lumumba.luc.ac.be>
Mail-Followup-To: Panagiotis Issaris <takis@lumumba.luc.ac.be>,
	torvalds@osdl.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050610193519.GA28628@lumumba.luc.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2005 at 09:35:19PM +0200, Panagiotis Issaris wrote:
> Hi Linus,
> 
> I wanted to be able to track CVS repositories in a GIT repository. The
> cvs2git program worked fine with the initial import but needed a tiny
> modification to enable me to resync the GIT repository with the updated
> CVS tree.
> 

The original version of this patch failed to track the correct
branch on the first new commit.
Fixed and tested patch below.

skimo
--
cvs2git.c: support incremental conversion

Add -u option to indicate incremental conversion.

Signed-off-by: Panagiotis Issaris <takis@lumumba.luc.ac.be>
Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit 67fcd1648f66d04972c90860b58449f586718653
tree 698e9c37f91c88c797cab7324d69106b898987a3
parent 4fd62062eb2d52d32cb771feb05bf1ee29d760f9
author Panagiotis Issaris <takis@lumumba.luc.ac.be> Fri, 17 Jun 2005 18:30:27 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Fri, 17 Jun 2005 18:30:27 +0200

 cvs2git.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/cvs2git.c b/cvs2git.c
--- a/cvs2git.c
+++ b/cvs2git.c
@@ -28,11 +28,17 @@ static int verbose = 0;
  * Usage:
  *
  *	TZ=UTC cvsps -A |
- *		cvs2git --cvsroot=[root] --module=[module] > script
+ *		git-cvs2git --cvsroot=[root] --module=[module] > script
  *
  * Creates a shell script that will generate the .git archive of
  * the names CVS repository.
  *
+ *	TZ=UTC cvsps -s 1234- -A |
+ *		git-cvs2git -u --cvsroot=[root] --module=[module] > script
+ *
+ * Creates a shell script that will update the .git archive with
+ * CVS changes from patchset 1234 until the last one.
+ *
  * IMPORTANT NOTE ABOUT "cvsps"! This requires version 2.1 or better,
  * and the "TZ=UTC" and the "-A" flag is required for sane results!
  */
@@ -230,6 +236,10 @@ int main(int argc, char **argv)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-u")) {
+			initial_commit = 0;
+			continue;
+		}
 	}
 
 
@@ -241,11 +251,13 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	printf("[ -d .git ] && exit 1\n");
-	printf("git-init-db\n");
-	printf("mkdir -p .git/refs/heads\n");
-	printf("mkdir -p .git/refs/tags\n");
-	printf("ln -sf refs/heads/master .git/HEAD\n");
+	if (initial_commit) {
+		printf("[ -d .git ] && exit 1\n");
+		    printf("git-init-db\n");
+		printf("mkdir -p .git/refs/heads\n");
+		printf("mkdir -p .git/refs/tags\n");
+		printf("ln -sf refs/heads/master .git/HEAD\n");
+	}
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int linelen = strlen(line);
