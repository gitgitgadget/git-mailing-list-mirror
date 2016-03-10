From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] pull: drop confusing prefix parameter of
 die_on_unclean_work_tree()
Date: Thu, 10 Mar 2016 14:24:26 +0100 (CET)
Message-ID: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 14:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae0a7-0006jE-1S
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 14:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbcCJNYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 08:24:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:62755 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbcCJNYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 08:24:36 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MGFz9-1aavee49LT-00FAJD; Thu, 10 Mar 2016 14:24:28
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fNHbAN2IBzTRDxkMFNT+CcfVQ5dG6NQ0mA3ERiuSpmtSmqE7CUY
 RSMiPCeFaGfhmP3fHqRwtUNr/DUXaOGeSz8iqDLgNjHWuDG5RU2o468aEzidIslWYqr/yrM
 +wdtrRT9iaJy6gKMxOcSf4qt3fDmnjoTz036cqKv8GO3upIKWB43N0Usa/o+V4LFlKSI1jj
 WcnLr4ZFHOceW+OsR1eSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GOutzDA9dfU=:qDMGLSJZFBiPUKyjJFMYao
 qdeLbxT42Qc58JDSFxT4xFc7XUjp/fqmLP3o09HP8wWVTWexwvIyFERAvg9+nfFrjbI00oxjC
 kJMRR7vNy88gJATy9Nn7Ay0UdXM4xgP4FTQQULju+pFXxEdZp3DNSLiNX1qT8dzY6VqKkFJHJ
 NB8G3SMWNbF8/Em386Ec1poHZIE/L0VgU8irb0V7SvZ85tUhz/dbahDyPYexFkViOvnWzCpU9
 Ze9zKniskxEIM/q4Qt/mpN3d51vI9DiUMFzxnRtzEZYuxZ44Q04mqWDNTbzCYNMHtuRCRuHgz
 hBNzMPS33zo7QnAcEwVYlmyy/rSvuwG6b+2phJiQlFaUijdCeOS2HJbxKtqkBKQ+Ob0QEco5U
 Im3x61kOYGYl0hMJu+1Fbi50FWcWqRB/KD1T6VnHS0XzOiNItfwfvopexZqcV4n84ykx0tocU
 GoGAVcMyLNiMm34EZUxfplah7Z7d/hbBbJS0y9Ab0M2uMwwqR4bCWtOlgOHHAON0gmasbRQAq
 J45+x4U1Fm+E+d9wXbBqNmes6OkuCz2Dx0O1QmC4TcqBsZAkm71oAb58huMmeZav5o2DnMQoH
 dD5O0Wg4C97wGoCJe2FayWgx+Nacu1F/dvH8cT8Va3KMldDvyo2x6Rtr1EoitJN4yf88QMrLO
 pvxoL1jiAFLINbEU/JT7/HDJQSxCKDDzXTvzF1JZT3gITMN/OSTTDMcaK63wwuUyqP+gExsnI
 ho2vHwM9aLaqbN3zJwumOOuBFPbEHLHWnpTdTjxfkB+UIgVHiNERjMcFYRWnaa4hto47gZ7H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288623>

In cmd_pull(), when verifying that there are no changes preventing a
rebasing pull, we diligently pass the prefix parameter to the
die_on_unclean_work_tree() function which in turn diligently passes it
to the has_unstaged_changes() and has_uncommitted_changes() functions.

The casual reader might now be curious (as this developer was) whether
that means that calling `git pull --rebase` in a subdirectory will
ignore unstaged changes in other parts of the working directory. And be
puzzled that `git pull --rebase` (correctly) complains about those
changes outside of the current directory.

The puzzle is easily resolved: while we take pains to pass around the
prefix and even pass it to init_revisions(), the fact that no paths are
passed to init_revisions() ensures that the prefix is simply ignored.

That, combined with the fact that we will *always* want a *full* working
directory check before running a rebasing pull, is reason enough to
simply do away with the actual prefix parameter and to pass NULL
instead, as if we were running this from the top-level working directory
anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..4ed46b3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -308,12 +308,12 @@ static enum rebase_type config_get_rebase(void)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-static int has_unstaged_changes(const char *prefix)
+static int has_unstaged_changes()
 {
 	struct rev_info rev_info;
 	int result;
 
-	init_revisions(&rev_info, prefix);
+	init_revisions(&rev_info, NULL);
 	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	diff_setup_done(&rev_info.diffopt);
@@ -324,7 +324,7 @@ static int has_unstaged_changes(const char *prefix)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-static int has_uncommitted_changes(const char *prefix)
+static int has_uncommitted_changes()
 {
 	struct rev_info rev_info;
 	int result;
@@ -332,7 +332,7 @@ static int has_uncommitted_changes(const char *prefix)
 	if (is_cache_unborn())
 		return 0;
 
-	init_revisions(&rev_info, prefix);
+	init_revisions(&rev_info, NULL);
 	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
@@ -345,7 +345,7 @@ static int has_uncommitted_changes(const char *prefix)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-static void die_on_unclean_work_tree(const char *prefix)
+static void die_on_unclean_work_tree()
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int do_die = 0;
@@ -355,12 +355,12 @@ static void die_on_unclean_work_tree(const char *prefix)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes(prefix)) {
+	if (has_unstaged_changes()) {
 		error(_("Cannot pull with rebase: You have unstaged changes."));
 		do_die = 1;
 	}
 
-	if (has_uncommitted_changes(prefix)) {
+	if (has_uncommitted_changes()) {
 		if (do_die)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
@@ -842,7 +842,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		git_config_get_bool("rebase.autostash", &autostash);
 		if (!autostash)
-			die_on_unclean_work_tree(prefix);
+			die_on_unclean_work_tree();
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.7.2.windows.1.8.g47d64e6.dirty
