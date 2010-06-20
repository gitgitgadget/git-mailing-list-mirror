From: Greg Hewgill <greg@hewgill.com>
Subject: Re: Proposal for git stash rename
Date: Sun, 20 Jun 2010 11:11:12 +0000
Message-ID: <20100620111112.GH24805@occam.hewgill.net>
References: <20100620093142.GF24805@occam.hewgill.net> <AANLkTimjEksHI4nlefqmNzdNiseVyMQcw312g2AHFQDZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 20 13:11:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQIQt-0000et-Dj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 13:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884Ab0FTLLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 07:11:15 -0400
Received: from occam.hewgill.net ([69.41.174.196]:49829 "EHLO
	occam.hewgill.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab0FTLLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 07:11:14 -0400
Received: by occam.hewgill.net (Postfix, from userid 1001)
	id 0728E22823; Sun, 20 Jun 2010 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hewgill.com;
 i=@hewgill.com; q=dns/txt; s=greg; t=1277032272; h=Date : From : To :
 Subject : Message-ID : References : MIME-Version : Content-Type :
 Content-Disposition : In-Reply-To : X-PGP-Fingerprint : User-Agent;
 bh=EarFRrER71HWnnYXBchBpJd8wRFkYKyoDZeScwHLgZw=; b=BXzVFVMPetNmeWSros8IHwBZMHrjjyO9BFcDWBL1lQR17K6YVxsotnF3Ot6lu3q6klp2YhBXYeP4DVT2CD0uNSZYsE9HtKUC+D+ePPNJc5a4z18O3K0lcUhKZ+THUfp1u/y2PLXpeh4EVTQWrWEq62+uwRLAAH2BTObmgue4jEI=
Content-Disposition: inline
In-Reply-To: <AANLkTimjEksHI4nlefqmNzdNiseVyMQcw312g2AHFQDZ@mail.gmail.com>
X-PGP-Fingerprint: 862C 894D 4908 0240 FEEE  6D1F FA34 8460 74E0 2115
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149394>

On Sun, Jun 20, 2010 at 10:54:43AM +0000, ??var Arnfj??r?? Bjarmason wrote:
> It's good to post a WIP PATCH even if it needs cleanup, just as a
> point for further discussion.

Thanks, point taken. WIP patch follows.

This patch implements a "git stash rename" using a new
"git reflog update" command that updates the message associated
with a reflog entry.
---
 builtin/reflog.c |  149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh     |    5 ++
 t/t3903-stash.sh |   10 ++++
 3 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ebf610e..35eae1f 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
+#include "strbuf.h"
 
 /*
  * reflog expire
@@ -16,6 +17,8 @@ static const char reflog_expire_usage[] =
 "git reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =
 "git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
+static const char reflog_update_usage[] =
+"git reflog update [--verbose] [--dry-run] [--rewrite] <ref> <newdescr>";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -30,6 +33,7 @@ struct cmd_reflog_expire_cb {
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
 	int recno;
+	struct strbuf newmsg;
 };
 
 struct expire_reflog_cb {
@@ -335,6 +339,30 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
+static int update_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct expire_reflog_cb *cb = cb_data;
+
+	if (cb->cmd->rewrite)
+		osha1 = cb->last_kept_sha1;
+
+	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
+		message = cb->cmd->newmsg.buf;
+
+	if (cb->newlog) {
+		char sign = (tz < 0) ? '-' : '+';
+		int zone = (tz < 0) ? (-tz) : tz;
+		fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			sha1_to_hex(osha1), sha1_to_hex(nsha1),
+			email, timestamp, sign, zone,
+			message);
+		hashcpy(cb->last_kept_sha1, nsha1);
+	}
+	return 0;
+}
+
 static int push_tip_to_list(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct commit_list **list = cb_data;
@@ -448,6 +476,65 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	return status;
 }
 
+static int update_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+{
+	struct cmd_reflog_expire_cb *cmd = cb_data;
+	struct expire_reflog_cb cb;
+	struct ref_lock *lock;
+	char *log_file, *newlog_path = NULL;
+	int status = 0;
+
+	memset(&cb, 0, sizeof(cb));
+
+	/*
+	 * we take the lock for the ref itself to prevent it from
+	 * getting updated.
+	 */
+	lock = lock_any_ref_for_update(ref, sha1, 0);
+	if (!lock)
+		return error("cannot lock ref '%s'", ref);
+	log_file = git_pathdup("logs/%s", ref);
+	if (!file_exists(log_file))
+		goto finish;
+	if (!cmd->dry_run) {
+		newlog_path = git_pathdup("logs/%s.lock", ref);
+		cb.newlog = fopen(newlog_path, "w");
+	}
+
+	cb.cmd = cmd;
+
+	for_each_reflog_ent(ref, update_reflog_ent, &cb);
+
+ finish:
+	if (cb.newlog) {
+		if (fclose(cb.newlog)) {
+			status |= error("%s: %s", strerror(errno),
+					newlog_path);
+			unlink(newlog_path);
+		} else if (cmd->updateref &&
+			(write_in_full(lock->lock_fd,
+				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
+			 close_ref(lock) < 0)) {
+			status |= error("Couldn't write %s",
+				lock->lk->filename);
+			unlink(newlog_path);
+		} else if (rename(newlog_path, log_file)) {
+			status |= error("cannot rename %s to %s",
+					newlog_path, log_file);
+			unlink(newlog_path);
+		} else if (cmd->updateref && commit_ref(lock)) {
+			status |= error("Couldn't set %s", lock->ref_name);
+		} else {
+			adjust_shared_perm(log_file);
+		}
+	}
+	free(newlog_path);
+	free(log_file);
+	unlock_ref(lock);
+	return status;
+}
+
 static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
 {
 	struct collected_reflog *e;
@@ -752,6 +839,65 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int cmd_reflog_update(int argc, const char **argv, const char *prefix)
+{
+	struct cmd_reflog_expire_cb cb;
+	int i, status = 0;
+
+	memset(&cb, 0, sizeof(cb));
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
+			cb.dry_run = 1;
+		else if (!strcmp(arg, "--rewrite"))
+			cb.rewrite = 1;
+		else if (!strcmp(arg, "--verbose"))
+			cb.verbose = 1;
+		else if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_update_usage);
+		else
+			break;
+	}
+
+	if (argc - i < 2)
+		usage(reflog_update_usage);
+
+	strbuf_init(&cb.newmsg, strlen(argv[i+1])+1);
+	strbuf_addstr(&cb.newmsg, argv[i+1]);
+	strbuf_addstr(&cb.newmsg, "\n");
+
+	const char *spec = strstr(argv[i], "@{");
+	unsigned char sha1[20];
+	char *ep, *ref;
+	int recno;
+
+	if (!spec) {
+		return error("Not a reflog: %s", argv[i]);
+	}
+
+	if (!dwim_log(argv[i], spec - argv[i], sha1, &ref)) {
+		return error("no reflog for '%s'", argv[i]);
+	}
+
+	recno = strtoul(spec + 2, &ep, 10);
+	if (*ep == '}') {
+		cb.recno = -recno;
+		for_each_reflog_ent(ref, count_reflog_ent, &cb);
+	} else {
+		return error("specific ref please");
+	}
+
+	status |= update_reflog(ref, sha1, 0, &cb);
+	free(ref);
+
+	return status;
+}
+
 /*
  * main "reflog"
  */
@@ -777,6 +923,9 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "update"))
+		return cmd_reflog_update(argc - 1, argv + 1, prefix);
+
 	/* Not a recognized reflog command..*/
 	usage(reflog_usage);
 }
diff --git a/git-stash.sh b/git-stash.sh
index 1d95447..aa80897 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -8,6 +8,7 @@ USAGE="list [<options>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
+   or: $dashless rename <stash> <message>
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -431,6 +432,10 @@ branch)
 	shift
 	apply_to_branch "$@"
 	;;
+rename)
+	shift
+	git reflog update $1 "$2"
+	;;
 *)
 	case $# in
 	0)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 8fe14cc..c0de00c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,14 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'update stash message' '
+	git reset --hard &&
+	git checkout master &&
+	echo foo >file &&
+	git stash save "first message" &&
+	git stash list | grep "^stash@{0}: On master: first message$" &&
+	git stash rename stash@{0} "second message" &&
+	git stash list | grep "^stash@{0}: second message$"
+'
+
 test_done
-- 
1.6.6
