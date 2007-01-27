From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 27 Jan 2007 13:39:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070127040618.GA14205@fieldses.org>
 <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
 <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org>
 <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 13:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAmq2-0003gS-7N
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 13:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXA0MjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 07:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXA0MjK
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 07:39:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:59960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751421AbXA0MjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 07:39:09 -0500
Received: (qmail invoked by alias); 27 Jan 2007 12:39:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 27 Jan 2007 13:39:07 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37949>


Instead of (or, in addition to) --tags, to use only tags for naming,
you can now use --ref-filter=<regex> to specify which refs are
used for naming.

Example:

	$ git name-rev --ref-filter='/v1' 33db5f4d
	33db5f4d tags/v1.0rc1^0~1593

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Fri, 26 Jan 2007, Junio C Hamano wrote:

	> Yeah, I found name-rev to be mostly useless since it almost
	> always names relative to my unannotated "anchor" tag that I use
	> to keep track of 'master' I sent the last "What's in" message
	> for.

	How about this?

	Though I think you'd use --ref-filter='tags/v[0-9]'. Or you would 
	alias it:

		git-repo-config alias.findver \
			"name-rev --ref-filter='tags/v[0-9]'"

 Documentation/git-name-rev.txt |   14 ++++++++++++--
 builtin-name-rev.c             |   27 +++++++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 37fbf66..7de4bea 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -8,7 +8,7 @@ git-name-rev - Find symbolic names for given revs
 
 SYNOPSIS
 --------
-'git-name-rev' [--tags] ( --all | --stdin | <committish>... )
+'git-name-rev' [--tags | --ref-filter=<regex>] ( --all | --stdin | <committish>... )
 
 DESCRIPTION
 -----------
@@ -22,6 +22,9 @@ OPTIONS
 --tags::
 	Do not use branch names, but only tags to name the commits
 
+--ref-filter=<regex>::
+	Only use refs for naming which match the regexp
+
 --all::
 	List all commits reachable from all refs
 
@@ -29,7 +32,7 @@ OPTIONS
 	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
 	commits, and pass to stdout
 
-EXAMPLE
+EXAMPLES
 -------
 
 Given a commit, find out where it is relative to the local refs. Say somebody
@@ -52,6 +55,13 @@ Another nice thing you can do is:
 % git log | git name-rev --stdin
 ------------
 
+If you want to name a revision only by a subset of the refs you have, use
+a regular expression to specify the subset:
+
+------------
+$ git name-rev --ref-filter='/v1' 33db5f4d
+33db5f4d tags/v1.0rc1^0~1593
+------------
 
 Author
 ------
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index b4f15cc..89ea95d 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -3,9 +3,10 @@
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
+#include <regex.h>
 
 static const char name_rev_usage[] =
-	"git-name-rev [--tags] ( --all | --stdin | committish [committish...] )\n";
+	"git-name-rev [--tags | --ref-filter=<regexp>] ( --all | --stdin | committish [committish...] )\n";
 
 typedef struct rev_name {
 	const char *tip_name;
@@ -74,13 +75,21 @@ copy_data:
 	}
 }
 
+struct name_ref_data {
+	int tags_only;
+	regex_t *ref_filter;
+};
+
 static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
-	int tags_only = *(int*)cb_data;
+	struct name_ref_data *data = cb_data;
 	int deref = 0;
 
-	if (tags_only && strncmp(path, "refs/tags/", 10))
+	if (data->tags_only && strncmp(path, "refs/tags/", 10))
+		return 0;
+
+	if (data->ref_filter && regexec(data->ref_filter, path, 0, NULL, 0))
 		return 0;
 
 	while (o && o->type == OBJ_TAG) {
@@ -129,7 +138,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = { 0, 0, NULL };
 	int as_is = 0, all = 0, transform_stdin = 0;
-	int tags_only = 0;
+	struct name_ref_data data = { 0, NULL };
 
 	git_config(git_default_config);
 
@@ -146,7 +155,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				as_is = 1;
 				continue;
 			} else if (!strcmp(*argv, "--tags")) {
-				tags_only = 1;
+				data.tags_only = 1;
+				continue;
+			} else  if (!strncmp(*argv, "--ref-filter=", 13)) {
+				data.ref_filter = xmalloc(sizeof(regex_t));
+				if (regcomp(data.ref_filter, *argv + 13,
+							REG_EXTENDED))
+					die ("invalid regexp: %s", *argv + 13);
 				continue;
 			} else if (!strcmp(*argv, "--all")) {
 				if (argc > 1)
@@ -185,7 +200,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		add_object_array((struct object *)commit, *argv, &revs);
 	}
 
-	for_each_ref(name_ref, &tags_only);
+	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
 		char buffer[2048];
-- 
1.5.0.rc2.g324a-dirty
