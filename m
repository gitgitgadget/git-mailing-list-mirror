From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 5/6] Fix "git-local-fetch -s" with packed source repository
Date: Fri, 23 Sep 2005 16:28:33 +0400 (MSD)
Message-ID: <20050923122833.49AD2E010FC@center4.mivlgu.local>
References: <20050923122754.GB2197@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:30:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImfO-00079T-29
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVIWM2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVIWM2f
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:35 -0400
Received: from mivlgu.ru ([81.18.140.87]:16336 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750934AbVIWM2e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:34 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 49AD2E010FC; Fri, 23 Sep 2005 16:28:33 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050923122754.GB2197@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9187>

"git-local-fetch -s" did not work with a packed repository, because
symlink() happily created a link to a non-existing object file,
therefore fetch_file() always returned success, and fetch_pack() was
not called.  Fixed by calling stat() before symlink() to ensure the
file really exists.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 local-fetch.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

40d9d7c0c86ee790a330f2fb3e1355bde4e9d434
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -65,9 +65,17 @@ static int copy_file(const char *source,
 			return -1;
 		}
 	}
-	if (use_symlink && !symlink(source, dest)) {
-		pull_say("symlink %s\n", hex);
-		return 0;
+	if (use_symlink) {
+		struct stat st;
+		if (stat(source, &st)) {
+			fprintf(stderr, "cannot stat %s: %s\n", source,
+				strerror(errno));
+			return -1;
+		}
+		if (!symlink(source, dest)) {
+			pull_say("symlink %s\n", hex);
+			return 0;
+		}
 	}
 	if (use_filecopy) {
 		int ifd, ofd, status;
