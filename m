From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] builtin-add.c: restructure the code for
 maintainability
Date: Sun, 20 Jul 2008 22:22:02 -0700
Message-ID: <7v3am3yfph.fsf@gitster.siamese.dyndns.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 07:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKnrk-0002dY-RS
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 07:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbYGUFWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 01:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbYGUFWT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 01:22:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbYGUFWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 01:22:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7ED172EC7B;
	Mon, 21 Jul 2008 01:22:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 800B52EC7A; Mon, 21 Jul 2008 01:22:14 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness> (Johannes
 Schindelin's message of "Mon, 21 Jul 2008 02:56:35 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC386A78-56E4-11DD-B945-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89302>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This comment left me scratching my head.  While I do see a breakage when 
> reading the index first, I had the impression that it should not.

The directory traversal that originates from git-ls-files (not the
"show-index" mode which the command originally was about, but the "show
others" part of the feature that came much later) were primarily designed
for collecting paths that do not appear in the active_cache[].  Very early
version of git-add was about adding untracked paths (and update-index was
to stage changes to tracked files), and did have the fill_directory()
after we have read the index for this exact reason.

That changed late 2006 when Nico allowed git-add to stage already tracked
files as well.  We collect the paths in the work tree that match given
pathspec, and for the directory traverser to do that job, you would need
an empty index.

	Side note: 366bfcb (make 'git add' a first class user friendly
	interface to the index, 2006-12-04) is something to marvel at.  It
	describes the change with its documentation update fully, changes
	the semantics in a drastic way, with so little change.

        Documentation/git-add.txt  |   53 ++++++++++++-----------
        Documentation/tutorial.txt |   46 ++++++++++++++++++---
        builtin-add.c              |    6 +-
        wt-status.c                |    2 +-
        4 files changed, 72 insertions(+), 35 deletions(-)

Perhaps we can add a bit to the dir_struct we give to the traverser to
tell it to ignore the index even if we have already read one.  That would
be a much cleaner API enhancement than reading the index and setting aside
while calling read_directory() which feels like a you know what I would
call it.

Perhaps you can lose that comment like this.

 builtin-add.c |   12 ++++--------
 dir.c         |   12 +++++++++---
 dir.h         |    1 +
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index fc3f96e..c6185c3 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -58,6 +58,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 
 	/* Set up the default git porcelain excludes */
 	memset(dir, 0, sizeof(*dir));
+	dir->ignore_index = 1;
 	if (!ignored_too) {
 		dir->collect_ignored = 1;
 		setup_standard_excludes(dir);
@@ -280,17 +281,12 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	pathspec = get_pathspec(prefix, argv);
 
-	/*
-	 * If we are adding new files, we need to scan the working
-	 * tree to find the ones that match pathspecs; this needs
-	 * to be done before we read the index.
-	 */
-	if (add_new_files)
-		fill_directory(&dir, pathspec, ignored_too);
-
 	if (read_cache() < 0)
 		die("index file corrupt");
 
+	if (add_new_files)
+		fill_directory(&dir, pathspec, ignored_too);
+
 	if (refresh_only) {
 		refresh(verbose, pathspec);
 		goto finish;
diff --git a/dir.c b/dir.c
index 29d1d5b..7447485 100644
--- a/dir.c
+++ b/dir.c
@@ -389,7 +389,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_name_exists(pathname, len, ignore_case))
+	if (!dir->ignore_index && cache_name_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -483,8 +483,14 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len,
 	const struct path_simplify *simplify)
 {
-	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(dirname, len-1)) {
+	enum exist_status in_index;
+
+	if (dir->ignore_index)
+		in_index = index_nonexistent;
+	else
+		/* The "len-1" is to strip the final '/' */
+		in_index = directory_exists_in_index(dirname, len-1);
+	switch (in_index) {
 	case index_directory:
 		return recurse_into_directory;
 
diff --git a/dir.h b/dir.h
index 2df15de..4ef1c99 100644
--- a/dir.h
+++ b/dir.h
@@ -38,6 +38,7 @@ struct dir_struct {
 		     show_other_directories:1,
 		     hide_empty_directories:1,
 		     no_gitlinks:1,
+		     ignore_index:1,
 		     collect_ignored:1;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
