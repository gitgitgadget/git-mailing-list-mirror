X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Thu, 23 Nov 2006 10:36:33 +0100
Message-ID: <slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Thu, 23 Nov 2006 09:37:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 117
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32128>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnB1B-0005o3-08 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757288AbWKWJhM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 04:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757290AbWKWJhL
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:37:11 -0500
Received: from main.gmane.org ([80.91.229.2]:50872 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757288AbWKWJhJ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 04:37:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnB0x-0005lb-6B for git@vger.kernel.org; Thu, 23 Nov 2006 10:37:03 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 10:37:03 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 23 Nov 2006 10:37:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This allows one to see the root commit as a diff in commands like git-log,
git-show and git-whatchanged. It also modifies git-diff-tree to act as --root
was specified on the commandline. The default is set to true.

Signed-off-by: Peter Baumann <Peter.B.Baumannn@stud.informatik.uni-erlangen.de>
---
I'm not sure if making core.showroot acting on git-diff-tree is the
right thing to do. Please check first bevore applying.

 Documentation/config.txt |    6 ++++++
 builtin-diff-tree.c      |    1 +
 builtin-log.c            |    3 +++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 6 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9d3c71c..7e600ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -110,6 +110,12 @@ core.legacyheaders::
 	database directly (where the "http://" and "rsync://" protocols
 	count as direct access).
 
+core.showroot::
+	If true, the initial commit will be shown as a big creation event.
+	This is equivalent to a diff against an empty tree.
+	Tools like gitlink:git-log[1] or gitlink:git-whatchanged[1], which
+	normally hide the root commit will now show it. True by default.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 24cb2d7..d58b7ca 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -72,6 +72,7 @@ int cmd_diff_tree(int argc, const char *
 	nr_sha1 = 0;
 	opt->abbrev = 0;
 	opt->diff = 1;
+	opt->show_root_diff = show_root_diff;
 	argc = setup_revisions(argc, argv, opt, NULL);
 
 	while (--argc > 0) {
diff --git a/builtin-log.c b/builtin-log.c
index fedb013..9541c7d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -53,6 +53,7 @@ int cmd_whatchanged(int argc, const char
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
 	rev.simplify_history = 0;
+	rev.show_root_diff = show_root_diff;
 	cmd_log_init(argc, argv, prefix, &rev);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -72,6 +73,7 @@ int cmd_show(int argc, const char **argv
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
+	rev.show_root_diff = show_root_diff;
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
@@ -83,6 +85,7 @@ int cmd_log(int argc, const char **argv,
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
+	rev.show_root_diff = show_root_diff;
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
diff --git a/cache.h b/cache.h
index f2ec5c8..feff2bd 100644
--- a/cache.h
+++ b/cache.h
@@ -191,6 +191,7 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
+extern int show_root_diff;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 3cae390..dd720b5 100644
--- a/config.c
+++ b/config.c
@@ -319,6 +319,11 @@ int git_default_config(const char *var,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.showroot")) {
+		show_root_diff = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 84d870c..71099f4 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
 int pager_use_color = 1;
+int show_root_diff = 1;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
-- 
1.4.3.3

