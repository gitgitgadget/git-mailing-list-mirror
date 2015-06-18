From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 05/31] am: split out mbox/maildir patches with git-mailsplit
Date: Thu, 18 Jun 2015 19:25:17 +0800
Message-ID: <1434626743-8552-6-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:26:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xxw-0004e3-0x
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbbFRL03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:29 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35812 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454AbbFRL0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:25 -0400
Received: by pacyx8 with SMTP id yx8so59546782pac.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/0BxOcahn39xgaxzMK+yCGNB2SJYlxcbpDCUBTvIHw=;
        b=ykK+GEes7IyxT2hlftZvKhN0R8f2b7cjqMde7S2QVkl1l5y+kGO4HzH+b5OfWh7Gd4
         lr+2owBanzq+kzXIznTVshwX1+oYRc3zty827xk39+NrPvJTvWv64Bgzy8NDKJOXOEIp
         m5Bt9RXY2HCfzRfGVB/vSsnV1c4Ef3kjKq6WB6CUuAt6WvRObapkYoVKRXadoLHSubJ/
         keDftGs39FfdygTtKzCkuZYMsnHLhxfqOOnLimJpMDqzvm/joMG/q5woTiYtJm/CkISs
         wtYpLhTrgJIf0iGYXxDYrbMnPRqpYTPzJ/pHBmROg4+zt9o8f2/yBQG0GwFDz2kjG1TK
         SU5A==
X-Received: by 10.68.180.131 with SMTP id do3mr20304260pbc.42.1434626784998;
        Thu, 18 Jun 2015 04:26:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271968>

git-am.sh supports mbox, stgit and mercurial patches. Re-implement
support for splitting out mbox/maildirs using git-mailsplit, while also
implementing the framework required to support other patch formats in
the future.

Re-implement support for the --patch-format option (since a5a6755
(git-am foreign patch support: introduce patch_format, 2009-05-27)) to
allow the user to choose between the different patch formats.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * Moved the TODO comment to the previous patch

 builtin/am.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index af68c51..e9a3687 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -8,6 +8,12 @@
 #include "exec_cmd.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "run-command.h"
+
+enum patch_format {
+	PATCH_FORMAT_UNKNOWN = 0,
+	PATCH_FORMAT_MBOX
+};
 
 struct am_state {
 	/* state directory path */
@@ -16,6 +22,9 @@ struct am_state {
 	/* current and last patch numbers, 1-indexed */
 	int cur;
 	int last;
+
+	/* number of digits in patch filename */
+	int prec;
 };
 
 /**
@@ -26,6 +35,8 @@ static void am_state_init(struct am_state *state)
 	memset(state, 0, sizeof(*state));
 
 	strbuf_init(&state->dir, 0);
+
+	state->prec = 4;
 }
 
 /**
@@ -111,13 +122,69 @@ static void am_destroy(const struct am_state *state)
 }
 
 /**
+ * Splits out individual patches from `paths`, where each path is either a mbox
+ * file or a Maildir. Return 0 on success, -1 on failure.
+ */
+static int split_patches_mbox(struct am_state *state, struct string_list *paths)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	struct strbuf last = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "mailsplit");
+	argv_array_pushf(&cp.args, "-d%d", state->prec);
+	argv_array_pushf(&cp.args, "-o%s", state->dir.buf);
+	argv_array_push(&cp.args, "-b");
+	argv_array_push(&cp.args, "--");
+
+	for_each_string_list_item(item, paths)
+		argv_array_push(&cp.args, item->string);
+
+	if (capture_command(&cp, &last, 8))
+		return -1;
+
+	state->cur = 1;
+	state->last = strtol(last.buf, NULL, 10);
+
+	return 0;
+}
+
+/**
+ * Splits out individual patches, of patch_format, contained within paths.
+ * These patches will be stored in the state directory, with each patch's
+ * filename being its index, padded to state->prec digits. state->cur will be
+ * set to the index of the first patch, and state->last will be set to the
+ * index of the last patch.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int split_patches(struct am_state *state, enum patch_format patch_format,
+		struct string_list *paths)
+{
+	switch (patch_format) {
+	case PATCH_FORMAT_MBOX:
+		return split_patches_mbox(state, paths);
+	default:
+		die("BUG: invalid patch_format");
+	}
+	return -1;
+}
+
+/**
  * Setup a new am session for applying patches
  */
-static void am_setup(struct am_state *state)
+static void am_setup(struct am_state *state, enum patch_format patch_format,
+		struct string_list *paths)
 {
 	if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir.buf);
 
+	if (split_patches(state, patch_format, paths) < 0) {
+		am_destroy(state);
+		die(_("Failed to split patches."));
+	}
+
 	write_file(am_path(state, "next"), 1, "%d", state->cur);
 
 	write_file(am_path(state, "last"), 1, "%d", state->last);
@@ -148,7 +215,23 @@ static void am_run(struct am_state *state)
 	am_destroy(state);
 }
 
+/**
+ * parse_options() callback that validates and sets opt->value to the
+ * PATCH_FORMAT_* enum value corresponding to `arg`.
+ */
+static int parse_opt_patchformat(const struct option *opt, const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	if (!strcmp(arg, "mbox"))
+		*opt_value = PATCH_FORMAT_MBOX;
+	else
+		return -1;
+	return 0;
+}
+
 static struct am_state state;
+static int opt_patch_format;
 
 static const char * const am_usage[] = {
 	N_("git am [options] [(<mbox>|<Maildir>)...]"),
@@ -156,6 +239,8 @@ static const char * const am_usage[] = {
 };
 
 static struct option am_options[] = {
+	OPT_CALLBACK(0, "patch-format", &opt_patch_format, N_("format"),
+		N_("format the patch(es) are in"), parse_opt_patchformat),
 	OPT_END()
 };
 
@@ -185,8 +270,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	if (am_in_progress(&state))
 		am_load(&state);
-	else
-		am_setup(&state);
+	else {
+		struct string_list paths = STRING_LIST_INIT_DUP;
+		int i;
+
+		for (i = 0; i < argc; i++) {
+			if (is_absolute_path(argv[i]) || !prefix)
+				string_list_append(&paths, argv[i]);
+			else
+				string_list_append(&paths, mkpath("%s/%s", prefix, argv[i]));
+		}
+
+		am_setup(&state, opt_patch_format, &paths);
+
+		string_list_clear(&paths, 0);
+	}
 
 	am_run(&state);
 
-- 
2.1.4
