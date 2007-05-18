From: skimo@liacs.nl
Subject: [PATCH 12/16] builtin-fetch--tool: extend "native-store" for use in cloning
Date: Fri, 18 May 2007 21:25:01 +0200
Message-ID: <11795163072266-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp854-0002MY-Ks
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563AbXERTZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758069AbXERTZb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:31 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55759 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757563AbXERTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:23 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPDZu005206;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 777797DDAB; Fri, 18 May 2007 21:25:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47640>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 builtin-fetch--tool.c |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index ed4d5de..3441a4a 100644
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
@@ -294,8 +321,12 @@ static int fetch_native_store(FILE *fp,
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
1.5.2.rc3.783.gc7476-dirty
