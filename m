From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] git-reflog: add new option '--exclude=' to expire subcommand
Date: Wed, 11 Jun 2008 16:28:45 -0500
Message-ID: <OB99Y9Hiy2c1naDAzYj91bRmhr-KtTLrzzhzcVSN6-blyrxKhqEWtg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Xtm-0003bw-H9
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYFKV3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYFKV3b
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:29:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43684 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbYFKV3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:29:31 -0400
Received: by mail.nrlssc.navy.mil id m5BLSjk0023269; Wed, 11 Jun 2008 16:28:45 -0500
X-OriginalArrivalTime: 11 Jun 2008 21:28:45.0388 (UTC) FILETIME=[20E818C0:01C8CC0A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84664>

This new option will allow refs to be specified which will be skipped
when expiring, i.e. they will not be expired. Currently it is convenient
to use the '--all' option to operate on _all_ reflogs. In some cases it
may be convenient to operate on _all_ reflogs except one or two or ...

The primary motivation behind this option is to allow git-gc to exclude
refs/stash when calling git-reflog to expire reflogs.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I had one reservation against using --exclude= as the option name and that
is that --exclude= is generally used with a glob. In the future this can easily
be extended to accept a glob, and may be necessary depending on how per-branch
stashes are implemented. For now it is not necessary (for me).

-brandon


 Documentation/git-reflog.txt |    5 +++++
 builtin-reflog.c             |   27 ++++++++++++++++++++++++---
 t/t1410-reflog.sh            |   16 +++++++++++++++-
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 8492aea..d1c4a14 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -65,6 +65,11 @@ should not have to ever worry about missing objects, because the current
 prune and pack-objects know about reflogs and protect objects referred by
 them.
 
+--exclude=<ref>::
+	When expiring, do not operate on the reflog of the named ref.
+	This option may be used multiple times to exclude more than one ref.
+	This is not a glob, it is a ref name such as `stash` or `refs/stash`.
+
 --expire=<time>::
 	Entries older than this time are pruned.  Without the
 	option it is taken from configuration `gc.reflogExpire`,
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 897d1dc..9bb964b 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -350,7 +350,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cb;
 	unsigned long now = time(NULL);
-	int i, status, do_all;
+	int i, n, status, do_all;
+	const char **excludes = NULL;
+	int num_excludes = 0;
 
 	git_config(reflog_expire_config, NULL);
 
@@ -375,6 +377,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
+		else if (!prefixcmp(arg, "--exclude=")) {
+			excludes = xrealloc(excludes,
+				sizeof(*excludes) * (num_excludes+1));
+			excludes[num_excludes++] = arg+10;
+		}
 		else if (!prefixcmp(arg, "--expire="))
 			cb.expire_total = approxidate(arg + 9);
 		else if (!prefixcmp(arg, "--expire-unreachable="))
@@ -415,7 +422,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for_each_reflog(collect_reflog, &collected);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
-			status |= expire_reflog(e->reflog, e->sha1, 0, &cb);
+			for (n = 0; n < num_excludes; n++)
+				if (refname_match(excludes[n], e->reflog,
+					    ref_rev_parse_rules))
+					break;
+			if (n == num_excludes)
+				status |= expire_reflog(e->reflog, e->sha1, 0,
+					&cb);
 			free(e);
 		}
 		free(collected.e);
@@ -428,8 +441,16 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			status |= error("%s points nowhere!", ref);
 			continue;
 		}
-		status |= expire_reflog(ref, sha1, 0, &cb);
+		for (n = 0; n < num_excludes; n++)
+			if (refname_match(excludes[n], ref,
+				    ref_rev_parse_rules))
+				break;
+		if (n == num_excludes)
+			status |= expire_reflog(ref, sha1, 0, &cb);
 	}
+
+	free(excludes);
+
 	return status;
 }
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 73f830d..d33f3d0 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -158,6 +158,19 @@ test_expect_success 'reflog expire' '
 	check_fsck "dangling commit $K"
 '
 
+test_expect_success 'reflog expire --exclude=' '
+
+	git reflog expire --exclude=master \
+		--expire=now \
+		--expire-unreachable=now \
+		--all &&
+
+	loglen=$(wc -l <.git/logs/HEAD) &&
+	test $loglen = 0 &&
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 2
+'
+
 test_expect_success 'prune and fsck' '
 
 	git prune &&
@@ -188,7 +201,8 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&
 
-	test 5 = $(git reflog | wc -l) &&
+	test 3 = $(git reflog | wc -l) &&
+	test 5 = $(git reflog show master | wc -l) &&
 
 	git reflog delete master@{1} &&
 	git reflog show master > output &&
-- 
1.5.5.3
