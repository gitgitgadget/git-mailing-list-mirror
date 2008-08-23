From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-apply - Add --include=PATH
Date: Sat, 23 Aug 2008 13:37:49 -0700
Message-ID: <1219523869.18365.106.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 22:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzst-00045K-DY
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 22:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbYHWUhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYHWUhv
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 16:37:51 -0400
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:3998 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYHWUhu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 16:37:50 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id NAA21416
	for <git@vger.kernel.org>; Sat, 23 Aug 2008 13:28:10 -0700
X-Mailer: Evolution 2.12.3-1.3mdv2008.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93488>

Add similar capability to --exclude=

Allows selection of files to patch from a
large patchset.

Signed-off-by: Joe Perches <joe@perches.com>

 Documentation/git-apply.txt |    8 +++++++-
 builtin-apply.c             |   27 +++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index feb51f1..2467e62 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
-	  [--exclude=PATH] [--directory=<root>] [--verbose] [<patch>...]
+	  [--exclude=PATH] [--include=PATH] [--directory=<root>]
+	  [--verbose] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -137,6 +138,11 @@ discouraged.
 	be useful when importing patchsets, where you want to exclude certain
 	files or directories.
 
+--include=<path-pattern>::
+	Apply changes to files matching the given path pattern. This can
+	be useful when importing patchsets, where you want to include certain
+	files or directories.
+
 --whitespace=<action>::
 	When applying a patch, detect a new or modified line that has
 	whitespace errors.  What are considered whitespace errors is
diff --git a/builtin-apply.c b/builtin-apply.c
index 2216a0b..121a6d0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -46,7 +46,7 @@ static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
-"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|fix|error|error-all>] <patch>...";
+"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|fix|error|error-all>] [--exclude=PATH] [--include=PATH] <patch>...";
 
 static enum ws_error_action {
 	nowarn_ws_error,
@@ -2996,10 +2996,16 @@ static struct excludes {
 	const char *path;
 } *excludes;
 
+static struct includes {
+	struct includes *next;
+	const char *path;
+} *includes;
+
 static int use_patch(struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
 	struct excludes *x = excludes;
+	struct includes *y = includes;
 	while (x) {
 		if (fnmatch(x->path, pathname, 0) == 0)
 			return 0;
@@ -3011,7 +3017,17 @@ static int use_patch(struct patch *p)
 		    memcmp(prefix, pathname, prefix_length))
 			return 0;
 	}
-	return 1;
+
+	if (!y || !y->path)
+		return 1;
+
+	while (y && y->path) {
+		if (fnmatch(y->path, pathname, 0) == 0)
+			return 1;
+		y = y->next;
+	}
+
+	return 0;
 }
 
 static void prefix_one(char **name)
@@ -3160,6 +3176,13 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			excludes = x;
 			continue;
 		}
+		if (!prefixcmp(arg, "--include=")) {
+			struct includes *y = xmalloc(sizeof(*y));
+			y->path = arg + 10;
+			y->next = includes;
+			includes = y;
+			continue;
+		}
 		if (!prefixcmp(arg, "-p")) {
 			p_value = atoi(arg + 2);
 			p_value_known = 1;
