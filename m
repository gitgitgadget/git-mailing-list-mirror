From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] revert: Implement --abort processing
Date: Wed,  1 Jun 2011 16:07:26 +0000
Message-ID: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
References: <This is sli>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRnxH-0005wF-G3
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab1FAQHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:07:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62175 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1FAQH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:07:29 -0400
Received: by vws1 with SMTP id 1so4181569vws.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LMHVBYLi0CPILTMVIFzDaNdbO8NxxMxZ69WJvLYZLog=;
        b=fQh09G1E+H9jDQLOdlEvyRJfaPPX6dO69S1sL4wJ95aKy8AcC3ioUl/V9ZZqy5LUXw
         MbOdTBz2kj3QT9A2oRoZSxTnLnhW8nSdf3EfKj3obYOayJSt/gmzeNsIBhxRhp+AFHIR
         6qP/L5O5YKILpoT63jn12bIEcp9pUa/nbD15I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WVGVK7kl+Qc0r62UIhOwdY5Wjfo5qzXe6rWG/vtugRMc+0h7UQ6mFMmseAWG1kRCP9
         j6ywc3104VHFKfb8EJP3YOMt5M0C/CFWXWbRecllUbwxKJZEBiDy82LhjoIM0834AUq3
         YgLpSlX+jxJmgRbpiYxgn875JeWPHPXaZOwZY=
Received: by 10.52.75.167 with SMTP id d7mr1209564vdw.95.1306944448751;
        Wed, 01 Jun 2011 09:07:28 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id bl1sm410893vbb.5.2011.06.01.09.07.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 09:07:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <This is sli>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174874>

To abort, perform a "rerere clear" and "reset --hard" to the ref
specified by the HEAD file introduced earlier in the series.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I want some feedback on this -- am I doing this right? Should I be
 re-implementing "reset --hard" like this?

 builtin/revert.c                |   84 +++++++++++++++++++++++++++++++++++++--
 t/t3510-cherry-pick-sequence.sh |   27 ++++++++++++
 2 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8eee4d5..ae85df7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -12,6 +12,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "merge-recursive.h"
+#include "unpack-trees.h"
 #include "refs.h"
 #include "dir.h"
 
@@ -208,8 +209,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 
 	/* Remove these when the options are actually implemented */
-	if (opts->abort_oper)
-		die("--abort is not implemented yet");
 	if (opts->skip_oper)
 		die("--skip is not implemented yet");
 	if (opts->continue_oper)
@@ -647,6 +646,44 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
+static int hard_reset_to_ref(unsigned char *sha1)
+{
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree_desc desc;
+	int fd;
+
+	/* rerere clear */
+	setup_rerere(&merge_rr, 0);
+	rerere_clear(&merge_rr);
+
+	/* Clean worktree, index */
+	read_cache_unmerged();
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = &the_index;
+	unpack_tree_opts.dst_index = &the_index;
+	unpack_tree_opts.fn = oneway_merge;
+	unpack_tree_opts.merge = 1;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.reset = 1;
+
+	fd = hold_locked_index(lock, 1);
+	fill_tree_descriptor(&desc, sha1);
+	if (unpack_trees(1, &desc, &unpack_tree_opts) < 0)
+		return error (_("Failed to unpack trees."));
+	if (write_index(&the_index, fd) ||
+		commit_locked_index(lock))
+		return error(_("Could not write index."));
+
+	/* Update the HEAD ref */
+	if (update_ref("updating HEAD", "HEAD", sha1, NULL, 0, MSG_ON_ERR))
+		return error(_("Unable to update HEAD"));
+	return 0;
+}
+
 static void format_todo(struct strbuf *buf, struct commit_list *list,
 			struct replay_opts *opts)
 {
@@ -743,6 +780,45 @@ static int pick_commits(struct replay_opts *opts)
 	return cleanup_sequencer_dir();
 }
 
+static int process_continuation(struct replay_opts *opts)
+{
+	unsigned char sha1[20];
+	char head[40];
+	int fd;
+
+	if (opts->abort_oper) {
+		/* First, read the HEAD_FILE */
+		if (!file_exists(HEAD_FILE))
+			goto error;
+		fd = open(HEAD_FILE, O_RDONLY, 0666);
+		if (fd < 0)
+			return error(_("Could not open '%s' for reading: %s"),
+				HEAD_FILE, strerror(errno));
+		if (read_in_full(fd, head, 40) < 40 || get_sha1_hex(head, sha1) < 0) {
+			close(fd);
+			return error(_("Corrupt '%s': %s"), HEAD_FILE, strerror(errno));
+		}
+		close(fd);
+
+		if (hard_reset_to_ref(sha1) < 0)
+			/* Error already reported */
+			return -1;
+		return cleanup_sequencer_dir();
+	}
+	else if (opts->skip_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+	}
+	else if (opts->continue_oper) {
+		if (!file_exists(TODO_FILE))
+			goto error;
+	}
+
+	return pick_commits(opts);
+error:
+	return error(_("No %s in progress"), me);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	int res;
@@ -755,7 +831,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "revert";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -775,7 +851,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "cherry-pick";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		return res;
 	if (res < 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index a2e1888..7e22898 100644
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -36,4 +36,31 @@ test_expect_success 'cherry-pick cleans up sequencer directory upon success' '
 	test_must_fail test -d .git/sequencer
 '
 
+test_expect_success '--abort complains when no cherry-pick is in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --abort >actual 2>&1 &&
+	echo "error: No cherry-pick in progress" >expect &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success '--abort restores HEAD after failed cherry-pick' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --abort &&
+	newhead=$(git rev-parse HEAD) &&
+	test "$head" = "$newhead"
+'
+
+test_expect_success '--abort resets worktree and index after failed cherry-pick' '
+	pristine_detach initial &&
+	head=$(git rev-parse HEAD) &&
+	test_must_fail git cherry-pick base..picked &&
+	git add foo &&
+	git cherry-pick --abort &&
+	git update-index -q --ignore-submodules --refresh &&
+	git diff-files --quiet --ignore-submodules &&
+	git diff-index --cached --quiet --ignore-submodules HEAD --
+'
+
 test_done
-- 
1.7.5.GIT
