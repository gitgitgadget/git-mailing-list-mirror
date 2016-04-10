From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/3] index-helper: fix UNIX_PATH_MAX redefinition error on
 cygwin
Date: Sun, 10 Apr 2016 23:59:58 +0100
Message-ID: <570ADAEE.20201@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 01:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apOL2-0007sF-6h
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 01:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbcDJXAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 19:00:05 -0400
Received: from avasout08.plus.net ([212.159.14.20]:49347 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcDJXAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 19:00:04 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id gn001s0032D2Veb01n02qS; Mon, 11 Apr 2016 00:00:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=VVostui09viuwyME698A:9 a=1S-_CKO0HFGbbtuZ:21
 a=2b1SE7ex9I-SSZKX:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291191>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 git-compat-util.h | 17 -----------------
 index-helper.c    |  4 ++--
 read-cache.c      |  2 +-
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 0e35c13..c90c8c6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1043,21 +1043,4 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
-#ifdef __linux__
-#define UNIX_PATH_MAX 108
-#elif defined(__APPLE__) || defined(BSD)
-#define UNIX_PATH_MAX 104
-#else
-/*
- * Quoth POSIX: The size of sun_path has intentionally been left
- * undefined. This is because different implementations use different
- * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD uses a
- * size of 104. Since most implementations originate from BSD
- * versions, the size is typically in the range 92 to 108.
- *
- * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any buffers!
- */
-#define UNIX_PATH_MAX 92
-#endif
-
 #endif
diff --git a/index-helper.c b/index-helper.c
index 4d08ff4..4a8e2ae 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -309,7 +309,7 @@ static int setup_socket(const char *socket_path)
 	int len;
 
 	len = strlen(socket_path);
-	if (len > UNIX_PATH_MAX - 1)
+	if (len > sizeof(address.sun_path) - 1)
 		die("path %s is too long for a socket", socket_path);
 
 	fd = socket(PF_UNIX, SOCK_STREAM, 0);
@@ -317,7 +317,7 @@ static int setup_socket(const char *socket_path)
 		return -1;
 
 	address.sun_family = AF_UNIX;
-	strncpy(address.sun_path, socket_path, UNIX_PATH_MAX);
+	strncpy(address.sun_path, socket_path, sizeof(address.sun_path));
 
 	if (bind(fd, (struct sockaddr *) &address, sizeof(address)))
 		die_errno(_("failed to bind to socket %s"), socket_path);
diff --git a/read-cache.c b/read-cache.c
index ab2fbaa..c7053d8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1728,7 +1728,7 @@ int connect_to_index_helper(void)
 	int fd;
 
 	if (readlink(git_path("index-helper.path"), address.sun_path,
-		     UNIX_PATH_MAX) < 0)
+		     sizeof(address.sun_path)) < 0)
 		return -1;
 
 	fd = socket(PF_UNIX, SOCK_STREAM, 0);
-- 
2.8.0
