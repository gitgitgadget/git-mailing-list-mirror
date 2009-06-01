From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v3] refuse to merge during a merge
Date: Mon, 1 Jun 2009 11:20:56 +0200
Message-ID: <20090601092056.GA6933@localhost>
References: <20090527210410.GA14742@localhost> <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com> <20090530083721.GA12963@localhost> <20090531104359.GA19094@localhost> <7vd49prrne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dave Olszewski <cxreg@pobox.com>,
	John Tapsell <johnflux@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 11:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB3hd-0000YZ-LF
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 11:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbZFAJVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 05:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbZFAJVA
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 05:21:00 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:4684 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbZFAJVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 05:21:00 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Jun 2009 11:21:01 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MB3hQ-0001sA-L0; Mon, 01 Jun 2009 11:20:56 +0200
Content-Disposition: inline
In-Reply-To: <7vd49prrne.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 01 Jun 2009 09:21:01.0651 (UTC) FILETIME=[47EFD230:01C9E29A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120453>

The following is an easy mistake to make for users coming from version
control systems with an "update and commit"-style workflow.

        1. git pull
        2. resolve conflicts
        3. git pull

Step 3 overrides MERGE_HEAD, starting a new merge with dirty index.
IOW, probably not what the user intended. Instead, refuse to merge
again if a merge is in progress.

Reported-by: Dave Olszewski <cxreg@pobox.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, May 31, 2009 at 12:36:37PM -0700, Junio C Hamano wrote:
> For example, "git merge" may learn "git merge --abort" like other commands
> that have "attempt, stop, let the user fix up to conclude" modes of
> operations (i.e. rebase and am), and we may suggest to use that to recover
> in the message, instead of 'git reset'.  But that can only be used if we
> stopped because we saw MERGE_HEAD; you definitely do not want to suggest
> "git merge --abort" if the index is unmerged due to a conflicted rebase in
> progress.

Indeed. I wasn't thinking.

Clemens

 builtin-merge.c            |    5 ++++-
 t/t3030-merge-recursive.sh |    3 +++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 0b58e5e..9e9bd52 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -836,8 +836,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list **remotes = &remoteheads;
 
 	setup_work_tree();
+	if (file_exists(git_path("MERGE_HEAD")))
+		die("You have not concluded your merge. (MERGE_HEAD exists)");
 	if (read_cache_unmerged())
-		die("You are in the middle of a conflicted merge.");
+		die("You are in the middle of a conflicted merge."
+				" (index unmerged)");
 
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 0de613d..9b3fa2b 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -276,6 +276,9 @@ test_expect_success 'fail if the index has unresolved entries' '
 
 	test_must_fail git merge "$c5" &&
 	test_must_fail git merge "$c5" 2> out &&
+	grep "You have not concluded your merge" out &&
+	rm -f .git/MERGE_HEAD &&
+	test_must_fail git merge "$c5" 2> out &&
 	grep "You are in the middle of a conflicted merge" out
 
 '
-- 
1.6.3.1.147.g637c3
