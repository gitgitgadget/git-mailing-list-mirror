From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v6 5/6] Change copy_fd() to not close input fd
Date: Tue, 26 Aug 2014 17:23:24 +0200
Message-ID: <1409066605-4851-6-git-send-email-prohaska@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:24:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIbQ-0001Gq-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758467AbaHZPX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:23:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:35477 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755843AbaHZPXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:23:55 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNego011316;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNcNe011272;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1409066605-4851-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FCA67C.005 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FCA67C.005 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FCA67C.005 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255911>

The caller opened the fd, so it should be responsible for closing it.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 copy.c     | 5 +----
 lockfile.c | 3 +++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/copy.c b/copy.c
index a7f58fd..d0a1d82 100644
--- a/copy.c
+++ b/copy.c
@@ -10,7 +10,6 @@ int copy_fd(int ifd, int ofd)
 			break;
 		if (len < 0) {
 			int read_error = errno;
-			close(ifd);
 			return error("copy-fd: read returned %s",
 				     strerror(read_error));
 		}
@@ -21,17 +20,14 @@ int copy_fd(int ifd, int ofd)
 				len -= written;
 			}
 			else if (!written) {
-				close(ifd);
 				return error("copy-fd: write returned 0");
 			} else {
 				int write_error = errno;
-				close(ifd);
 				return error("copy-fd: write returned %s",
 					     strerror(write_error));
 			}
 		}
 	}
-	close(ifd);
 	return 0;
 }
 
@@ -60,6 +56,7 @@ int copy_file(const char *dst, const char *src, int mode)
 		return fdo;
 	}
 	status = copy_fd(fdi, fdo);
+	close(fdi);
 	if (close(fdo) != 0)
 		return error("%s: close error: %s", dst, strerror(errno));
 
diff --git a/lockfile.c b/lockfile.c
index 2564a7f..2448d30 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -224,8 +224,11 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	} else if (copy_fd(orig_fd, fd)) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
+		close(orig_fd);
 		close(fd);
 		return -1;
+	} else {
+		close(orig_fd);
 	}
 	return fd;
 }
-- 
2.1.0.8.gf3a29c8
