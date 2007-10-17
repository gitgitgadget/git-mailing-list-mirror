From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach "git reflog" a subcommand to delete single entries
Date: Wed, 17 Oct 2007 02:50:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710170249260.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 17 03:51:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy3u-0002nu-EE
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761669AbXJQBuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761546AbXJQBuz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:50:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761540AbXJQBuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:50:54 -0400
Received: (qmail invoked by alias); 17 Oct 2007 01:50:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 17 Oct 2007 03:50:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nrYAni4HnoS5IXImJC+pY0D1lKWdBuW2gbCo4W4
	0FIPigjMc5RIHD
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61304>


This commit implements the "delete" subcommand:

	git reflog delete master@{2}

will delete the second reflog entry of the "master" branch.

With this, it should be easy to implement "git stash pop" everybody
seems to want these days.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-reflog.txt |    5 +++
 builtin-reflog.c             |   59 ++++++++++++++++++++++++++++++++++++++++++
 t/t1410-reflog.sh            |   26 ++++++++++++++++++
 3 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5c7316c..a0c7cee 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -19,6 +19,8 @@ depending on the subcommand:
 git reflog expire [--dry-run] [--stale-fix] [--verbose]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
 
+git reflog delete ref@\{specifier\}...
+
 git reflog [show] [log-options]
 
 Reflog is a mechanism to record when the tip of branches are
@@ -36,6 +38,9 @@ subcommands) will take all the normal log options, and show the log of
 It is basically an alias for 'git log -g --abbrev-commit
 --pretty=oneline', see gitlink:git-log[1].
 
+To delete single entries from the reflog, use the subcommand "delete"
+and specify the _exact_ entry (e.g. ``git reflog delete master@\{2\}'').
+
 
 OPTIONS
 -------
diff --git a/builtin-reflog.c b/builtin-reflog.c
index ce093ca..f422693 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -25,6 +25,7 @@ struct cmd_reflog_expire_cb {
 	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
+	int recno;
 };
 
 struct expire_reflog_cb {
@@ -220,6 +221,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			goto prune;
 	}
 
+	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
+		goto prune;
+
 	if (cb->newlog) {
 		char sign = (tz < 0) ? '-' : '+';
 		int zone = (tz < 0) ? (-tz) : tz;
@@ -363,6 +367,58 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct cmd_reflog_expire_cb *cb = cb_data;
+	if (!cb->expire_total || timestamp < cb->expire_total)
+		cb->recno++;
+	return 0;
+}
+
+static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
+{
+	struct cmd_reflog_expire_cb cb;
+	int i, status = 0;
+
+	if (argc < 2)
+		return error("Nothing to delete?");
+
+	memset(&cb, 0, sizeof(cb));
+
+	for (i = 1; i < argc; i++) {
+		const char *spec = strstr(argv[i], "@{");
+		unsigned char sha1[20];
+		char *ep, *ref;
+		int recno;
+
+		if (!spec) {
+			status |= error("Not a reflog: %s", ref);
+			continue;
+		}
+
+		if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
+			status |= error("%s points nowhere!", argv[i]);
+			continue;
+		}
+
+		recno = strtoul(spec + 2, &ep, 10);
+		if (*ep == '}') {
+			cb.recno = -recno;
+			for_each_reflog_ent(ref, count_reflog_ent, &cb);
+		} else {
+			cb.expire_total = approxidate(spec + 2);
+			for_each_reflog_ent(ref, count_reflog_ent, &cb);
+			cb.expire_total = 0;
+		}
+
+		status |= expire_reflog(ref, sha1, 0, &cb);
+		free(ref);
+	}
+	return status;
+}
+
 /*
  * main "reflog"
  */
@@ -382,6 +438,9 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "delete"))
+		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
+
 	/* Not a recognized reflog command..*/
 	usage(reflog_usage);
 }
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index e5bbc38..12a53ed 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -175,4 +175,30 @@ test_expect_success 'recover and check' '
 
 '
 
+test_expect_success 'delete' '
+	echo 1 > C &&
+	test_tick &&
+	git commit -m rat C &&
+
+	echo 2 > C &&
+	test_tick &&
+	git commit -m ox C &&
+
+	echo 3 > C &&
+	test_tick &&
+	git commit -m tiger C &&
+
+	test 5 = $(git reflog | wc -l) &&
+
+	git reflog delete master@{1} &&
+	git reflog show master > output &&
+	test 4 = $(wc -l < output) &&
+	! grep ox < output &&
+
+	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
+	git reflog show master > output &&
+	test 3 = $(wc -l < output) &&
+	! grep dragon < output
+'
+
 test_done
-- 
1.5.3.4.1223.ga973c
