From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 06:02:51 -0400
Message-ID: <20090809100251.GC25231@coredump.intra.peff.net>
References: <20090809100045.GA25197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 12:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma5Ey-000511-SX
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 12:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbZHIKCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 06:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbZHIKCw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 06:02:52 -0400
Received: from peff.net ([208.65.91.99]:52374 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787AbZHIKCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 06:02:52 -0400
Received: (qmail 3145 invoked by uid 107); 9 Aug 2009 10:05:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 06:05:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 06:02:51 -0400
Content-Disposition: inline
In-Reply-To: <20090809100045.GA25197@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125340>

Previously when merging directly from a local tracking
branch like:

  git merge origin/master

The merge message said:

   Merge commit 'origin/master'

     * commit 'origin/master':
       ...

Instead, let's be more explicit about what we are merging:

   Merge remote branch 'origin/master'

     * origin/master:
       ...

We accomplish this by recognizing remote tracking branches
in git-merge when we build the simulated FETCH_HEAD output
that we feed to fmt-merge-msg.

In addition to a new test in t7608, we have to tweak the
expected output of t3409, which does such a merge.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-merge.c                   |    5 +++++
 t/t3409-rebase-preserve-merges.sh |    2 +-
 t/t7608-merge-messages.sh         |   10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index f7db148..f4de73f 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -375,6 +375,11 @@ static void merge_name(const char *remote, struct strbuf *msg)
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
+		if (!prefixcmp(found_ref, "refs/remotes/")) {
+			strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 	}
 
 	/* See if remote matches <name>^^^.. or <name>~<number> */
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index e6c8327..297d165 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -71,7 +71,7 @@ test_expect_success 'rebase -p fakes interactive rebase' '
 	git fetch &&
 	git rebase -p origin/topic &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote branch " | wc -l)
 	)
 '
 
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 81ced8a..28d5679 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -47,4 +47,14 @@ test_expect_success 'ambiguous tag' '
 	check_oneline "Merge commit QambiguousQ"
 '
 
+test_expect_success 'remote branch' '
+	git checkout -b remote master &&
+	test_commit remote-1 &&
+	git update-ref refs/remotes/origin/master remote &&
+	git checkout master &&
+	test_commit master-5 &&
+	git merge origin/master &&
+	check_oneline "Merge remote branch Qorigin/masterQ"
+'
+
 test_done
-- 
1.6.4.178.g7a987
