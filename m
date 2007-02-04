From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1.5/2] fix git-rev-parse for ...@{0}
Date: Sat, 03 Feb 2007 22:56:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702032254040.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 04:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDYVI-0003Ur-FR
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 04:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbXBDD4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 22:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbXBDD4r
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 22:56:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60567 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXBDD4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 22:56:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCX004PJ6YLMA50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 22:56:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38644>

My patch enabling HEAD@{...} broke the @{0} case.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sha1_name.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9841b05..d77f770 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -267,7 +267,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 	return refs_found;
 }
 
-static int dwim_log(const char *str, int len, char **log)
+static int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
 	const char **p;
 	int logs_found = 0;
@@ -278,8 +278,10 @@ static int dwim_log(const char *str, int len, char **log)
 		char *path = mkpath(*p, len, str);
 		if (!stat(git_path("logs/%s", path), &st) &&
 		    S_ISREG(st.st_mode)) {
-			if (!logs_found++)
+			if (!logs_found++) {
 				*log = xstrdup(path);
+				resolve_ref(path, sha1, 0, NULL);
+			}
 			if (!warn_ambiguous_refs)
 				break;
 		}
@@ -317,7 +319,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	} else if (reflog_len)
-		refs_found = dwim_log(str, len, &real_ref);
+		refs_found = dwim_log(str, len, sha1, &real_ref);
 	else
 		refs_found = dwim_ref(str, len, sha1, &real_ref);
 
-- 
1.5.0.rc2.652.g4dfde-dirty
