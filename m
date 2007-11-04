From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/5] pretty describe: add min_prio parameter to describe_commit()
Date: Sun, 04 Nov 2007 15:08:55 +0100
Message-ID: <472DD277.2070406@lsrfire.ath.cx>
References: <472DB1B0.1050904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IogAJ-0003Eu-Uy
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbXKDOJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbXKDOJN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:09:13 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:46972
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498AbXKDOJN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 09:09:13 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id 4FFF1873BA;
	Sun,  4 Nov 2007 15:09:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <472DB1B0.1050904@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63406>

If load_commit_names() is called with a certain priority and later with
a higher priority, all the old, low-priority names are still kept and
describe_commit() will happily take them into account.  It can thus
report heads, even if the user asked for annotated tags.

In the current code, this can't happen, because builtin-describe.c calls
load_commit_names() only once, and commit.c always asks for the highest
priority (annotated tags).  This patch fixes the problem anyway, for the
benefit of future users.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 builtin-describe.c |    6 ++++--
 cache.h            |    2 +-
 commit.c           |    2 +-
 describe.c         |    7 ++++---
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index fcd93f4..481d92f 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -14,6 +14,7 @@ static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
+static int min_prio;
 
 static void describe(const char *arg, int last_one)
 {
@@ -28,7 +29,7 @@ static void describe(const char *arg, int last_one)
 	if (!cmit)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
-	name = describe_commit(cmit, max_candidates, debug, &depth);
+	name = describe_commit(cmit, max_candidates, min_prio, debug, &depth);
 	if (!name)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 
@@ -74,7 +75,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
-	load_commit_names(all ? 0 : (tags ? 1 : 2));
+	min_prio = all ? 0 : (tags ? 1 : 2);
+	load_commit_names(min_prio);
 
 	if (argc == 0) {
 		describe("HEAD", 1);
diff --git a/cache.h b/cache.h
index 84423a3..703d6a9 100644
--- a/cache.h
+++ b/cache.h
@@ -605,6 +605,6 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 /* describe.c */
 struct commit;
 extern void load_commit_names(int min_prio);
-extern char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *depthp);
+extern char *describe_commit(struct commit *cmit, int max_candidates, int min_prio, int debug, int *depthp);
 
 #endif /* CACHE_H */
diff --git a/commit.c b/commit.c
index 9ff4735..624005b 100644
--- a/commit.c
+++ b/commit.c
@@ -897,7 +897,7 @@ void format_commit_message(struct commit *commit,
 		const char *abbr;
 
 		load_commit_names(2);
-		name = describe_commit(commit, 10, 0, &depth);
+		name = describe_commit(commit, 10, 2, 0, &depth);
 		clear_commit_name_flags(commit);
 		abbr = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 
diff --git a/describe.c b/describe.c
index 18c7abc..b6de4c1 100644
--- a/describe.c
+++ b/describe.c
@@ -102,7 +102,8 @@ static unsigned long finish_depth_computation(
 	return seen_commits;
 }
 
-char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *depthp)
+char *describe_commit(struct commit *cmit, int max_candidates, int min_prio,
+                      int debug, int *depthp)
 {
 	struct commit *gave_up_on = NULL;
 	struct commit_list *list;
@@ -110,7 +111,7 @@ char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *d
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
 
-	if (cmit->name) {
+	if (cmit->name && cmit->name_prio >= min_prio) {
 		*depthp = 0;
 		return cmit->name;
 	}
@@ -130,7 +131,7 @@ char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *d
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
 		seen_commits++;
-		if (c->name) {
+		if (c->name && c->name_prio >= min_prio) {
 			if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
 				t->name = c->name;
