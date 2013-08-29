From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] stage: add edit command
Date: Thu, 29 Aug 2013 13:09:04 -0500
Message-ID: <1377799744-5201-3-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:14:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6je-0000fX-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335Ab3H2SOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:14:18 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44175 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab3H2SOR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:14:17 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so845633obc.26
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w62SyFCrndZIxGlghQ6LmPC1iB1vqC27zoj6EWeMjjo=;
        b=qNMP1su+F/MhV5PexZFCFL7cpLr9/3h0umiBUV1Wm0rtLzUUQgem/gzoD2XRESGHGY
         RsgPlyFWGxqiT4bP/yW8iTDa4sgAls3Q41UXHVsd2Z4h7Iqkfx8iXFzPJfSKSJE4MfXn
         lQfDE9nYuvIAGVGPexYbU+te+HlucmxE0WumiYn73HNOY2NmGIi2c5d+BCBJ37vtXWpM
         /ZwafPawJ15R88HHGKK8f2oVz9SPjOnb6gUuui3nO0T9ppTfKLWEff4oiDlr+o78+F9J
         AOqSbUbGuhYhXpP/QXcpN9Z0JD7AVL9vPqMTgSLE5ANKj0oxtdWjEDbcr2qijnSi8DWz
         qA3w==
X-Received: by 10.60.133.133 with SMTP id pc5mr2242292oeb.63.1377800057459;
        Thu, 29 Aug 2013 11:14:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm33778559oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:14:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233306>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt            |  5 +++
 builtin/stage.c                        | 74 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  4 +-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 318bf45..3e52a66 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git stage diff' [options] [<commit>] [--] [<paths>...]
 'git stage rm' [options] [--] [<paths>...]
 'git stage apply' [options] [--] [<paths>...]
+'git stage edit'
 
 DESCRIPTION
 -----------
@@ -45,6 +46,10 @@ Remove files from the staging area only. See linkgit:git-rm[1] --staged.
 
 Apply a patch to the staging area. See linkgit:git-rm[1] --staged.
 
+'edit'::
+
+Manually edit the staging area (as a diff).
+
 SEE ALSO
 --------
 linkgit:git-add[1]
diff --git a/builtin/stage.c b/builtin/stage.c
index 3023d17..d3c58d5 100644
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
@@ -16,6 +19,74 @@ static const char *const stage_usage[] = {
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
@@ -46,6 +117,9 @@ int cmd_stage(int argc, const char **argv, const char *prefix)
 
 			return cmd_apply(argc, argv, prefix);
 		}
+		if (!strcmp(argv[1], "edit")) {
+			return edit(argc - 1, argv + 1, prefix);
+		}
 	}
 
 	return cmd_add(argc, argv, prefix);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8cf26e2..2b81e78 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1693,7 +1693,7 @@ _git_stage ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add reset diff rm apply"
+	local subcommands="add reset diff rm apply edit"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -1711,6 +1711,8 @@ _git_stage ()
 		_git_rm;;
 	apply)
 		_git_apply;;
+	edit)
+		;;
 	*)
 		_git_add;
 	esac
-- 
1.8.4-fc
