From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 12/24] ls-files.c: use index api
Date: Sun, 18 Aug 2013 21:42:01 +0200
Message-ID: <1376854933-31241-13-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8y0-0003xJ-BZ
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab3HRTsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:45 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52557 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:44 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so2835517wgh.2
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nd7VDZ2z/iJsOSB006lvoPkrAJW1+8WRjZkV2pP0Ni0=;
        b=kgilggXEelg4RE3PKy29RD9TPomlejznAAdlcXSdawBWiseqGJibBOARuMJ6BDpfUG
         fNL7Lo9et9qIer4aIcVvMtV8J1PUv7idz24hLXnJmm32q5gD3IhijFVLXsCTYAx5lSib
         08FkSWcM5aHZKFN67ptog5+lXQiQM/p2Mt8SCc17fteOeQcnCZ0Dt6mVTZ8s+Ymsy1xi
         /w0NzOayyRu2YzGqR88TaJxg1G9UVlE76l2P3J2DoVGmXGCQTh9xFfJP7wrSFI83wX08
         H+OIDFtq2lGYQ1UXlRvD9O3LjIeNxWeaLPhM5+wsGgaBQ8aqvXGY2zQFiNPqm/FtD4QO
         nLHQ==
X-Received: by 10.194.201.202 with SMTP id kc10mr5886139wjc.1.1376855323057;
        Sun, 18 Aug 2013 12:48:43 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id fz8sm11976200wic.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232498>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/ls-files.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bebc9c2..fbf9c47 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -288,6 +288,22 @@ static void prune_cache(const char *prefix)
 	active_nr = last;
 }
 
+static int needs_trailing_slash_stripped(void)
+{
+	int i;
+
+	if (!pathspec.nr)
+		return 0;
+
+	for (i = 0; i < pathspec.nr; i++) {
+		int len = strlen(pathspec.items[i].original);
+
+		if (len > 1 && (pathspec.items[i].original)[len - 1] == '/')
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -445,6 +461,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct dir_struct dir;
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct filter_opts *opts = xmalloc(sizeof(*opts));
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			N_("paths are separated with NUL character"),
@@ -510,9 +527,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
@@ -548,6 +562,22 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
 
+	if (!with_tree && !needs_trailing_slash_stripped()) {
+		memset(opts, 0, sizeof(*opts));
+		opts->pathspec = &pathspec;
+		opts->read_staged = 1;
+		if (show_resolve_undo)
+			opts->read_resolve_undo = 1;
+		read_cache_filtered(opts);
+	} else {
+		read_cache();
+		parse_pathspec(&pathspec, 0,
+			       PATHSPEC_PREFER_CWD |
+			       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+			       prefix, argv);
+
+	}
+
 	/* Find common prefix for all pathspec's */
 	max_prefix = common_prefix(&pathspec);
 	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
-- 
1.8.3.4.1231.g9fbf354.dirty
