From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] Work around missing hard links on FAT formatted media
Date: Wed, 26 Oct 2005 01:41:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260140320.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:41:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYQ0-0005PH-RV
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVJYXlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVJYXlW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:41:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18835 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932483AbVJYXlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:41:21 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EDC5413EEF1; Wed, 26 Oct 2005 01:41:20 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D12F6B0D71; Wed, 26 Oct 2005 01:41:20 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A70F3B00FD; Wed, 26 Oct 2005 01:41:20 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 972CE13EEF1; Wed, 26 Oct 2005 01:41:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10635>

FAT -- like Coda -- does not like cross-directory hard links. To be 
precise, FAT does not like links at all. But links are not needed either. 
So get rid of them.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 clone-pack.c |    2 +-
 sha1_file.c  |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

applies-to: 73c52ee93ee1d5441a4cb207287b3ba7b0d8f4ed
8ffaffc904086970c66e5e8b7dd54001a1a2c466
diff --git a/clone-pack.c b/clone-pack.c
index 4f4975b..9609219 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -211,7 +211,7 @@ static int clone_without_unpack(int fd[2
 
 	ifd = fd[0];
 	snprintf(tmpfile, sizeof(tmpfile),
-		 "%s/pack-XXXXXX", get_object_directory());
+		 "%s/pack/tmp-XXXXXX", get_object_directory());
 	ofd = mkstemp(tmpfile);
 	if (ofd < 0)
 		return error("unable to create temporary file %s", tmpfile);
diff --git a/sha1_file.c b/sha1_file.c
index e456799..7fdc469 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1239,11 +1239,14 @@ int move_temp_to_file(const char *tmpfil
 		 * won't be able to check collisions, but that's not a
 		 * big deal.
 		 *
+		 * The same holds for FAT formatted media.
+		 *
 		 * When this succeeds, we just return 0. We have nothing
 		 * left to unlink.
 		 */
-		if (ret == EXDEV && !rename(tmpfile, filename))
+		if ((ret == EXDEV || ret == ENOTSUP) && !rename(tmpfile, filename))
 			return 0;
+		ret = errno;
 	}
 	unlink(tmpfile);
 	if (ret) {
---
0.99.8.GIT
