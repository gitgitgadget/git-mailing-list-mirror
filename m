From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 4/5] Help.c: add list_common_guides_help() function
Date: Sun,  3 Mar 2013 20:21:11 +0000
Message-ID: <1362342072-1412-5-git-send-email-philipoakley@iee.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 21:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCFPg-0001Sf-KB
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 21:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab3CCUVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 15:21:04 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:11339 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753367Ab3CCUVA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 15:21:00 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0FANmqM1FZ8rke/2dsb2JhbABFhWe8Y30Xc4IgAQVWMwhJOR4GE4gXxwqPJINAA6AqhwiDCA
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="401806126"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 03 Mar 2013 20:20:57 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217353>

Re-use list_common_cmds_help but simply change the array name.
Candidate for future refactoring to pass a pointer to the array.

The common-guides.h list was generated with a simple variant of the
generate-cmdlist.sh and command-list.txt.

Do not list User-manual and Everday Git which not follow the naming
convention, nor gitrepository-layout which doesn't fit within the
name field size.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c  |  1 +
 common-guides.h | 11 +++++++++++
 help.c          | 18 ++++++++++++++++++
 help.h          |  1 +
 4 files changed, 31 insertions(+)
 create mode 100644 common-guides.h

diff --git a/builtin/help.c b/builtin/help.c
index 6089d72..e21ffa5 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -434,6 +434,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		if (!show_guides) return 0;
 	}
 	if (show_guides) {
+		list_common_guides_help();
 		return 0;
 	}
 	if (!argv[0]) {
diff --git a/common-guides.h b/common-guides.h
new file mode 100644
index 0000000..0e94fdc
--- /dev/null
+++ b/common-guides.h
@@ -0,0 +1,11 @@
+/* re-use struct cmdname_help in common-commands.h */
+
+static struct cmdname_help common_guides[] = {
+  {"attributes", "defining attributes per path"},
+  {"glossary", "A GIT Glossary"},
+  {"ignore", "Specifies intentionally untracked files to ignore"},
+  {"modules", "defining submodule properties"},
+  {"revisions", "specifying revisions and ranges for git"},
+  {"tutorial", "A tutorial introduction to git (for version 1.5.1 or newer)"},
+  {"workflows", "An overview of recommended workflows with git"},
+};
diff --git a/help.c b/help.c
index 1dfa0b0..f4de407 100644
--- a/help.c
+++ b/help.c
@@ -4,6 +4,7 @@
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
+#include "common-guides.h"
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
@@ -240,6 +241,23 @@ void list_common_cmds_help(void)
 	}
 }
 
+void list_common_guides_help(void)
+{
+	int i, longest = 0;
+
+	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
+		if (longest < strlen(common_guides[i].name))
+			longest = strlen(common_guides[i].name);
+	}
+
+	puts(_("The common Git guides are:"));
+	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
+		printf("   %s   ", common_guides[i].name);
+		mput_char(' ', longest - strlen(common_guides[i].name));
+		puts(_(common_guides[i].help));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 0ae5a12..4ae1fd7 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_common_guides_help(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
1.8.1.msysgit.1
