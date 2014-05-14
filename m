From: Jeff King <peff@peff.net>
Subject: [PATCH] run_diff_files: do not look at uninitialized stat data
Date: Wed, 14 May 2014 18:13:06 -0400
Message-ID: <20140514221306.GA5020@sigill.intra.peff.net>
References: <CAPZ477Ot8MiTUNx1AwDTb5sGDDerDvBY=znsK4Fhcb5taYsaHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Thu May 15 00:13:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQI-0005FU-Go
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbaENWNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:51771 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751407AbaENWNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:09 -0400
Received: (qmail 21518 invoked by uid 102); 14 May 2014 22:13:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 May 2014 17:13:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2014 18:13:06 -0400
Content-Disposition: inline
In-Reply-To: <CAPZ477Ot8MiTUNx1AwDTb5sGDDerDvBY=znsK4Fhcb5taYsaHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249007>

On Sun, May 11, 2014 at 02:20:57PM -0500, Elliott Cable wrote:

> So, I've spent some time in the #git channel on Freenode chatting
> about this, and we couldn't figure it out. I can't reproduce it in a
> newly-made repository, but it's reproducible with the repository I've
> been working in.
>
>     > git status
>     On branch Master
>     Your branch is ahead of 'ec/Master' by 2 commits.
>      (use "git push" to publish your local commits)
> 
>     nothing to commit, working directory clean
>     > g diff --find-copies-harder
>     diff --git i/Executables/paws.js w/Executables/paws.js
>     old mode 100755
>     new mode 100644
>     > stat -f '%p' Executables/paws.js
>     100755
>     >

Thanks for a thorough bug report. I was able to reproduce it. The
problem is related to accessing uninitialized memory, so it may vary
from system to system, or even run to run.

The test I've included below seems to trigger reliably for me. I
wouldn't be surprised if it does not trigger on other people's systems,
but I think it does not hurt to include it (the behavior it tests
for certainly _should_ be what happens).

-- >8 --
Subject: run_diff_files: do not look at uninitialized stat data

If we try to diff an index entry marked CE_VALID (because it
was marked with --assume-unchanged), we do not bother even
running stat() on the file to see if it was removed. This
started long ago with 540e694 (Prevent diff machinery from
examining assume-unchanged entries on worktree, 2009-08-11).

However, the subsequent code may look at our "struct stat"
and expect to find actual data; currently it will find
whatever cruft was left on the stack. This can cause
problems in two situations:

  1. We call match_stat_with_submodule with the stat data,
     so a submodule may be erroneously marked as changed.

  2. If --find-copies-harder is in effect, we pass all
     entries, even unchanged ones, to diff_change, so it can
     list them as rename/copy sources. Since we found no
     change, we assume that function will realize it and not
     actually display any diff output. However, we end up
     feeding it a bogus mode, leading it to sometimes claim
     there was a mode change.

We can fix both by splitting the CE_VALID and regular code
paths, and making sure only to look at the stat information
in the latter. Furthermore, we push the declaration of our
"struct stat" down into the code paths that actually set it,
so we cannot accidentally access it uninitialized in future
code.

Signed-off-by: Jeff King <peff@peff.net>
---
The patch is kind of nasty due to re-indenting. "diff -b" makes it much
clearer.

 diff-lib.c                       | 34 ++++++++++++++++++++++------------
 t/t4039-diff-assume-unchanged.sh | 11 +++++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 0448729..62aee81 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -97,7 +97,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
 	for (i = 0; i < entries; i++) {
-		struct stat st;
 		unsigned int oldmode, newmode;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
@@ -115,6 +114,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			unsigned int wt_mode = 0;
 			int num_compare_stages = 0;
 			size_t path_len;
+			struct stat st;
 
 			path_len = ce_namelen(ce);
 
@@ -195,26 +195,36 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			continue;
 
 		/* If CE_VALID is set, don't look at workdir for file removal */
-		changed = (ce->ce_flags & CE_VALID) ? 0 : check_removed(ce, &st);
-		if (changed) {
-			if (changed < 0) {
-				perror(ce->name);
+		if (ce->ce_flags & CE_VALID) {
+			changed = 0;
+			newmode = ce->ce_mode;
+		}
+		else {
+			struct stat st;
+
+			changed = check_removed(ce, &st);
+			if (changed) {
+				if (changed < 0) {
+					perror(ce->name);
+					continue;
+				}
+				diff_addremove(&revs->diffopt, '-', ce->ce_mode,
+					       ce->sha1, !is_null_sha1(ce->sha1),
+					       ce->name, 0);
 				continue;
 			}
-			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-				       ce->sha1, !is_null_sha1(ce->sha1),
-				       ce->name, 0);
-			continue;
+
+			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
+							    ce_option, &dirty_submodule);
+			newmode = ce_mode_from_stat(ce, st.st_mode);
 		}
-		changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-						    ce_option, &dirty_submodule);
+
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 				continue;
 		}
 		oldmode = ce->ce_mode;
-		newmode = ce_mode_from_stat(ce, st.st_mode);
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    ce->sha1, (changed ? null_sha1 : ce->sha1),
 			    !is_null_sha1(ce->sha1), (changed ? 0 : !is_null_sha1(ce->sha1)),
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 9d9498b..23c0e35 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -28,4 +28,15 @@ test_expect_success 'diff-files does not examine assume-unchanged entries' '
 	test -z "$(git diff-files -- one)"
 '
 
+test_expect_success POSIXPERM 'find-copies-harder is not confused by mode bits' '
+	echo content >exec &&
+	chmod +x exec &&
+	git add exec &&
+	git commit -m exec &&
+	git update-index --assume-unchanged exec &&
+	>expect &&
+	git diff-files --find-copies-harder -- exec >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.0.0.rc1.436.g03cb729
