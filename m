From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Make 'remote show' distinguish between merged and rebased remote branches
Date: Tue, 10 Feb 2009 12:08:58 -0500
Message-ID: <20090210202046.8EBEC3360AC@rincewind>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 21:22:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWz7c-0002OH-QQ
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZBJUUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbZBJUUy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:20:54 -0500
Received: from smtp242.iad.emailsrvr.com ([207.97.245.242]:57641 "EHLO
	smtp242.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbZBJUUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:20:53 -0500
Received: from relay14.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay14.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 21DF12368E5
	for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:20:50 -0500 (EST)
Received: by relay14.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9B5E22368F2
	for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:20:49 -0500 (EST)
Received: by rincewind (Postfix, from userid 1000)
	id 8EBEC3360AC; Tue, 10 Feb 2009 15:20:46 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109301>

Prints "rebased" instead of "merged" if branch.<name>.rebase is true.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I'd like to be able to tell if my "git pull" is going to merge or rebase...

 builtin-remote.c  |   13 ++++++++++---
 t/t5505-remote.sh |    5 +++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index abc8dd8..ac3a88e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -145,6 +145,7 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote;
 	struct string_list merge;
+	int rebase;
 };
 
 static struct string_list branch_list;
@@ -164,7 +165,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
-		enum { REMOTE, MERGE } type;
+		enum { REMOTE, MERGE, REBASE } type;
 
 		key += 7;
 		if (!postfixcmp(key, ".remote")) {
@@ -173,6 +174,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else if (!postfixcmp(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
+		} else if (!postfixcmp(key, ".rebase")) {
+			name = xstrndup(key, strlen(key) - 7);
+			type = REBASE;
 		} else
 			return 0;
 
@@ -185,7 +189,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			if (info->remote)
 				warning("more than one branch.%s", key);
 			info->remote = xstrdup(value);
-		} else {
+		} else if (type == MERGE) {
 			char *space = strchr(value, ' ');
 			value = abbrev_branch(value);
 			while (space) {
@@ -196,6 +200,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(xstrdup(value), &info->merge);
+		} else {
+			info->rebase = 1;
 		}
 	}
 	return 0;
@@ -678,9 +684,10 @@ static int show(int argc, const char **argv)
 
 			if (!info->merge.nr || strcmp(*argv, info->remote))
 				continue;
-			printf("  Remote branch%s merged with 'git pull' "
+			printf("  Remote branch%s %s with 'git pull' "
 				"while on branch %s\n   ",
 				info->merge.nr > 1 ? "es" : "",
+				info->rebase ? "rebased" : "merged",
 				branch->string);
 			for (j = 0; j < info->merge.nr; j++)
 				printf(" %s", info->merge.items[j].string);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1f59960..be0316a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -112,6 +112,8 @@ cat > test/expect << EOF
   URL: $(pwd)/one
   Remote branch merged with 'git pull' while on branch master
     master
+  Remote branch rebased with 'git pull' while on branch rebaser
+    side
   New remote branch (next fetch will store in remotes/origin)
     master
   Tracked remote branches
@@ -136,7 +138,10 @@ test_expect_success 'show' '
 		refs/heads/master:refs/heads/upstream &&
 	 git config --add remote.origin.push \
 		+refs/tags/lastbackup &&
+	 git branch --track rebaser origin/side &&
+	 git config --add branch.rebaser.rebase true &&
 	 git remote show origin > output &&
+	 git branch -D rebaser &&
 	 test_cmp expect output)
 '
 
-- 
1.6.1.2.390.gba743
