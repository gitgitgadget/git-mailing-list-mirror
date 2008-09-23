From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/2] git remote: move part of prune() into prune_one()
Date: Tue, 23 Sep 2008 23:13:24 +0200
Message-ID: <1222204405-30454-2-git-send-email-hjemli@gmail.com>
References: <1222204405-30454-1-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 23:14:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFDT-0005sI-7c
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYIWVNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYIWVNa
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:13:30 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:40814 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbYIWVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:13:29 -0400
Received: from localhost.localdomain (ti0025a380-3500.bb.online.no [83.108.111.180])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id m8NLDPbN011664
	for <git@vger.kernel.org>; Tue, 23 Sep 2008 23:13:26 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.2.309.gc1f46
In-Reply-To: <1222204405-30454-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96597>

The new function will be reused by prune_all() in the next patch.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-remote.c |   67 +++++++++++++++++++++++++++++------------------------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 4cb763f..626256e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -537,6 +537,41 @@ static int show(int argc, const char **argv)
 	return result;
 }

+static int prune_one(const char *name, int dry_run)
+{
+	struct ref_states states;
+	int result = 0;
+	int i;
+
+	memset(&states, 0, sizeof(states));
+	get_remote_ref_states(name, &states, 1);
+
+	if (states.stale.nr) {
+		printf("Pruning %s\n", name);
+		printf("URL: %s\n",
+		       states.remote->url_nr
+		       ? states.remote->url[0]
+		       : "(no URL)");
+	}
+
+	for (i = 0; i < states.stale.nr; i++) {
+		const char *refname = states.stale.items[i].util;
+
+		if (!dry_run)
+			result |= delete_ref(refname, NULL);
+
+		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
+		       abbrev_ref(refname, "refs/remotes/"));
+	}
+
+	/* NEEDSWORK: free remote */
+	string_list_clear(&states.new, 0);
+	string_list_clear(&states.stale, 0);
+	string_list_clear(&states.tracked, 0);
+
+	return result;
+}
+
 static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
@@ -545,42 +580,14 @@ static int prune(int argc, const char **argv)
 		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
-	struct ref_states states;

 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);

 	if (argc < 1)
 		usage_with_options(builtin_remote_usage, options);

-	memset(&states, 0, sizeof(states));
-	for (; argc; argc--, argv++) {
-		int i;
-
-		get_remote_ref_states(*argv, &states, 1);
-
-		if (states.stale.nr) {
-			printf("Pruning %s\n", *argv);
-			printf("URL: %s\n",
-			       states.remote->url_nr
-			       ? states.remote->url[0]
-			       : "(no URL)");
-		}
-
-		for (i = 0; i < states.stale.nr; i++) {
-			const char *refname = states.stale.items[i].util;
-
-			if (!dry_run)
-				result |= delete_ref(refname, NULL);
-
-			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
-			       abbrev_ref(refname, "refs/remotes/"));
-		}
-
-		/* NEEDSWORK: free remote */
-		string_list_clear(&states.new, 0);
-		string_list_clear(&states.stale, 0);
-		string_list_clear(&states.tracked, 0);
-	}
+	for (; argc; argc--, argv++)
+		result |= prune_one(*argv, dry_run);

 	return result;
 }
--
1.6.0.2.309.gc1f46
