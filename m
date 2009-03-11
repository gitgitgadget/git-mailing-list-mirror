From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] Removed unnecessary use of global variables.
Date: Wed, 11 Mar 2009 00:09:28 +0000
Message-ID: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johannes.Schindelin@gmx.de, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 02:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhCyN-0004qE-TE
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 02:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbZCKBJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 21:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbZCKBJf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 21:09:35 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:59859 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbZCKBJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 21:09:35 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGB00BZYF3RPP30@bgo1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 11 Mar 2009 01:09:27 +0100 (CET)
Received: from localhost.localdomain ([84.48.62.155])
 by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGB00IZ1F3R3R30@bgo1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 11 Mar 2009 01:09:27 +0100 (CET)
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112864>

git_config() now takes a third data-parameter that is passed back
to the callback-function. At the time this code was written, that
parameter did not exist, so a somewhat nasty (but by all means
correct) use of global variables was introduced. In commit
ef90d6d4208a5130185b04f06e5f90a5f9959fe3 Johannes Schindelin
<Johannes.Schindelin@gmx.de> introduced a parameter for similar
purposes.

I've changed the code to utilize this parameter to pass the
string. In addition, I've made the function calculate the string
length on usage instead, to reduce the parameters needed to what
the callback-interface supplies.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 connect.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index 2f23ab3..98fbaea 100644
--- a/connect.c
+++ b/connect.c
@@ -371,14 +371,13 @@ static void git_tcp_connect(int fd[2], char *host, int flags)
 	fd[1] = dup(sockfd);
 }
 
-
 static char *git_proxy_command;
-static const char *rhost_name;
-static int rhost_len;
-
 static int git_proxy_command_options(const char *var, const char *value,
-		void *cb)
+		void *data)
 {
+	const char *rhost_name = data;
+	const size_t rhost_len = strlen(rhost_name);
+
 	if (!strcmp(var, "core.gitproxy")) {
 		const char *for_pos;
 		int matchlen = -1;
@@ -421,16 +420,13 @@ static int git_proxy_command_options(const char *var, const char *value,
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, data);
 }
 
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
