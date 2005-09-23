From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 4/6] git-local-fetch: Avoid calling close(-1)
Date: Fri, 23 Sep 2005 16:28:28 +0400 (MSD)
Message-ID: <20050923122828.43796E010FC@center4.mivlgu.local>
References: <20050923122754.GB2197@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:29:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImfJ-000795-Tp
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVIWM2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVIWM2a
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:30 -0400
Received: from mivlgu.ru ([81.18.140.87]:15568 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750934AbVIWM23 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:29 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 43796E010FC; Fri, 23 Sep 2005 16:28:28 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050923122754.GB2197@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9183>

After open() failure, copy_file() called close(ifd) with ifd == -1
(harmless, but causes Valgrind noise).  The same thing was possible
for the destination file descriptor.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 local-fetch.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

bb38750b6016dcd8dc71b2cd0a3bdef035f6508d
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -75,7 +75,8 @@ static int copy_file(const char *source,
 		void *map;
 		ifd = open(source, O_RDONLY);
 		if (ifd < 0 || fstat(ifd, &st) < 0) {
-			close(ifd);
+			if (ifd >= 0)
+				close(ifd);
 			fprintf(stderr, "cannot open %s\n", source);
 			return -1;
 		}
@@ -89,7 +90,8 @@ static int copy_file(const char *source,
 		status = ((ofd < 0) ||
 			  (write(ofd, map, st.st_size) != st.st_size));
 		munmap(map, st.st_size);
-		close(ofd);
+		if (ofd >= 0)
+			close(ofd);
 		if (status)
 			fprintf(stderr, "cannot write %s\n", dest);
 		else
