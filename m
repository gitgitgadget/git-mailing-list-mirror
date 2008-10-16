From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refactor handling of "other" files in ls-files and
	status
Date: Thu, 16 Oct 2008 11:07:26 -0400
Message-ID: <20081016150726.GB31859@sigill.intra.peff.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net> <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl> <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net> <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org> <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net> <48F7280C.3080205@viscovery.net> <8199b7ae4c441c4311045141ddaaa36f.squirrel@webmail.highteq.net> <20081016141812.GA30026@sigill.intra.peff.net> <20081016145916.GA31859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 17:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUSw-0007yE-Rt
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 17:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYJPPHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYJPPHa
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 11:07:30 -0400
Received: from peff.net ([208.65.91.99]:4192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbYJPPH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 11:07:29 -0400
Received: (qmail 7925 invoked by uid 111); 16 Oct 2008 15:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 16 Oct 2008 11:07:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 11:07:26 -0400
Content-Disposition: inline
In-Reply-To: <20081016145916.GA31859@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98390>

On Thu, Oct 16, 2008 at 10:59:16AM -0400, Jeff King wrote:

> This patch pulls the ls-files code into a new function,
> cache_name_is_other, and uses it in both places. This should
> leave the ls-files functionality the same and fix the bug
> in status.

BTW, this is probably maint-worthy, but I prepared it on 'master'.
Unfortunately, there is a purely textual conflict when applying to
maint. For your convenience, here's a rebase to maint:

-- >8 --
refactor handling of "other" files in ls-files and status

When the "git status" display code was originally converted
to C, we copied the code from ls-files to discover whether a
pathname returned by read_directory was an "other", or
untracked, file.

Much later, 5698454e updated the code in ls-files to handle
some new cases caused by gitlinks.  This left the code in
wt-status.c broken: it would display submodule directories
as untracked directories. Nobody noticed until now, however,
because unless status.showUntrackedFiles was set to "all",
submodule directories were not actually reported by
read_directory. So the bug was only triggered in the
presence of a submodule _and_ this config option.

This patch pulls the ls-files code into a new function,
cache_name_is_other, and uses it in both places. This should
leave the ls-files functionality the same and fix the bug
in status.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-ls-files.c |   33 ++-------------------------------
 cache.h            |    2 ++
 read-cache.c       |   28 ++++++++++++++++++++++++++++
 t/t7502-status.sh  |    6 ++++++
 wt-status.c        |   15 ++-------------
 5 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 068f424..b48327d 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -91,39 +91,10 @@ static void show_other_files(struct dir_struct *dir)
 {
 	int i;
 
-
-	/*
-	 * Skip matching and unmerged entries for the paths,
-	 * since we want just "others".
-	 *
-	 * (Matching entries are normally pruned during
-	 * the directory tree walk, but will show up for
-	 * gitlinks because we don't necessarily have
-	 * dir->show_other_directories set to suppress
-	 * them).
-	 */
 	for (i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
-		int len, pos;
-		struct cache_entry *ce;
-
-		/*
-		 * Remove the '/' at the end that directory
-		 * walking adds for directory entries.
-		 */
-		len = ent->len;
-		if (len && ent->name[len-1] == '/')
-			len--;
-		pos = cache_name_pos(ent->name, len);
-		if (0 <= pos)
-			continue;	/* exact match */
-		pos = -pos - 1;
-		if (pos < active_nr) {
-			ce = active_cache[pos];
-			if (ce_namelen(ce) == len &&
-			    !memcmp(ce->name, ent->name, len))
-				continue; /* Yup, this one exists unmerged */
-		}
+		if (!cache_name_is_other(ent->name, ent->len))
+			continue;
 		show_dir_entry(tag_other, ent);
 	}
 }
diff --git a/cache.h b/cache.h
index 884fae8..76730ce 100644
--- a/cache.h
+++ b/cache.h
@@ -270,6 +270,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
+#define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #endif
 
 enum object_type {
@@ -382,6 +383,7 @@ extern int add_to_index(struct index_state *, const char *path, struct stat *, i
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
+extern int index_name_is_other(const struct index_state *, const char *, int);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index 8f96fd1..4e067e4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1480,3 +1480,31 @@ int read_index_unmerged(struct index_state *istate)
 	istate->cache_nr = dst - istate->cache;
 	return !!last;
 }
+
+/*
+ * Returns 1 if the path is an "other" path with respect to
+ * the index; that is, the path is not mentioned in the index at all,
+ * either as a file, a directory with some files in the index,
+ * or as an unmerged entry.
+ *
+ * We helpfully remove a trailing "/" from directories so that
+ * the output of read_directory can be used as-is.
+ */
+int index_name_is_other(const struct index_state *istate, const char *name,
+		int namelen)
+{
+	int pos;
+	if (namelen && name[namelen - 1] == '/')
+		namelen--;
+	pos = index_name_pos(istate, name, namelen);
+	if (0 <= pos)
+		return 0;	/* exact match */
+	pos = -pos - 1;
+	if (pos < istate->cache_nr) {
+		struct cache_entry *ce = istate->cache[pos];
+		if (ce_namelen(ce) == namelen &&
+		    !memcmp(ce->name, name, namelen))
+			return 0; /* Yup, this one exists unmerged */
+	}
+	return 1;
+}
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index c8e4c2e..187a13e 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -285,6 +285,12 @@ test_expect_success 'status submodule summary is disabled by default' '
 	test_cmp expect output
 '
 
+# we expect the same as the previous test
+test_expect_success 'status --untracked-files=all does not show submodule' '
+	git status --untracked-files=all >output &&
+	test_cmp expect output
+'
+
 head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 
 cat >expect <<EOF
diff --git a/wt-status.c b/wt-status.c
index 889e50f..64cedfc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -275,20 +275,9 @@ static void wt_status_print_untracked(struct wt_status *s)
 
 	read_directory(&dir, ".", "", 0, NULL);
 	for(i = 0; i < dir.nr; i++) {
-		/* check for matching entry, which is unmerged; lifted from
-		 * builtin-ls-files:show_other_files */
 		struct dir_entry *ent = dir.entries[i];
-		int pos = cache_name_pos(ent->name, ent->len);
-		struct cache_entry *ce;
-		if (0 <= pos)
-			die("bug in wt_status_print_untracked");
-		pos = -pos - 1;
-		if (pos < active_nr) {
-			ce = active_cache[pos];
-			if (ce_namelen(ce) == ent->len &&
-			    !memcmp(ce->name, ent->name, ent->len))
-				continue;
-		}
+		if (!cache_name_is_other(ent->name, ent->len))
+			continue;
 		if (!shown_header) {
 			s->workdir_untracked = 1;
 			wt_status_print_header(s, "Untracked files",
-- 
1.6.0.2.710.gc3f34.dirty
