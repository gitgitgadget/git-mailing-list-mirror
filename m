Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 24317 invoked by uid 111); 5 Nov 2007 19:01:49 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 14:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXKETBo (ORCPT <rfc822;peff@peff.net>);
	Mon, 5 Nov 2007 14:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbXKETBo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:01:44 -0500
Received: from pan.madism.org ([88.191.52.104]:58915 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184AbXKETBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:01:43 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4DB682894C;
	Mon,  5 Nov 2007 20:01:41 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7A76E20E80B; Mon,  5 Nov 2007 20:01:41 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date:	Mon,  5 Nov 2007 20:01:41 +0100
Message-Id: <1194289301-7800-1-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1541.gd2b5c-dirty
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

When git-revert has a file argument then redirect the user to what he
probably meant.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-revert.c |   24 +++++++++++++++++-------
 gitk             |    2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 62ab1fa..9660048 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -38,7 +38,7 @@ static const char *me;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-static void parse_args(int argc, const char **argv)
+static void parse_args(int argc, const char **argv, const char *prefix)
 {
 	const char * const * usage_str =
 		action == REVERT ?  revert_usage : cherry_pick_usage;
@@ -58,8 +58,18 @@ static void parse_args(int argc, const char **argv)
 		usage_with_options(usage_str, options);
 	arg = argv[0];
 
-	if (get_sha1(arg, sha1))
-		die ("Cannot find '%s'", arg);
+	if (get_sha1(arg, sha1)) {
+		struct stat st;
+		const char *name;
+
+		name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
+		if (!lstat(name, &st)) {
+			die("Cannot find commit '%s', did you meant: "
+				"git checkout HEAD -- '%s'", arg, arg);
+		} else {
+			die("Cannot find commit '%s'", arg);
+		}
+	}
 	commit = (struct commit *)parse_object(sha1);
 	if (!commit)
 		die ("Could not find %s", sha1_to_hex(sha1));
@@ -225,7 +235,7 @@ static int merge_recursive(const char *base_sha1,
 	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -237,7 +247,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	git_config(git_default_config);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv);
+	parse_args(argc, argv, prefix);
 
 	/* this is copied from the shell script, but it's never triggered... */
 	if (action == REVERT && !no_replay)
@@ -405,12 +415,12 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 		edit = 1;
 	no_replay = 1;
 	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	no_replay = 0;
 	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
diff --git a/gitk b/gitk
index 1da0b0a..ab8bab2 100755
--- a/gitk
+++ b/gitk
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Tcl ignores the next line -*- tcl -*- \
-exec wish "$0" -- "$@"
+exec wish8.5 "$0" -- "$@"
 
 # Copyright (C) 2005-2006 Paul Mackerras.  All rights reserved.
 # This program is free software; it may be used, copied, modified
-- 
1.5.3.5.1541.gd2b5c-dirty

