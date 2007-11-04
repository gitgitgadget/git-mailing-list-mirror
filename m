From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] pretty describe: factor out describe_commit() from describe()
Date: Sun, 04 Nov 2007 12:48:31 +0100
Message-ID: <472DB18F.9000302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodyN-000187-Ff
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbXKDLsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbXKDLsr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:48:47 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43767
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754159AbXKDLsq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:48:46 -0500
Received: from [10.0.1.201] (p57B7FCFB.dip.t-dialin.net [87.183.252.251])
	by neapel230.server4you.de (Postfix) with ESMTP id 990BD873BA;
	Sun,  4 Nov 2007 12:48:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63388>

Factor out a new function, describe_commit(), out of describe().  All
arguments are passed as parameters, not globals.  Also move the clamping
of max_candidates from cmd_describe() into the new function, which makes
it ready to be used in a library.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-describe.c |   64 +++++++++++++++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 82c25c3..e68a3d0 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -116,28 +116,26 @@ static unsigned long finish_depth_computation(
 	return seen_commits;
 }
 
-static void describe(const char *arg, int last_one)
+char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *depthp)
 {
-	unsigned char sha1[20];
-	struct commit *cmit, *gave_up_on = NULL;
+	struct commit *gave_up_on = NULL;
 	struct commit_list *list;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
 
-	if (get_sha1(arg, sha1))
-		die("Not a valid object name %s", arg);
-	cmit = lookup_commit_reference(sha1);
-	if (!cmit)
-		die("%s is not a valid '%s' object", arg, commit_type);
-
 	if (cmit->name) {
-		printf("%s\n", all ? cmit->name : cmit->name + 5);
-		return;
+		*depthp = 0;
+		return cmit->name;
 	}
 
 	if (debug)
-		fprintf(stderr, "searching to describe %s\n", arg);
+		fprintf(stderr, "searching...\n");
+
+	if (max_candidates < 1)
+		max_candidates = 1;
+	else if (max_candidates > MAX_TAGS)
+		max_candidates = MAX_TAGS;
 
 	list = NULL;
 	cmit->name_flags = SEEN;
@@ -149,7 +147,7 @@ static void describe(const char *arg, int last_one)
 		if (c->name) {
 			if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
-				t->name = all ? c->name : c->name + 5;
+				t->name = c->name;
 				t->prio = c->name_prio;
 				t->depth = seen_commits - 1;
 				t->flag_within = 1u << match_cnt;
@@ -184,8 +182,11 @@ static void describe(const char *arg, int last_one)
 		}
 	}
 
-	if (!match_cnt)
-		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+	if (!match_cnt) {
+		free_commit_list(list);
+		*depthp = -1;
+		return NULL;
+	}
 
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
 
@@ -211,11 +212,32 @@ static void describe(const char *arg, int last_one)
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
 	}
-	if (abbrev == 0)
-		printf("%s\n", all_matches[0].name);
+
+	*depthp = all_matches[0].depth;
+	return all_matches[0].name;
+}
+
+static void describe(const char *arg, int last_one)
+{
+	unsigned char sha1[20];
+	struct commit *cmit;
+	char *name;
+	int depth = 0;
+
+	if (get_sha1(arg, sha1))
+		die("Not a valid object name %s", arg);
+	cmit = lookup_commit_reference(sha1);
+	if (!cmit)
+		die("%s is not a valid '%s' object", arg, commit_type);
+
+	name = describe_commit(cmit, max_candidates, debug, &depth);
+	if (!name)
+		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+
+	if (abbrev == 0 || depth == 0)
+		printf("%s\n", all ? name : name + 5);
 	else
-		printf("%s-%d-g%s\n", all_matches[0].name,
-		       all_matches[0].depth,
+		printf("%s-%d-g%s\n", all ? name : name + 5, depth,
 		       find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
@@ -237,10 +259,6 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, options, describe_usage, 0);
-	if (max_candidates < 1)
-		max_candidates = 1;
-	else if (max_candidates > MAX_TAGS)
-		max_candidates = MAX_TAGS;
 
 	save_commit_buffer = 0;
 
-- 
1.5.3.5.529.ge3d6d
