From: Ariel Badichi <abadichi@bezeqint.net>
Subject: [PATCH] copy.c: copy_fd - correctly report write errors
Date: Wed, 23 Apr 2008 04:05:29 +0300
Message-ID: <877ieppehy.fsf@sneeze.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 03:03:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoTO1-0000Q3-4y
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 03:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbYDWBCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 21:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758385AbYDWBCO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 21:02:14 -0400
Received: from bzq-84-110-251-84.red.bezeqint.net ([84.110.251.84]:25570 "EHLO
	sneeze.site" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756396AbYDWBCO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 21:02:14 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2008 21:02:13 EDT
Received: by sneeze.site (Postfix, from userid 1000)
	id D4F217A79E; Wed, 23 Apr 2008 04:05:30 +0300 (IDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80176>


Previously, the errno could have been lost due to an intervening
close() call.

This patch also contains minor cosmetic changes.

Signed-off-by: Ariel Badichi <abadichi@bezeqint.net>
---
 copy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/copy.c b/copy.c
index afc4fbf..e54d15a 100644
--- a/copy.c
+++ b/copy.c
@@ -9,8 +9,7 @@ int copy_fd(int ifd, int ofd)
 		if (!len)
 			break;
 		if (len < 0) {
-			int read_error;
-			read_error = errno;
+			int read_error = errno;
 			close(ifd);
 			return error("copy-fd: read returned %s",
 				     strerror(read_error));
@@ -25,9 +24,10 @@ int copy_fd(int ifd, int ofd)
 				close(ifd);
 				return error("copy-fd: write returned 0");
 			} else {
+				int write_error = errno;
 				close(ifd);
 				return error("copy-fd: write returned %s",
-					     strerror(errno));
+					     strerror(write_error));
 			}
 		}
 	}
@@ -48,7 +48,7 @@ int copy_file(const char *dst, const char *src, int mode)
 	}
 	status = copy_fd(fdi, fdo);
 	if (close(fdo) != 0)
-		return error("%s: write error: %s", dst, strerror(errno));
+		return error("%s: close error: %s", dst, strerror(errno));
 
 	if (!status && adjust_shared_perm(dst))
 		return -1;
-- 
1.5.5.1.57.g5909c
