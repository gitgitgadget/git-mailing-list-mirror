From: skimo@liacs.nl
Subject: [PATCH 1/3] builtin-fetch--tool: extend "native-store" for use in cloning
Date: Sun, 20 May 2007 19:57:43 +0200
Message-ID: <11796838661131-git-send-email-skimo@liacs.nl>
References: <1179683865547-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 19:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppfW-000640-Gu
	for gcvg-git@gmane.org; Sun, 20 May 2007 19:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbXETR5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbXETR5z
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 13:57:55 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37074 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756823AbXETR5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 13:57:54 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KHvkI2007623;
	Sun, 20 May 2007 19:57:51 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 37CC27DDA0; Sun, 20 May 2007 19:57:46 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <1179683865547-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47857>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 builtin-fetch--tool.c |   52 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index ed4d5de..b3ed3da 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -207,6 +207,32 @@ static void remove_keep_on_signal(int signo)
 	raise(signo);
 }
 
+static char *construct_local_name(const char *remote_ref, const char *remote_nick,
+				  int use_separate_remote)
+{
+	static char local_ref[PATH_MAX];
+	int len = strlen(remote_ref);
+
+	if (len >= 3 && !memcmp(remote_ref+len-3, "^{}", 3))
+		return NULL;
+	if (!strcmp(remote_ref, "HEAD"))
+		return "REMOTE_HEAD";
+	if (!prefixcmp(remote_ref, "refs/heads/")) {
+		if (snprintf(local_ref, sizeof(local_ref), "refs/%s%s/%s",
+			    use_separate_remote ? "remotes/" : "heads",
+			    use_separate_remote ? remote_nick : "",
+			    remote_ref+11) > sizeof(local_ref))
+			die("Local branchname too long");
+	} else if (!prefixcmp(remote_ref, "refs/tags/")) {
+		if (snprintf(local_ref, sizeof(local_ref), "refs/tags/%s",
+			    remote_ref+10) > sizeof(local_ref))
+			die("Local branchname too long");
+	} else
+		return NULL;
+
+	return local_ref;
+}
+
 static char *find_local_name(const char *remote_name, const char *refs,
 			     int *force_p, int *not_for_merge_p)
 {
@@ -261,7 +287,8 @@ static int fetch_native_store(FILE *fp,
 			      const char *remote,
 			      const char *remote_nick,
 			      const char *refs,
-			      int verbose, int force)
+			      int verbose, int force,
+			      int all, int use_separate_remote)
 {
 	char buffer[1024];
 	int err = 0;
@@ -273,7 +300,7 @@ static int fetch_native_store(FILE *fp,
 		int len;
 		char *cp;
 		char *local_name;
-		int single_force, not_for_merge;
+		int single_force = force, not_for_merge = 0;
 
 		for (cp = buffer; *cp && !isspace(*cp); cp++)
 			;
@@ -294,14 +321,18 @@ static int fetch_native_store(FILE *fp,
 			continue;
 		}
 
-		local_name = find_local_name(cp, refs,
-					     &single_force, &not_for_merge);
+		if (all)
+			local_name = construct_local_name(cp, remote_nick,
+							  use_separate_remote);
+		else
+			local_name = find_local_name(cp, refs,
+						     &single_force, &not_for_merge);
 		if (!local_name)
 			continue;
 		err |= append_fetch_head(fp,
 					 buffer, remote, cp, remote_nick,
 					 local_name, not_for_merge,
-					 verbose, force || single_force);
+					 verbose, single_force);
 	}
 	return err;
 }
@@ -514,6 +545,8 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 	int verbose = 0;
 	int force = 0;
 	int sopt = 0;
+	int all = 0;
+	int use_separate_remote = 1;
 
 	while (1 < argc) {
 		const char *arg = argv[1];
@@ -523,6 +556,12 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 			force = 1;
 		else if (!strcmp("-s", arg))
 			sopt = 1;
+		else if (!strcmp("--all", arg))
+			all = 1;
+		else if (!strcmp("--use-separate-remote", arg))
+			use_separate_remote = 1;
+		else if (!strcmp("--no-separate-remote", arg))
+			use_separate_remote = 0;
 		else
 			break;
 		argc--;
@@ -554,7 +593,8 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 			return error("fetch-native-store takes 3 args");
 		fp = fopen(git_path("FETCH_HEAD"), "a");
 		result = fetch_native_store(fp, argv[2], argv[3], argv[4],
-					    verbose, force);
+					    verbose, force, all,
+					    use_separate_remote);
 		fclose(fp);
 		return result;
 	}
-- 
1.5.1.5.g8fc2
