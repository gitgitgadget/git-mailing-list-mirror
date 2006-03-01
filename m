From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Teach git-checkout-index to use file suffixes.
Date: Tue, 28 Feb 2006 23:41:32 -0500
Message-ID: <20060301044132.GF22894@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 05:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEJ9k-0001wu-ES
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 05:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCAElj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 23:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCAElj
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 23:41:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59555 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932092AbWCAEli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 23:41:38 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEJ9X-0006aF-7l
	for git@vger.kernel.org; Tue, 28 Feb 2006 23:41:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C2FC20FBBF; Tue, 28 Feb 2006 23:41:32 -0500 (EST)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16962>

Sometimes it is useful to unpack the unmerged stage entries
to the same directory as the tracked file itself, but with
a suffix indicating which stage that version came from.
In many user interface level scripts this is being done
by git-unpack-file followed by creating the necessary
directory structure and then moving the file into the
directory with the requested name.  It is now possible to
perform the same action for a larger set of files directly
through git-checkout-index.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 I think this completes the two features I've found missing from
 git-checkout-index:  --stdin and --suffix.  These two options
 should make writing a working directory based merge strategy
 a little easier.

 FYI: I built this on top of my immediately prior patch ('Teach
 git-checkout-index to read filenames from stdin.') so this one
 may not apply cleanly without that patch being applied first.

 Documentation/git-checkout-index.txt |   29 ++++++++++++++++++++++++++++-
 apply.c                              |    2 ++
 cache.h                              |    2 ++
 checkout-index.c                     |   14 ++++++++++++--
 entry.c                              |   10 +++++++---
 read-tree.c                          |    1 +
 6 files changed, 52 insertions(+), 6 deletions(-)

base df23c1119d0af1fbac6b8afd296113e155d9a878
last e1674dc0b01de5c34fada13f7cf5fcbb3be82d09
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index b0b6588..f0be2a0 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -9,7 +9,8 @@ git-checkout-index - Copy files from the
 SYNOPSIS
 --------
 [verse]
-'git-checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
+'git-checkout-index' [-u] [-q] [-a] [-f] [-n]
+		   [--prefix=<string>] [--suffix=<string>]
 		   [--stage=<number>]
 		   [-z] [--stdin]
 		   [--] [<file>]\*
@@ -43,6 +44,10 @@ OPTIONS
 	When creating files, prepend <string> (usually a directory
 	including a trailing /)
 
+--suffix=<string>::
+	When creating files, append <string> to the name.  The value
+	of <string> must not contain a directory separator (/).
+
 --stage=<number>::
 	Instead of checking out unmerged entries, copy out the
 	files from named stage.  <number> must be between 1 and 3.
@@ -120,6 +125,28 @@ $ git-checkout-index --prefix=.merged- M
 This will check out the currently cached copy of `Makefile`
 into the file `.merged-Makefile`.
 
+Export files with a suffix::
++
+----------------
+$ git-checkout-index --suffix=\#2 --stage=2 Makefile
+----------------
++
+If `Makefile` is unmerged and has a stage 2 entry in the index
+this will check out that version into the file `Makefile#2`.
+
+A suffix may be preferred over a prefix when checking out all
+unmerged entries:
++
+----------------
+$ git-checkout-index --suffix=\#1 --stage=1 --all
+$ git-checkout-index --suffix=\#2 --stage=2 --all
+$ git-checkout-index --suffix=\#3 --stage=3 --all
+----------------
++
+would unpack all unmerged stages into the same directory as the
+tracked file.  (Compare with --prefix=.stage1/ which would have
+created a partial directory tree within `.stage1/`.)
+
 
 Author
 ------
diff --git a/apply.c b/apply.c
index 244718c..1ec8473 100644
--- a/apply.c
+++ b/apply.c
@@ -1307,6 +1307,8 @@ static int check_patch(struct patch *pat
 				/* checkout */
 				costate.base_dir = "";
 				costate.base_dir_len = 0;
+				costate.name_suffix = "";
+				costate.name_suffix_len = 0;
 				costate.force = 0;
 				costate.quiet = 0;
 				costate.not_new = 0;
diff --git a/cache.h b/cache.h
index 58eec00..055e213 100644
--- a/cache.h
+++ b/cache.h
@@ -254,6 +254,8 @@ extern const char *git_committer_info(in
 struct checkout {
 	const char *base_dir;
 	int base_dir_len;
+	const char *name_suffix;
+	int name_suffix_len;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
diff --git a/checkout-index.c b/checkout-index.c
index f54c606..af7b230 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -47,6 +47,8 @@ static int checkout_stage; /* default to
 static struct checkout state = {
 	.base_dir = "",
 	.base_dir_len = 0,
+	.name_suffix = "",
+	.name_suffix_len = 0,
 	.force = 0,
 	.quiet = 0,
 	.not_new = 0,
@@ -180,6 +182,14 @@ int main(int argc, char **argv)
 			state.base_dir_len = strlen(state.base_dir);
 			continue;
 		}
+		if (!strncmp(arg, "--suffix=", 9)) {
+			if (strchr(arg+9, '/')) {
+				die("--suffix cannot contain /");
+			}
+			state.name_suffix = arg+9;
+			state.name_suffix_len = strlen(state.name_suffix);
+			continue;
+		}
 		if (!strncmp(arg, "--stage=", 8)) {
 			int ch = arg[8];
 			if ('1' <= ch && ch <= '3')
@@ -193,8 +203,8 @@ int main(int argc, char **argv)
 		break;
 	}
 
-	if (state.base_dir_len) {
-		/* when --prefix is specified we do not
+	if (state.base_dir_len || state.name_suffix_len) {
+		/* when --prefix or --suffix is specified we do not
 		 * want to update cache.
 		 */
 		if (state.refresh_cache) {
diff --git a/entry.c b/entry.c
index 8fb99bc..dc35a07 100644
--- a/entry.c
+++ b/entry.c
@@ -117,10 +117,14 @@ int checkout_entry(struct cache_entry *c
 {
 	struct stat st;
 	static char path[MAXPATHLEN+1];
-	int len = state->base_dir_len;
+	int len1 = state->base_dir_len;
+	int len2 = strlen(ce->name);
+	int len3 = state->name_suffix_len;
+	char *path_len1 = path + len1;
 
-	memcpy(path, state->base_dir, len);
-	strcpy(path + len, ce->name);
+	memcpy(path, state->base_dir, len1);
+	memcpy(path_len1, ce->name, len2 + 1);
+	memcpy(path_len1 + len2, state->name_suffix, len3 + 1);
 
 	if (!lstat(path, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, 1);
diff --git a/read-tree.c b/read-tree.c
index f39fe5c..f223a0d 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -281,6 +281,7 @@ static void check_updates(struct cache_e
 {
 	static struct checkout state = {
 		.base_dir = "",
+		.name_suffix = "",
 		.force = 1,
 		.quiet = 1,
 		.refresh_cache = 1,
-- 
1.2.3.gdf23c-dirty
