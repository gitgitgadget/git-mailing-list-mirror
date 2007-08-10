From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH resend] git-apply: apply submodule changes
Date: Fri, 10 Aug 2007 15:57:44 +0200
Message-ID: <20070810135744.GA29243MdfPADPa@greensroom.kotnet.org>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Steffen Prohaska <prohaska@zib.de>, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 15:57:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJUzu-0002W5-Rg
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 15:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761085AbXHJN5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 09:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760810AbXHJN5r
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 09:57:47 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:38803 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757593AbXHJN5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 09:57:46 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMK00DJ89G8DR@psmtp09.wxs.nl> for git@vger.kernel.org; Fri,
 10 Aug 2007 15:57:45 +0200 (MEST)
Received: (qmail 27592 invoked by uid 500); Fri, 10 Aug 2007 13:57:44 +0000
In-reply-to: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55539>

Apply "Subproject commit HEX" changes produced by git-diff.
As usual in the current git, only the superproject itself is actually
modified (possibly creating empty directories for new submodules).
Any checked-out submodule is left untouched and is not required to
be up-to-date.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
This second version has a test and an extra sanity check.

I seem to be experiencing some problems receiving emails,
so I'll reply to a message from Dscho here.

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> For rebase and cherry-pick, it would be nice if git just ignored the 
> changes in the submodules, provided that the submodule commit was not 
> affected by the to-be-applied patches.

I have no idea what you mean.

The checked out copies of the submodules are ignored completely
(if that is what you were talking about, then I hope this issue
is clarified by the updated commit message).  In the superproject,
the change to the submodule is obviously not ignored, since it's
an integral part of the patch.  However, git-apply will fail if
the original submodule commit does not correspond exactly to the
"from-file" submodule commit.
I don't think there is anything else we can do without a true
recursive git-diff/git-apply.

skimo

 builtin-apply.c            |   50 ++++++++++++++++++++++++++++++++++---------
 t/t7400-submodule-basic.sh |    8 +++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index da27075..a38dbf1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1984,6 +1984,26 @@ static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
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
+
+	return 0;
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	char *buf;
@@ -1994,20 +2014,18 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	alloc = 0;
 	buf = NULL;
 	if (cached) {
-		if (ce) {
-			enum object_type type;
-			buf = read_sha1_file(ce->sha1, &type, &size);
-			if (!buf)
-				return error("read of %s failed",
-					     patch->old_name);
-			alloc = size;
-		}
+		if (read_file_or_gitlink(ce, &buf, &size))
+			return error("read of %s failed", patch->old_name);
+		alloc = size;
 	}
 	else if (patch->old_name) {
 		size = xsize_t(st->st_size);
 		alloc = size + 8192;
 		buf = xmalloc(alloc);
-		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
+		if (S_ISGITLINK(patch->old_mode))
+			size = snprintf(buf, alloc,
+				"Subproject commit %s\n", sha1_to_hex(ce->sha1));
+		else if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
 			return error("read of %s failed", patch->old_name);
 	}
 
@@ -2098,7 +2116,7 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 			}
 			if (!cached)
 				changed = ce_match_stat(ce, &st, 1);
-			if (changed)
+			if (changed && !S_ISGITLINK(patch->old_mode))
 				return error("%s: does not match index",
 					     old_name);
 			if (cached)
@@ -2387,7 +2405,10 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 			die("unable to stat newly created file %s", path);
 		fill_stat_cache_info(ce, &st);
 	}
-	if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
+	if (S_ISGITLINK(mode)) {
+		if (get_sha1_hex(buf + strlen("Subproject commit "), ce->sha1))
+			die("corrupt patch for subproject %s", path);
+	} else if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
 		die("unable to create backing store for newly created file %s", path);
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 		die("unable to add cache entry for %s", path);
@@ -2398,6 +2419,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
index e8ce7cd..cede2e7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -175,4 +175,12 @@ test_expect_success 'checkout superproject with subproject already present' '
 	git-checkout master
 '
 
+test_expect_success 'rebase with subproject changes' '
+	git-checkout initial &&
+	echo t > t &&
+	git add t &&
+	git-commit -m "change t" &&
+	git-rebase HEAD master
+'
+
 test_done
-- 
1.5.3.rc4.29.g74276-dirty
