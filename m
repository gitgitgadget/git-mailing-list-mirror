From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] mailinfo: Use i18n.commitencoding
Date: Sun, 27 Nov 2005 16:39:22 -0800
Message-ID: <7v1x1161xh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 01:40:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgX3K-0007V0-7F
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 01:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVK1AjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 19:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVK1AjY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 19:39:24 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18927 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751204AbVK1AjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 19:39:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128003924.SSXL25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 19:39:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12838>

This uses i18n.commitencoding configuration item to pick up the
default commit encoding for the repository when converting form
e-mail encoding to commit encoding (the default is utf8).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I am not very thrilled with doing this change to mailinfo;
   alternatively the wrapper could read the configuration and
   decide what encoding to pass with -u=encoding flag.

 mailinfo.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

applies-to: dab00e61bbd43be526bce908d4142d7c80d7a325
f1f909e3185b5ee366e198042447afe749bfc813
diff --git a/mailinfo.c b/mailinfo.c
index 6d8c933..de105ac 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <iconv.h>
+#include "cache.h"
 
 #ifdef NO_STRCASESTR
 extern char *gitstrcasestr(const char *haystack, const char *needle);
@@ -718,27 +719,27 @@ static void handle_body(void)
 static const char mailinfo_usage[] =
 	"git-mailinfo [-k] [-u] msg patch <mail >info";
 
-static void usage(void) {
-	fprintf(stderr, "%s\n", mailinfo_usage);
-	exit(1);
-}
-
 int main(int argc, char **argv)
 {
+	/* NEEDSWORK: might want to do the optional .git/ directory
+	 * discovery
+	 */
+	git_config(git_default_config);
+
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
 			keep_subject = 1;
 		else if (!strcmp(argv[1], "-u"))
-			metainfo_charset = "utf-8";
+			metainfo_charset = git_commit_encoding;
 		else if (!strncmp(argv[1], "-u=", 3))
 			metainfo_charset = argv[1] + 3;
 		else
-			usage();
+			usage(mailinfo_usage);
 		argc--; argv++;
 	}
 
 	if (argc != 3)
-		usage();
+		usage(mailinfo_usage);
 	cmitmsg = fopen(argv[1], "w");
 	if (!cmitmsg) {
 		perror(argv[1]);
---
0.99.9.GIT
