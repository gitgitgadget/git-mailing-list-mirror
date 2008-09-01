From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-revert: use merge_recursive_generic()
Date: Mon,  1 Sep 2008 03:09:01 +0200
Message-ID: <1220231341-1748-1-git-send-email-vmiklos@frugalware.org>
References: <20080901010612.GC16514@genesis.frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 03:09:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZxvC-0005kL-M5
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 03:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbYIABI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 21:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYIABI3
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 21:08:29 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:60715 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYIABI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 21:08:29 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id E05961DDC5B;
	Mon,  1 Sep 2008 03:08:26 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id F221A84CA; Mon,  1 Sep 2008 03:09:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <20080901010612.GC16514@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94519>

We had a separate function to run merge-recursive in a separate process,
but this is not really necessary, since we have
merge_recursive_generic() to do the same, without wasting resources.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Sep 01, 2008 at 03:06:12AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> I'm sending both patches: the one that works properly using
> merge_recursive_generic() - and which one passes the testsuite here

Here it is.

 builtin-revert.c |   55 ++++++++++++++++++-----------------------------------
 1 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 3667705..8d4ebcf 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -12,6 +12,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "rerere.h"
+#include "merge-recursive.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -201,36 +202,6 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static int merge_recursive(const char *base_sha1,
-		const char *head_sha1, const char *head_name,
-		const char *next_sha1, const char *next_name)
-{
-	char buffer[256];
-	const char *argv[6];
-	int i = 0;
-
-	sprintf(buffer, "GITHEAD_%s", head_sha1);
-	setenv(buffer, head_name, 1);
-	sprintf(buffer, "GITHEAD_%s", next_sha1);
-	setenv(buffer, next_name, 1);
-
-	/*
-	 * This three way merge is an interesting one.  We are at
-	 * $head, and would want to apply the change between $commit
-	 * and $prev on top of us (when reverting), or the change between
-	 * $prev and $commit on top of us (when cherry-picking or replaying).
-	 */
-	argv[i++] = "merge-recursive";
-	if (base_sha1)
-		argv[i++] = base_sha1;
-	argv[i++] = "--";
-	argv[i++] = head_sha1;
-	argv[i++] = next_sha1;
-	argv[i++] = NULL;
-
-	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
-}
-
 static char *help_msg(const unsigned char *sha1)
 {
 	static char helpbuf[1024];
@@ -266,12 +237,16 @@ static int index_is_dirty(void)
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
+	unsigned const char *ca = NULL;
 	struct commit *base, *next, *parent;
-	int i;
+	int i, fail;
 	char *oneline, *reencoded_message = NULL;
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
+	struct merge_options o;
+	struct commit *result;
 
+	init_merge_options(&o);
 	git_config(git_default_config, NULL);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
@@ -374,11 +349,19 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	if (merge_recursive(base == NULL ?
-				NULL : sha1_to_hex(base->object.sha1),
-				sha1_to_hex(head), "HEAD",
-				sha1_to_hex(next->object.sha1), oneline) ||
-			write_cache_as_tree(head, 0, NULL)) {
+	if (base)
+		ca = base->object.sha1;
+	o.branch1 = "HEAD";
+	o.branch2 = oneline;
+	fail = merge_recursive_generic(&o,
+				head,
+				next->object.sha1,
+				ca ? 1 : 0,
+				&ca,
+				&result);
+	if (fail < 0)
+		exit(1);
+	if (fail || write_cache_as_tree(head, 0, NULL)) {
 		add_to_msg("\nConflicts:\n\n");
 		read_cache();
 		for (i = 0; i < active_nr;) {
-- 
1.6.0
