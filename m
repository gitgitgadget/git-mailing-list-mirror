From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC 3/3] git rerere unresolve file...
Date: Sat, 21 Nov 2009 20:02:47 +0100
Message-ID: <200911212002.47757.j6t@kdbg.org>
References: <200911211958.40872.j6t@kdbg.org> <200911212000.19326.j6t@kdbg.org> <200911212001.06207.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 21:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsJ-00041R-W0
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbZKUTCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 14:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbZKUTCx
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 14:02:53 -0500
Received: from [93.83.142.38] ([93.83.142.38]:62863 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756048AbZKUTCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 14:02:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CDB2F19F6A4;
	Sat, 21 Nov 2009 20:02:47 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <200911212001.06207.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133411>

There was no way to remove a recorded resolution short of removing the
entire .git/rr-cache. This gets in the way when an incorrect resolution
was recorded.

This implements the subcommand 'git rerere unresolve' that selectively
removes the recorded resolution of the specified files. It also reverts
the resolution so that the files again have conflict markers. However,
these unresolved conflict markers not necessarily reflect "ours" and
"theirs" correctly because the preimage that was stored in the cache has
the conflicted sides in a canonical order.

In handle_file(), the checks for the beginning and end of a conflict
region have to be loosened slightly -- there can be any whitespace,
including a LF, not just a blank -- because after the conflict regions are
restored, there are no trailing blanks and a subsequent 'git rerere' would
not recognize them anymore.

'git checkout --conflict=merge path...' can restore the conflicted file
as well, but it does not remove the recorded resolution.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Documentation/git-rerere.txt |   10 +++++-
 builtin-rerere.c             |    9 +++--
 rerere.c                     |   74 ++++++++++++++++++++++++++++++++++++++----
 rerere.h                     |    2 +
 4 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 7dd515b..c9bf3f1 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,7 +7,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 
 SYNOPSIS
 --------
-'git rerere' ['clear'|'diff'|'status'|'gc']
+'git rerere' ['clear'|'diff'|'status'|'unresolve file...'|'gc']
 
 DESCRIPTION
 -----------
@@ -52,6 +52,14 @@ conflicts.  Additional arguments are passed directly to the system
 Like 'diff', but this only prints the filenames that will be tracked
 for resolutions.
 
+'unresolve'::
+
+Removes the resolution that was recorded for the specified files.
+The conflict sections are restored as well, although the direction of
+the "ours" and "theirs" sections may be inverted.
+You can use 'git checkout --conflict=merge file' to restore the
+original conflict markers in the correct direction.
+
 'gc'::
 
 This prunes records of conflicted merges that
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 275827d..5d3a3a5 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -7,7 +7,7 @@
 #include "xdiff-interface.h"
 
 static const char git_rerere_usage[] =
-"git rerere [clear | status | diff | gc]";
+"git rerere [clear | status | diff | unresolve file... | gc]";
 
 /* these values are days */
 static int cutoff_noresolve = 15;
@@ -102,7 +102,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
 	struct string_list merge_rr_done = { NULL, 0, 0, 1 };
-	int i, fd;
+	int i, fd, ret = 0;
 
 	if (argc < 2)
 		return rerere();
@@ -129,10 +129,13 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			const char *name = (const char *)merge_rr.items[i].util;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
+	else if (!strcmp(argv[1], "unresolve"))
+		ret = unresolve_rerere(&merge_rr, &merge_rr_done,
+				       get_pathspec(prefix, &argv[2]), fd);
 	else
 		usage(git_rerere_usage);
 
 	string_list_clear(&merge_rr, 1);
 	string_list_clear(&merge_rr_done, 1);
-	return 0;
+	return ret;
 }
diff --git a/rerere.c b/rerere.c
index 11fef88..b31008d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -140,7 +140,7 @@ static int handle_file(const char *path,
 		git_SHA1_Init(&ctx);
 
 	while (fgets(buf, sizeof(buf), f)) {
-		if (!prefixcmp(buf, "<<<<<<< ")) {
+		if (!prefixcmp(buf, "<<<<<<<") && isspace(buf[7])) {
 			if (hunk != RR_CONTEXT)
 				goto bad;
 			hunk = RR_SIDE_1;
@@ -152,7 +152,7 @@ static int handle_file(const char *path,
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				goto bad;
 			hunk = RR_SIDE_2;
-		} else if (!prefixcmp(buf, ">>>>>>> ")) {
+		} else if (!prefixcmp(buf, ">>>>>>>") && isspace(buf[7])) {
 			if (hunk != RR_SIDE_2)
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
@@ -248,23 +248,29 @@ static int record_preimage(struct string_list *rr, const char *path, int 
force)
 	return 0;
 }
 
-static int merge(const char *name, const char *path)
+#define RESOLVE 0
+#define UNRESOLVE 1
+#define UNRESOLVE_CHECK 2
+
+static int merge(const char *name, const char *path, int mode)
 {
 	int ret;
 	mmfile_t cur, base, other;
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
+	const char *basename = mode == RESOLVE ? "preimage" : "postimage";
+	const char *othername = mode == RESOLVE ? "postimage" : "preimage";
 
 	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
 		return 1;
 
 	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
-			read_mmfile(&base, rerere_path(name, "preimage")) ||
-			read_mmfile(&other, rerere_path(name, "postimage")))
+			read_mmfile(&base, rerere_path(name, basename)) ||
+			read_mmfile(&other, rerere_path(name, othername)))
 		return 1;
 	ret = xdl_merge(&base, &cur, "", &other, "",
 			&xpp, XDL_MERGE_ZEALOUS, &result);
-	if (!ret) {
+	if (!ret && mode != UNRESOLVE_CHECK) {
 		FILE *f = fopen(path, "w");
 		if (!f)
 			return error("Could not open %s: %s", path,
@@ -347,7 +353,7 @@ static int do_plain_rerere(struct string_list *rr,
 		const char *name = (const char *)rr->items[i].util;
 
 		if (has_rerere_resolution(name)) {
-			if (!merge(name, path)) {
+			if (!merge(name, path, RESOLVE)) {
 				if (rerere_autoupdate)
 					string_list_insert(path, &update);
 				fprintf(stderr,
@@ -433,3 +439,57 @@ int rerere(void)
 		return 0;
 	return do_plain_rerere(&merge_rr, &merge_rr_done, fd);
 }
+
+static int unresolve_check(struct string_list *rr_done, const char *path)
+{
+	struct string_list_item *item = string_list_lookup(path, rr_done);
+
+	if (!item) {
+		warning("not resolved using a previous resolution: %s", path);
+		return 0;
+	}
+	if (!has_rerere_resolution(item->util))
+		return error("no resolution found for %s", path);
+	if (merge(item->util, path, UNRESOLVE_CHECK))
+		return error("cannot revert resolution of %s", path);
+	return 0;
+}
+
+int unresolve_rerere_1(struct string_list *rr, struct string_list *rr_done,
+		       const char *path)
+{
+	struct string_list_item *item = string_list_lookup(path, rr_done);
+
+	if (!item)
+		return 0;
+	if (merge(item->util, path, UNRESOLVE))
+		return -1;
+
+	if (record_preimage(rr, path, 1))
+		return error("no conflict markers found: %s", path);
+
+	item->util = NULL;
+	unlink_or_warn(rerere_path(item->util, "postimage"));
+	return 0;
+}
+
+int unresolve_rerere(struct string_list *rr, struct string_list *rr_done,
+		     const char **pathspec, int fd)
+{
+	int i, ret = 0;
+
+	if (!pathspec)
+		return error("unresolve what?");
+
+	for (i = 0; pathspec[i]; i++) {
+		ret |= unresolve_check(rr_done, pathspec[i]);
+	}
+	if (ret)
+		return ret;
+
+	for (i = 0; !ret && pathspec[i]; i++) {
+		ret = unresolve_rerere_1(rr, rr_done, pathspec[i]);
+	}
+	ret |= write_rr(rr, rr_done, fd);
+	return ret;
+}
diff --git a/rerere.h b/rerere.h
index 9bb2f13..a0fa50f 100644
--- a/rerere.h
+++ b/rerere.h
@@ -7,5 +7,7 @@ extern int setup_rerere(struct string_list *, struct string_list *);
 extern int rerere(void);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
+extern int unresolve_rerere(struct string_list *, struct string_list *,
+	const char **, int);
 
 #endif
-- 
1.6.5.2.182.ge039a
