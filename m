From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 03:14:46 -0400
Message-ID: <20090809071446.GA24221@coredump.intra.peff.net>
References: <20090809065936.GA24112@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 09:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma2cU-00037P-Ub
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 09:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbZHIHOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 03:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbZHIHOs
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 03:14:48 -0400
Received: from peff.net ([208.65.91.99]:47289 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbZHIHOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 03:14:48 -0400
Received: (qmail 2340 invoked by uid 107); 9 Aug 2009 07:17:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 03:17:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 03:14:46 -0400
Content-Disposition: inline
In-Reply-To: <20090809065936.GA24112@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125324>

On Sun, Aug 09, 2009 at 02:59:36AM -0400, Jeff King wrote:

> This is a repost of
> 
>   http://article.gmane.org/gmane.comp.version-control.git/119909
> 
> which got no response from you. I think it is a good idea, but I am not
> deeply committed to it. I mainly want a yes or no so I can clean it out
> of my patch queue.

Ah, it may have had to do with the fact that it doesn't actually pass
the tests. There is a trivial text update needed in t3409, which calls
"git merge origin/master" during its setup phase.

Updated, passing-all-tests patch is below. Sorry for the confusion.

-- >8 --
Subject: [PATCH] merge: indicate remote tracking branches in merge message

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

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-merge.c                   |   11 +++++++++++
 t/t3409-rebase-preserve-merges.sh |    2 +-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 82b5466..1f59567 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -378,6 +378,17 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		goto cleanup;
 	}
 
+	strbuf_setlen(&buf, 0);
+	strbuf_addstr(&buf, "refs/remotes/");
+	strbuf_addstr(&buf, remote);
+	resolve_ref(buf.buf, branch_head, 0, 0);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+				sha1_to_hex(branch_head), remote);
+		goto cleanup;
+	}
+
 	/* See if remote matches <name>^^^.. or <name>~<number> */
 	for (len = 0, ptr = remote + strlen(remote);
 	     remote < ptr && ptr[-1] == '^';
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index e6c8327..2ce0236 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -71,7 +71,7 @@ test_expect_success 'rebase -p fakes interactive rebase' '
 	git fetch &&
 	git rebase -p origin/topic &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote branch" | wc -l)
 	)
 '
 
-- 
1.6.4.178.g7a987
