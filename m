From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Remove more gcc extension usage.
Date: Sat, 8 Jul 2006 14:34:02 -0400
Message-ID: <20060708183402.GA17644@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 20:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzHdQ-0002tu-Lu
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWGHSeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 14:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWGHSeU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 14:34:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26526 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964958AbWGHSeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 14:34:19 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FzHcy-0001pL-HK; Sat, 08 Jul 2006 14:34:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6B72220E482; Sat,  8 Jul 2006 14:34:02 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23494>

Removing these last remaining extension uses allows GIT to compile
with the Sun C compiler rather then gcc.  This can be handy when
you are trying to compile GIT on a Solaris system that seems to
have a total lack of GNU utilities.
---
 builtin-read-tree.c |   18 ++++++++----------
 checkout-index.c    |   10 ++--------
 diff.c              |   12 ++++++------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9a2099d..33b2faf 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -43,10 +43,7 @@ struct tree_entry_list {
 	const unsigned char *sha1;
 };
 
-static struct tree_entry_list df_conflict_list = {
-	.name = NULL,
-	.next = &df_conflict_list
-};
+static struct tree_entry_list df_conflict_list;
 
 typedef int (*merge_fn_t)(struct cache_entry **src);
 
@@ -333,14 +330,9 @@ static void setup_progress_signal(void)
 	setitimer(ITIMER_REAL, &v, NULL);
 }
 
+static struct checkout state;
 static void check_updates(struct cache_entry **src, int nr)
 {
-	static struct checkout state = {
-		.base_dir = "",
-		.force = 1,
-		.quiet = 1,
-		.refresh_cache = 1,
-	};
 	unsigned short mask = htons(CE_UPDATE);
 	unsigned last_percent = 200, cnt = 0, total = 0;
 
@@ -884,6 +876,12 @@ int cmd_read_tree(int argc, const char *
 	unsigned char sha1[20];
 	merge_fn_t fn = NULL;
 
+	df_conflict_list.next = &df_conflict_list;
+	state.base_dir = "";
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/checkout-index.c b/checkout-index.c
index ea40bc2..88c21cb 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -49,14 +49,7 @@ static int checkout_stage; /* default to
 static int to_tempfile;
 static char topath[4][MAXPATHLEN+1];
 
-static struct checkout state = {
-	.base_dir = "",
-	.base_dir_len = 0,
-	.force = 0,
-	.quiet = 0,
-	.not_new = 0,
-	.refresh_cache = 0,
-};
+static struct checkout state;
 
 static void write_tempfile_record (const char *name)
 {
@@ -177,6 +170,7 @@ int main(int argc, char **argv)
 	int all = 0;
 	int read_from_stdin = 0;
 
+	state.base_dir = "";
 	prefix = setup_git_directory();
 	git_config(git_default_config);
 	prefix_length = prefix ? strlen(prefix) : 0;
diff --git a/diff.c b/diff.c
index f0450a8..4b389b1 100644
--- a/diff.c
+++ b/diff.c
@@ -43,12 +43,12 @@ #define COLOR_CYAN    "\033[36m"
 #define COLOR_WHITE   "\033[37m"
 
 static const char *diff_colors[] = {
-	[DIFF_RESET]    = COLOR_RESET,
-	[DIFF_PLAIN]    = COLOR_NORMAL,
-	[DIFF_METAINFO] = COLOR_BOLD,
-	[DIFF_FRAGINFO] = COLOR_CYAN,
-	[DIFF_FILE_OLD] = COLOR_RED,
-	[DIFF_FILE_NEW] = COLOR_GREEN,
+	COLOR_RESET,
+	COLOR_NORMAL,
+	COLOR_BOLD,
+	COLOR_CYAN,
+	COLOR_RED,
+	COLOR_GREEN
 };
 
 static int parse_diff_color_slot(const char *var, int ofs)
-- 
1.4.1.gbcf1
