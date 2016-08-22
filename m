Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20341F859
	for <e@80x24.org>; Mon, 22 Aug 2016 23:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756833AbcHVXnr (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 19:43:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:11778 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756444AbcHVXnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 19:43:46 -0400
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP; 22 Aug 2016 16:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,562,1464678000"; 
   d="scan'208";a="706783"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2016 16:43:45 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v10 0/9] submodule inline diff format
Date:   Mon, 22 Aug 2016 16:43:35 -0700
Message-Id: <20160822234344.22797-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

A few suggestions from Stefan in regards to falling back to
.git/modules/<path> being a bad idea. I've chosen I think to avoid using
die() as we just stick with the current path if we can't find its name.
I think this should be safe since we already do this today. The new flow
only changes if we are able to lookup the submodule, so I don't think
it's worth adding a die() call.

interdiff between v9 and v10 is pretty small:


diff --git c/Documentation/RelNotes/2.10.0.txt w/Documentation/RelNotes/2.10.0.txt
index 4f7460be3914..0ef70fd9b1eb 100644
--- c/Documentation/RelNotes/2.10.0.txt
+++ w/Documentation/RelNotes/2.10.0.txt
@@ -118,6 +118,15 @@ UI, Workflows & Features
    "git branch --delete/--move [--remote]".
    (merge 2703c22 vs/completion-branch-fully-spelled-d-m-r later to maint).
 
+ * "git rev-parse --git-path hooks/<hook>" learned to take
+   core.hooksPath configuration variable (introduced during 2.9 cycle)
+   into account.
+   (merge 9445b49 ab/hooks later to maint).
+
+ * "git log --show-signature" and other commands that display the
+   verification status of PGP signature now shows the longer key-id,
+   as 32-bit key-id is so last century.
+
 
 Performance, Internal Implementation, Development Support etc.
 
@@ -600,6 +609,28 @@ notes for details).
    arises).
    (merge c2cafd3 js/test-lint-pathname later to maint).
 
+ * When "git merge-recursive" works on history with many criss-cross
+   merges in "verbose" mode, the names the command assigns to the
+   virtual merge bases could have overwritten each other by unintended
+   reuse of the same piece of memory.
+   (merge 5447a76 rs/pull-signed-tag later to maint).
+
+ * "git checkout --detach <branch>" used to give the same advice
+   message as that is issued when "git checkout <tag>" (or anything
+   that is not a branch name) is given, but asking with "--detach" is
+   an explicit enough sign that the user knows what is going on.  The
+   advice message has been squelched in this case.
+   (merge 779b88a sb/checkout-explit-detach-no-advice later to maint).
+
+ * "git difftool" by default ignores the error exit from the backend
+   commands it spawns, because often they signal that they found
+   differences by exiting with a non-zero status code just like "diff"
+   does; the exit status codes 126 and above however are special in
+   that they are used to signal that the command is not executable,
+   does not exist, or killed by a signal.  "git difftool" has been
+   taught to notice these exit status codes.
+   (merge 45a4f5d jk/difftool-command-not-found later to maint).
+
  * Other minor clean-ups and documentation updates
    (merge 02a8cfa rs/merge-add-strategies-simplification later to maint).
    (merge af4941d rs/merge-recursive-string-list-init later to maint).
diff --git c/GIT-VERSION-GEN w/GIT-VERSION-GEN
index eea85c340454..702c067a78c0 100755
--- c/GIT-VERSION-GEN
+++ w/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v2.10.0-rc0
+DEF_VER=v2.10.0-rc1
 
 LF='
 '
diff --git c/path.c w/path.c
index 081a22c1163c..07dd0f62eb82 100644
--- c/path.c
+++ w/path.c
@@ -475,7 +475,7 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	const char *git_dir;
 	struct strbuf git_submodule_common_dir = STRBUF_INIT;
 	struct strbuf git_submodule_dir = STRBUF_INIT;
-	const struct submodule *submodule_config;
+	const struct submodule *sub;
 
 	strbuf_addstr(buf, path);
 	strbuf_complete(buf, '/');
@@ -487,17 +487,12 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		strbuf_reset(buf);
-		/*
-		 * Lookup the submodule name from the config. If that fails
-		 * fall back to assuming the path is the name.
-		 */
-		submodule_config = submodule_from_path(null_sha1, path);
-		if (submodule_config)
+		sub = submodule_from_path(null_sha1, path);
+		if (sub) {
+			strbuf_reset(buf);
 			strbuf_git_path(buf, "%s/%s", "modules",
-					submodule_config->name);
-		else
-			strbuf_git_path(buf, "%s/%s", "modules", path);
+					sub->name);
+		}
 	}
 
 	strbuf_addch(buf, '/');

-------->8

Jacob Keller (7):
  cache: add empty_tree_oid object and helper function
  graph: add support for --line-prefix on all graph-aware output
  diff: prepare for additional submodule formats
  allow do_submodule_path to work even if submodule isn't checked out
  submodule: convert show_submodule_summary to use struct object_id *
  submodule: refactor show_submodule_summary with helper function
  diff: teach diff to display submodule difference with an inline diff

Junio C Hamano (2):
  Git 2.10-rc1
  diff.c: remove output_prefix_length field

