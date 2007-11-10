From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] git-add: make the entry stat-clean after re-adding the same contents
Date: Sat, 10 Nov 2007 01:02:29 -0800
Message-ID: <7vve8ao4m2.fsf_-_@gitster.siamese.dyndns.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711091702190.4362@racer.site>
	<7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
	<7vzlxmq1oj.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711091840120.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqmEx-0003Di-LK
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 10:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXKJJCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 04:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbXKJJCj
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 04:02:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56892 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbXKJJCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 04:02:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8816E2F2;
	Sat, 10 Nov 2007 04:02:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 49F9592479;
	Sat, 10 Nov 2007 04:02:53 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999.0711091840120.15101@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 9 Nov 2007 18:43:07 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64317>

Earlier in commit 0781b8a9b2fe760fc4ed519a3a26e4b9bd6ccffe
(add_file_to_index: skip rehashing if the cached stat already
matches), add_file_to_index() were taught not to re-add the path
if it already matches the index.

The change meant well, but was not executed quite right.  It
used ie_modified() to see if the file on the work tree is really
different from the index, and skipped adding the contents if the
function says "not modified".

This was wrong.  There are three possible comparison results
between the index and the file in the work tree:

 - with lstat(2) we _know_ they are different.  E.g. if the
   length or the owner in the cached stat information is
   different from the length we just obtained from lstat(2), we
   can tell the file is modified without looking at the actual
   contents.

 - with lstat(2) we _know_ they are the same.  The same length,
   the same owner, the same everything (but this has a twist, as
   described below).

 - we cannot tell from lstat(2) information alone and need to go
   to the filesystem to actually compare.

The last case arises from what we call 'racy git' situation,
that can be caused with this sequence:

    $ echo hello >file
    $ git add file
    $ echo aeiou >file ;# the same length

If the second "echo" is done within the same filesystem
timestamp granularity as the first "echo", then the timestamp
recorded by "git add" and the timestamp we get from lstat(2)
will be the same, and we can mistakenly say the file is not
modified.  The path is called 'racily clean'.  We need to
reliably detect racily clean paths are in fact modified.

To solve this problem, when we write out the index, we mark the
index entry that has the same timestamp as the index file itself
(that is the time from the point of view of the filesystem) to
tell any later code that does the lstat(2) comparison not to
trust the cached stat info, and ie_modified() then actually goes
to the filesystem to compare the contents for such a path.

That's all good, but it should not be used for this "git add"
optimization, as the goal of "git add" is to actually update the
path in the index and make it stat-clean.  With the false
optimization, we did _not_ cause any data loss (after all, what
we failed to do was only to update the cached stat information),
but it made the following sequence leave the file stat dirty:

    $ echo hello >file
    $ git add file
    $ echo hello >file ;# the same contents
    $ git add file

The solution is not to use ie_modified() which goes to the
filesystem to see if it is really clean, but instead use
ie_match_stat() with "assume racily clean paths are dirty"
option, to force re-adding of such a path.

There was another problem with "git add -u".  The codepath
shares the same issue when adding the paths that are found to be
modified, but in addition, it asked "git diff-files" machinery
run_diff_files() function (which is "git diff-files") to list
the paths that are modified.  But "git diff-files" machinery
uses the same ie_modified() call so that it does not report
racily clean _and_ actually clean paths as modified, which is
not what we want.

The patch allows the callers of run_diff_files() to pass the
same "assume racily clean paths are dirty" option, and makes
"git-add -u" codepath to use that option, to discover and re-add
racily clean _and_ actually clean paths.

We could further optimize on top of this patch to differentiate
the case where the path really needs re-adding (i.e. the content
of the racily clean entry was indeed different) and the case
where only the cached stat information needs to be refreshed
(i.e. the racily clean entry was actually clean), but I do not
think it is worth it.

This patch applies to maint and all the way up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is a respin of the earlier fix, using the new
   constants.

 builtin-add.c |    2 +-
 diff-lib.c    |    4 +++-
 diff.h        |    2 ++
 read-cache.c  |    3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 373f87f..e072320 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -123,7 +123,7 @@ static void update(int verbose, const char *prefix, const char **files)
 	rev.diffopt.format_callback_data = &verbose;
 	if (read_cache() < 0)
 		die("index file corrupt");
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 }
 
 static void refresh(int verbose, const char **pathspec)
diff --git a/diff-lib.c b/diff-lib.c
index 9f8afbe..ec1b5e3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -338,6 +338,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
 	int silent_on_removed = option & DIFF_SILENT_ON_REMOVED;
+	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
+			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
@@ -443,7 +445,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				       ce->sha1, ce->name, NULL);
 			continue;
 		}
-		changed = ce_match_stat(ce, &st, 0);
+		changed = ce_match_stat(ce, &st, ce_option);
 		if (!changed && !revs->diffopt.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
diff --git a/diff.h b/diff.h
index de533da..efaa8f7 100644
--- a/diff.h
+++ b/diff.h
@@ -226,6 +226,8 @@ extern const char *diff_unique_abbrev(const unsigned char *, int);
 
 /* do not report anything on removed paths */
 #define DIFF_SILENT_ON_REMOVED 01
+/* report racily-clean paths as modified */
+#define DIFF_RACY_IS_MODIFIED 02
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int setup_diff_no_index(struct rev_info *revs,
 		int argc, const char ** argv, int nongit, const char *prefix);
diff --git a/read-cache.c b/read-cache.c
index 9e4d4a9..c3dbf89 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -388,6 +388,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	int size, namelen, pos;
 	struct stat st;
 	struct cache_entry *ce;
+	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
 	if (lstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
@@ -422,7 +423,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	pos = index_name_pos(istate, ce->name, namelen);
 	if (0 <= pos &&
 	    !ce_stage(istate->cache[pos]) &&
-	    !ie_modified(istate, istate->cache[pos], &st, CE_MATCH_IGNORE_VALID)) {
+	    !ie_match_stat(istate, istate->cache[pos], &st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
 		return 0;
-- 
1.5.3.5.1651.g30bf0
