From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] name-rev: introduce the --ref-filter=<pattern> option
Date: Sat, 17 Feb 2007 19:22:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702171921130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070127040618.GA14205@fieldses.org>
 <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
 <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org>
 <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUCm-0002LI-QD
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbXBQSWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbXBQSWh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:22:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:46634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965381AbXBQSWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:22:37 -0500
Received: (qmail invoked by alias); 17 Feb 2007 18:22:35 -0000
X-Provags-ID: V01U2FsdGVkX1/Jhlx1BpXJvsgvHiJikacoCdUuD2eS/yPnzYWpbd
	NEyQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkiwvfy5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40003>


Instead of (or, in addition to) --tags, to use only tags for naming,
you can now use --ref-filter=<patter> to specify a shell pattern
which the refs must match to be used for naming.

Example:

	$ git name-rev --ref-filter=*v1* 33db5f4d
	33db5f4d tags/v1.0rc1^0~1593

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Sat, 17 Feb 2007, Junio C Hamano wrote:

	> When we talk about path and path-like things including refs
	> I think we consistently use fnmatch not regexp.  At least I
	> think we try to.

	And this patch does exactly that.

 Documentation/git-name-rev.txt |    6 +++++-
 builtin-name-rev.c             |   23 +++++++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 37fbf66..a99d60b 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -8,7 +8,8 @@ git-name-rev - Find symbolic names for given revs
 
 SYNOPSIS
 --------
-'git-name-rev' [--tags] ( --all | --stdin | <committish>... )
+'git-name-rev' [--tags] [--ref-filter=<pattern>]
+	       ( --all | --stdin | <committish>... )
 
 DESCRIPTION
 -----------
@@ -22,6 +23,9 @@ OPTIONS
 --tags::
 	Do not use branch names, but only tags to name the commits
 
+--ref-filter=<pattern>::
+	Only use refs whose names match a given shell pattern.
+
 --all::
 	List all commits reachable from all refs
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index b4f15cc..615af4b 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 
 static const char name_rev_usage[] =
-	"git-name-rev [--tags] ( --all | --stdin | committish [committish...] )\n";
+	"git-name-rev [--tags | --ref-filter=<pattern>] ( --all | --stdin | committish [committish...] )\n";
 
 typedef struct rev_name {
 	const char *tip_name;
@@ -74,13 +74,21 @@ copy_data:
 	}
 }
 
+struct name_ref_data {
+	int tags_only;
+	const char *ref_filter;
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
+	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
 		return 0;
 
 	while (o && o->type == OBJ_TAG) {
@@ -129,7 +137,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = { 0, 0, NULL };
 	int as_is = 0, all = 0, transform_stdin = 0;
-	int tags_only = 0;
+	struct name_ref_data data = { 0, NULL };
 
 	git_config(git_default_config);
 
@@ -146,7 +154,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				as_is = 1;
 				continue;
 			} else if (!strcmp(*argv, "--tags")) {
-				tags_only = 1;
+				data.tags_only = 1;
+				continue;
+			} else  if (!strncmp(*argv, "--ref-filter=", 13)) {
+				data.ref_filter = *argv + 13;
 				continue;
 			} else if (!strcmp(*argv, "--all")) {
 				if (argc > 1)
@@ -185,7 +196,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		add_object_array((struct object *)commit, *argv, &revs);
 	}
 
-	for_each_ref(name_ref, &tags_only);
+	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
 		char buffer[2048];
-- 
1.5.0.2139.gdafc9-dirty
