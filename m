From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] Refactor list of environment variables to be sanitized
Date: Sat, 28 Feb 2009 16:03:39 -0800
Message-ID: <1235865822-14625-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 01:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdZBp-000803-PZ
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 01:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZCAADs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754279AbZCAADr
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 19:03:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZCAADr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 19:03:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B0B1289D
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 19:03:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6B8EA289C for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 19:03:44 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
X-Pobox-Relay-ID: 6E6AEFEE-05F4-11DE-A1CF-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111799>

When local process-to-process pipe transport spawns a subprocess,
it cleans up various git related variables to give the new process
a fresh environment.  The list of variables to cleanse is useful
in other places.
---
 cache.h   |    2 ++
 connect.c |   26 +++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 189151d..b72434f 100644
--- a/cache.h
+++ b/cache.h
@@ -389,6 +389,8 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern const char *sanitize_git_env[];
+
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
diff --git a/connect.c b/connect.c
index 2f23ab3..b4705ff 100644
--- a/connect.c
+++ b/connect.c
@@ -6,6 +6,20 @@
 #include "run-command.h"
 #include "remote.h"
 
+/*
+ * When spawning a subprocess in a fresh environment,
+ * these variables may need to be cleared
+ */
+const char *sanitize_git_env[] = {
+	ALTERNATE_DB_ENVIRONMENT,
+	DB_ENVIRONMENT,
+	GIT_DIR_ENVIRONMENT,
+	GIT_WORK_TREE_ENVIRONMENT,
+	GRAFT_ENVIRONMENT,
+	INDEX_ENVIRONMENT,
+	NULL
+};
+
 static char *server_capabilities;
 
 static int check_ref(const char *name, int len, unsigned int flags)
@@ -625,17 +639,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		*arg++ = host;
 	}
 	else {
-		/* remove these from the environment */
-		const char *env[] = {
-			ALTERNATE_DB_ENVIRONMENT,
-			DB_ENVIRONMENT,
-			GIT_DIR_ENVIRONMENT,
-			GIT_WORK_TREE_ENVIRONMENT,
-			GRAFT_ENVIRONMENT,
-			INDEX_ENVIRONMENT,
-			NULL
-		};
-		conn->env = env;
+		conn->env = sanitize_git_env;
 		*arg++ = "sh";
 		*arg++ = "-c";
 	}
-- 
1.6.2.rc2.99.g9f3bb
