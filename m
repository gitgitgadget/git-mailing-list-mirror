From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] copy_fd: close ifd on error
Date: Tue, 27 Dec 2005 09:19:05 +0100
Message-ID: <20051227081905.GA9946@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 27 09:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErAWh-0003GN-I1
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 09:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVL0Itp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 03:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVL0Itp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 03:49:45 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:10389 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932270AbVL0Ito
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 03:49:44 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 3CC27262856
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 09:49:41 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 7119D6AD668; Tue, 27 Dec 2005 09:19:05 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14072>

In copy_fd when write fails we ought to close input file descriptor.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Found while looking at the source for inspiration for something else.
I did not see any error related to this.

	Sam

diff --git a/copy.c b/copy.c
index 7100eed..08a3d38 100644
--- a/copy.c
+++ b/copy.c
@@ -22,11 +22,14 @@ int copy_fd(int ifd, int ofd)
 				buf += written;
 				len -= written;
 			}
-			else if (!written)
+			else if (!written) {
+				close(ifd);
 				return error("copy-fd: write returned 0");
-			else
+			} else {
+				close(ifd);
 				return error("copy-fd: write returned %s",
 					     strerror(errno));
+			}
 		}
 	}
 	close(ifd);
