From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/5] glossary: introduce glossary lookup command
Date: Mon,  8 Dec 2014 16:38:56 +0100
Message-ID: <585191103e7bdd21ed422324504b6503bec2b914.1418052470.git.git@drmicha.warpmail.net>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 16:39:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0PD-0000ST-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 16:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbaLHPjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 10:39:05 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40728 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753135AbaLHPjE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 10:39:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id C6350209DA
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 10:39:03 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Dec 2014 10:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=jvqWJnVutwNulM
	/wPeDXYo6cL+U=; b=haN8SIabOY7K7bHJzcgve2gSohiVPlbl8Haf6rjRSVlLdH
	HRT5fD+iMRiBX8+VqozqZb1MIqSIPSGMWTwUfuhvOT/ybwabukv3mbLkn96G4Lyr
	90ceyfjezuWT8UMFEGVgRg2QSKzOs9NUMlMAVlepmoA2kQLfJy/vBrr4jpo7I=
X-Sasl-enc: 6EOCKFx2r4C108cUSN5dsaewyDPRTuAGa0pyPZhmCQOt 1418053143
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 67E7BC00282;
	Mon,  8 Dec 2014 10:39:03 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <cover.1418052470.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261049>

When using a localised git, there are many reasons why a correspondence
between English and localised git terms is needed:
- connect localised messages with English ones (porcelain vs. plumbing)
- connect localised messages with English man pages or online docs
- help out someone in a different locale

Introduce a `git glossary' command that leverages the existing infrastructure
in three possible ways:
- `git glossary' lists all glossary terms along with their translation
- `git glossary foo' matches `foo' in the glossary (both English and
  localisation; partial matches shown)
- `git glossary -a foo' matches `foo' in the git message catalogue
  (English, exact match only).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Some bike-shedding expected regarding the interface...
Once I've learned how to test l10n stuff, this will be amended.

 .gitignore         |   1 +
 Makefile           |   1 +
 builtin.h          |   1 +
 builtin/glossary.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt   |   1 +
 git.c              |   1 +
 6 files changed, 109 insertions(+)
 create mode 100644 builtin/glossary.c

diff --git a/.gitignore b/.gitignore
index fb4ebaa..ff627a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -64,6 +64,7 @@
 /git-fsck-objects
 /git-gc
 /git-get-tar-commit-id
+/git-glossary
 /git-grep
 /git-hash-object
 /git-help
diff --git a/Makefile b/Makefile
index ae74fdf..8fc9de2 100644
--- a/Makefile
+++ b/Makefile
@@ -824,6 +824,7 @@ BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
+BUILTIN_OBJS += builtin/glossary.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
diff --git a/builtin.h b/builtin.h
index b87df70..dcaf220 100644
--- a/builtin.h
+++ b/builtin.h
@@ -68,6 +68,7 @@ extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
+extern int cmd_glossary(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
diff --git a/builtin/glossary.c b/builtin/glossary.c
new file mode 100644
index 0000000..4ad8c51
--- /dev/null
+++ b/builtin/glossary.c
@@ -0,0 +1,104 @@
+/*
+ * Builtin help command
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "column.h"
+#include "glossary.h"
+
+
+static int match_all = 0;
+static unsigned int colopts;
+static struct option builtin_glossary_options[] = {
+	OPT_BOOL('a', "all", &match_all, N_("match all English git messages")),
+	OPT_END(),
+};
+
+static const char * const builtin_glossary_usage[] = {
+	N_("git glossary [-a|--all] [term]..."),
+	NULL
+};
+
+
+/*
+static int git_glossary_config(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "column."))
+		return git_column_config(var, value, "help", &colopts);
+
+	return git_default_config(var, value, cb);
+}
+*/
+
+static void emit_one(const char *one, const char* two, int pad)
+{
+	printf("   %s   ", one);
+	for (; pad; pad--)
+		putchar(' ');
+	puts(two);
+}
+
+static void lookup_all(int n, const char **terms)
+{
+	int i;
+	for (i = 0; i < n; i++)
+		emit_one(terms[i], _(terms[i]), 0);
+}
+
+static void lookup_glossary(int n, const char **terms)
+{
+	int i, j;
+	for (i = 0; i < ARRAY_SIZE(glossary); i++) {
+		for (j = 0; j < n; j++) {
+			if (strstr(glossary[i], terms[j]) || strstr(_(glossary[i]), terms[j])) {
+				emit_one(glossary[i], _(glossary[i]), 0);
+				break;
+			}
+		}
+	}
+}
+
+static void list_glossary()
+{
+	int i, longest = 0;
+
+	for (i = 0; i < ARRAY_SIZE(glossary); i++) {
+		if (longest < strlen(glossary[i]))
+			longest = strlen(glossary[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(glossary); i++)
+		emit_one(glossary[i], _(glossary[i]), longest - strlen(glossary[i]));
+}
+
+int cmd_glossary(int argc, const char **argv, const char *prefix)
+{
+	int nongit;
+
+	argc = parse_options(argc, argv, prefix, builtin_glossary_options,
+			builtin_glossary_usage, 0);
+
+	if (match_all && !argc) {
+		printf(_("usage: %s%s"), _(builtin_glossary_usage[0]), "\n\n");
+		exit(1);
+	}
+
+
+/*
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config, NULL);
+*/
+	if (!argc) {
+		list_glossary();
+		exit(0);
+	}
+	if (match_all)
+		lookup_all(argc, argv);
+	else
+		lookup_glossary(argc, argv);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index f1eae08..d26517d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -51,6 +51,7 @@ git-format-patch                        mainporcelain
 git-fsck	                        ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
+git-glossary				ancillaryinterrogators
 git-grep                                mainporcelain common
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
diff --git a/git.c b/git.c
index 82d7a1c..e2adfbe 100644
--- a/git.c
+++ b/git.c
@@ -411,6 +411,7 @@ static struct cmd_struct commands[] = {
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id },
+	{ "glossary", cmd_glossary },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
-- 
2.2.0.345.g7041aac
