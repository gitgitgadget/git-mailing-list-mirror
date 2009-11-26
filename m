From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 4/8] Teach git-merge to pass -X<option> to the backend strategy module
Date: Wed, 25 Nov 2009 21:23:56 -0500
Message-ID: <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
Cc: gitster@pobox.com, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKM-0004ry-1F
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbZKZCmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbZKZCmr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:47 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbZKZCmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:32 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Nov 2009 21:26:41 -0500
Received: (qmail 5570 invoked from network); 26 Nov 2009 02:25:41 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)
  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:41 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:16 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:26:41.0152 (UTC) FILETIME=[E3743800:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133757>

Distinguishing slight variation of modes of operation between the vanilla
merge-recursive and merge-recursive-ours by the command name may have been
an easy way to experiment, but we should bite the bullet and allow backend
specific options to be given by the end user.

(Patch originally by Junio Hamano <gitster@pobox.com>.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Makefile                     |    3 ---
 builtin-merge-recursive.c    |   21 +++++++++++++++------
 builtin-merge.c              |   40 ++++++++++++++++++++++++++++++++++++----
 t/t6034-merge-ours-theirs.sh |    4 ++--
 4 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index f92b375..5a0b3d4 100644
--- a/Makefile
+++ b/Makefile
@@ -401,8 +401,6 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
-BUILT_INS += git-merge-recursive-ours$X
-BUILT_INS += git-merge-recursive-theirs$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
@@ -1911,7 +1909,6 @@ check-docs::
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-recursive-ours | git-merge-recursive-theirs | \
 		git-merge-resolve | git-merge-subtree | \
 		git-fsck-objects | git-init-db | \
 		git-?*--?* ) continue ;; \
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index f5082da..53f8f05 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -29,18 +29,27 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		int namelen = strlen(argv[0]);
 		if (!suffixcmp(argv[0], "-subtree"))
 			o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
-		else if (!suffixcmp(argv[0], "-ours"))
-			o.recursive_variant = MERGE_RECURSIVE_OURS;
-		else if (!suffixcmp(argv[0], "-theirs"))
-			o.recursive_variant = MERGE_RECURSIVE_THEIRS;
 	}
 
 	if (argc < 4)
 		usagef("%s <base>... -- <head> <remote> ...", argv[0]);
 
 	for (i = 1; i < argc; ++i) {
-		if (!strcmp(argv[i], "--"))
-			break;
+		const char *arg = argv[i];
+
+		if (!prefixcmp(arg, "--")) {
+			if (!arg[2])
+				break;
+			if (!strcmp(arg+2, "ours"))
+				o.recursive_variant = MERGE_RECURSIVE_OURS;
+			else if (!strcmp(arg+2, "theirs"))
+				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
+			else if (!strcmp(arg+2, "subtree"))
+				o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+			else
+				die("Unknown option %s", arg);
+			continue;
+		}
 		if (bases_count < ARRAY_SIZE(bases)-1) {
 			unsigned char *sha = xmalloc(20);
 			if (get_sha1(argv[i], sha))
diff --git a/builtin-merge.c b/builtin-merge.c
index df089bb..9a95bc8 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -50,13 +50,13 @@ static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
+static const char **xopts;
+static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static int verbosity;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
-	{ "recursive-ours", DEFAULT_TWOHEAD | NO_TRIVIAL },
-	{ "recursive-theirs", DEFAULT_TWOHEAD | NO_TRIVIAL },
 	{ "octopus",    DEFAULT_OCTOPUS },
 	{ "resolve",    0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
@@ -148,6 +148,17 @@ static int option_parse_strategy(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_x(const struct option *opt,
+			  const char *arg, int unset)
+{
+	if (unset)
+		return 0;
+	
+	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
+	xopts[xopts_nr++] = xstrdup(arg);
+	return 0;
+}
+
 static int option_parse_n(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -174,6 +185,8 @@ static struct option builtin_merge_options[] = {
 		"abort if fast-forward is not possible"),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
+	OPT_CALLBACK('X', "extended", &xopts, "option=value",
+		"option for selected merge strategy", option_parse_x),
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
 		"message to be used for the merge commit (if any)",
 		option_parse_message),
@@ -536,7 +549,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      const char *head_arg)
 {
 	const char **args;
-	int i = 0, ret;
+	int i = 0, x = 0, ret;
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
 	int index_fd;
@@ -566,6 +579,17 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		init_merge_options(&o);
 		if (!strcmp(strategy, "subtree"))
 			o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+			
+		for (x = 0; x < xopts_nr; x++) {
+			if (!strcmp(xopts[x], "ours"))
+				o.recursive_variant = MERGE_RECURSIVE_OURS;
+			else if (!strcmp(xopts[x], "theirs"))
+				o.recursive_variant = MERGE_RECURSIVE_THEIRS;
+			else if (!strcmp(xopts[x], "subtree"))
+				o.recursive_variant = MERGE_RECURSIVE_SUBTREE;
+			else
+				die("Unknown option for merge-recursive: -X%s", xopts[x]);
+		}
 
 		o.branch1 = head_arg;
 		o.branch2 = remoteheads->item->util;
@@ -583,10 +607,16 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		rollback_lock_file(lock);
 		return clean ? 0 : 1;
 	} else {
-		args = xmalloc((4 + commit_list_count(common) +
+		args = xmalloc((4 + xopts_nr + commit_list_count(common) +
 					commit_list_count(remoteheads)) * sizeof(char *));
 		strbuf_addf(&buf, "merge-%s", strategy);
 		args[i++] = buf.buf;
+		for (x = 0; x < xopts_nr; x++) {
+			char *s = xmalloc(strlen(xopts[x])+2+1);
+			strcpy(s, "--");
+			strcpy(s+2, xopts[x]);
+			args[i++] = s;
+		}
 		for (j = common; j; j = j->next)
 			args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
 		args[i++] = "--";
@@ -597,6 +627,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		ret = run_command_v_opt(args, RUN_GIT_CMD);
 		strbuf_release(&buf);
 		i = 1;
+		for (x = 0; x < xopts_nr; x++)
+			free((void *)args[i++]);
 		for (j = common; j; j = j->next)
 			free((void *)args[i++]);
 		i += 2;
diff --git a/t/t6034-merge-ours-theirs.sh b/t/t6034-merge-ours-theirs.sh
index 56a9247..08c9f79 100755
--- a/t/t6034-merge-ours-theirs.sh
+++ b/t/t6034-merge-ours-theirs.sh
@@ -35,7 +35,7 @@ test_expect_success 'plain recursive - should conflict' '
 
 test_expect_success 'recursive favouring theirs' '
 	git reset --hard master &&
-	git merge -s recursive-theirs side &&
+	git merge -s recursive -Xtheirs side &&
 	! grep nine file &&
 	grep nueve file &&
 	! grep 9 file &&
@@ -45,7 +45,7 @@ test_expect_success 'recursive favouring theirs' '
 
 test_expect_success 'recursive favouring ours' '
 	git reset --hard master &&
-	git merge -s recursive-ours side &&
+	git merge -s recursive -X ours side &&
 	grep nine file &&
 	! grep nueve file &&
 	! grep 9 file &&
-- 
1.6.6.rc0.62.gaccf
