From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix memory leak in "connect.c".
Date: Thu, 7 Sep 2006 05:59:52 +0200
Message-ID: <20060907055952.dafffe2b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 05:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLAxy-0008Fa-Rq
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 05:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWIGDyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 23:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWIGDyL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 23:54:11 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:30402 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422707AbWIGDyI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 23:54:08 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 3AE1447E69;
	Thu,  7 Sep 2006 05:54:06 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26589>

sq_quote allocates some memory that should be freed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 connect.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 1c6429b..40a1c28 100644
--- a/connect.c
+++ b/connect.c
@@ -697,8 +697,9 @@ int git_connect(int fd[2], char *url, co
 	if (pid < 0)
 		die("unable to fork");
 	if (!pid) {
-		snprintf(command, sizeof(command), "%s %s", prog,
-			 sq_quote(path));
+		char *sq_path = sq_quote(path);
+		snprintf(command, sizeof(command), "%s %s", prog, sq_path);
+		free(sq_path);
 		dup2(pipefd[1][0], 0);
 		dup2(pipefd[0][1], 1);
 		close(pipefd[0][0]);
-- 
1.4.2.g1ccae49
