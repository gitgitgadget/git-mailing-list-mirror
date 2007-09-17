From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] git-gc --auto: run "repack -A -d -l" as necessary.
Date: Mon, 17 Sep 2007 01:27:13 -0700
Message-ID: <11900176363269-git-send-email-gitster@pobox.com>
References: <1190017633436-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:43:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD8Y-0006vM-N6
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbXIQJm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbXIQJm6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:42:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbXIQJm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:42:57 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082716.TEZ9301.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 17 Sep 2007 04:27:16 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTG1X00G1gtr5g0000000; Mon, 17 Sep 2007 04:27:16 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <1190017633436-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58414>

This teaches "git-gc --auto" to consolidate many packs into one
without losing unreachable objects in them by using "repack -A"
when there are too many packfiles that are not marked with *.keep
in the repository.  gc.autopacklimit configuration can be used
to set the maximum number of packs a repository is allowed to
have before this mechanism kicks in.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    9 +++++-
 Documentation/git-gc.txt |    7 +++++-
 builtin-gc.c             |   57 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3643c0b..f5136c3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -443,8 +443,13 @@ gc.auto::
 	When there are approximately more than this many loose
 	objects in the repository, `git gc --auto` that is
 	invoked by some Porcelain commands will create a new
-	pack and prune them.  Setting this to 0 disables the
-	auto garbage collection.
+	pack and prune them.  Setting this to 0 disables this.
+
+gc.autopacklimit::
+	When there are more than this many packs that are not
+	marked with `*.keep` file in the repository, `git gc
+	--auto` consolidates them into one larger pack.  Setting
+	this to 0 disables this.
 
 gc.packrefs::
 	`git gc` does not run `git pack-refs` in a bare repository by
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 40c1ce4..b9d5660 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -47,10 +47,15 @@ OPTIONS
 	With this option, `git gc` checks if there are too many
 	loose objects in the repository and runs
 	gitlink:git-repack[1] with `-d -l` option to pack them.
-	The threshold is set with `gc.auto` configuration
+	The threshold for loose objects is set with `gc.auto` configuration
 	variable, and can be disabled by setting it to 0.  Some
 	Porcelain commands use this after they perform operation
 	that could create many loose objects automatically.
+	Additionally, when there are too many packs are present,
+	they are consolidated into one larger pack by running
+	the `git-repack` command with `-A` option.  The
+	threshold for number of packs is set with
+	`gc.autopacklimit` configuration variable.
 
 Configuration
 -------------
diff --git a/builtin-gc.c b/builtin-gc.c
index 34ce35b..a82f6be 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -21,6 +21,7 @@ static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
 static int pack_refs = 1;
 static int aggressive_window = -1;
 static int gc_auto_threshold = 6700;
+static int gc_auto_pack_limit = 20;
 
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
@@ -46,6 +47,10 @@ static int gc_config(const char *var, const char *value)
 		gc_auto_threshold = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.autopacklimit")) {
+		gc_auto_pack_limit = git_config_int(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -78,6 +83,9 @@ static int too_many_loose_objects(void)
 	int num_loose = 0;
 	int needed = 0;
 
+	if (gc_auto_threshold <= 0)
+		return 0;
+
 	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
 		warning("insanely long object directory %.*s", 50, objdir);
 		return 0;
@@ -100,21 +108,58 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
+static int too_many_packs(void)
+{
+	struct packed_git *p;
+	int cnt;
+
+	if (gc_auto_pack_limit <= 0)
+		return 0;
+
+	for (cnt = 0, p = packed_git; p; p = p->next) {
+		char *suffix;
+		int keep;
+		if (!p->pack_local)
+			continue;
+		suffix = p->pack_name + strlen(p->pack_name) - 5;
+		if (memcmp(suffix, ".pack", 6))
+			continue;
+		memcpy(suffix, ".keep", 6);
+		keep = access(p->pack_name, F_OK) && (errno == ENOENT);
+		memcpy(suffix, ".pack", 6);
+		if (keep)
+			continue;
+		/*
+		 * Perhaps check the size of the pack and count only
+		 * very small ones here?
+		 */
+		cnt++;
+	}
+	return gc_auto_pack_limit <= cnt;
+}
+
 static int need_to_gc(void)
 {
 	int ac = 0;
 
 	/*
-	 * Setting gc.auto to 0 or negative can disable the
-	 * automatic gc
+	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
+	 * disable the automatic gc.
 	 */
-	if (gc_auto_threshold <= 0)
-		return 0;
-
-	if (!too_many_loose_objects())
+	if (gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0)
 		return 0;
 
+	/*
+	 * If there are too many loose objects, but not too many
+	 * packs, we run "repack -d -l".  If there are too many packs,
+	 * we run "repack -A -d -l".  Otherwise we tell the caller
+	 * there is no need.
+	 */
 	argv_repack[ac++] = "repack";
+	if (too_many_packs())
+		argv_repack[ac++] = "-A";
+	if (!too_many_loose_objects() && ac == 1)
+		return 0;
 	argv_repack[ac++] = "-d";
 	argv_repack[ac++] = "-l";
 	argv_repack[ac++] = NULL;
-- 
1.5.3.1.967.g6bb01
