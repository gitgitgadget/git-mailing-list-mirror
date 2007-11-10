From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-add: make the entry stat-clean after re-adding the same contents
Date: Fri, 09 Nov 2007 18:22:52 -0800
Message-ID: <7vzlxmq1oj.fsf_-_@gitster.siamese.dyndns.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711091702190.4362@racer.site>
	<7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 03:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqg0E-0003pk-JI
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 03:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420AbXKJCXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 21:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756376AbXKJCXA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 21:23:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39026 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbXKJCW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 21:22:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 82D852F2;
	Fri,  9 Nov 2007 21:23:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2809893D9D;
	Fri,  9 Nov 2007 21:23:16 -0500 (EST)
In-Reply-To: <7vhcjvtgz5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Nov 2007 10:24:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64299>

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

 * Blech.  This took longer than I thought.  It's only cached
   stat info and does not cause real data breakage, but I think
   it is a good thing to fix nevertheless.

 builtin-add.c |    2 +-
 diff-lib.c    |    6 ++++--
 diff.h        |    2 +-
 read-cache.c  |    2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 373f87f..b6d6bbe 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -123,7 +123,7 @@ static void update(int verbose, const char *prefix, const char **files)
 	rev.diffopt.format_callback_data = &verbose;
 	if (read_cache() < 0)
 		die("index file corrupt");
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, 2);
 }
 
 static void refresh(int verbose, const char **pathspec)
diff --git a/diff-lib.c b/diff-lib.c
index da55713..b83f650 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -332,10 +332,12 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 	return run_diff_files(revs, silent_on_removed);
 }
 
-int run_diff_files(struct rev_info *revs, int silent_on_removed)
+int run_diff_files(struct rev_info *revs, int option)
 {
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
+	int silent_on_removed = option & 01;
+	int assume_racy_is_modified = option & 02;
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
@@ -441,7 +443,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 				       ce->sha1, ce->name, NULL);
 			continue;
 		}
-		changed = ce_match_stat(ce, &st, 0);
+		changed = ce_match_stat(ce, &st, assume_racy_is_modified);
 		if (!changed && !revs->diffopt.find_copies_harder)
 			continue;
 		oldmode = ntohl(ce->ce_mode);
diff --git a/diff.h b/diff.h
index 4546aad..040e18c 100644
--- a/diff.h
+++ b/diff.h
@@ -224,7 +224,7 @@ extern void diff_flush(struct diff_options*);
 
 extern const char *diff_unique_abbrev(const unsigned char *, int);
 
-extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
+extern int run_diff_files(struct rev_info *revs, int option);
 extern int setup_diff_no_index(struct rev_info *revs,
 		int argc, const char ** argv, int nongit, const char *prefix);
 extern int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv);
diff --git a/read-cache.c b/read-cache.c
index 928e8fa..75e2d46 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -420,7 +420,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	pos = index_name_pos(istate, ce->name, namelen);
 	if (0 <= pos &&
 	    !ce_stage(istate->cache[pos]) &&
-	    !ie_modified(istate, istate->cache[pos], &st, 1)) {
+	    !ie_match_stat(istate, istate->cache[pos], &st, 3)) {
 		/* Nothing changed, really */
 		free(ce);
 		return 0;
-- 
1.5.3.5.1651.g30bf0
