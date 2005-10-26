From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix cloning (memory corruption)
Date: Wed, 26 Oct 2005 16:18:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261616550.21073@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 16:21:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUm7U-00035K-EV
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 16:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVJZOS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 10:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVJZOS7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 10:18:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5859 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751494AbVJZOS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 10:18:58 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8CB5313F39A; Wed, 26 Oct 2005 16:18:57 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 722E89ABBB; Wed, 26 Oct 2005 16:18:57 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5DFB99AB53; Wed, 26 Oct 2005 16:18:57 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F97313F39A; Wed, 26 Oct 2005 16:18:57 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10666>

upload-pack would set create_full_pack=1 if nr_has==0, but would ask later
if nr_needs<MAX_NEEDS. If that proves true, it would ignore create_full_pack,
and arguments would be written into unreserved memory.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This patch fixes what can be seen in all beauty when executing

		git-clone . some_dir

	in a repository with lots of branches/tags.

 upload-pack.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

applies-to: 764f8a201d063a7b49b07daa3a6e48b0af267162
d05392d3ddfa647552190b73505a738330e492b4
diff --git a/upload-pack.c b/upload-pack.c
index 07c1505..878254d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -60,7 +60,7 @@ static void create_pack_file(void)
 		close(fd[1]);
 		*p++ = "git-rev-list";
 		*p++ = "--objects";
-		if (MAX_NEEDS <= nr_needs)
+		if (create_full_pack || MAX_NEEDS <= nr_needs)
 			*p++ = "--all";
 		else {
 			for (i = 0; i < nr_needs; i++) {
@@ -69,12 +69,13 @@ static void create_pack_file(void)
 				buf += 41;
 			}
 		}
-		for (i = 0; i < nr_has; i++) {
-			*p++ = buf;
-			*buf++ = '^';
-			memcpy(buf, sha1_to_hex(has_sha1[i]), 41);
-			buf += 41;
-		}
+		if (!create_full_pack)
+			for (i = 0; i < nr_has; i++) {
+				*p++ = buf;
+				*buf++ = '^';
+				memcpy(buf, sha1_to_hex(has_sha1[i]), 41);
+				buf += 41;
+			}
 		*p++ = NULL;
 		execvp("git-rev-list", argv);
 		die("git-upload-pack: unable to exec git-rev-list");
---
0.99.8.GIT
