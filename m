From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] sequencer: free memory used in "make_patch" function
Date: Fri, 26 Jun 2009 23:08:45 +0200
Message-ID: <20090626210847.3885.22240.chriscool@tuxfamily.org>
References: <20090626205319.3885.91532.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKIfS-0000qR-Lc
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 23:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbZFZVIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 17:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbZFZVIx
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 17:08:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56327 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbZFZVIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 17:08:51 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D0E2281814C;
	Fri, 26 Jun 2009 23:08:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 77179818127;
	Fri, 26 Jun 2009 23:08:42 +0200 (CEST)
X-git-sha1: 22b73059cb27dda987801681d51ee80d74f53c74 
X-Mailer: git-mail-commits v0.5.0
In-Reply-To: <20090626205319.3885.91532.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122322>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 8d32480..1dda525 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -18,6 +18,7 @@ static void make_patch(struct commit *commit)
 	struct commit_list *parents = commit->parents;
 	const char **args;
 	struct child_process chld;
+	int i;
 	int fd = open(PATCH_FILE, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		return;
@@ -34,20 +35,22 @@ static void make_patch(struct commit *commit)
 		args[2] = xstrdup(sha1_to_hex(parents->item->object.sha1));
 		args[3] = xstrdup(sha1_to_hex(((struct object *)commit)->sha1));
 	} else {
-		int i = 0;
 		int count = 1;
 
 		for (; parents; parents = parents->next)
 			++count;
+
+		i = 0;
 		args = xcalloc(count + 3, sizeof(char *));
 		args[i++] = "diff";
 		args[i++] = "--cc";
 		args[i++] = xstrdup(sha1_to_hex(commit->object.sha1));
 
 		for (parents = commit->parents; parents;
-		     parents = parents->next)
-			args[i++] = xstrdup(sha1_to_hex(
-					    parents->item->object.sha1));
+		     parents = parents->next) {
+			char *hex = sha1_to_hex(parents->item->object.sha1);
+			args[i++] = xstrdup(hex);
+		}
 	}
 
 	chld.argv = args;
@@ -55,11 +58,12 @@ static void make_patch(struct commit *commit)
 	chld.out = fd;
 
 	/* Run, ignore errors. */
-	if (start_command(&chld))
-		return;
-	finish_command(&chld);
+	if (!start_command(&chld))
+		finish_command(&chld);
 
-	/* TODO: free dup'ed SHAs in argument list */
+	for (i = 2; args[i]; i++)
+		free((char *)args[i]);
+	free(args);
 }
 
 /* Return a commit object of "arg" */
-- 
1.6.3.GIT
