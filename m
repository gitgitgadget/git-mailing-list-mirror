X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 00:25:03 -0800
Message-ID: <7v64c8thr4.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
	<20061218140813.GA32446@spearce.org>
	<7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 08:25:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34796>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwaHl-0002tb-6w for gcvg-git@gmane.org; Tue, 19 Dec
 2006 09:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932665AbWLSIZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 03:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWLSIZH
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 03:25:07 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57483 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932664AbWLSIZF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 03:25:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219082504.PVND9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 03:25:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0YRG1W0041kojtg0000000; Tue, 19 Dec 2006
 03:25:16 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

This prepares a place to collect reflog management subcommands,
and implements "expire" action.

	$ git reflog expire --dry-run \
		--expire=4.weeks \
		--expire-lost=1.week \
		refs/heads/master

The expiration uses two timestamps: --expire and --expire-lost.
Entries older than expire time (defaults to 90 days), and
entries older than expire-lost time (defaults to 30 days) and
talk about a commit that has been rewound and made unreachable
from the current tip of the ref are removed from the reflog.

The parameter handling is still rough, but I think the
core logic for expiration is already sound.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile         |    1 +
 builtin-reflog.c |  175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h        |    1 +
 git.c            |    1 +
 4 files changed, 178 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8919dab..17dabde 100644
--- a/Makefile
+++ b/Makefile
@@ -292,6 +292,7 @@ BUILTIN_OBJS = \
 	builtin-prune-packed.o \
 	builtin-push.o \
 	builtin-read-tree.o \
+	builtin-reflog.o \
 	builtin-repo-config.o \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
diff --git a/builtin-reflog.c b/builtin-reflog.c
new file mode 100644
index 0000000..aef2fc2
--- /dev/null
+++ b/builtin-reflog.c
@@ -0,0 +1,175 @@
+#include "cache.h"
+#include "builtin.h"
+#include "commit.h"
+#include "refs.h"
+#include "dir.h"
+#include <time.h>
+
+struct expire_reflog_cb {
+	FILE *newlog;
+	const char *ref;
+	struct commit *ref_commit;
+	unsigned long expire_total;
+	unsigned long expire_lost;
+};
+
+static int keep_entry(struct commit **it, unsigned char *sha1)
+{
+	*it = NULL;
+	if (is_null_sha1(sha1))
+		return 1;
+	*it = lookup_commit_reference_gently(sha1, 1);
+	return (*it != NULL);
+}
+
+static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     char *data, void *cb_data)
+{
+	struct expire_reflog_cb *cb = cb_data;
+	unsigned long timestamp;
+	char *cp, *ep;
+	struct commit *old, *new;
+
+	cp = strchr(data, '>');
+	if (!cp || *++cp != ' ')
+		goto prune;
+	timestamp = strtoul(cp, &ep, 10);
+	if (*ep != ' ')
+		goto prune;
+	if (timestamp < cb->expire_total)
+		goto prune;
+
+	if (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1))
+		goto prune;
+
+	if ((timestamp < cb->expire_lost) &&
+	    ((old && !in_merge_bases(old, cb->ref_commit)) ||
+	     (new && !in_merge_bases(new, cb->ref_commit))))
+		goto prune;
+
+	if (cb->newlog)
+		fprintf(cb->newlog, "%s %s %s",
+			sha1_to_hex(osha1), sha1_to_hex(nsha1), data);
+	return 0;
+ prune:
+	if (!cb->newlog)
+		fprintf(stderr, "would prune %s", data);
+	return 0;
+}
+
+struct cmd_reflog_expire_cb {
+	int dry_run;
+	unsigned long expire_total;
+	unsigned long expire_lost;
+};
+
+static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+{
+	struct cmd_reflog_expire_cb *cmd = cb_data;
+	struct expire_reflog_cb cb;
+	struct ref_lock *lock;
+	char *newlog_path = NULL;
+	int status = 0;
+
+	if (strncmp(ref, "refs/", 5))
+		return error("not a ref '%s'", ref);
+
+	memset(&cb, 0, sizeof(cb));
+	/* we take the lock for the ref itself to prevent it from
+	 * getting updated.
+	 */
+	lock = lock_ref_sha1(ref + 5, sha1);
+	if (!lock)
+		return error("cannot lock ref '%s'", ref);
+	if (!file_exists(lock->log_file))
+		goto finish;
+	if (!cmd->dry_run) {
+		newlog_path = xstrdup(git_path("logs/%s.lock", ref));
+		cb.newlog = fopen(newlog_path, "w");
+	}
+
+	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
+	if (!cb.ref_commit) {
+		status = error("ref '%s' does not point at a commit", ref);
+		goto finish;
+	}
+	cb.ref = ref;
+	cb.expire_total = cmd->expire_total;
+	cb.expire_lost = cmd->expire_lost;
+	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+ finish:
+	if (cb.newlog) {
+		if (fclose(cb.newlog))
+			status |= error("%s: %s", strerror(errno),
+					newlog_path);
+		if (rename(newlog_path, lock->log_file)) {
+			status |= error("cannot rename %s to %s",
+					newlog_path, lock->log_file);
+			unlink(newlog_path);
+		}
+	}
+	free(newlog_path);
+	unlock_ref(lock);
+	return status;
+}
+
+static const char reflog_expire_usage[] =
+"git-reflog expire [--dry-run] [--expire=<time>] [--expire-lost=<time>] [--all] <refs>...";
+
+static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
+{
+	struct cmd_reflog_expire_cb cb;
+	unsigned long now = time(NULL);
+	int i, status, do_all;
+
+	save_commit_buffer = 0;
+	do_all = status = 0;
+	memset(&cb, 0, sizeof(cb));
+	cb.expire_total = now - 90 * 24 * 3600;
+	cb.expire_lost = now - 30 * 24 * 3600;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
+			cb.dry_run = 1;
+		else if (!strncmp(arg, "--expire=", 9))
+			cb.expire_total = approxidate(arg + 9);
+		else if (!strncmp(arg, "--expire-lost=", 14))
+			cb.expire_lost = approxidate(arg + 14);
+		else if (!strcmp(arg, "--all"))
+			do_all = 1;
+		else if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_expire_usage);
+		else
+			break;
+	}
+	if (do_all)
+		status |= for_each_ref(expire_reflog, &cb);
+	while (i < argc) {
+		const char *ref = argv[i++];
+		unsigned char sha1[20];
+		if (!resolve_ref(ref, sha1, 1, NULL)) {
+			status |= error("%s points nowhere!", ref);
+			continue;
+		}
+		status |= expire_reflog(ref, sha1, 0, &cb);
+	}
+	return status;
+}
+
+static const char reflog_usage[] =
+"git-reflog (expire | ...)";
+
+int cmd_reflog(int argc, const char **argv, const char *prefix)
+{
+	if (argc < 2)
+		usage(reflog_usage);
+	else if (!strcmp(argv[1], "expire"))
+		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
+	else
+		usage(reflog_usage);
+}
diff --git a/builtin.h b/builtin.h
index 08519e7..fdc0907 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,6 +51,7 @@ extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 016ee8a..ae4c99f 100644
--- a/git.c
+++ b/git.c
@@ -256,6 +256,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "repo-config", cmd_repo_config },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
-- 
1.4.4.2.g688739

