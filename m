From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 4/5] Help.c: add list_common_guides_help() function
Date: Tue,  2 Apr 2013 23:39:51 +0100
Message-ID: <1364942392-576-5-git-send-email-philipoakley@iee.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9sW-00037Z-Hq
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933636Ab3DBWjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:39:51 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:45193 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933453Ab3DBWjm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:39:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Am4JAPtcW1FOl3a6/2dsb2JhbABDgwc2gje9VgQBgQQXdIIgAQVWIxAISTkeBhOIGLFrkBONVSeBHQeDQAOgXocYgS+BXTuBLg
X-IronPort-AV: E=Sophos;i="4.87,396,1363132800"; 
   d="scan'208";a="571152198"
Received: from host-78-151-118-186.as13285.net (HELO localhost) ([78.151.118.186])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 02 Apr 2013 23:39:41 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219898>

Re-use list_common_cmds_help but simply change the array name.
Candidate for future refactoring to pass a pointer to the array.

The common-guides.h list was generated with a simple variant of the
generate-cmdlist.sh and command-list.txt.

Do not list User-manual and Everday Git which not follow the naming
convention, nor gitrepository-layout which doesn't fit within the
name field size.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c  |  3 ++-
 common-guides.h | 11 +++++++++++
 help.c          | 18 ++++++++++++++++++
 help.h          |  1 +
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 common-guides.h

diff --git a/builtin/help.c b/builtin/help.c
index 03d432b..91a6158 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -433,7 +433,8 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_guides) {
-		/* do action - next patch */
+		list_common_guides_help();
+		printf("\n");
 	}
 
 	if (show_all || show_guides) {
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
index 1dfa0b0..e0368ca 100644
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
+	puts(_("The common Git guides are:\n"));
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
