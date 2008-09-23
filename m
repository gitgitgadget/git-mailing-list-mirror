From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/2] git remote: prune all remotes with `prune -a`
Date: Tue, 23 Sep 2008 23:13:25 +0200
Message-ID: <1222204405-30454-3-git-send-email-hjemli@gmail.com>
References: <1222204405-30454-1-git-send-email-hjemli@gmail.com>
 <1222204405-30454-2-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 23:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFDU-0005sI-Nb
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbYIWVNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYIWVNd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:13:33 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:40815 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbYIWVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:13:29 -0400
Received: from localhost.localdomain (ti0025a380-3500.bb.online.no [83.108.111.180])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id m8NLDPbO011664
	for <git@vger.kernel.org>; Tue, 23 Sep 2008 23:13:26 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.2.309.gc1f46
In-Reply-To: <1222204405-30454-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96600>

This is handy when working with lots of remotes.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-remote.txt |    4 +++-
 builtin-remote.c             |   32 ++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index bb99810..55c108e 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git remote rm' <name>
 'git remote show' [-n] <name>
-'git remote prune' [-n | --dry-run] <name>
+'git remote prune' [-n | --dry-run] [-a | <name>]
 'git remote update' [group]
 
 DESCRIPTION
@@ -82,6 +82,8 @@ referenced by <name>, but are still locally available in
 +
 With `--dry-run` option, report what branches will be pruned, but do no
 actually prune them.
++
+With `-a` option, prune all remotes.
 
 'update'::
 
diff --git a/builtin-remote.c b/builtin-remote.c
index 626256e..973637e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -572,20 +572,48 @@ static int prune_one(const char *name, int dry_run)
 	return result;
 }
 
+struct prune_cbdata {
+	int result;
+	int dry_run;
+};
+
+static int prune_all_cb(struct remote *remote, void *cbdata)
+{
+	struct prune_cbdata *cb = cbdata;
+
+	cb->result |= prune_one(remote->name, cb->dry_run);
+	return 0;
+}
+
+static int prune_all(int dry_run)
+{
+	int result;
+	struct prune_cbdata cb;
+
+	cb.result = 0;
+	cb.dry_run = dry_run;
+	result = for_each_remote(prune_all_cb, &cb);
+	return (result | cb.result);
+}
+
 static int prune(int argc, const char **argv)
 {
-	int dry_run = 0, result = 0;
+	int dry_run = 0, all = 0, result = 0;
 	struct option options[] = {
 		OPT_GROUP("prune specific options"),
+		OPT_BOOLEAN('a', NULL, &all, "prune all remotes"),
 		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
-	if (argc < 1)
+	if (!argc == !all)
 		usage_with_options(builtin_remote_usage, options);
 
+	if (all)
+		return prune_all(dry_run);
+
 	for (; argc; argc--, argv++)
 		result |= prune_one(*argv, dry_run);
 
-- 
1.6.0.2.309.gc1f46
