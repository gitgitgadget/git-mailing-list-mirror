From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH v6] git-apply: apply submodule changes
Date: Wed, 15 Aug 2007 19:22:09 +0200
Message-ID: <20070815172209.GD1070MdfPADPa@greensroom.kotnet.org>
References: <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
 <7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
 <20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
 <7vr6m8imj6.fsf@assigned-by-dhcp.cox.net> <20070813093740.GA4684@liacs.nl>
 <20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
 <7vmywvfag3.fsf@assigned-by-dhcp.cox.net>
 <7vd4xqeilh.fsf@assigned-by-dhcp.cox.net>
 <20070814083940.GN999MdfPADPa@greensroom.kotnet.org>
 <7vps1qcwj4.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:22:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMZW-00075n-SM
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 19:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762743AbXHORWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 13:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762173AbXHORWO
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 13:22:14 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:60312 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760748AbXHORWL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 13:22:11 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMT001T9S8X43@psmtp08.wxs.nl> for git@vger.kernel.org; Wed,
 15 Aug 2007 19:22:10 +0200 (MEST)
Received: (qmail 27462 invoked by uid 500); Wed, 15 Aug 2007 17:22:09 +0000
In-reply-to: <7vps1qcwj4.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55927>

Apply "Subproject commit HEX" changes produced by git-diff.
As usual in the current git, only the superproject itself is actually
modified (possibly creating empty directories for new submodules).
Any checked-out submodule is left untouched and is not required to
be up-to-date.

With clean-ups from Junio C Hamano.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
On Tue, Aug 14, 2007 at 02:09:35AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> >> diff --git a/builtin-apply.c b/builtin-apply.c
> >
> > Did you remove the documentation on purpose ?
> 
> No, I just wanted to get a feedback on a (possibly partial)
> cleanup, as I couldn't make heads or tails of your patch
> especially around that TYPE_CHANGED part, and also the part to
> write out the results.

I agree that the TYPE_CHANGED thing may have been confusing,
so I kept your version (although I switched the tests around,
since there is no point in checking if the stat info matches
if you're going to ignore the result anyway).

Other than that, the only change wrt to your version is that
I added back the creation and (attempt at) removal of the
corresponding subdirectory.

I'm not sure if you intented to remove the check for
either an empty dir or a git repo.  You asked me to add
it before, but then you removed it in your version.
I didn't add it back again.

skimo

 Documentation/git-apply.txt |   14 +++++
 builtin-apply.c             |  112 +++++++++++++++++++++++++++++++++----------
 t/t7400-submodule-basic.sh  |   17 +++++++
 3 files changed, 118 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f03f661..4c7e3a2 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -171,6 +171,20 @@ apply.whitespace::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
 
+Submodules
+----------
+If the patch contains any changes to submodules then gitlink:git-apply[1]
+treats these changes as follows.
+
+If --index is specified (explicitly or implicitly), then the submodule
+commits must match the index exactly for the patch to apply.  If any
+of the submodules are checked-out, then these check-outs are completely
+ignored, i.e., they are not required to be up-to-date or clean and they
+are not updated.
+
+If --index is not specified, then the submodule commits in the patch
+are ignored and only the absence of presence of the corresponding
+subdirectory is checked and (if possible) updated.
 
 Author
 ------
diff --git a/builtin-apply.c b/builtin-apply.c
index da27075..8055c7d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1984,6 +1984,25 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
 	return 0;
 }
 
+static int read_file_or_gitlink(struct cache_entry *ce, char **buf_p,
+				unsigned long *size_p)
+{
+	if (!ce)
+		return 0;
+
+	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
+		*buf_p = xmalloc(100);
+		*size_p = snprintf(*buf_p, 100,
+			"Subproject commit %s\n", sha1_to_hex(ce->sha1));
+	} else {
+		enum object_type type;
+		*buf_p = read_sha1_file(ce->sha1, &type, size_p);
+		if (!*buf_p)
+			return -1;
+	}
+	return 0;
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	char *buf;
@@ -1994,22 +2013,32 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	alloc = 0;
 	buf = NULL;
 	if (cached) {
-		if (ce) {
-			enum object_type type;
-			buf = read_sha1_file(ce->sha1, &type, &size);
-			if (!buf)
+		if (read_file_or_gitlink(ce, &buf, &size))
+			return error("read of %s failed", patch->old_name);
+		alloc = size;
+	} else if (patch->old_name) {
+		if (S_ISGITLINK(patch->old_mode)) {
+			if (ce)
+				read_file_or_gitlink(ce, &buf, &size);
+			else {
+				/*
+				 * There is no way to apply subproject
+				 * patch without looking at the index.
+				 */
+				patch->fragments = NULL;
+				size = 0;
+			}
+		}
+		else {
+			size = xsize_t(st->st_size);
+			alloc = size + 8192;
+			buf = xmalloc(alloc);
+			if (read_old_data(st, patch->old_name,
+					  &buf, &alloc, &size))
 				return error("read of %s failed",
 					     patch->old_name);
-			alloc = size;
 		}
 	}
-	else if (patch->old_name) {
-		size = xsize_t(st->st_size);
-		alloc = size + 8192;
-		buf = xmalloc(alloc);
-		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
-			return error("read of %s failed", patch->old_name);
-	}
 
 	desc.size = size;
 	desc.alloc = alloc;
@@ -2055,6 +2084,16 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
+static int verify_index_match(struct cache_entry *ce, struct stat *st)
+{
+	if (S_ISGITLINK(ntohl(ce->ce_mode))) {
+		if (!S_ISDIR(st->st_mode))
+			return -1;
+		return 0;
+	}
+	return ce_match_stat(ce, st, 1);
+}
+
 static int check_patch(struct patch *patch, struct patch *prev_patch)
 {
 	struct stat st;
@@ -2065,8 +2105,14 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 	int ok_if_exists;
 
 	patch->rejected = 1; /* we will drop this after we succeed */
+
+	/*
+	 * Make sure that we do not have local modifications from the
+	 * index when we are looking at the index.  Also make sure
+	 * we have the preimage file to be patched in the work tree,
+	 * unless --cached, which tells git to apply only in the index.
+	 */
 	if (old_name) {
-		int changed = 0;
 		int stat_ret = 0;
 		unsigned st_mode = 0;
 
@@ -2096,15 +2142,12 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 				    lstat(old_name, &st))
 					return -1;
 			}
-			if (!cached)
-				changed = ce_match_stat(ce, &st, 1);
-			if (changed)
+			if (!cached && verify_index_match(ce, &st))
 				return error("%s: does not match index",
 					     old_name);
 			if (cached)
 				st_mode = ntohl(ce->ce_mode);
-		}
-		else if (stat_ret < 0)
+		} else if (stat_ret < 0)
 			return error("%s: %s", old_name, strerror(errno));
 
 		if (!cached)
@@ -2354,7 +2397,11 @@ static void remove_file(struct patch *patch, int rmdir_empty)
 		cache_tree_invalidate_path(active_cache_tree, patch->old_name);
 	}
 	if (!cached) {
-		if (!unlink(patch->old_name) && rmdir_empty) {
+		if (S_ISGITLINK(patch->old_mode)) {
+			if (rmdir(patch->old_name))
+				warning("unable to remove submodule %s",
+					patch->old_name);
+		} else if (!unlink(patch->old_name) && rmdir_empty) {
 			char *name = xstrdup(patch->old_name);
 			char *end = strrchr(name, '/');
 			while (end) {
@@ -2382,13 +2429,21 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = htons(namelen);
-	if (!cached) {
-		if (lstat(path, &st) < 0)
-			die("unable to stat newly created file %s", path);
-		fill_stat_cache_info(ce, &st);
+	if (S_ISGITLINK(mode)) {
+		const char *s = buf;
+
+		if (get_sha1_hex(s + strlen("Subproject commit "), ce->sha1))
+			die("corrupt patch for subproject %s", path);
+	} else {
+		if (!cached) {
+			if (lstat(path, &st) < 0)
+				die("unable to stat newly created file %s",
+				    path);
+			fill_stat_cache_info(ce, &st);
+		}
+		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
+			die("unable to create backing store for newly created file %s", path);
 	}
-	if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
-		die("unable to create backing store for newly created file %s", path);
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 		die("unable to add cache entry for %s", path);
 }
@@ -2398,6 +2453,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	int fd;
 	char *nbuf;
 
+	if (S_ISGITLINK(mode)) {
+		struct stat st;
+		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
+			return 0;
+		return mkdir(path, 0777);
+	}
+
 	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e8ce7cd..9d142ed 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -175,4 +175,21 @@ test_expect_success 'checkout superproject with subproject already present' '
 	git-checkout master
 '
 
+test_expect_success 'apply submodule diff' '
+	git branch second &&
+	(
+		cd lib &&
+		echo s >s &&
+		git add s &&
+		git commit -m "change subproject"
+	) &&
+	git update-index --add lib &&
+	git-commit -m "change lib" &&
+	git-format-patch -1 --stdout >P.diff &&
+	git checkout second &&
+	git apply --index P.diff &&
+	D=$(git diff --cached master) &&
+	test -z "$D"
+'
+
 test_done
-- 
1.5.3.rc5.1.g7de89
