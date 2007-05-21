From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Cross-reference the manpages for git-name-rev and git-describe
Date: Mon, 21 May 2007 03:20:25 -0400
Message-ID: <20070521072025.GO3141@spearce.org>
References: <20070519120933.GW17511@curie-int.orbis-terrarum.net> <20070519121154.GA10268@coredump.intra.peff.net> <pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr> <A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com> <vpq8xbkoir8.fsf@bauges.imag.fr> <839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com> <7vfy5sy91f.fsf@assigned-by-dhcp.cox.net> <vpq7ir3658t.fsf_-_@bauges.imag.fr> <7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 09:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2CF-0006X6-46
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXEUHUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbXEUHUh
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:20:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58129 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXEUHUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:20:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq2Bu-0007WP-9s; Mon, 21 May 2007 03:20:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F32E20FBAE; Mon, 21 May 2007 03:20:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47980>

Junio C Hamano <junkio@cox.net> wrote:
> wouldn't this be useful?
> 
> $ git-describe --contains --tags 1b600e659
> v1.5.0-rc3~34

Like this?  ;-)

-->8--
Teach git-describe how to run name-rev

Often users want to know not which tagged version a commit came
after, but which tagged version a commit is contained within.
This latter task is the job of git-name-rev, but most users are
looking to git-describe to do the job.

Junio suggested we make `git describe --contains` run the correct
tool, `git name-rev`, and that's exactly what we do here.  The output
of name-rev was adjusted slightly through the new --name-only option,
allowing describe to execv into name-rev and maintain its current
output format.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-describe.txt |    7 ++++++-
 Documentation/git-name-rev.txt |    7 +++++++
 builtin-describe.c             |   15 +++++++++++++++
 builtin-name-rev.c             |   23 +++++++++++++++++------
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 47a583d..dc47b65 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -8,7 +8,7 @@ git-describe - Show the most recent tag that is reachable from a commit
 
 SYNOPSIS
 --------
-'git-describe' [--all] [--tags] [--abbrev=<n>] <committish>...
+'git-describe' [--all] [--tags] [--contains] [--abbrev=<n>] <committish>...
 
 DESCRIPTION
 -----------
@@ -31,6 +31,11 @@ OPTIONS
 	Instead of using only the annotated tags, use any tag
 	found in `.git/refs/tags`.
 
+--contains::
+	Instead of finding the tag that predates the commit, find
+	the tag that comes after the commit, and thus contains it.
+	Automatically implies --tags.
+
 --abbrev=<n>::
 	Instead of using the default 8 hexadecimal digits as the
 	abbreviated object name, use <n> digits.
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index d6c8bf8..9a1645d 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -34,6 +34,13 @@ OPTIONS
 	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
 	commits, and pass to stdout
 
+--name-only::
+	Instead of printing both the SHA-1 and the name, print only
+	the name.  If given with --tags the usual tag prefix of
+	"tags/" is also ommitted from the name, matching the output
+	of gitlink::git-describe[1] more closely.  This option
+	cannot be combined with --stdin.
+
 EXAMPLE
 -------
 
diff --git a/builtin-describe.c b/builtin-describe.c
index 165917e..efbd43f 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -3,6 +3,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "builtin.h"
+#include "exec_cmd.h"
 
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -242,12 +243,15 @@ static void describe(const char *arg, int last_one)
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	int contains = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (*arg != '-')
 			break;
+		else if (!strcmp(arg, "--contains"))
+			contains = 1;
 		else if (!strcmp(arg, "--debug"))
 			debug = 1;
 		else if (!strcmp(arg, "--all"))
@@ -272,6 +276,17 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 
+	if (contains) {
+		const char **nr = xmalloc((4 + argc - i) * sizeof(char*));
+		nr[0] = "name-rev";
+		nr[1] = "--name-only";
+		nr[2] = "--tags";
+		memcpy(nr + 3, argv + i, (argc - i) * sizeof(char*));
+		nr[3 + argc - i] = NULL;
+		execv_git_cmd(nr);
+		die("unable to start %s", nr[0]);
+	}
+
 	if (argc <= i)
 		describe("HEAD", 1);
 	else
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index ef16385..a639e2f 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -83,6 +83,7 @@ copy_data:
 
 struct name_ref_data {
 	int tags_only;
+	int name_only;
 	const char *ref_filter;
 };
 
@@ -110,6 +111,10 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 
 		if (!prefixcmp(path, "refs/heads/"))
 			path = path + 11;
+		else if (data->tags_only
+		    && data->name_only
+		    && !prefixcmp(path, "refs/tags/"))
+			path = path + 10;
 		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
@@ -149,7 +154,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = { 0, 0, NULL };
 	int as_is = 0, all = 0, transform_stdin = 0;
-	struct name_ref_data data = { 0, NULL };
+	struct name_ref_data data = { 0, 0, NULL };
 
 	git_config(git_default_config);
 
@@ -165,6 +170,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			if (!strcmp(*argv, "--")) {
 				as_is = 1;
 				continue;
+			} else if (!strcmp(*argv, "--name-only")) {
+				data.name_only = 1;
+				continue;
 			} else if (!strcmp(*argv, "--tags")) {
 				data.tags_only = 1;
 				continue;
@@ -263,14 +271,17 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			struct object * obj = get_indexed_object(i);
 			if (!obj)
 				continue;
-			printf("%s %s\n", sha1_to_hex(obj->sha1), get_rev_name(obj));
+			if (!data.name_only)
+				printf("%s ", sha1_to_hex(obj->sha1));
+			printf("%s\n", get_rev_name(obj));
 		}
 	} else {
 		int i;
-		for (i = 0; i < revs.nr; i++)
-			printf("%s %s\n",
-				revs.objects[i].name,
-				get_rev_name(revs.objects[i].item));
+		for (i = 0; i < revs.nr; i++) {
+			if (!data.name_only)
+				printf("%s ", revs.objects[i].name);
+			printf("%s\n", get_rev_name(revs.objects[i].item));
+		}
 	}
 
 	return 0;
-- 
1.5.2.14.g45bde-dirty

-- 
Shawn.
