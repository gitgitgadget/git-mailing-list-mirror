From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 3/6] connect: only match the host with core.gitProxy
Date: Sun,  1 May 2016 15:02:50 +0900
Message-ID: <1462082573-17992-4-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTM-0007yr-Qp
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcEAGDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33602 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbcEAGC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:02:59 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkSz-0004h4-VW; Sun, 01 May 2016 15:02:53 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293138>

Currently, core.gitProxy doesn't actually match purely on domain names
as documented: it also matches ports.

So a core.gitProxy value like "script for kernel.org" doesn't make the
script called for an url like git://kernel.org:port/path, while it is
called for git://kernel.org/path.

This per-port behavior seems like an oversight rather than a deliberate
choice, so, make git://kernel.org:port/path call the gitProxy script in
the case described above.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 98449bc..1c8ed6b 100644
--- a/connect.c
+++ b/connect.c
@@ -695,7 +695,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
-		if (git_use_proxy(hostandport))
+		if (git_use_proxy(host))
 			conn = git_proxy_connect(fd, hostandport);
 		else
 			git_tcp_connect(fd, hostandport, flags);
-- 
2.8.1.16.g58dac65.dirty
