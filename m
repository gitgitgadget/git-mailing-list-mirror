From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] connect.c: remove a few globals by using git_config
 callback data
Date: Wed, 11 Mar 2009 02:38:12 +0000
Message-ID: <1236739092-8280-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 03:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhEMA-0000g7-At
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 03:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbZCKCiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 22:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbZCKCiO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 22:38:14 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:36464 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZCKCiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 22:38:13 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGB00EQRLZN5H90@bgo1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 11 Mar 2009 03:38:11 +0100 (CET)
Received: from localhost.localdomain ([84.48.62.155])
 by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGB00KW0LZN8450@bgo1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 11 Mar 2009 03:38:11 +0100 (CET)
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112870>

Since ef90d6d (Provide git_config with a callback-data parameter,
2008-05-14), git_config() takes a callback data pointer that can be
used to pass extra parameters to the parsing function.  The codepath
to parse configuration variables related to git proxy predates this
facility and used a pair of file scope static variables instead.

This patch removes the need for these global variables by passing the
name of the host we are trying to access as the callback data.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 connect.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 2f23ab3..0a35cc1 100644
--- a/connect.c
+++ b/connect.c
@@ -373,8 +373,6 @@ static void git_tcp_connect(int fd[2], char *host, int flags)
 
 
 static char *git_proxy_command;
-static const char *rhost_name;
-static int rhost_len;
 
 static int git_proxy_command_options(const char *var, const char *value,
 		void *cb)
@@ -383,6 +381,8 @@ static int git_proxy_command_options(const char *var, const char *value,
 		const char *for_pos;
 		int matchlen = -1;
 		int hostlen;
+		const char *rhost_name = cb;
+		int rhost_len = strlen(rhost_name);
 
 		if (git_proxy_command)
 			return 0;
@@ -426,11 +426,8 @@ static int git_proxy_command_options(const char *var, const char *value,
 
 static int git_use_proxy(const char *host)
 {
-	rhost_name = host;
-	rhost_len = strlen(host);
 	git_proxy_command = getenv("GIT_PROXY_COMMAND");
-	git_config(git_proxy_command_options, NULL);
-	rhost_name = NULL;
+	git_config(git_proxy_command_options, (void*)host);
 	return (git_proxy_command && *git_proxy_command);
 }
 
-- 
1.6.2.GIT
