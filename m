From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] minor git-prune optimization
Date: Tue, 20 Mar 2007 23:32:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703202326380.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 04:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTrYk-0002Kp-69
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 04:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933403AbXCUDcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 23:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933571AbXCUDcO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 23:32:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26921 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403AbXCUDcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 23:32:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF800ELTHTPP8B0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 23:32:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42777>

Don't try to remove the containing directory for every pruned object but
try only once after the directory has been scanned instead.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-prune.c b/builtin-prune.c
index 09864b7..44df59e 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -14,10 +14,8 @@ static int prune_object(char *path, const char *filename, const unsigned char *s
 		enum object_type type = sha1_object_info(sha1, NULL);
 		printf("%s %s\n", sha1_to_hex(sha1),
 		       (type > 0) ? typename(type) : "unknown");
-		return 0;
-	}
-	unlink(mkpath("%s/%s", path, filename));
-	rmdir(path);
+	} else
+		unlink(mkpath("%s/%s", path, filename));
 	return 0;
 }
 
@@ -60,6 +58,8 @@ static int prune_dir(int i, char *path)
 		}
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
+	if (!show_only)
+		rmdir(path);
 	closedir(dir);
 	return 0;
 }
