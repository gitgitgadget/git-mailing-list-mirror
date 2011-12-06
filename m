From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/5] cache-tree revisited
Date: Tue, 6 Dec 2011 18:43:34 +0100
Message-ID: <cover.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXz3W-0000Dz-A0
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1LFRnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:43:43 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab1LFRnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:43:42 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:39 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:43:40 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186357>

Junio C Hamano wrote:
> Ahh, I forgot all about that exchange.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/178480/focus=178515
> 
> The cache-tree mechanism has traditionally been one of the more important
> optimizations and it would be very nice if we can resurrect the behaviour
> for "git commit" too.

Oh, I buried that.  Let's try something other than the aggressive
strategy I had there: only compute cache-tree if

* we know we're going to need it soon, and we're about to write out
  the index anyway (as in git-commit)

* we know we can rebuild it from a tree, and we're about to write out
  the index anyway (as in git-reset)

Both of these are essentially free, so I'm not sure I should even
bother with timings, but I ran the silly script at the end on my
favourite linux v2.6.37-rc2 repo, and it takes

  before-:  real 0m29.103s   user 0m17.335s   sys 0m8.415s
  before+:  real 0m30.860s   user 0m9.741s    sys 0m7.287s
  after-:   real 0m28.798s   user 0m17.367s   sys 0m8.435s
  after+:   real 0m17.563s   user 0m8.246s    sys 0m7.122s

where the + signifies starting out with fully valid cache-tree data,
and - means starting out with none at all.

So it's really free when it's starting out in bad shape, and it's
much faster when it starts out with valid data.

If you insist on writing cache-tree at *every* (except --only) commit,
then we might make it so that it writes out the index again at the
very end if it didn't already update it earlier.  It would (and does,
I've tried... ok ok, patch is at the end) of course give the +
performance in the - case, but it's not free so other operations may
be affected.



---- 8< ---- test script for the above timings ---- 8< ----
#!/bin/sh

for i in $(seq 1 100); do
    echo $i > arch/alpha/boot/foo
    git add arch/alpha/boot/foo
    git commit -m$i
done
---- >8 ----

---- 8< ---- patch to let git-commit always write the index ---- 8< ----
diff --git i/builtin/commit.c w/builtin/commit.c
index 57d028e..8e0c773 100644
--- i/builtin/commit.c
+++ w/builtin/commit.c
@@ -333,6 +333,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
+static int wrote_index_already = 0;
+
 static char *prepare_index(int argc, const char **argv, const char *prefix,
 			   const struct commit *current_head, int is_status)
 {
@@ -395,6 +397,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(1);
+		wrote_index_already = 1;
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
@@ -415,6 +418,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
+			wrote_index_already = 1;
 			update_main_cache_tree(1);
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
@@ -639,6 +643,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
+	int fd;
 
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -863,11 +868,17 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * the editor and after we invoke run_status above.
 	 */
 	discard_cache();
+	if (!wrote_index_already)
+		fd = hold_locked_index(&index_lock, 1);
 	read_cache_from(index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
 		return 0;
 	}
+	if (!wrote_index_already && commit_style != COMMIT_PARTIAL)
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close_lock_file(&index_lock))
+			die(_("unable to write new_index file"));
 
 	if (run_hook(index_file, "prepare-commit-msg",
 		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
---- >8 ----


Thomas Rast (5):
  Add test-scrap-cache-tree
  Test the current state of the cache-tree optimization
  Refactor cache_tree_update idiom from commit
  commit: write cache-tree data when writing index anyway
  reset: update cache-tree data when appropriate

 .gitignore              |    1 +
 Makefile                |    1 +
 builtin/commit.c        |    7 +--
 builtin/reset.c         |    7 +++
 cache-tree.c            |   19 +++++++--
 cache-tree.h            |    4 +-
 merge-recursive.c       |    2 +-
 t/t0090-cache-tree.sh   |   95 +++++++++++++++++++++++++++++++++++++++++++++++
 test-dump-cache-tree.c  |    2 +-
 test-scrap-cache-tree.c |   17 ++++++++
 10 files changed, 144 insertions(+), 11 deletions(-)
 create mode 100755 t/t0090-cache-tree.sh
 create mode 100644 test-scrap-cache-tree.c

-- 
1.7.8.425.ga639d3
