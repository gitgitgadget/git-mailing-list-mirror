From: Aviv Eyal <avivey@gmail.com>
Subject: [PATCH] Support specific color for a specific remote branches
Date: Mon,  8 Aug 2011 18:49:13 +0300
Message-ID: <1312818553-25042-1-git-send-email-avivey@gmail.com>
Cc: Aviv Eyal <avivey@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 17:50:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqS5d-0001dj-G4
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 17:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab1HHPuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 11:50:00 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43866 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1HHPt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 11:49:59 -0400
Received: by iye16 with SMTP id 16so9237725iye.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uhtMtS0StiQOrElb/v/c+TZtiea+j/HCtZmZvTXSPm0=;
        b=qWbeSCKdIH9TbIM2RsvG4D/gePReVkbmPCFgQX5Q6XM2BiPJ1icgmrUbY5UefF0xR/
         5W54kVHxnDrIJV1LQBsA5XkERATacS6YMh92afbdsdKwkdUZvuIl4KMOQhFibZVHK81O
         oKBxF9RCcLjEBESndeUt4Sibn/LnENCDkMZpI=
Received: by 10.231.23.73 with SMTP id q9mr5639401ibb.84.1312818598281;
        Mon, 08 Aug 2011 08:49:58 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-108-245-56.cablep.bezeqint.net [84.108.245.56])
        by mx.google.com with ESMTPS id fr11sm4310444ibb.63.2011.08.08.08.49.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 08:49:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.411.g8a900
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178960>

Program 'show branch -a' supports different colors for 'local' and 'remote' branches.
When tracking more then one remote, all branches have the same color.
This change lets the user define a color for each remote, providing better visual distinction for different remotes.

Signed-off-by: Aviv Eyal <avivey@gmail.com>
---

Since my C days are now ancient history, I'm worried I might leak some char*s down there. Also, 
I might have missed some apis that would have made this patch smaller.

I'm using a sorted list as a dictionary (Remote name -> Color), which is not too elegant but
probably 'good enough', considering I expect it to be a very small (<3) list.

Aviv.

 Documentation/config.txt |    6 ++
 builtin/branch.c         |  119 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 102 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0658ffb..efdb61f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -700,6 +700,7 @@ color.branch.<slot>::
 	`current` (the current branch), `local` (a local branch),
 	`remote` (a remote-tracking branch in refs/remotes/), `plain` (other
 	refs).
+	See also `remote.<name>.color`.
 +
 The value for these configuration variables is a list of colors (at most
 two) and attributes (at most one), separated by spaces.  The colors
@@ -1658,6 +1659,11 @@ remote.<name>.mirror::
 	If true, pushing to this remote will automatically behave
 	as if the `\--mirror` option was given on the command line.
 
+remote.<name>.color:
+	If set, the `branch` command will use the colors specified here
+	for the names of all branches tracking this remote. Colors
+	specified here take precedent over `color.branch.remote` config.
+
 remote.<name>.skipDefaultUpdate::
 	If true, this remote will be skipped by default when updating
 	using linkgit:git-fetch[1] or the `update` subcommand of
diff --git a/builtin/branch.c b/builtin/branch.c
index 3142daa..85e6920 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -15,6 +15,7 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "string-list.h"
 
 static const char * const builtin_branch_usage[] = {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -46,6 +47,9 @@ enum color_branch {
 	BRANCH_COLOR_CURRENT = 4
 };
 
+// this string_list is used as a basic dictionary.
+struct string_list custom_colors = STRING_LIST_INIT_DUP;
+
 static enum merge_filter {
 	NO_FILTER = 0,
 	SHOW_NOT_MERGED,
@@ -68,6 +72,52 @@ static int parse_branch_color_slot(const char *var, int ofs)
 	return -1;
 }
 
+static char *strclone(const char *start, int len)
+{
+	char *result = malloc((len + 1) * sizeof(char));
+	if (!result)
+		return NULL;
+	strncpy(result, start, len);
+	result[len] = '\0';
+	return result;
+}
+
+static int git_branch_config_custom_color_remote(const char *var, const char *value)
+{
+	struct string_list_item *item;
+	char *name, *color;
+	name = strclone(var + 7, strlen(var) - 13); // "remote."=7, "remote..color"=13.
+	if (!name)
+		return 0;
+	color =  malloc(COLOR_MAXLEN * sizeof(char));
+	if (!color) {
+		free(name);
+		return 0;
+	}
+	item = string_list_insert(&custom_colors, name);
+	color_parse(value, var, color);
+	item->util = color;
+	return 0;
+}
+
+static char *git_branch_get_custom_color_remote(const char *name)
+{
+	int name_len;
+	char* repo_name;
+	struct string_list_item *custom;
+	name_len = strchr(name, '/') - name;
+	repo_name = strclone(name, name_len);
+	if (!repo_name)
+		return NULL;
+
+	custom = string_list_lookup(&custom_colors, repo_name);
+	free(repo_name);
+	if (custom)
+		return (char*) custom->util;
+	return NULL;
+}
+
+
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.branch")) {
@@ -83,14 +133,10 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	return git_color_default_config(var, value, cb);
-}
+	if (!prefixcmp(var, "remote.") && !suffixcmp(var, ".color"))
+		return git_branch_config_custom_color_remote(var, value);
 
-static const char *branch_get_color(enum color_branch ix)
-{
-	if (branch_use_color > 0)
-		return branch_colors[ix];
-	return "";
+	return git_color_default_config(var, value, cb);
 }
 
 static int branch_merged(int kind, const char *name,
@@ -354,6 +400,43 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
+static const char *branch_get_color(struct ref_item *item, int current)
+{
+	int index;
+	char *color;
+
+	if (branch_use_color <= 0)
+		return "";
+
+	if (!item)
+		index = BRANCH_COLOR_RESET;
+	else if (current)
+		index = BRANCH_COLOR_CURRENT;
+	else switch (item->kind) {
+		case REF_LOCAL_BRANCH:
+			index = BRANCH_COLOR_LOCAL;
+			break;
+		case REF_REMOTE_BRANCH:
+			index = BRANCH_COLOR_REMOTE;
+			color = git_branch_get_custom_color_remote(item->name);
+			if (color)
+				return color;
+			break;
+		default:
+			index = BRANCH_COLOR_PLAIN;
+			break;
+	}
+
+	return branch_colors[index];
+}
+
+static const char *branch_get_color_reset()
+{
+	if (branch_use_color <= 0)
+		return "";
+	return branch_colors[BRANCH_COLOR_RESET];
+}
+
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		int show_upstream_ref)
 {
@@ -424,18 +507,6 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	if (!matches_merge_filter(commit))
 		return;
 
-	switch (item->kind) {
-	case REF_LOCAL_BRANCH:
-		color = BRANCH_COLOR_LOCAL;
-		break;
-	case REF_REMOTE_BRANCH:
-		color = BRANCH_COLOR_REMOTE;
-		break;
-	default:
-		color = BRANCH_COLOR_PLAIN;
-		break;
-	}
-
 	c = ' ';
 	if (current) {
 		c = '*';
@@ -444,12 +515,12 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	strbuf_addf(&name, "%s%s", prefix, item->name);
 	if (verbose)
-		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
+		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(item, current),
 			    maxwidth, name.buf,
-			    branch_get_color(BRANCH_COLOR_RESET));
+			    branch_get_color_reset());
 	else
-		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
-			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(item, current),
+			    name.buf, branch_get_color_reset());
 
 	if (item->dest)
 		strbuf_addf(&out, " -> %s", item->dest);
@@ -712,5 +783,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
+	string_list_clear(&custom_colors, 1);
+
 	return 0;
 }
-- 
1.7.4.1
