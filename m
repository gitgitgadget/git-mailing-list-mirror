From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 02/14] stage: add edit command
Date: Fri, 25 Apr 2014 13:12:35 -0500
Message-ID: <1398449567-16314-3-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdkod-0001Gs-Nz
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbaDYSZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:25:34 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:54554 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbaDYSXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:25 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so4623913oac.30
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l9mxF9lqVCYwkxHl5IAxG3v0sLBYrmgdNsnPXPtTPKQ=;
        b=WLjhqeKNFbBckOSI2+xfRCSxzfOEo+RSDPG4EgVnKAoMvwP1yH59w+nxUZeWwFe/eU
         8nAW9OTqbX9VAkuPITJ/f3L40WaQWR3EzdV9Tdk4ttb0UPCbK/YhHF+CPtfvr8n+VKjp
         6El/FYp/kt7cM51SBcAv3WFmW9xO+LNlmXqtAk7Ez4km5IlaYJ1fHvhC2SEbWCnhL694
         CoevBAsqJTB4gmirOZhvIldAX3qaHzMpQK8QEyoYzH45lZ70/9S+v3bOy9O/9qqSfamX
         8bR6AYXGjcWmUBf8FsbPUKUly8WkrWXGQyw1jRdSOPYyZqNdYb7+/wS+NKdp48h+uaE4
         Ep7A==
X-Received: by 10.60.135.106 with SMTP id pr10mr8186743oeb.15.1398450204990;
        Fri, 25 Apr 2014 11:23:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm34691804oek.12.2014.04.25.11.23.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247089>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt            |  5 +++
 builtin/stage.c                        | 74 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  4 +-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 5b42b29..13a01c8 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git stage diff' [options] [<commit>] [--] [<paths>...]
 'git stage rm' [options] [--] [<paths>...]
 'git stage apply' [options] [--] [<paths>...]
+'git stage edit'
 
 DESCRIPTION
 -----------
@@ -46,6 +47,10 @@ Remove files from the staging area only. See linkgit:git-rm[1] --staged.
 
 Apply a patch to the staging area. See linkgit:git-rm[1] --staged.
 
+'edit'::
+
+Manually edit the staging area (as a diff).
+
 SEE ALSO
 --------
 linkgit:git-add[1]
diff --git a/builtin/stage.c b/builtin/stage.c
index 7c4d442..f537c1d 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -6,6 +6,9 @@
 
 #include "builtin.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
 
 static const char *const stage_usage[] = {
 	N_("git stage [options] [--] <paths>..."),
@@ -17,6 +20,74 @@ static const char *const stage_usage[] = {
 	NULL
 };
 
+static int do_reset(const char *prefix)
+{
+	const char *argv[] = { "reset", "--quiet", NULL };
+	return cmd_reset(2, argv, prefix);
+}
+
+static int do_apply(const char *file, const char *prefix)
+{
+	const char *argv[] = { "apply", "--recount", "--cached", file, NULL };
+	return cmd_apply(4, argv, prefix);
+}
+
+static int edit(int argc, const char **argv, const char *prefix)
+{
+	char *file = git_pathdup("STAGE_EDIT.patch");
+	int out;
+	struct rev_info rev;
+	int ret = 0;
+	struct stat st;
+
+	read_cache();
+
+	init_revisions(&rev, prefix);
+	rev.diffopt.context = 7;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	add_head_to_pending(&rev);
+	if (!rev.pending.nr) {
+		struct tree *tree;
+		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
+		add_pending_object(&rev, &tree->object, "HEAD");
+	}
+
+	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev.diffopt.use_color = 0;
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
+
+	out = open(file, O_CREAT | O_WRONLY, 0666);
+	if (out < 0)
+		die(_("Could not open '%s' for writing."), file);
+	rev.diffopt.file = xfdopen(out, "w");
+	rev.diffopt.close_file = 1;
+
+	if (run_diff_index(&rev, 1))
+		die(_("Could not write patch"));
+	if (launch_editor(file, NULL, NULL))
+		exit(1);
+
+	if (stat(file, &st))
+		die_errno(_("Could not stat '%s'"), file);
+
+	ret = do_reset(prefix);
+	if (ret)
+		goto leave;
+
+	if (!st.st_size)
+		goto leave;
+
+	ret = do_apply(file, prefix);
+	if (ret)
+		goto leave;
+
+leave:
+	unlink(file);
+	free(file);
+	return ret;
+}
+
 int cmd_stage(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = { OPT_END() };
@@ -47,6 +118,9 @@ int cmd_stage(int argc, const char **argv, const char *prefix)
 
 			return cmd_apply(argc, argv, prefix);
 		}
+		if (!strcmp(argv[1], "edit")) {
+			return edit(argc - 1, argv + 1, prefix);
+		}
 	}
 
 	return cmd_add(argc, argv, prefix);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0521d52..2ec7b1a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1707,7 +1707,7 @@ _git_stage ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add reset diff rm apply"
+	local subcommands="add reset diff rm apply edit"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -1725,6 +1725,8 @@ _git_stage ()
 		_git_rm;;
 	apply)
 		_git_apply;;
+	edit)
+		;;
 	*)
 		_git_add;
 	esac
-- 
1.9.2+fc1.2.gfbaae8c
